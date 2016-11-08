//
//  OnyoInteraction.swift
//  OnyoDeepLink
//
//  Created by Matheus Cavalca on 11/8/16.
//  Copyright © 2016 Onyo. All rights reserved.
//

import Foundation
import Branch

@objc public class OnyoInteraction: NSObject {
    
    static private let onyoAppStoreId = "id1132629081"
    static private let itunesURL = "http://itunes.apple.com/app/\(onyoAppStoreId)"
    
    static private let openAggregatorScheme = "onyo://aggregator/"
    static private let aggregatorIdKey = "aggregatorId"
    
    @objc public static func openAggregator(aggregatorId: String, viewController: UIViewController? = nil) {
        if isOnyoAppInstalled() {
            UIApplication.sharedApplication().openURL(NSURL(string: openAggregatorScheme + aggregatorId)!)
        } else {
            useBranchInteraction(aggregatorId)
        }
    }
    
    @objc public static func isOnyoAppInstalled() -> Bool {
        return UIApplication.sharedApplication().canOpenURL(NSURL(string: "onyo://")!)
    }
    
}

extension OnyoInteraction {
    
    private static func useBranchInteraction(aggregatorId: String, viewController: UIViewController? = nil) {
        let branchUniversalObject: BranchUniversalObject = BranchUniversalObject(canonicalIdentifier: "item/1")
        branchUniversalObject.title = "Open Aggregator Link"
        branchUniversalObject.contentDescription = "Passing aggregatorId"
        branchUniversalObject.addMetadataKey(aggregatorIdKey, value: aggregatorId)
        
        let linkProperties: BranchLinkProperties = BranchLinkProperties()
        branchUniversalObject.getShortUrlWithLinkProperties(linkProperties) { (url, error) in
            if error == nil {
                if let viewController = viewController {
                    loadBranchRequest(url, viewController: viewController)
                } else if var topController = UIApplication.sharedApplication().keyWindow?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }
                    
                    loadBranchRequest(url, viewController: topController)
                }
            }
        }
    }
    
    private static func loadBranchRequest(url: String, viewController: UIViewController) {
        let webView = UIWebView()
        viewController.view.addSubview(webView)
        let req = NSURLRequest(URL: NSURL(string: url)!)
        webView.loadRequest(req)
        
        self.goToAppStore()
    }
    
    private static func goToAppStore() {
        if let url = NSURL(string: itunesURL) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
}