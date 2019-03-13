//
//  ViewController.swift
//  GitApiTeste
//
//  Created by Italus Rodrigues do Prado on 12/03/19.
//  Copyright © 2019 Italus Rodrigues do Prado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var usersTableView: UITableView!
    
    var usersArray = [User]()
    var filtered = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        
        RequestManager.requestList(){ (dictArray) in
            for dict in dictArray{
                self.usersArray.append(User(dict: dict))
            }
            self.filtered = self.usersArray
            self.usersTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            let vc = segue.destination as! DetailsViewController
        
        }
    }


}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty{
            filtered = usersArray
            self.usersTableView.reloadData()
            return
        }
        
        filtered = usersArray.filter({ (dict) -> Bool in
            dict.login!.lowercased().contains(searchText.lowercased())
        })
        self.usersTableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "userCell") as! UsersTableViewCell
        
        if let login = filtered[indexPath.row].login{
            cell.nameLabel.text = login
            cell.nameLabel.textColor = .black
        } else {
            cell.nameLabel.text = "Nickname não encontrado"
            cell.nameLabel.textColor = .red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        RequestManager.requestUserInformation(nick: filtered[indexPath.row].login) { (response) in
            <#code#>
        }
    }
    
    
}
