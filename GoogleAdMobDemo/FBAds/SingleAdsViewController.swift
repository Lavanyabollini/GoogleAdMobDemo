//
//  SingleAdsViewController.swift
//  AdsTutorial
//
//  Created by Gabriel Theodoropoulos on 29/07/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit

class SingleAdsViewController: UIViewController, FBNativeAdDelegate  {

    @IBOutlet weak var viewAdContainer: UIView!
    
    @IBOutlet weak var lblAdTitle: UILabel!
    
    @IBOutlet weak var lblAdBody: UILabel!
    
    @IBOutlet weak var imgAdIcon: UIImageView!
    
    @IBOutlet weak var btnAdAction: UIButton!
    
    @IBOutlet weak var lblSocialContext: UILabel!
 
    var nativeAd: FBNativeAd!
    
    var coverMediaView: FBMediaView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewAdContainer.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    @IBAction func loadNativeAd(sender: AnyObject) {
        nativeAd = FBNativeAd(placementID: "135908590442099_135909610441997")
        nativeAd.mediaCachePolicy = FBNativeAdsCachePolicy.video
        nativeAd.delegate = self
        nativeAd.load()
    }
    
    func nativeAdDidLoad(_ nativeAd: FBNativeAd) {
        handleLoadedNativeAdUsingCustomViews()
    }
    
    
    func nativeAd(_ nativeAd: FBNativeAd, didFailWithError error: Error) {
        print(error)
    }
   
    
   
    func handleLoadedNativeAdUsingCustomViews() {
        // Set the ad title.
        lblAdTitle.text = nativeAd.title
        
        // Set the ad body (if exists).
        if let body = nativeAd.body {
            lblAdBody.text = body
        }
        
        // Set the title of the call-to-action button.
        btnAdAction.setTitle(nativeAd.callToAction, for:[])
        
        // Load and display the ad icon image.
        nativeAd.icon?.loadAsync(block: { (iconImage) in
            if let image = iconImage {
                self.imgAdIcon.image = image
            }
        })
        
        // Create a cover media view and assign the native ad object to it (it will display image(s) or video, depending on what ad contains).
        let yPoint = lblAdBody.frame.origin.y + lblAdBody.frame.size.height + 8.0
//        CGRect(origin: CGPoint(x:lblAdBody.frame.origin.x ,y :yPoint), size: CGSize(width: lblAdBody.frame.size.width, height: lblSocialContext.frame.origin.y - yPoint - 8.0))
        let coverMediaViewFrame = CGRect(origin: CGPoint(x:lblAdBody.frame.origin.x ,y :yPoint), size: CGSize(width: lblAdBody.frame.size.width, height: lblSocialContext.frame.origin.y - yPoint - 8.0))
        let coverMediaView = FBMediaView(frame: coverMediaViewFrame)
        coverMediaView.clipsToBounds = true
        coverMediaView.nativeAd = nativeAd
        viewAdContainer.addSubview(coverMediaView)
        
        
        // Set the social context title (if exists).
        if let socialContext = nativeAd.socialContext {
            lblSocialContext.text = socialContext
        }
        // Add the AdChoices view.
        let adChoicesView = FBAdChoicesView(nativeAd: nativeAd)
        viewAdContainer.addSubview(adChoicesView)
        adChoicesView.updateFrameFromSuperview()
        // Use this to make the whole ad container view interact when tapping.
        nativeAd.registerView(forInteraction: viewAdContainer, with: self)
        //     //   // Use this to make the call-to-action interactive only.
        //    //    nativeAd.registerViewForInteraction(viewAdContainer, withViewController: self, withClickableViews: [btnAdAction])
        // Make the native ad view container visible.
        viewAdContainer.isHidden = false
   
    }
    
//    func handleLoadedNativeAdUsingCustomViews() {
//     
//        // Add the AdChoices view.
//        let adChoicesView = FBAdChoicesView(nativeAd: nativeAd)
//        viewAdContainer.addSubview(adChoicesView)
//        adChoicesView.updateFrameFromSuperview()
//        // Make the native ad view container visible.
//        viewAdContainer.isHidden = false
//        // Use this to make the whole ad container view interact when tapping.
//        nativeAd.registerViewForInteraction(viewAdContainer, withViewController: self)
//     //   // Use this to make the call-to-action interactive only.
//    //    nativeAd.registerViewForInteraction(viewAdContainer, withViewController: self, withClickableViews: [btnAdAction])
//        
//    }
}
