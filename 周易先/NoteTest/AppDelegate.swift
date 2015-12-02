//
//  AppDelegate.swift
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      // 啟動應用程序走的第一個定制方法。
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
          //使用此方法可暫停正在進行的工作。   
    }

    func applicationDidEnterBackground(application: UIApplication) {
        //當程序被推送到後台的時候調用。所以要設置後台繼續運行，則在這個函數里面設置即可 使用這個方法來釋放共享資源，保存用戶數據，廢止定時器，並存儲足夠的應用程序狀態信息的情況下被終止後，將應用程序恢復到目前的狀態。
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // 當程序從後台將要重新回到前台時候調用。
    }

    func applicationDidBecomeActive(application: UIApplication) {
         // 當應用程序處在不活動狀態時，重新啟動一個被暫停(或還未啟動)的任務。如果程序之前就在後台，根據情況可以刷新用戶界面。
    }

    func applicationWillTerminate(application: UIApplication) {
        // 當程序將要退出是被調用，通常是用來保存數據和一些退出前的清理工作。

    }


}

