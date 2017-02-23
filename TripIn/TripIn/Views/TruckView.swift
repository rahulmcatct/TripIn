//
//  TruckView.swift
//  TripIn
//
//  Created by Rahul Tamrakar on 21/02/17.
//  Copyright © 2017 Rahul Tamrakar. All rights reserved.
//
//  Custom view for Truck Body

import UIKit

class TruckView: UIView {
    
    // Initialize TruckView with Truck model
    init(frame: CGRect, truck:Truck) {
        super.init(frame: frame)
        
        let imageView : UIImageView = UIImageView(frame: CGRect(x:0,y:0,width:frame.size.width,height:frame.size.height-30))
        imageView.contentMode = .center
        imageView.image = UIImage(named: truck.truckImageName!)
        self.addSubview(imageView)
        
        let lblBodyName : UILabel = UILabel(frame: CGRect(x:0,y:frame.size.height-30,width:frame.size.width,height:30))
        lblBodyName.text = truck.truckBodyType
        lblBodyName.textAlignment = .center
        self.addSubview(lblBodyName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
