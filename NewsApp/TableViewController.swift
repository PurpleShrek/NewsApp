//
//  TableViewController.swift
//  NewsApp
//
//  Created by Zaitsev Aleksey on 15.05.2020.
//  Copyright © 2020 Zaitsev Aleksey. All rights reserved.
//

import UIKit


class TableViewController: UITableViewController {
    
    let myRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        loadNewsTableView()
    }
    // download news
    func loadNewsTableView() {
        loadNews {
            DispatchQueue.main.async {
                //старый рефреш контрол
                self.addRefreshControl()
                self.tableView.reloadData()
                self.finishedRefreshing()
            }
        }
    }
    
  // MARK: - Refresh control settings
    func addRefreshControl() {
        guard let customView = Bundle.main.loadNibNamed("CustomRefresh", owner: nil, options: nil) else { return }
        guard let refreshView = customView[0] as? UIView else { return }
        myRefreshControl.addSubview(refreshView)
        refreshView.tag = 2020
        refreshView.frame = myRefreshControl.frame
        myRefreshControl.tintColor = .red
        myRefreshControl.backgroundColor = .systemTeal
        myRefreshControl.addTarget(self, action: #selector(refreshContents), for: .valueChanged)
        if #available(iOS 13.0, *) {
            tableView.refreshControl = myRefreshControl
        } else {
            tableView.addSubview(myRefreshControl)
        }
    }
    
    @objc func refreshContents() {
        let refreshView = myRefreshControl.viewWithTag(2020)
        
        for vw in (refreshView?.subviews)! {
                if let titleLablel = vw as? UILabel {
                    titleLablel.text = "Refreshing contents"
                }
        }
        self.perform(#selector(finishedRefreshing), with: nil, afterDelay: 0)
    }
    
    @objc func finishedRefreshing() {
        myRefreshControl.endRefreshing()
        let refreshView = myRefreshControl.viewWithTag(2020)
        for vw in (refreshView?.subviews)! {
            if let titleLablel = vw as? UILabel {
                titleLablel.text = "Pull down to refresh this list"
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.publishedAt
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "detailSegue" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        (segue.destination as? OneNewsViewController)?.article = articles[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



