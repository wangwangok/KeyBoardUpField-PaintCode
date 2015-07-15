//
//  ViewController.swift
//  KeyBoardUpField
//
//  Created by 王望 on 15/5/31.
//  Copyright (c) 2015年 王望. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var supConstraint: NSLayoutConstraint!

    @IBOutlet weak var superView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var numberKitView: NumberKitView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDidShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onHide:", name: UIKeyboardWillHideNotification, object: nil)
        (self.view.viewWithTag(10) as! UITextField).delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.textField.resignFirstResponder()
    }
    
    func onDidShow(notification:NSNotification){
        print("onDidShow\((notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().height)\n")
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            //Y轴平移-(notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().height的距离
            self.view.transform = CGAffineTransformMakeTranslation(0, -(notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().height)
            }) { (Bool) -> Void in
        }
    }
    
    func onHide(notification:NSNotification){
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            //Y轴平移-(notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().height的距离
            self.view.transform = CGAffineTransformMakeTranslation(0, 0)
            }) { (Bool) -> Void in
        }
    }
    //MARK: - IBAction -
    @IBAction func onSend(sender: UIButton) {
        (self.view.viewWithTag(10) as! UITextField).resignFirstResponder()
        numberKitView.number = (self.view.viewWithTag(10) as! UITextField).text.toInt()!
        numberKitView.setNeedsDisplay()
    }
    
    @IBAction func onAdd(sender: UIButton) {
        numberKitView.number += 1
        if(numberKitView.number > 9){
           numberKitView.number = 0
        }
        numberKitView.setNeedsDisplay()
    }
    
    //MARK: - UITextField Delegate -
    func textFieldDidEndEditing(textField: UITextField) {
        if(count(textField.text) > 1){
            textField.text = textField.text.substringToIndex(advance(textField.text.startIndex, 1))
        }
    }
    
}
@IBDesignable
class NumberKitView: UIView {
    @IBInspectable var textColor:UIColor!
    @IBInspectable var backGroundColor:UIColor!
    var number:Int = 0
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        switch (self.number){
        case 0:
            NumberKit.drawNumber10(textColor: self.textColor, backGroundColor: self.backGroundColor)
        case 1:
            NumberKit.drawNumber11(textColor: self.textColor, backGroundColor: self.backGroundColor)
        case 2:
            NumberKit.drawNumber12(textColor: self.textColor, backGroundColor: self.backGroundColor)
        case 3:
            NumberKit.drawNumber13(textColor: self.textColor, backGroundColor: self.backGroundColor)
        case 4:
            NumberKit.drawNumber14(textColor: self.textColor, backGroundColor: self.backGroundColor)
        case 5:
            NumberKit.drawNumber15(textColor: self.textColor, backGroundColor: self.backGroundColor)
        case 6:
            NumberKit.drawNumber16(textColor: self.textColor, backGroundColor: self.backGroundColor)
        case 7:
            NumberKit.drawNumber17(textColor: self.textColor, backGroundColor: self.backGroundColor)
        case 8:
            NumberKit.drawNumber18(textColor: self.textColor, backGroundColor: self.backGroundColor)
        case 9:
            NumberKit.drawNumber19(textColor: self.textColor, backGroundColor: self.backGroundColor)
        default:
            break
        }
    }
}

