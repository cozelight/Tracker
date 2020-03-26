import Foundation

class TrackerProvider: ProviderType {
    func log(_ eventName: String, parameters: [String : Any]?) {
        print("event: \(eventName), params: \(String(describing: parameters))")
    }
}

/// 打点中心
public let Tracker = Analytics<Event>(providers: [TrackerProvider()])

public protocol TrackerPageabel: TrackerTransferable {

    /// 上报埋点
    /// - Parameters:
    ///   - event: 埋点事件
    ///   - handle: 额外处理埋点参数, 可在该 handle 内对参数进行再加工
    func tracker(_ event: Event, handle: (([String: Any]) -> Void)?)
}


extension UIViewController: TrackerPageabel {    }

extension TrackerPageabel {
    public func tracker(_ event: Event, handle: (([String: Any]) -> Void)? = nil) {
        Tracker.providers.forEach {
            guard let eventName = event.name(for: $0) else { return }
            var parameters = [String: Any]()
            if let eventParameters = event.parameters(for: $0) {
                parameters.merge(eventParameters) { $1 }
            }
            parameters.merge(self.event.toDictionary()) { $1 }
            if let handle = handle {
                handle(parameters)
            }
            $0.log(eventName, parameters: parameters)
        }
    }
}
