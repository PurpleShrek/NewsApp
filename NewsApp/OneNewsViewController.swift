//
//  OneNewsViewController.swift
//  NewsApp
//
//  Created by Zaitsev Aleksey on 15.05.2020.
//  Copyright © 2020 Zaitsev Aleksey. All rights reserved.
//

import UIKit
import SafariServices
import Lottie

class OneNewsViewController: UIViewController {
    
    var index: Int = 0
    var article: Article!
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buttonBrowser: UIButton!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    
    @IBAction func buttonBrowserPressed(_ sender: UIButton) {
        guard let url = URL(string: article.url) else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBrowser.layer.cornerRadius = 12
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        
        // DispatchQueue.global(qos: .default).async {
        DispatchQueue.main.async {
            if self.article.urlToImage != "" {
                guard let url = URL(string: self.article.urlToImage) else { return }
                guard let data = try? Data(contentsOf: url) else { return }
                self.imageView.image = UIImage(data: data)
            } else {
                self.imageView.image = UIImage(named: "zaglushka")
            }
        }
        
        if URL(string: article.url) == nil {
            buttonBrowser.isEnabled = true
            buttonBrowser.backgroundColor = UIColor.gray
        }
        lottieAnimation()
    }
    
    func lottieAnimation() {
        let animationViewConst = AnimationView(name: "download_icon")
        animationViewConst.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        animationViewConst.center = self.view.center
        animationViewConst.contentMode = .scaleAspectFit
        view.addSubview(animationViewConst)
        animationViewConst.play()
        animationViewConst.loopMode = .loop
        
        
        
    }
    
}
