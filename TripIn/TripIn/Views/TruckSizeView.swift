//
//  TruckSizeView.swift
//  TripIn
//
//  Created by Rahul Tamrakar on 22/02/17.
//  Copyright © 2017 Rahul Tamrakar. All rights reserved.
//
//  Custom view for TruckSize circle view

import UIKit

// Protocol TruckSizeViewDelegate
protocol TruckSizeViewDelegate {
     func touchUpInside(_ sizeView: TruckSizeView)
}

class TruckSizeView: UIView {

    var truckSize:String?
    
    var delegate: TruckSizeViewDelegate?
    var lblSize : UILabel!
    
    init(frame: CGRect, truckSize:String, owner:Any) {
        super.init(frame: frame)
        
        self.truckSize = truckSize
        self.delegate = owner as? TruckSizeViewDelegate
        
        self.layer.cornerRadius = frame.size.width/2
        self.layer.borderColor  = UIColor.lightGray.cgColor
        self.layer.borderWidth  = 1.0
        
        lblSize  = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        lblSize.text = truckSize as String
        lblSize.textAlignment = .center
        lblSize.textColor = UIColor.gray
        self.addSubview(lblSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // set TruckSizeView to selected mode
    func setSelected() {
        lblSize.textColor = UIColor.white
        self.backgroundColor = UIColor(red:0.26, green:0.81, blue:0.92, alpha:1.00)
    }

    // reset TruckSizeView to default mode
    func reset() {
        lblSize.textColor = UIColor.gray
        self.backgroundColor = UIColor.white
    }
    
    // UIView touch delegate method
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.delegate != nil) {
            self.delegate?.touchUpInside(self)
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
