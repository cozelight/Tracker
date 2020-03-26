import Foundation

public protocol TrackerTransferable {

    /// 来源埋点数据
    var fromEvent: TrackerEvent? { get set }

    /// 埋点数据
    var event: TrackerEvent { get }

    /// 配置当前埋点数据
    /// - Parameter event: 埋点
    func config(event: TrackerEvent)
}

private enum AssociatedKeys {
    static var fromEventKey = "fromEventKey"
    static var eventKey = "eventKey"
}

extension TrackerTransferable where Self: UIResponder {
    public var fromEvent: TrackerEvent? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.fromEventKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let event = objc_getAssociatedObject(self, &AssociatedKeys.fromEventKey) as? TrackerEvent {
                return event
            } else {
                if let from = self.next as? TrackerTransferable {
                    objc_setAssociatedObject(self, &AssociatedKeys.fromEventKey, from.fromEvent, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                    return from.fromEvent
                } else {
                    return nil
                }
            }
        }
    }

    public var event: TrackerEvent {
        if let event = objc_getAssociatedObject(self, &AssociatedKeys.eventKey) as? TrackerEvent {
            return event
        } else {
            let event = makeEvent()
            objc_setAssociatedObject(self, &AssociatedKeys.eventKey, event, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return event
        }
    }

    func makeEvent() -> TrackerEvent {
        var event = TrackerEvent()
        if let next = nextTracker(self) {
            event = next.event
        }
        if let from = fromEvent {
            event.config(from: from)
        }
        config(event: event)
        return event
    }

    func nextTracker(_ responder: UIResponder) -> TrackerTransferable? {
        if let next = responder.next as? TrackerTransferable {
            return next
        }
        if let next = responder.next {
            return nextTracker(next)
        }
        if let vc = responder as? UIViewController, let parent = vc.parent {
            return nextTracker(parent)
        }
        return nil
    }

    public func config(event: TrackerEvent) {}
}

extension TrackerTransferable where Self: UIViewController {
    public func config(event: TrackerEvent) {
        event.page = "\(Self.self)"
    }
}
