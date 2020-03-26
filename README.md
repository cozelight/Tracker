#Tracker

### 特性介绍

- 抽象打点层的设计，无痛添加新的 Event
- 脚本自动生成 Event 代码，避免硬编码
- 提供简易的传递公参方式

### 使用说明

#### 脚本自动生成 Event 代码

编译前执行脚本，自动检查 event.yml 文件是否发生变化（通过判断 git 暂存区和工作区），发生变化则执行生成代码

#### 如何新增 Event 埋点

编辑  **event.yml** 文件

> 格式说明：(YAML格式，空格敏感,  缩进为2个空格！！)
>
> [~] 代表没有参数[0] 代表参数类型为 Int
>
> [0.0] 代表参数类型为 Double
>
> [str] 代表参数类型为 String

示例：

```
# 埋点 event1，没有参数
event1: ~
# 埋点 event2，参数为 [params1: Int, params2: Double, params3: String]
event2:
 params1: 0
 params2: 0.0
 params3: ""
```

#### 如何打点

调用 Tracker.log(event)，传递相应的埋点对象 Event 即可

```
Tracker.log(
  .bookmarkChange(
    changeType: "",
    isLogin: 0,
    isVideo: 0,
    itemId: ""
 ))
```

> **注意！！！ Tracker.log(event) 方式打点没有带公参（page、fromPage）**

需要带公参，则打点的 ViewController、View，需要遵循 TrackerPageabel 协议，该协议提供了 

以下方法：

```
/// 上报埋点
/// - Parameters:
///  - event: 埋点事件
///  - handle: 额外处理埋点参数, 可在该 handle 内对参数进行再加工
func tracker(_ event: EHIEvent, handle: (([String: Any]) -> Void)?)
```

调用  tracker(event)即可进行携带公参的打点

#### 如何传递公参

UIViewController，默认遵循了 TrackerPageabel 协议，即页面之间已经支持传递公参。如果视图 View 需要传递公参，则需要主动遵循 TrackerPageabel 协议。

TrackerPageabel 协议继承自 TrackerTransferable 协议。

以下为该协议声明：

```
public protocol TrackerTransferable {
  /// 来源埋点数据
  var fromEvent: TrackerEvent? { get set }
  /// 埋点数据
  var event: TrackerEvent { get }
  /// 配置当前埋点数据
  /// - Parameter event: 埋点
  func config(event: TrackerEvent)
}
```

通过在自己的页面，实现 config(event: TrackerEvent) 方法，即可完成本页面公参的配置

> **页面间如何自定义传递？**
>
> 目前需要在 push、present 页面时，需要自己设置！
>
> 建议在 Base 类，统一处理

```
override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if var toTracker = viewControllerToPresent as? TrackerTransferable {
            toTracker.fromEvent = event
        }
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
```