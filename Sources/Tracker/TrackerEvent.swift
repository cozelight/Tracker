import Foundation

/// 埋点公参
public class TrackerEvent {

    public var fromPage: String?
    public var page: String?
    public var params = [String: Any]()

    public func config(from event: TrackerEvent) {
        fromPage = event.page
    }

    public func toDictionary() -> [String: Any] {
        var dict = [String: Any]()
        if let page = page {
            dict["page"] = page
        }
        if let fromPage = fromPage {
            dict["fromPage"] = fromPage
        }
        dict.merge(params) { $1 }
        return dict
    }
}
