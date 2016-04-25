//
//  PageViewController.swift
//  PhotoPractice
//
//  Created by Charles on 2016. 4. 24..
//  Copyright © 2016년 Charles. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    
    var list = Array<UIViewController>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        delegate = self
        dataSource = self
        
        
        let aaa = self.storyboard?.instantiateViewControllerWithIdentifier("aaa")
        let bbb = self.storyboard?.instantiateViewControllerWithIdentifier("bbb")
        let ccc = self.storyboard?.instantiateViewControllerWithIdentifier("ccc")
        
        
        list.append(aaa!)
        list.append(bbb!)
        list.append(ccc!)
        
        setViewControllers([list[0]], direction: .Forward, animated: false, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    var page = 0
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
//        currentIndex -= 1
//        
//        if currentIndex <= 0{
//            currentIndex = 0
//            return nil
//        }else{
//            return list[currentIndex]
//        }
//        
        
        if page == 0{//이코드를 주석처리하면 순환페이지
            return nil
        }
        
        let currentIndex = list.indexOf(viewController)!
        let previousIndex = abs((currentIndex - 1) % list.count)
                page = previousIndex
        return list[previousIndex]
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
//        currentIndex += 1
//        
//        if currentIndex >= list.count{
//            currentIndex = list.count - 1
//            return nil
//        }else{
//            return list[currentIndex]
//        }
        
        if page == list.count-1{//이코드를 주석처리하면 순환페이지
            return nil
        }
        
        let currentIndex = list.indexOf(viewController)!
        let nextIndex = abs((currentIndex + 1) % list.count)
        page = nextIndex
        return list[nextIndex]
        
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return page
    }


    

    
}
