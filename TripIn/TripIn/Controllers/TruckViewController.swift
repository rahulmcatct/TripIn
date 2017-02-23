//
//  TruckViewController.swift
//  TripIn
//
//  Created by Rahul Tamrakar on 21/02/17.
//  Copyright © 2017 Rahul Tamrakar. All rights reserved.
//

import UIKit

class TruckViewController: UIViewController, UIScrollViewDelegate, TruckSizeViewDelegate {

    var isTodaySelected:Bool = true

    weak var selectedTruckBody      : Truck?            // object for Selected Truck Body
    weak var selectedTruckCapacity  : TruckCapacity?    // object for Selected Truck Capacity
    var selectedTruckSize           : String?           // String for Selected Truck Size
    
    @IBOutlet weak var lblToday             : UILabel!
    @IBOutlet weak var lblTomorrow          : UILabel!
    @IBOutlet weak var selectionViewToday   : UIView!
    @IBOutlet weak var selectionViewTomorrow: UIView!
    @IBOutlet weak var lblAvailable         : UILabel!
    @IBOutlet weak var scrollTrucks         : UIScrollView!
    @IBOutlet weak var scrollCapacity       : UIScrollView!
    @IBOutlet weak var scrollSizes          : UIScrollView!
    @IBOutlet weak var btnAddTruck          : UIButton!
    
    var listTrucks          : Array<Truck> = []         // Array of Truck Body model objects
    var listTruckCapacity   : Array<TruckCapacity> = [] // Array of Truck Capacity model objects
    var listTruckSize       : Array<String> = []        // Array of Truck Sizes

    var cart    : CartView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupInitialValues()
        
        var index = 0
        var scrollFrameWidth : CGFloat = self.scrollTrucks.frame.size.width
        var scrollFrameHeight : CGFloat = self.scrollTrucks.frame.size.height
        
        for truck in listTrucks {
            let xOffset = scrollFrameWidth * CGFloat(index) // calculate x offset value for item
            let truckView:TruckView = TruckView(frame: CGRect(x: xOffset, y:CGFloat(0), width:scrollFrameWidth, height:scrollFrameHeight), truck: truck )
            scrollTrucks.addSubview(truckView)
            index = index + 1
        }
        scrollTrucks.contentSize = CGSize(width: scrollFrameWidth * CGFloat(index), height: scrollFrameHeight)
        
        index = 0
        scrollFrameWidth   = self.scrollCapacity.frame.size.width
        scrollFrameHeight  = self.scrollCapacity.frame.size.height
        for truckCapacity in listTruckCapacity {
            let xOffset = scrollFrameWidth * CGFloat(index) // calculate x offset value for item
            let truckCapacityLabel: UILabel = UILabel(frame: CGRect(x: xOffset, y: 0.0, width: scrollFrameWidth, height: scrollFrameHeight))
            truckCapacityLabel.text = truckCapacity.truckCapacity
            truckCapacityLabel.textAlignment = .center
            scrollCapacity.addSubview(truckCapacityLabel)
            index = index + 1
        }
        scrollCapacity.contentSize = CGSize(width: scrollFrameWidth * CGFloat(index), height: scrollFrameHeight)
        
        cart = CartView(frame: CGRect(x: 0, y: self.view.frame.size.height-80, width:self.view.frame.size.width , height: 80))
        cart?.hideCart()
        self.view.addSubview(cart!)
        
        // Select Today as default
        self.lblToday.text = todayDate
        selectionViewToday.isHidden = false
        selectionViewTomorrow.isHidden = true
        self.lblTomorrow.text = tomorrowDate

        self.refreshTruckSizesScrollView()
    }
    
    func setupInitialValues() {
        
        // Add dummy items in arrays
        
        listTrucks.append(Truck(truckType: "Platform Trailer", truckImageName: "Truck_Pltfrm_Trlr"))
        listTrucks.append(Truck(truckType: "3ft Openable body", truckImageName: "Truck_Open_Body"))
        listTrucks.append(Truck(truckType: "4ft Fixed body", truckImageName: "Truck_Full_Body"))
        listTrucks.append(Truck(truckType: "Half Solid & Half-Caged Body", truckImageName: "Truck_Open_Body"))
        listTrucks.append(Truck(truckType: "Full Body", truckImageName: "Truck_Full_Body"))
        
        listTruckCapacity.append(TruckCapacity(truckCapacity: "9/10mt", truckLengths: ["18ft","20ft","22ft","24ft"] , truckAvailable: 10, truckRent: 800))
        listTruckCapacity.append(TruckCapacity(truckCapacity: "16/18mt", truckLengths: ["20ft","22ft","24ft"] , truckAvailable: 15, truckRent: 1000))
        listTruckCapacity.append(TruckCapacity(truckCapacity: "20/21mt", truckLengths: ["22ft","24ft","26ft","28ft",] , truckAvailable: 12, truckRent: 1100))
        listTruckCapacity.append(TruckCapacity(truckCapacity: "28/29mt", truckLengths: ["24ft","28ft","32ft"] , truckAvailable: 17, truckRent: 1500))
        listTruckCapacity.append(TruckCapacity(truckCapacity: "32/33mt", truckLengths: ["30ft","36ft"] , truckAvailable: 9, truckRent: 2000))
        
        listTruckSize = listTruckCapacity[0].truckLengths!
        
        selectedTruckBody       = listTrucks[0]
        selectedTruckCapacity   = listTruckCapacity[0]
    }

    // Refresh truckSize scroll view
    func refreshTruckSizesScrollView() {
        for subview in scrollSizes.subviews {
            if subview.tag == 1001 {
                subview.removeFromSuperview()
            }
        }
        var index = 0
        for truckSize in listTruckSize {
            let xOffset = 100 * CGFloat(index) + 10
            let truckSizeView: TruckSizeView = TruckSizeView(frame: CGRect(x: xOffset, y:CGFloat(0), width:80, height:80), truckSize: truckSize, owner:self)
            truckSizeView.tag = 1001
            scrollSizes.addSubview(truckSizeView)
            index = index + 1
        }
        scrollSizes.contentSize = CGSize(width: CGFloat(100*index), height: 80)
        self.disableAddTruckButton()
        lblAvailable.text = "\(selectedTruckCapacity!.truckAvailable!) Available"
    }
    
    // Add Truck to cart action
    @IBAction func addTruckAction(_ sender: Any) {
        let cartItem = CartItem(truckType: selectedTruckBody!.truckBodyType!, truckCapacity: selectedTruckCapacity!.truckCapacity!, truckLength: selectedTruckSize!, truckRent: selectedTruckCapacity!.truckRent!)
        selectedTruckCapacity?.updateAvailability()
        self.cart?.addToCart(item: cartItem)
        
        self.refreshTruckSizesScrollView()
        cart?.showCart()
    }

    // enable Add Truck button
    func enableAddTruckButton() {
        btnAddTruck.backgroundColor = UIColor(red:0.26, green:0.81, blue:0.92, alpha:1.00)
        btnAddTruck.setTitleColor(UIColor.white, for: .normal)
        btnAddTruck.isEnabled = true
        
        btnAddTruck.layer.cornerRadius  = 8
        btnAddTruck.layer.borderColor   = UIColor(red:0.26, green:0.81, blue:0.92, alpha:1.00).cgColor
        btnAddTruck.layer.borderWidth   = 1
    }
    
    // disable Add Truck button
    func disableAddTruckButton() {
        btnAddTruck.backgroundColor = UIColor.white
        btnAddTruck.setTitleColor(UIColor.lightGray, for: .normal)
        btnAddTruck.isEnabled = false
        
        btnAddTruck.layer.cornerRadius  = 8
        btnAddTruck.layer.borderColor   = UIColor.lightGray.cgColor
        btnAddTruck.layer.borderWidth   = 1
    }
    
    // Delegate method of TruckSizeViewDelegate
    func touchUpInside(_ sizeView: TruckSizeView) {
        for view in scrollSizes.subviews {
            if view is TruckSizeView {
                if view == sizeView {
                    sizeView.setSelected()
                }
                else{
                    (view as! TruckSizeView).reset()
                }
            }
        }
        selectedTruckSize = sizeView.truckSize!
        self.enableAddTruckButton()
    }
    
    // Today button action
    @IBAction func todayAction(_ sender: Any) {
        self.isTodaySelected = true
        selectionViewToday.isHidden = false
        selectionViewTomorrow.isHidden = true
    }
    
    // Tomorrow button action
    @IBAction func tomorrowAction(_ sender: Any) {
        self.isTodaySelected = false
        selectionViewToday.isHidden = true
        selectionViewTomorrow.isHidden = false
    }

    // ScrollView delegate method
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Calculate current item offset index in scroll view
        let index = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
        if scrollView == scrollTrucks {
            selectedTruckBody = listTrucks[index]
            self.refreshTruckSizesScrollView()
        }
        else if scrollView == scrollCapacity {
            selectedTruckCapacity = listTruckCapacity[index]
            listTruckSize = (selectedTruckCapacity?.truckLengths)!
            self.refreshTruckSizesScrollView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
