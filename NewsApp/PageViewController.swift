//
//  PageViewController.swift
//  NewsApp
//
//  Created by Zaitsev Aleksey on 16.05.2020.
//  Copyright © 2020 Zaitsev Aleksey. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.showVC()
        loadNews {
            self.showVC()
        }
    }
    @IBAction func refreshNewsButtonPressed(_ sender: UIBarButtonItem) {
        showVC()
    }
    
    func showVC() {
        DispatchQueue.main.async {
            guard let vc = self.pageViewController(for: 0) else { return }
            self.setViewControllers([vc], direction: .forward, animated: false, completion: nil)
        }
    }
    
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = ((viewController as? OneNewsViewController)?.index ?? 0) - 1
        return self.pageViewController(for: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = ((viewController as? OneNewsViewController)?.index ?? 0) + 1
        return self.pageViewController(for: index)
    }
    
    func pageViewController(for index: Int) -> OneNewsViewController? {
        if index < 0 {
            return nil
        } else if index >= articles.count {
            return nil
        }
        
        let vc = (storyboard?.instantiateViewController(withIdentifier: "oneNewsSID") as! OneNewsViewController)
        vc.article = articles[index]
        vc.index = index
        return vc
    }
}
