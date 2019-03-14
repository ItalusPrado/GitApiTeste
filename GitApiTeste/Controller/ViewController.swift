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
    
    var userSelected: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RequestManager.requestList(path: Github.listUsers){ (dictArray, loaded) in
            if loaded, let array = dictArray {
                for dict in array{
                    self.usersArray.append(User(dict: dict))
                }
                self.filtered = self.usersArray
                self.usersTableView.reloadData()
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            self.searchBar.resignFirstResponder()
            let vc = segue.destination as! DetailsViewController
            vc.user = self.userSelected
        }
    }
    
    @IBAction func searchUser(_ sender: Any) {
        let alert = UIAlertController(title: "Digite o nome para pesquisa", message: nil, preferredStyle: .alert)
        
        let cancelAction  = UIAlertAction(title: "Cancelar", style: .cancel)
        let yesAction = UIAlertAction(title: "Buscar", style: .default) { (_) in
            RequestManager.requestUserInformation(nick: alert.textFields![0].text!, completion: { (response) in
                let currentUser = User(dict: response)
                currentUser.getDetails(completion: { (_) in
                    currentUser.getRepos(completion: { (result) in
                        self.userSelected = currentUser
                        self.performSegue(withIdentifier: "showDetails", sender: self)
                    })
                    
                })
                
            })
        }
        
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Nome"
        })

        self.present(alert, animated: true, completion: nil)
    }

}

extension ViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
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
        self.userSelected = nil
        let user = filtered[indexPath.row]
        
        user.getDetails { (loaded) in
            if loaded{
                user.getRepos(completion: { (loaded) in
                    self.userSelected = self.filtered[indexPath.row]
                    self.performSegue(withIdentifier: "showDetails", sender: self)
                })
                
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
    }
    
}
