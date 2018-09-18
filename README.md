# Objective-C 项目实战

> 面向对象编程三大特性：封装、继承、多态，这篇文章会在实际项目编码中介绍这些特性，提高编码水平和质量。

> 根据实际项目开发总结，旨在让我们更加快速、高效的开发移动app

1. 目录结构
2. 接口封装
3. 界面封装
4. 模型封装
5. 组件封装
6. 对象组合
7. 宏定义、工具类

![动图](Resource/TemplateCocoa.gif)

`功能列表`

### 包含不限于下列功能：

1. UIViewController控制器封装(包含：BaseVC、BaseWebVC、BaseTC、BaseLoadTC、BaseFormTC、BaseFormGroupTC、BaseSwipeVC、BaseNavSwipeVC)。支持导航栏标题和图标设置、自定义导航栏、左右标题事件、HUD功能、空页面提示和交互功能、html5页面访问功能、表视图控制器功能、自定义约束、下拉刷新和上拉加载交互功能、表单和分组表视图控制器功能、仿新闻多视图切换控制器功能、导航多视图切换控制器功能。查看`Common/VC`目录
2. 接口封装(包含：RestApi、BaseRestApi、API_UnitTest、Login_Post......等)。自定义网络库，支持同步和异步访问接口、取消任务、配置路径和参数、模拟本地接口、数据解析和回调。查看`API`目录
3. UITableViewCell界面封装(包含：TCell_Image、TCell_Input、TCell_Label、TCell_Notify...等)，可以扩展新的组件。支持图片、输入框、通知、文本的表单元格式，每个Cell都是一个独立的组件，封装了各自的交互逻辑。查看`Common/Cell`和`Common/Kit/Table view cell`目录
4. 模型封装(JSONModel)，支持模型和JSON的相互转化，也可以使用第三方库(YYModel、MJExtension)。查看`Model`目录
5. 组件封装(包含：表单元、空视图、导航栏、多标题视图......等)，你可以扩展新的组件。查看`Common/Kit`目录
6. 服务模块(包含：Workspace、FileManager...等)。支持用户管理、APP配置管理、远程配置管理、数据库访问、日期管理、正则表达式、运行时系统、Action接口管理、谓词...等接口封装，基于外观模式设计。访问`Service`目录
7. 基于`WKWebView`类，JavaScript和原生数据交互
8. 宏定义、枚举、block定义
9. 动画，基于`CAAnimation`和`UIBezierPath`的购物车动画
10. 设计模式：单例模式、适配器模式、外观模式、对象去耦(中介者和观察者模式)、组合模式、模板方法...等设计模式的使用。[个人总结的iOS开发设计模式](https://www.jianshu.com/p/f4f8318d51c9)
11. 基于Swift语言的项目实战[TemplateSwiftAPP](https://github.com/turkeyaa/TemplateSwiftAPP)

### TODO

1. 基于上传图片基类：`BaseUploadApi`，支持一张和多张图片的上传
2. 工具类、开发技巧
3. 基于Vapor服务端项目实战[SwiftCN](https://github.com/SwiftCN/SwiftCN)

***

#### 1. 目录结构图
![目录结构图](Resource/Structure.png)

##### 说明

* APIs：包含所有的接口调用，每个接口都包装成一个单独的类。处理数据的解析、回调、传值、统计分析、错误日志、错误码
* Common：封装界面相关的类，比如BaseVC、BaseTC、BaseView、BaseTCell...等
* Image：本地图片资源
* Macro：定义常量、枚举、block...等
* Model：定义模型
* Resource：本地 json 数据，模拟本地接口
* Service：单例类、工具类...等
* Vendors：自定义第三方工具插件
* VCs：新功能模块开发
* Images.xcassets：切图资源
* PrefixHeader.pch：编译预引用头文件
* Pods：第三方库

***

#### 2. 接口封装

> 一般的我们会使用第三方插件(AFNetworking...)来处理网络请求，每个请求都是通过AFN来调用，这样不好是因为开发和维护都需要很多的工作量。而有写经验的开发者会考虑在基类中实现AFN接口，通过继承的方式来处理网络请求，这样就很好了。下面介绍如何打造自己的网络库。

![](http://turkeyaa.github.io/assets/2015/MVC.png)

#### 在ViewController中，登录接口就是这样：

```
// 在 LoginVC.m 中实现登录
Login_Post *loginApi = [[Login_Post alloc] initWithAccount:account password:password];
[loginApi call];

if (loginApi.code == RestApi_OK) {
	// 登录成功，赋值，其他处理....
	UserInfo *userInfo = loginApi.userInfo;

}
else {
	// 登录失败
	[self showErrorMessage:loginApi.errorMessage];
}
```


#### 一般的网络请求方法步骤：

```
// 1. 创建url
NSString *urlStr = @"http://192.169.1.88/loging?account=turkey&password=123456";
NSURL *url = [NSURL URLWithString:urlStr];

// 2. 创建请求
NSURLRequest *request = [NSURLRequest requestWithURL:url];

// 3. 创建会话（这里使用了一个全局会话）
NSURLSession *session = [NSURLSession sharedSession];

// 4. 通过会话创建任务
NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request 
		completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
	if (!error) {
		NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		NSLog(@"%@",dataStr);
	}else{
		NSLog(@"error is :%@",error.localizedDescription);
	}
}];

// 5. 每一个任务默认都是挂起的，需要调用 resume 方法启动任务
[dataTask resume];

```

#### 这些方法是通用的，不同的只是参数、请求方式(GET/POST/PUT...)、接口路径、返回的数据。那我们是不是可以把不同的参数通过多态(重写父类的方法)来实现。而请求数据完成，通过block、代理或重载来处理不同的结果。这里的结果一般的是json数据，同时就可以把json转换成model传递给相应的控制器对象。你会发现我们的请求过程会特别的简单、方便。流程图：

#### 如何实现？

1. 定义RestApi，一个抽象类。包含：初始化、执行、取消、结果处理、参数...等方法。一些是子类必须要实现的方法(参数、结果处理)
2. 定义BaseRestApi，继承RestApi。定义错误码和结果处理方法
3. 定义Login_Post，继承BaseRestApi。定义初始化方法、请求参数、处理结果方法

#### 在RestApi，中实现网络请求、回调，也可以处理一些统计分析、异常等处理。在BaseRestApi中会有相应的错误码，是否成功，提示客户。在LoginApi中得到回调，并解析，传递给相应的控制器。

```
// 1. 定义一个枚举，请求方式
typedef NS_ENUM(NSInteger, HttpMethods) {
	HttpMethods_Get = 1,
	HttpMethods_Post = 2,
	HttpMethods_Delete = 3,
	HttpMethods_Put = 4,
};

// 2. 初始化方法
- (id)initWithURL:(NSString *)url httpMethod:(HttpMethods)httpMethod;

// 3. 执行和取消
- (void)call:(BOOL)async;
- (void)cancel;

// 3. 参数：Get、Post方式，
- (NSData *)requestData;                // Post
- (NSDictionary *)queryParameters;      // Get

// 4. 回调，需要子类重写
- (void)onSuccessed;
- (void)onFailed;
- (void)onCancelled;
- (void)onTimeout;
- (void)onError:(NSError *)error;

```		

#### 重点是 call：方法

```
// 1. 数据请求必须在异步线程中
if ([NSThread isMainThread] && !async) {
	[self raiseException:@"主线程不允许同步调用"];
	return;
}

// 2. 初始化request
NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];

// 3. 在GET请求中我的接口是：http://192.169.1.88/loging?account=turkey&password=123456"。而POST请求接口：http://192.169.1.88/loging，参数方式不同。
if (_httpMethod == HttpMethods_Get) {

NSMutableString *strUrl = [[NSMutableString alloc] initWithString:_url];

@try {
	NSDictionary *params = [self queryGetParameters];
	if (params) {

	// Get 参数
	NSArray *keys = params.allKeys;

	for (int i = 0; i< keys.count; i++) {
		NSString* key = [keys objectAtIndex:i];
		NSString* value = [params valueForKey:key];

		if (i == 0) {
			[strUrl appendString:@"?"];
		} else {
			[strUrl appendString:@"&"];
		}
		[strUrl appendString:key];
		[strUrl appendString:@"="];
		[strUrl appendString:[NSString stringWithFormat:@"%@", value]];
		}
	}

	[request setURL:[NSURL URLWithString:strUrl]];
	[request setHTTPMethod:@"GET"];
	[request setTimeoutInterval:timeout];

	} @catch (NSException *exception) {

	} @finally {

	}
}

	else if (_httpMethod == HttpMethods_Post) {
		[request setURL:[NSURL URLWithString:_url]];
		[request setHTTPMethod:@"POST"];
		[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
		NSData *postData = [self queryPostData];
		[request setHTTPBody:postData];
	}
else {
	NSAssert(NO, @"目前只支持 GET、POST 请求方式");
}

NSLog(@"url = %@",_url);

__weak RestApi *weakSelf = self;

// 4. 这里通过条件来实现线程同步
	NSCondition *condition = [[NSCondition alloc] init];

	NSURLSession *session = [NSURLSession sharedSession];

	_task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

	if (error) {

		[weakSelf doFailure:error];
	}
	else {
		[weakSelf doSuccess:data];
	}
	
	[condition lock];
	[condition signal];
	[condition unlock];
}];

// 5. 开始请求
[_task resume];

if (condition) {
	[condition lock];
	[condition wait];			
	[condition unlock];
}
```

#### 在BaseRestApi中，需要重写queryPostData:

```

id requestData = [self prepareRequestData];

if ([requestData isKindOfClass:NSData.class]) {
	return requestData;
}
if ([requestData isKindOfClass:NSDictionary.class]) {
	NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:requestData];
	NSData * jsondata=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
	return jsondata;
}
if ([requestData isKindOfClass:NSArray.class]) {

	NSMutableArray *array = [NSMutableArray arrayWithArray:requestData];
	NSData *jsondata = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
	return jsondata;
}
if ([requestData isKindOfClass:NSString.class]) {
	return [((NSString*)requestData) dataUsingEncoding:NSUTF8StringEncoding];
}
return nil;
		
```

#### 还有 doSuccess: 方法

```
// 1. 调用的哪个接口，返回的json数据，方便调试用
NSLog(@"RestApi :[%@]",self.class);
NSLog(@"RestApi Response:[%@]",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);

// 2. 解析数据
@try {
	NSError *error;
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
	self.code = [json[@"status"] integerValue];
	self.message = json[@"message"];

	if (self.code == RestApi_OK && [self parseResponseJson:json]) {
		[self onSuccessed];
	}
	else {
		if (self.code == RestApi_OK) {

			[self onSuccessed];
	}
	else {
		[self onFailed];
		}
	}

} @catch (NSException *exception) {
	[self onError:nil];
} @finally {

}
		
```

#### 在 Login_Post中，重写parseResponseJson：、prepareRequestData方法(如果的GET请求：queryParameters)

```
// 解析
- (BOOL)parseResponseJson:(NSDictionary *)json {

	NSDictionary *data = json[@"data"];
	if (data) {
		// 这里处理登录成功返回的JSON数据, 这里使用YYModel库
		self.userInfo = [UserModel yy_modelWithJSON:data];
	}

	return self.userInfo && self.userInfo.user_id.length > 0;
}

// POST 请求
- (id)prepareRequestData {
	return @{
		@"user_account":_account,
		@"user_pwd":[URLUtil base64Encode:_password]
	};
}

// GET 请求是这样
- (NSDictionary *)queryParameters {
	return @{
		@"email":_email
	};
}

```
***

#### 3. 界面封装

#### 重点介绍**UIViewController**和**UITableViewCell**的封装

#### UIViewController的继承关系，设计如下图：

![BaseVC继承关系图](http://turkeyaa.github.io/assets/2017/BaseLoadTC.png)

#### 在BaseVC.h中，定义了一些属性和方法，包括：是否显示导航条、左标题、右标题、左图标、右图标、左条目事件、右条目事件、HUD的显示和隐藏。基本上满足了对控制器对象的基本的交互封装。

#### 在BaseTC中，这是一个带有UITableView的视图控制器。包括：一个NSMutableArray类型的数据源和UITableView类型的表视图对象。

#### 在BaseLoadTC中，这是一个带有下拉刷新、加载更多和表视图的视图控制器对象。

#### 在我们的视图控制器中，就可以这样写：

```
// 显示标题
self.leftTitle = @"登录";
self.rightTitle = @"注册";
	
// 或者显示图标
self.leftImage = [UIImage imageNamed:@"app_icon"];
self.rightImage = [UIImage imageNamed:@"app_icon"];
	
// 显示HUD
[self showLoadingHUD];
// 自定义HUD
[self showLoadingHUD:@"正在登录中..."];
// 隐藏HUD
[self hideLoadingHUD];
// 成功、失败、错误...等
[self showSuccessMessage:@"加载成功"];
[self showErrorMessage:@"加载失败"];
[self showInfoMessage:@"其他失败"];

// 空页面
self.isShowEmptyView = YES;

/** 可选，子类已实现 */
- (UIImage *)baseEmptyImage {
    return [UIImage imageNamed:@"app_emptyView"];
}
- (NSString *)baseEmptyTitle {
    return @"暂无内容";
}
- (NSString *)baseEmptySecondTitle {
    return @"暂无子标题";
}
- (void)baseEmptyRefresh {
    [self showLoadingHUD:@"刷新空页面"];
    [GCDUtil runInGlobalQueue:^{
        sleep(1);
        [GCDUtil runInMainQueue:^{
            [self showSuccessMessage:@"刷新成功"];
            self.isShowEmptyView = NO;
        }];
    }];
}


```

#### BaseTCell类设计如下：

![BaseTCell继承关系](http://turkeyaa.github.io/assets/2017/BaseTCell.png)

#### 通过 **tcell:reuse:** 方法来初始化UITableViewCell对象，支持 **click** 监听点击事件、**showIndicator** 是否显示右边的箭头、重写 **classCellHeight** 重写子类的高度、重写 **setupSubViews** 自定义子类界面。

#### 然后我们的表视图数据源方法中 **tableView: cellForRowAtIndexPath:** ，初始化表视图就是这样：

```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	MainCell *cell = [MainCell tcell:self.tableView reuse:YES];
	MainInfo *info = self.dataSource[indexPath.row];
	cell.mainInfo = info;
	cell.showIndicator = YES;		// 默认为YES
    
	return cell;
}
	
```
	
#### 你也可以自定义UITableViewCell的高度：

```
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [MainCell classCellHeight];
}
	
```
***	

#### 4. 模型封装

#### 对象模型对象，最基本的需要满足下面的功能：
1. JSON和Model的相互转化
2. 编码和解码
3. 对象的深复制

#### 一般的我们使用**MJExtension**来处理模型转化，基本上可以项目中的各种需求。如果让你自己来实现这些功能，该如何来设计？

#### 定义JSONModel类，继承NSObject类。实现NSCopying,NSCoding,NSMutableCopying三个协议。支持编码和解码功能，两个类方法，支持JSON和Model的相互转化。

> 代码清单 JSONModel.h
	
```
@interface JSONModel : NSObject <NSCopying,NSCoding,NSMutableCopying>

+ (id)jsonModelWithDictionary:(NSDictionary *)jsonDict;
+ (NSDictionary *)jsonModelWithModel:(JSONModel *)model;

@end
	
```
	
> 代码清单 JSONModel.m
	
```
// 基于运行时特性，动态获取类的属性
#import "NSObject+Property.h"
	
- (id)initWithDictionary:(NSDictionary *)jsonDict {
	if (self = [super init]) {
		[self setValuesForKeysWithDictionary:jsonDict];
	}
	return self;
}

+ (id)jsonModelWithDictionary:(NSDictionary *)jsonDict {
	JSONModel *model = [[self alloc] initWithDictionary:jsonDict];
	return model;
}

+ (NSDictionary *)jsonModelWithModel:(JSONModel *)model {
    
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
	NSArray *properNames = [model getPropertyList];
    
	for (NSString *key in properNames) {
        
		id value = [model valueForKey:key];
		if (value) {
			[dict setValue:value forKey:key];
		}
	}
	return dict;
}
	
```

#### 在 **jsonModelWithDictionary:** 方法中，基于KVC特性，把JSON转化成MOdel对象，在 **jsonModelWithModel:** 方法中，在运行时获取model的属性类型(runtime机制)，然后根据属性获取属性值(KVC机制)，然后把属性和值添加到字典中。即可实现Model转化成JSON字典对象。

> 代码清单，接上，JSONModel.m
	
```
#pragma mark -
#pragma mark - NSCoding协议:解码
- (id)initWithCoder:(NSCoder *)aDecoder {
    
	if (self = [super init]) {
        
		NSArray *properNames = [self getPropertyList];
        
		for (NSString *key in properNames) {
            
			id varValue = [aDecoder decodeObjectForKey:key];
			if (varValue) {
				[self setValue:varValue forKey:key];
			}
		}
	}
	return self;
}
	
#pragma mark -
#pragma mark - NSCoding协议:编码
- (void)encodeWithCoder:(NSCoder *)aCoder {
	NSArray *properNames = [self getPropertyList];
	for (NSString *key in properNames) {
        
		id varValue = [self valueForKey:key];
		if (varValue)
		{
			[aCoder encodeObject:varValue forKey:key];
		}
	}
}

#pragma mark -
#pragma mark - NSCopying协议
- (id)mutableCopyWithZone:(NSZone *)zone {
	// subclass implementation should do a deep mutable copy
	// this class doesn't have any ivars so this is ok
	JSONModel *newModel = [[JSONModel allocWithZone:zone] init];
	return newModel;
}

- (id)copyWithZone:(NSZone *)zone {
	// subclass implementation should do a deep mutable copy
	// this class doesn't have any ivars so this is ok
	JSONModel *newModel = [[JSONModel allocWithZone:zone] init];
	return newModel;
}
	
```

***

> 客户端代码
	
```
// json转化成model 和 model 转化成 json
MainInfo *info = [MainInfo jsonModelWithDictionary:dict];
NSDictionary *dict = [MainInfo jsonModelWithModel:info];
	
// 编码
MainInfo *p = [[MainInfo alloc] init];
p.name = @"turkey";
NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
NSString *path = [documents stringByAppendingPathComponent:@"main.archiver"];//拓展名可以自己随便取
[NSKeyedArchiver archiveRootObject:p toFile:path];
	    
// 解码
NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
NSString *path = [documents stringByAppendingPathComponent:@"main.archiver"];
MainInfo *mainInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
	
```	

#### 5. 组件封装

![效果图](Resource/Kit.png)`效果图`

##### 上面包含了五种Cell，每个Cell都是独立的模块，并且完成各自的功能和交互逻辑。如：图片、文字、通知、输入框等功能。每个组件之间通过接口来访问

##### 如何实现？

首先定义了基类：**BaseTCell**，定义了通用的接口，然后在子类中来设计特定的实现。

接口定义如下：

```
@class BaseTCell;

typedef void(^ClickEventBlock)(NSIndexPath *indexPath, BaseTCell *cell);

@interface BaseTCell : UITableViewCell

+ (CGFloat)classCellHeight;

+ (instancetype)tcell:(UITableView *)tableView reuse:(BOOL)reuse;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) BOOL showIndicator;
@property (nonatomic, strong) ClickEventBlock click;

- (CGFloat)height;

- (void)setupUI;

- (void)scrollToActiveTextField;

#pragma mark - Subclass
- (void)setupSubViews;
- (void)setupLayout;

@end

```

然后在子类中，实现相应的逻辑。比如：**TCell_Input**类，该类实现了输入框的交互逻辑。支持手机号、密码、符号的输入，同时实现了键盘的点击背景的隐藏事件、最大输入长度、颜色、图标......等。

接口设计如下：

```
@interface TCell_Input : BaseTCell

/** 图片 */
@property (nonatomic, strong) UIImage *icon;
/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 标题颜色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 输入框文本 */
@property (nonatomic, strong) NSString *text;
/** 输入框占位符 */
@property (nonatomic, strong) NSString *placeholder;

/** 支持可输入的最大长度，默认为11 */
@property (nonatomic, assign) NSInteger limitMaxLength;

/** 输入框类型：字符 */
+ (instancetype)stringInputCell;
/** 输入框类型：数字 */
+ (instancetype)numberInputCell;
/** 输入框类型：密码 */
+ (instancetype)passwordInputCell;

@end

```

客户端代码如下：

```
WEAKSELF
    _cellUser = [TCell_Image tcell:self.tableView reuse:NO];
    _cellUser.icon = [UIImage imageNamed:@"s_info"];
    _cellUser.title = @"设置";
    _cellUser.value = @"详情";
    
    _cellVersion = [TCell_Image tcell:self.tableView reuse:NO];
    _cellVersion.icon = [UIImage imageNamed:@"s_setting"];
    _cellVersion.title = @"版本";
    _cellVersion.value = @"V1.0";
    
    _cellAbout = [TCell_Image tcell:self.tableView reuse:NO];
    _cellAbout.icon = [UIImage imageNamed:@"s_notify"];
    _cellAbout.title = @"消息";
    _cellAbout.value = @"更多消息";
    _cellVersion.hasMsg = YES;
    
    // 多视图控制器切换(支持空页面)
    _cellNews = [TCell_Image tcell:self.tableView reuse:NO];
    _cellNews.icon = [UIImage imageNamed:@"s_notify"];
    _cellNews.title = @"新闻";
    _cellNews.click = ^(NSIndexPath *indexPath, BaseTCell *cell) {
        [weakSelf gotoNewsVC];
    };
    _cellMessages = [TCell_Image tcell:self.tableView reuse:NO];
    _cellMessages.icon = [UIImage imageNamed:@"s_notify"];
    _cellMessages.title = @"消息";
    _cellMessages.click = ^(NSIndexPath *indexPath, BaseTCell *cell) {
        [weakSelf gotoMessageVC];
    };
    
    _nameCell = [TCell_Input stringInputCell];
    _nameCell.icon = [UIImage imageNamed:@"business_nor"];
    _nameCell.title = @"姓名";
    _nameCell.showIndicator = NO;
    _nameCell.limitMaxLength = 12;
    _nameCell.placeholder = @"请输入姓名";
    
    _cardCell = [TCell_Input numberInputCell];
    _cardCell.title = @"身份证";
    _cardCell.showIndicator = NO;
    _cardCell.limitMaxLength = 20;
    _cardCell.placeholder = @"请输入身份证号码";
    
    _notifyCell =  [TCell_Notify tcell:self.tableView reuse:YES];
    _notifyCell.title = @"通知";
    _notifyCell.showIndicator = NO;
    _notifyCell.isNotifyOpened = NO;
    [_notifyCell addSwitchTarget:self selector:@selector(switchEvent:)];
    
    _networkCell = [TCell_Notify tcell:self.tableView reuse:YES];
    _networkCell.title = @"WIFI";
    _networkCell.showIndicator = NO;
    _networkCell.isNotifyOpened = YES;
    [_networkCell addSwitchTarget:self selector:@selector(switchEvent:)];
    
    _emptyCell = [TCell_Label tcell:self.tableView reuse:YES];
    _emptyCell.title = @"空页面";
    _emptyCell.value = @"测试空页面";
    _emptyCell.click = ^(NSIndexPath *indexPath, BaseTCell *cell) {
        [weakSelf gotoEmptyVC];
    };
    
    self.cells = @[@[_cellUser],@[_cellAbout,_cellVersion],@[_cellNews,_cellMessages],@[_notifyCell,_networkCell],@[_nameCell,_cardCell],@[_emptyCell]];
    
```

#### 6. 对象组合

> 组合模式：将对象组合成树形结构以表示”部分-整体”的层次结构。组合使得用户对单个对象和组合对象的使用具有一致性

![对象组合模式](https://turkeyaa.github.io/assets/2015/design/Composite.png)

基接口是定义了`Leaf`类和`Composite`类的共同操作的Component

每个节点代表一个叶节点或组合体节点。`Leaf`节点与`Composite`节点的主要区别在于，`Leaf`节点不包含同类型的子节点，而`Composite`则包含。`Composite`包含同一类型的子节点。由于`Leaf`类与`Composite`类有同样的接口，任何对`Component`类型的操作也能安全地应用到`Leaf`和`Composite`。客户端就不需要根据确切类型的is-else语句

`Composite`需要方法来管理子节点，比如`add:component`和`remove:component`。因为`Leaf`和`Composize`有共同的接口，这些方法必须也是接口的一部分。而向`Leaf`对象发送组合体操作消息则没有意义，也不起作用，只有默认的实现

##### 使用场景

1. 想获得对象抽象的树形表示(部分-整体层次结构)
2. 想让客户端统一处理组合结构中的所有对象



#### 7. 宏定义、工具类

> 一般项目开发中，我们会频繁的使用某些功能。比如：颜色、字体、设备型号、日志系统、图片拉伸、正则表达式、文件系统、数据库访问......等功能。可以把这些通用的功能封装成函数，或者宏定义方式访问。方便了以后的维护和扩展。

在`AppMacro.h`，定义了设备型号和系统版本号。代码如下：

```
#define is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS6_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >=6.0?YES:NO)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0?YES:NO)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0?YES:NO)
```

在`BlockMacro.h`中定义了通用的block。代码如下：

```
typedef void(^BlockHttpData)(id respose, NSError *error);
typedef void(^BlockJsonData)(id data);
typedef void(^BlockCompletion)(BOOL flag, NSError *error);

typedef void(^BlockTableSection)(NSInteger section, NSInteger row);

typedef void(^BlockItem)(NSInteger index);
typedef void(^BlockResult) (BOOL flag);
```

在`UIMacro.h`中定义了样式相关的宏定义。代码如下：

```
///设备宽高
#define DEVICE_HEIGHT   ([[UIScreen mainScreen]bounds].size.height)
#define DEVICE_WIDTH    ([[UIScreen mainScreen]bounds].size.width)

#define TAB_HEIGHT 49
#define NAV_HEIGHT 44
#define STATUS_HEIGHT 20

// 常用字体
#define FONT(fontsize)                [UIFont systemFontOfSize:fontsize]
#define FONT_BOLD(fontsize)           [UIFont boldSystemFontOfSize:fontsize]

// 粗体
#define FONT_H(fontsize)              [UIFont fontWithName:@"Helvetica" size:fontsize]
#define FONT_H_B(fontsize)            [UIFont fontWithName:@"Helvetica-Bold" size:fontsize]

// 字体大小
#define FONT_TEXT_BIG               FONT_H(19)        // A
#define FONT_TEXT_NORMAL            FONT_H(17)        // B
#define FONT_TEXT_SMALL             FONT_H(15)        // C
#define FONT_TEXT_SMALL2            FONT_H(13)        // D
#define FONT_TEXT_SMALL3            FONT_H(11)        // E
#define FONT_TEXT_SMALL4            FONT_H(9)         // F

// App 配置
#define Color_Nav                   RGB(0,123,252)
#define Color_Tab                   RGB(240,240,240)
#define Color_AppBackground         RGB(235, 236, 237)

#define Color_Alert_BackgroundLayer [UIColor colorWithWhite:.5f alpha:0.5f]

#define RGB(Red,Green,Blue)         [UIColor colorWithRed:Red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:1.0]
#define RGBA(Red,Green,Blue,Alpha)  [UIColor colorWithRed:Red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:Alpha]
```

在`UtilsMacro.h`中定义了一些函数相关的宏定义：

```
#define SharedApp ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define kHarpyCurrentVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

// 图片拉伸
#define IM_STRETCH_IMAGE(image, edgeInsets) ([image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])

```

你也可以扩展更多功能。

一般的我们需要访问设备文件系统。在`FileManager.h`中接口，定义如下：

```
///<>/Documents/config.plist
//程序设置信息
+ (NSString*)remotePreferenceFile;

///<>/Documents/Crash/crashLog.txt
// 错误日志
+ (NSString *)crashFile;

///<>/Library/Caches/mobile.sqlite
// 用户数据库文件
+ (NSString *)fmdbFileWithMobile:(NSString *)mobile;

///<><Application_Home>/Documents/app.sqlite
// App数据库文件
+ (NSString *)fmdbFile;

///<>/Library/Preferences/Icons
// 用户头像信息（自己头像，朋友头像）
+ (NSString *)userImageFileWithMobile:(NSString *)mobile;

///<>/Library/Preferences/<Phonenumber>/user.plist
//程序设置信息
+ (NSString*)userPreferenceFile:(NSString*)phoneNumber;
```

类`NSString+JudgeString`添加了对字符串的正则表达式封装，类`AppPreference`实现了对`NSUserDefault`的二次封装......等。所有的工具类在`Service`模块。