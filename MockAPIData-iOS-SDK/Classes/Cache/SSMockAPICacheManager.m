//
//  SSMockAPICacheManager.m
//  Pods
//
//  Created by sun on 2019/1/29.
//

#import "SSMockAPICacheManager.h"
#import "SSMockAPICommon.h"
#import "SSMockAPIDataSDK+Private.h"


#import "SSMockAPIRequestProjectsOperation.h"
#import "SSMockAPIRequestRulesOperation.h"

#import <YYModel/YYModel.h>

static SSMockAPICacheManager *__instance__ = nil;

static volatile BOOL __isSynced__ = NO;

@interface SSMockAPICacheManager ()
@property (nonatomic, strong) NSURL *rootURL;
@property (nonatomic, strong) NSFileManager *fileManager;

@property (nonatomic, strong) NSURL *projectURL;
@property (nonatomic, strong) NSURL *ruleURL;

@property (nonatomic, strong) NSArray<SSMockAPIProjectModel *> *projects;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSArray<SSMockAPIRuleModel *> *> *ruleMaps;
@end

@implementation SSMockAPICacheManager
+ (void)load {
   __unused SSMockAPICacheManager *obj = [SSMockAPICacheManager shared];
}
+ (instancetype)shared {
    if (!__instance__) {
        __instance__ = [[self alloc] init];
    }
    return __instance__;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (__instance__) {
        @throw [NSException exceptionWithName:@"SSMockAPIDataSDK" reason:@"请使用 [SSMockAPICacheManager shared]" userInfo:nil];
    }
    return [super allocWithZone:zone];
}
- (instancetype)init {
    if (self == [super init]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    self.rootURL = [[NSURL fileURLWithPath:path] URLByAppendingPathComponent:@".com.0x1306a94.mock.api" isDirectory:YES];
    self.projectURL = [self.rootURL URLByAppendingPathComponent:@"mock.project.plist"];
    self.ruleURL = [self.rootURL URLByAppendingPathComponent:@"mock.rule.plist"];
    self.fileManager = [NSFileManager defaultManager];

    BOOL isDirectory = NO;
    if (!([self.fileManager fileExistsAtPath:self.rootURL.path isDirectory:&isDirectory] && isDirectory)) {
        @try {
            [self.fileManager createDirectoryAtPath:self.rootURL.path withIntermediateDirectories:YES attributes:nil error:nil];
        } @catch (NSException *exception) {
            NSLog(@"createDirectoryAtPath exception: %@", exception);
        } @finally {

        }
    }
    if ([self.fileManager fileExistsAtPath:self.projectURL.path]) {
        NSArray *array = [NSArray arrayWithContentsOfURL:self.projectURL];
        self.projects = [NSArray yy_modelArrayWithClass:SSMockAPIProjectModel.class json:array];
    } else {
        self.projects = [NSArray<SSMockAPIProjectModel *> array];
    }
    if ([self.fileManager fileExistsAtPath:self.ruleURL.path]) {
        self.ruleMaps = [NSMutableDictionary<NSString *, NSArray<SSMockAPIRuleModel *> *> dictionary];
        NSDictionary *tmp = [[NSDictionary alloc] initWithContentsOfFile:self.ruleURL.path];
        [tmp enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSArray<SSMockAPIRuleModel *> *rules = [NSArray yy_modelArrayWithClass:SSMockAPIRuleModel.class json:obj];
            if (rules.count > 0) {
                self.ruleMaps[key] = rules;
            }
        }];
    } else {
        self.ruleMaps = [NSMutableDictionary<NSString *, NSArray<SSMockAPIRuleModel *> *> dictionary];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(motionEnd:) name:kSSRnotificationMotionEvent object:nil];
}
-(void)motionEnd:(NSNotification *)notification {
    if (__isSynced__) return;

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.name = @"com.0x1306a94.mock.api.sync";
    queue.maxConcurrentOperationCount = 5;
    SSMockAPIRequestProjectsOperation *projectOp = [[SSMockAPIRequestProjectsOperation alloc] initWithComplete:^(NSArray<SSMockAPIProjectModel *> * _Nullable projects) {
        if (projects.count == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                @synchronized (self) {
                    self.projects = @[];
                    self.ruleMaps = @{};
                    [self saveToDisk];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kSSRnotificationSyncCompleteEvent object:nil];
                }
                __isSynced__ = NO;
            });
            return;
        }
        NSArray<SSMockAPIProjectModel *> *allProject = projects;
        NSMutableDictionary<NSString *, NSArray<SSMockAPIRuleModel *> *> *allRuleMpas = [NSMutableDictionary<NSString *, NSArray<SSMockAPIRuleModel *> *> dictionary];
        NSBlockOperation *allOp = [NSBlockOperation blockOperationWithBlock:^{
            // 全部下载完成
            NSLog(@"全部下载完成...");
            NSLog(@"%@", allProject);
            NSLog(@"%@", allRuleMpas);
            dispatch_async(dispatch_get_main_queue(), ^{
                @synchronized (self) {
                    self.projects = allProject;
                    self.ruleMaps = allRuleMpas;
                    [self saveToDisk];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kSSRnotificationSyncCompleteEvent object:nil];
                }
                __isSynced__ = NO;
            });
        }];

        for (SSMockAPIProjectModel *p in projects) {
            SSMockAPIRequestRulesOperation *op = [[SSMockAPIRequestRulesOperation alloc] initWithProjectId:p.id projectKey:p.key complete:^(NSInteger projectId, NSString * _Nonnull projectKey, NSArray<SSMockAPIRuleModel *> * _Nullable rules) {
                @synchronized (allRuleMpas) {
                    if (rules.count > 0) {
                        allRuleMpas[projectKey] = rules;
                    }
                }
            }];
            [allOp addDependency:op];
            [queue addOperation:op];
        }
        [queue addOperation:allOp];
    }];
    [queue addOperation:projectOp];
}
- (NSArray<SSMockAPIProjectModel *> *)getCacheProjects {
    @synchronized (self) {
        if (self.projects.count == 0) return nil;
        return [NSArray arrayWithArray:self.projects];
    }
}
- (NSDictionary<NSString *, NSArray<SSMockAPIRuleModel *> *> *)getCacheRules {
    @synchronized (self) {
        if (self.ruleMaps.count == 0) return nil;
        return [NSDictionary dictionaryWithDictionary:self.ruleMaps];
    }
}

- (void)storeProjects:(NSArray<SSMockAPIProjectModel *> *)projects {
    @synchronized (self) {
        self.projects = projects.mutableCopy;
        @try {
            [(self.projects ? [self.projects yy_modelToJSONObject] : @[]) writeToFile:self.projectURL.path atomically:YES];
        } @catch (NSException *exception) {
            NSLog(@"storeProjects exception: %@", exception);
        } @finally {

        }
    }
}
- (void)removeRulesWithProjectKey:(NSString *)key {
    @synchronized (self) {
        if (!(key.length > 0 && self.ruleMaps[key])) return;
        [self.ruleMaps removeObjectForKey:key];
        @try {
            [(self.ruleMaps ? [self.ruleMaps yy_modelToJSONObject] : @{}) writeToFile:self.ruleURL.path atomically:YES];
        } @catch (NSException *exception) {
            NSLog(@"storeRulesWithProjectKey exception: %@", exception);
        } @finally {

        }
    }
}
- (void)storeRulesWithProjectKey:(NSString *)key rules:(NSArray<SSMockAPIRuleModel *> *)rules {
    @synchronized (self) {
        if (key.length == 0) return;
        self.ruleMaps[key] = rules;
        @try {
            [(self.ruleMaps ? [self.ruleMaps yy_modelToJSONObject] : @{}) writeToFile:self.ruleURL.path atomically:YES];
        } @catch (NSException *exception) {
            NSLog(@"storeRulesWithProjectKey exception: %@", exception);
        } @finally {

        }
    }
}
- (void)saveToDisk {
    @try {
        [(self.projects ? [self.projects yy_modelToJSONObject] : @[]) writeToFile:self.projectURL.path atomically:YES];
        [(self.ruleMaps ? [self.ruleMaps yy_modelToJSONObject] : @{}) writeToFile:self.ruleURL.path atomically:YES];
    } @catch (NSException *exception) {
        NSLog(@"saveToDisk exception: %@", exception);
    } @finally {

    }
}
@end
