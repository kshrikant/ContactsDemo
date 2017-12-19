//
//  CommonMethods.swift
//  TheFloat
//
//  Created by webwerks on 05/07/17.
//  Copyright © 2017 neosottech. All rights reserved.
//

import UIKit
import Spring
import SVProgressHUD


typealias anyDict = [String: Any]

class CommonMethods: NSObject {
    
    static let sharedInstance = CommonMethods()
    static let getScreenSize = UIScreen.main.bounds
    
    //MARK:-
    //MARK: AlertMessage
    
    func alertMessage(_ title:String, message:String, currentVC:UIViewController ) -> Void {
        
        let alert = UIAlertController(title: title as String, message:message as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        DispatchQueue.main.async(execute: {
            currentVC.present(alert, animated: true, completion: nil)
            
        })
    }
    
    func showNetworkAlert(currentVC:UIViewController) {
        let alert = UIAlertController(title: "Oops! Something went wrong." , message:"Please check your internet connection and try again." , preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        DispatchQueue.main.async(execute: {
            currentVC.present(alert, animated: true, completion: nil)
        })
    }
    
    
    func AlertForNoData(message:String, viewController:UIViewController, arrData:[AnyObject]) -> UIView {
        if arrData.isEmpty == false || arrData.count>0 {
            let view = UIView()
            let lblAlert = UILabel()
            view.frame = CGRect(x: 0, y: 65, width: viewController.view.frame.size.width, height: 50)
            
            lblAlert.frame = CGRect(x: 20, y: 10, width: viewController.view.frame.size.width-40, height: 30)
            lblAlert.textAlignment = .center
            lblAlert.font = FTTheme.Font.AllerRegular(FTTheme.FontSizes.subTitleSize)
            lblAlert.textColor = FTTheme.Color.BlackColor
            lblAlert.numberOfLines = 0
            lblAlert.text = message
            view.addSubview(lblAlert)
            return view
        }
        else {
            return UIView()
        }
        
    }
    
    //MARK:-
    //MARK: Convert JSON Data into dict
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    //MARK:-
    //MARK: Add Gradient Layer
    
    func addBackgorundGradientLayer(viewController : UIViewController) {
        
        let backgroundImage = UIImageView()
        
        backgroundImage.frame = CGRect.init(x: 0, y: 0, width: CommonMethods.getScreenSize.width, height: CommonMethods.getScreenSize.height)
        
        backgroundImage.image = UIImage.init(named: FTConstant.ImageAssetNames.appBackground)
        
        viewController.view.insertSubview(backgroundImage, at: 0)
    }
    
    //MARK:-
    //MARK: One pixel bottom of the view
    
    func onePixelBottomBorder(_ containerView: UIView) -> UIView  {
        let view = UIView(frame: CGRect(x: 0, y: containerView.frame.height-1, width: CommonMethods.getScreenSize.width, height: 0.5))
        view.backgroundColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.00)
        return view
    }
    
    //MARK:-
    //MARK: Make Transparent navigation bar
    
    func makeNavigationBarToTransparent(navigationBar: UINavigationBar?) {
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage()
        navigationBar?.isTranslucent = true
    }
    
    //MARK:-
    //MARK: Setup Navigation bar
    
    func setUpNavigationBar(navigationController: UINavigationController?, title: String) -> CustomNavigationBar {
        navigationController?.navigationBar.isHidden = true
        let navigationBar = UINib(nibName: "CustomNavigationBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? CustomNavigationBar
        navigationBar?.frame = CGRect(x: 0, y: 0, width: CommonMethods.getScreenSize.width, height: 65)
        navigationBar?.labelTitle.text = title
        navigationBar?.labelTitle.font = FTTheme.Font.AllerBold(18.0)
        navigationBar?.labelTitle.textColor = FTTheme.Color.WhiteColor
        navigationController?.view.addSubview(navigationBar!)
        navigationController?.view.bringSubview(toFront: navigationBar!)
        return navigationBar!
    }
    
    func setUpNavigationBarUsingViewController(controller: UIViewController?, title: String) -> CustomNavigationBar {
        let navigationBar = UINib(nibName: "CustomNavigationBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? CustomNavigationBar
        navigationBar?.frame = CGRect(x: 0, y: 0, width: CommonMethods.getScreenSize.width, height: 65)
        navigationBar?.labelTitle.text = title
        navigationBar?.labelTitle.font = FTTheme.Font.AllerBold(18.0)
        navigationBar?.labelTitle.textColor = FTTheme.Color.WhiteColor
        controller?.view.addSubview(navigationBar!)
        controller?.view.bringSubview(toFront: navigationBar!)
        return navigationBar!
    }
    
    
    
    //MARK:-
    //MARK:- Setup Complete textfield
    
    func setupTextFieldCompletely(textfield:DesignableTextField, imageName:String) -> () {
        textfield.addCustomLeftView(leftImage: UIImage(named: imageName)!)
        textfield.placeholderColor = FTTheme.Color.WhiteColor
    }
    
    func setupTextFieldLeftIcon(textfield:DesignableTextField, imageName:String, iconWidth:CGFloat,iconHeight:CGFloat, leftPadding:CGFloat, rightPaddingToIcon:CGFloat) -> () {
        textfield.setLeftIcon((UIImage(named: imageName)!), iconWidth: iconWidth,iconHeight:iconHeight, leftPadding: leftPadding, rightPaddingToIcon: rightPaddingToIcon)
        textfield.placeholderColor = FTTheme.Color.WhiteColor
    }
    
    
    func setupTextFieldCompletelyForTwoImages(textfield:DesignableTextField, leftImageName:String, rightImageName:String) -> () {
        textfield.addCustomLeftViewAndRightView(leftImage: UIImage(named: leftImageName)!, rightImage: UIImage(named: rightImageName)!)
        textfield.placeholderColor = FTTheme.Color.WhiteColor
    }
    
    
    
    //MARK:-
    //MARK:- Move textfield upwards
    
    func animateViewMoving (up:Bool, moveValue :CGFloat, viewController:UIViewController){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        
        viewController.view.frame = viewController.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    //MARK:-
    //MARK:- SVProgressHUD methods
    
    static func setLoaderStyle() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setBackgroundColor(UIColor(white: 0, alpha: 0.8))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setMinimumDismissTimeInterval(0.3)
    }
    
    static func loaderShow(_ text: String = "Loading...") {
        SVProgressHUD.show(withStatus: text)
    }
    
    static func loaderSuccess(_ text: String = "") {
        CommonMethods.loaderHide()
        SVProgressHUD.showSuccess(withStatus: text)
    }
    
    static func loaderError(_ text: String = "") {
        CommonMethods.loaderHide()
        SVProgressHUD.showError(withStatus: text)
    }
    
    static func loaderShowProgress(_ progress: Float, message: String) {
        SVProgressHUD.showProgress(progress, status: message)
    }
    
    static func loaderHide() {
        SVProgressHUD.dismiss()
    }
    static func showActivityIndicator(_ status: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = status
    }
    
    //MARK:-
    //MARK:- Customview Nib methods
    
    static func instanceFromNib(nibName:String) -> UIView {
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}
