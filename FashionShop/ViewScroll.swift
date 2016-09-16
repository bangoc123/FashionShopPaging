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
    
    @IBOutlet weak var pageController: UIPageControl!
    
    var photo = UIImageView()
    
    var pageImages: [String] = []
    
    var first = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pageImages = ["girl", "girl2","girl3", "girl4"]
        
        pageController.currentPage = 0
        
        pageController.numberOfPages = pageImages.count
        

        scrollView.minimumZoomScale = 0.5
        
        scrollView.maximumZoomScale = 2
        
        
     
        
        
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        if(!first){
            first = true
            
            let pagesScrollViewSize = scrollView.frame.size
            
            scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), 0)
            
            scrollView.pagingEnabled = true
            
            for(var i = 0; i < pageImages.count; i++){
                
                let imgView = UIImageView(image: UIImage(named: pageImages[i] + ".jpg"))
                
                imgView.frame = CGRectMake(CGFloat(i) * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)
                
                imgView.contentMode = .ScaleAspectFit
                
                scrollView.backgroundColor = UIColor.blackColor()
                
                self.scrollView.addSubview(imgView)
             
                
                if(i == 0){
                    photo = imgView
                }
            }
        
        
        
        }
        
        
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
    
    @IBAction func onChange(sender: AnyObject) {
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width * CGFloat(pageController.currentPage), 0)
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let width = scrollView.frame.size.width
        let page =  scrollView.contentOffset.x / width
        
        pageController.currentPage = Int(page)
    }
    
//    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        let width = scrollView.frame.size.width
//        let page =  scrollView.contentOffset.x / width
//        
//        pageController.currentPage = Int(page)
//    }
//    
    
}
