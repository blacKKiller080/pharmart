import Flutter
import UIKit
import HalykIDSDK

public class MyHalykIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "my_halyk_ios", binaryMessenger: registrar.messenger())
    let instance = MyHalykIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initializeHalykID":
            initializeHalykID(call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func initializeHalykID(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? [String: Any],
              let clientID = arguments["clientID"] as? String,
              let scope = arguments["scope"] as? String,
              let redirectURL = arguments["redirectURL"] as? String,
              let state = arguments["state"] as? String?,
              let localization = arguments["localization"] as? String,
              let configuration = arguments["configuration"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
            return
        }

        // Convert localization and configuration to appropriate types
        let halykIDLocalization = HalykIDLocalizationCode(rawValue: localization) ?? .kaz
        let halykIDConfiguration = (configuration == "development") ? .development : .production

        let halykIDObj = HalykID(
            clientID: clientID,
            scope: scope,
            redirectURL: redirectURL,
            state: state,
            localization: halykIDLocalization,
            configuration: halykIDConfiguration
        )

        // Do something with halykIDObj, for example, store it as a property in your plugin class
        // ...

        result(nil)
    }
}