//
//  CartView.swift
//  TripIn
//
//  Created by Rahul Tamrakar on 22/02/17.
//  Copyright © 2017 Rahul Tamrakar. All rights reserved.
//
//  View for Cart
import UIKit

class CartView: UIView {
    
    let btnArrow:UIButton = UIButton(type: UIButtonType.custom)
    
    let lblTotalItems:UILabel   = UILabel()
    let lblTotalPayload:UILabel = UILabel()
    let lblTotalAmount:UILabel  = UILabel()
    
    var cartItems : [CartItem]  = [] // Array for cart items
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        let backGroundView = UIView(frame: CGRect(x: 0, y: 15, width: frame.size.width, height: frame.size.height-15))
        backGroundView.backgroundColor = UIColor(red:0.26, green:0.81, blue:0.92, alpha:1.00)
        self.addSubview(backGroundView)
        
        btnArrow.frame = CGRect(x: frame.size.width/2 - 50, y: 0, width: 100, height: 50)
        btnArrow.setImage(UIImage.init(named: "down-arrow"), for: .normal)
        self.addSubview(btnArrow)
        self.btnArrow.addTarget(self, action: #selector(cartArrowAction), for: UIControlEvents.touchUpInside)

        lblTotalItems.frame     = CGRect(x: 0, y: 30, width: frame.size.width/3.0, height: 40)
        lblTotalPayload.frame   = CGRect(x: frame.size.width/3.0, y: 30, width: frame.size.width/3.0, height: 40)
        lblTotalAmount.frame    = CGRect(x: frame.size.width/1.5, y: 30, width: frame.size.width/3.0, height: 40)
        
        lblTotalItems.textAlignment = .center
        lblTotalPayload.textAlignment = .center
        lblTotalAmount.textAlignment = .center
        
        lblTotalItems.textColor = UIColor.white
        lblTotalPayload.textColor = UIColor.white
        lblTotalAmount.textColor = UIColor.white
        
        self.addSubview(lblTotalItems)
        self.addSubview(lblTotalPayload)
        self.addSubview(lblTotalAmount)
        
        lblTotalItems.text = "Total 0"
        lblTotalAmount.text = "₹ 0"

    }
    
    func addToCart(item:CartItem) {
        print("addToCart")
        cartItems.append(item)
        lblTotalItems.text = "Total \(cartItems.count)"
        
        var totalCartAmount = 0
        for cartItem in cartItems {
            totalCartAmount += cartItem.truckRent!
        }
        lblTotalAmount.text = "₹ \(totalCartAmount)"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // cart arrow button action
    func cartArrowAction() {
        if self.tag == 0 {
            self.showCart()
        }
        else{
            self.hideCart()
        }
    }
    
    // Show cart with animation
    func showCart() {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {() -> Void in
            self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-80, width:UIScreen.main.bounds.width , height: 80)
        }, completion: { _ in self.tag = 1})
    }

    // Hide cart with animation
    func hideCart() {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {() -> Void in
            self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-30, width:UIScreen.main.bounds.width , height: 80)
        }, completion: { _ in self.tag = 0})
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath.init(ovalIn: CGRect(x: rect.size.width/2 - 50, y: 0, width: 100, height: 40))
        UIColor(red:0.26, green:0.81, blue:0.92, alpha:1.00).setFill()
        path.fill()

    }

}
