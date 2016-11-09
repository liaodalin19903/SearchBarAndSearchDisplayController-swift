//
//  ViewController.swift
//  SearchDisplayControllerDemoSwift
//
//  Created by 优谱德 on 2016/11/9.
//  Copyright © 2016年 youpude. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var friendsArr: [FriendItem] = []
    var filteredFriendsArr: [FriendItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
    }
    
    func initData(){
    
        self.friendsArr.append(FriendItem(name: "whoareu"))
        self.friendsArr.append(FriendItem(name: "liaomaer"))
        self.friendsArr.append(FriendItem(name: "guess"))
        self.friendsArr.append(FriendItem(name: "liaodalin"))
        self.friendsArr.append(FriendItem(name: "pertty"))
        
        tableView.reloadData()
    }

    // MARK: - tableVIew
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            
            return self.filteredFriendsArr.count
        }else {
            
            return self.friendsArr.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        var friend: FriendItem
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            
            friend = self.filteredFriendsArr[indexPath.row]
        }else {
        
            friend = self.friendsArr[indexPath.row]
        }
        
        // 配置cell 
        cell.textLabel?.text = friend.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var friend: FriendItem
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            
            friend = self.filteredFriendsArr[indexPath.row]
        }else {
            friend = self.friendsArr[indexPath.row]
        }
        
        print(friend.name)
    }
    
    // MARK: - search 
    
    func filterContentForSearchText(searchText: String, scope: String = "Title")    {
        
        self.filteredFriendsArr = self.friendsArr.filter({(friend: FriendItem) -> Bool in
            let categoryMatch = (scope == "Title")
            let stringMatch = friend.name.range(of: searchText)
            
            return categoryMatch && (stringMatch != nil)
        })
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearch searchString: String?) -> Bool {
        self.filterContentForSearchText(searchText: searchString!, scope: "Title")
        
        return true
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        
        self.filterContentForSearchText(searchText: (self.searchDisplayController?.searchBar.text)!, scope: "Title")
        
        return true
    }
    
}

