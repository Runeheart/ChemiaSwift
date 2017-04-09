//
//  WalkthroughPageViewController.swift
//  ChemiaSwift
//
//  Created by Chase Thiebaut on 4/9/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource{
    
    var pageHeadings = ["Formula Type", "Create Formula", "Valence Electrons", "Skeleton", "Octets", "Bonds"]
    var pageImages = ["walkthrough1", "walkthrough2", "walkthrough3", "walkthrough4", "walkthrough5", "walkthrough6"]
    var pageContent = ["Click [Choose an example formula] to pick from 3 premade formulas or [Enter a formula] to create your own.", "Pick the center atom in your formula in the top section. In the bottom sections select an attached atom and its quantity.", "Pick the correct number of valence electrons in the formula and click submit to continue.", "Click on the gray boxes until the desired atom appears for the boxes in center atoms and attached atoms. Then click the correct bond type and submit to continue.", "Click the correct number of pairs around the center and attached atoms and click submit to check your answer and continue.", "Finally, if your formula calls for it, select the correct number of bonds and dot pairs to complete the correct structure and click submit to finish."]
    
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        return contentViewController(at: index)
    }
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        return contentViewController(at: index)
    }
    
    
    func contentViewController(at index: Int) -> WalkthroughContentViewController?
    {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        // Create a new view controller and pass suitable data.
        if let pageContentViewController =
            storyboard?.instantiateViewController(withIdentifier:
                "WalkthroughContentViewController") as? WalkthroughContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.content = pageContent[index]
            pageContentViewController.index = index
            return pageContentViewController
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let startingViewController = contentViewController(at: 0){
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageHeadings.count
    }
    


    func forward(index: Int){
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }

    }
    

    
}
