//
//  RewardedAdHelper.swift
//  spritekittest
//
//  Created by Николай Лаврентьев on 21.03.2023.
//

import GoogleMobileAds

var doAdsWork: Bool = false

class RewardedAdHelper : NSObject, GADFullScreenContentDelegate {
    private var rewardedAd : GADRewardedAd?
    let defaults = UserDefaults.standard
    
    func loadRewardedAd() {
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: "ca-app-pub-1982973540768035/8737518145", request: request) { [self] ad, error in
            if let error = error {
                print("Failed to load reward ad with error: \(error.localizedDescription)")
                doAdsWork = false
                return
            }
            doAdsWork = true
            rewardedAd = ad
            rewardedAd?.fullScreenContentDelegate = self
        }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        loadRewardedAd()
    }
    
    func showRewardedAd(viewController: UIViewController) {
        if rewardedAd != nil {
            rewardedAd!.present(fromRootViewController: viewController, userDidEarnRewardHandler: {
                let reward = self.rewardedAd!.adReward
                print("\(reward.amount) \(reward.type)")
                oldmoney = money
                money += 15
                moneyLabel.countFrom(CGFloat(oldmoney), to: CGFloat(money))
                self.defaults.set(money, forKey: moneyKey)
            })
        } else {
            print("RewardedAd wasn't ready")
        }
    }
}
