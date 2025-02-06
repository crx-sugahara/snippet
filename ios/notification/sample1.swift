import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // プッシュ通知の許可をリクエスト
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // プッシュ通知受信時の処理
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [String : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // ペイロードを解析
        if let aps = userInfo["aps"] as? [String: Any], let alert = aps["alert"] as? [String: Any], let url = alert["url"] as? String {
            // WebView を開く
            if let topController = UIApplication.shared.keyWindow?.rootViewController {
                let webViewVC = WebViewController()
                webViewVC.loadURL(urlString: url)
                topController.present(webViewVC, animated: true, completion: nil)
            }
        }
        completionHandler(.newData)
    }

    // プッシュ通知トークン取得時の処理
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // FCM トークンを登録
        // ...
    }

    // プッシュ通知エラー時の処理
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // エラー処理
        // ...
    }
}
