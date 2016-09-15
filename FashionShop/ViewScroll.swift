    //
//  ViewScroll.swift
//  FashionShop
//
//  Created by Ngoc on 9/14/16.
//  Copyright © 2016 GDG. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var sld_Zoom: UISlider!
    
    var photo = UIImageView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let imgView = UIImageView(image: UIImage(named: "girl.jpg"))
        imgView.frame = CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height)
        imgView.userInteractionEnabled = true
        imgView.multipleTouchEnabled = true
        imgView.contentMode = .ScaleAspectFit
        
        
        photo = imgView
        
        scrollView.contentSize = CGSizeMake(imgView.bounds.width, imgView.bounds.height)
        
        
        scrollView.minimumZoomScale = 0.5
        
        scrollView.maximumZoomScale = 2
        
        scrollView.zoomScale = 0.5
        
        sld_Zoom.minimumValue = 0.5
        
        sld_Zoom.maximumValue = 2
        
        sld_Zoom.value = Float(scrollView.zoomScale)
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapImg:"))
        
        tap.numberOfTapsRequired = 1
        
        let doubleTap = UITapGestureRecognizer(target: self, action: Selector("doubleTapImg:"))
        
        doubleTap.numberOfTapsRequired = 2
        
        imgView.addGestureRecognizer(tap)
        
        imgView.addGestureRecognizer(doubleTap)
        
        tap.requireGestureRecognizerToFail(doubleTap)
        
        self.scrollView.addSubview(imgView)

        // Do any additional setup after loading the view.
        
        scrollView.backgroundColor = UIColor.brownColor()
    }

    func tapImg(gesture: UITapGestureRecognizer){
        
        let position = gesture.locationInView(photo)
        
        zoomRectForScale(scrollView.zoomScale * 1.5, center: position)

        sld_Zoom.value = Float(scrollView.zoomScale)
    }
    
    func doubleTapImg(gesture: UITapGestureRecognizer){
        
        let position = gesture.locationInView(photo)
        
        zoomRectForScale(scrollView.zoomScale * 0.5, center: position)
        
        sld_Zoom.value = Float(scrollView.zoomScale)
    }
    
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint){
        
        var zoomRect = CGRect()
        
        let scrollViewSize = scrollView.bounds.size
        
        zoomRect.size.height = scrollViewSize.height/scale
        
        zoomRect.size.width = scrollViewSize.width/scale
        
        zoomRect.origin.x = center.x - zoomRect.size.width/2.0
        
        zoomRect.origin.y = center.y - zoomRect.size.height/2.0
        
        scrollView.zoomToRect(zoomRect, animated: true)
        

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?{
        return photo
    }
    
    
    
    @IBAction func sld_zoom(sender: UISlider) {
        
        var value = CGFloat(sender.value)
        
        scrollView.setZoomScale(value  , animated: true)
    
    }
    
    
}
