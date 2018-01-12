` 本教程旨在让我们更加快速、高效的开发移动app `

1. 目录结构
2. 接口封装
3. 界面封装
4. 模型封装
5. 对象组合
6. 工具类

#### 面向对象编程三大特性：封装、继承、多态，这篇文章会在实际项目编码中介绍这些特性，提高编码水平和质量。

```效果图```

![动图](Resource/TemplateCocoa.gif)


#### 1. 目录结构图
![目录结构图](http://turkeyaa.github.io/assets/2015/product_structure.png)

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

### TODO

#### 5. 对象组合

#### 6. 工具类
