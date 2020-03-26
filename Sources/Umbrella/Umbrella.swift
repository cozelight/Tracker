import Foundation

public protocol AnalyticsType {
    associatedtype Event: EventType
    func log(_ event: Event)
}

public protocol ProviderType {
    func log(_ eventName: String, parameters: [String: Any]?)
}

public protocol EventType {
    func name(for provider: ProviderType) -> String?
    func parameters(for provider: ProviderType) -> [String: Any]?
}

open class Analytics<Event: EventType>: AnalyticsType {
    public let providers: [ProviderType]

    public init(providers: [ProviderType]) {
        self.providers = providers
    }

    open func log(_ event: Event) {
        providers.forEach {
            guard let eventName = event.name(for: $0) else { return }
            let parameters = event.parameters(for: $0)
            $0.log(eventName, parameters: parameters)
        }
    }
}
