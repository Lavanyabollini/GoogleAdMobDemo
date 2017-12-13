//
//  ViewController.swift
//  GoogleAdMobDemo
//
//  Created by mobinius on 12/12/17.
//  Copyright © 2017 mobinius. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UITableViewController, GADBannerViewDelegate,GADInterstitialDelegate{
    
   var imagesArray=[UIImage]()
 var bannerView: GADBannerView!
    var interstitial: GADInterstitial?
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController!.isToolbarHidden = false

        imagesArray = [ UIImage(named: "Image1.png")!,
                            UIImage(named: "Image2.png")!,
                            UIImage(named: "Image3.png")!,
                            UIImage(named: "Image4.png")!
                            ]
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView?.adUnitID = "ca-app-pub-3827126407335086/6839878394"
        bannerView?.rootViewController = self
         bannerView?.load(GADRequest())
         bannerView?.delegate = self
        interstitial = createAndLoadInterstitial()
        
    }
    
   
    private func createAndLoadInterstitial() -> GADInterstitial? {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3827126407335086/6986437806")
        
        guard let interstitial = interstitial else {
            return nil
        }
        
        let request = GADRequest()
        // Remove the following line before you upload the app
        request.testDevices = [ kGADSimulatorID ]
        interstitial.load(request)
        interstitial.delegate = self
        
        return interstitial
    }
 
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("Interstitial loaded successfully")
        ad.present(fromRootViewController: self)
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        print("Fail to receive interstitial")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:-GADBannerView delegate methods
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        print("Banner loaded successfully")
        // Reposition the banner ad to create a slide down effect
        let translateTransform = CGAffineTransform(translationX:0, y: -bannerView.bounds.size.height)
        bannerView.transform = translateTransform
       
        UIView.animate(withDuration: 0.5) {
           // self.tableView.tableFooterView?.frame = bannerView.frame
            self.bannerView.transform = CGAffineTransform.identity
           // self.tableView.tableFooterView = self.bannerView

        }
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    
    //MARK:- UITableView Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewTableViewCell
        cell.postImageView.image=imagesArray[indexPath.row]
        return cell
    }
    //MARK:- UITableView Delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return bannerView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return bannerView.frame.height
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return bannerView
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return bannerView.frame.height
    }
}

