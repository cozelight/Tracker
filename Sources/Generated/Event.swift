// swiftlint:disable all
// ！！！该文件代码为自动生成！！！
// 如果埋点有更新，需更新埋点文件 event.yml

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length


// swiftlint:disable identifier_name line_length number_separator type_body_length
public enum Event {
    case homePageShow(iconOperationId: Int, isLogin: Int)
    case loginPageShow
    case sendSms(isRetake: Int)
    case sendSmsError(errorCode: String, errorInfo: String)
    case userLogout
}

extension Event: EventType {

    public func name(for provider: ProviderType) -> String? {
        switch self {
        case .homePageShow: return "home_page_show"
        case .loginPageShow: return "login_page_show"
        case .sendSms: return "send_sms"
        case .sendSmsError: return "send_sms_error"
        case .userLogout: return "user_logout"
        }
    }

    public func parameters(for provider: ProviderType) -> [String: Any]? {
        switch self {
        case let .homePageShow(iconOperationId, isLogin): return ["icon_operation_id": iconOperationId, "is_login": isLogin]
        case .loginPageShow: return nil
        case let .sendSms(isRetake): return ["is_retake": isRetake]
        case let .sendSmsError(errorCode, errorInfo): return ["error_code": errorCode, "error_info": errorInfo]
        case .userLogout: return nil
        }
    }
}
// swiftlint:enable identifier_name line_length number_separator type_body_length
