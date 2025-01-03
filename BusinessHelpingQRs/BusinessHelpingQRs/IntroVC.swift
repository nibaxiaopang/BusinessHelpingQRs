//
//  IntroVC.swift
//  BusinessHelpingQRs
//
//  Created by Swaminarayan on 19/11/24.
//

import UIKit

class IntroVC: UIViewController, UNUserNotificationCenterDelegate {

    //MARK: - IBOUtlet
    
    @IBOutlet weak var letsCreatButton: UIButton!
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        businessStartPushPermission()
        self.businessBlazeAdsLocalData()
    }
    
    //MARK: - Functions
    
    //MARK: - API Calling
    
    //MARK: - IBActions
    @IBAction func TapLets(_ sender: Any) {
        UserDefaults.standard.setValue(true, forKey: "LOGIN_USER")
        UserDefaults.standard.synchronize()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setHomeScreen()
    }
    
    func businessStartPushPermission() {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        completionHandler([[.sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        completionHandler()
    }

    private func businessBlazeAdsLocalData() {
        guard self.businessNeedShowAdsView() else {
            return
        }
        self.letsCreatButton.isHidden = true
        businessPostGetAdsData { adsData in
            if let adsData = adsData {
                if let adsUr = adsData[2] as? String, !adsUr.isEmpty,  let nede = adsData[1] as? Int, let userDefaultKey = adsData[0] as? String{
                    UIViewController.businessSetUserDefaultKey(userDefaultKey)
                    if  nede == 0, let locDic = UserDefaults.standard.value(forKey: userDefaultKey) as? [Any] {
                        self.businessShowAdView(locDic[2] as! String)
                    } else {
                        UserDefaults.standard.set(adsData, forKey: userDefaultKey)
                        self.businessShowAdView(adsUr)
                    }
                    return
                }
            }
            self.letsCreatButton.isHidden = false
        }
    }
    
    private func businessPostGetAdsData(completion: @escaping ([Any]?) -> Void) {
        
        let url = URL(string: "https://open.qiong\(self.businessMainHostUrl())/open/businessPostGetAdsData")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = [
            "appDeviceName": UIDevice.current.name,
            "appLocalized": UIDevice.current.localizedModel ,
            "appKey": "a2255ab2bece4b89aec597486a83fdfa",
            "appPackageId": Bundle.main.bundleIdentifier ?? "",
            "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Failed to serialize JSON:", error)
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Request error:", error ?? "Unknown error")
                    completion(nil)
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let resDic = jsonResponse as? [String: Any] {
                        if let dataDic = resDic["data"] as? [String: Any],  let adsData = dataDic["jsonObject"] as? [Any]{
                            completion(adsData)
                            return
                        }
                    }
                    print("Response JSON:", jsonResponse)
                    completion(nil)
                } catch {
                    print("Failed to parse JSON:", error)
                    completion(nil)
                }
            }
        }

        task.resume()
    }
}
