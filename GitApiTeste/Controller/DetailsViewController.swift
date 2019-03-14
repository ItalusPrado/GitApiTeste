//
//  DetailsViewController.swift
//  GitApiTeste
//
//  Created by Italus Rodrigues do Prado on 12/03/19.
//  Copyright © 2019 Italus Rodrigues do Prado. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var reposTableView: UITableView!
    
    var user: User?
    
    var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        fillInformation()
    }
    
    func fillInformation(){
        if let user = self.user{
            
            // Dados da label
            self.nameLabel.text = user.details?.name ?? "-----"
            self.companyLabel.text = user.details?.company ?? "-----"
            self.emailLabel.text = user.details?.email ?? "-----"
            self.blogLabel.text = user.details?.blog ?? "-----"
            if self.blogLabel.text == ""{
                self.blogLabel.text = "-----"
            }
            self.locationLabel.text = user.details?.location ?? "-----"
            
            // Download da imagem
            downloadImage()
        }
    }
    
    func downloadImage() {
        guard let urlPath = self.user?.avatar_url else {return}
        if let url = URL(string: urlPath){
            DispatchQueue.global().async {
                if let data = try? Data( contentsOf:url){
                    DispatchQueue.main.async {
                        self.profileImage.image = UIImage( data:data)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGit"{
            let vc = segue.destination as! WebGitViewController
            vc.url = user?.repos![currentIndex!].html_url
        }
    }

}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Repositórios"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let repos = user?.repos{
            return repos.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reposTableView.dequeueReusableCell(withIdentifier: "reposCell") as! ReposTableViewCell
        cell.linkLabel.text = user?.repos![indexPath.row].repoName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row
        performSegue(withIdentifier: "showGit", sender: self)
    }
    
}
