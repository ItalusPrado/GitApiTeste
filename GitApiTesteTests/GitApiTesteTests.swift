//
//  GitApiTesteTests.swift
//  GitApiTesteTests
//
//  Created by Italus Rodrigues do Prado on 12/03/19.
//  Copyright © 2019 Italus Rodrigues do Prado. All rights reserved.
//

import XCTest
@testable import GitApiTeste

class GitApiTesteTests: XCTestCase {

    var viewController: ViewController!
    var detailViewController: DetailsViewController!
    
    var array: [User]!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        viewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListController") as! ViewController)
        detailViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailController") as! DetailsViewController)
        
        detailViewController.loadViewIfNeeded()
        viewController.loadViewIfNeeded()
        
        let user1 = User(dict: ["login": "José"])
        let user2 = User(dict: ["login": "João"])
        let user3 = User(dict: ["login": "Jonas"])
        let user4 = User(dict: ["login": "Italus"])
        array = [user1,user2,user3]
    }
    
    func testTableViewSize(){
        viewController.usersArray = array
        viewController.filtered = viewController.usersArray
        //viewController.usersTableView.reloadData()
        XCTAssertEqual(viewController!.usersTableView!.numberOfRows(inSection: 0), array.count)
    }
    
    func testFilterSearch(){
        viewController.usersArray = array
        viewController.filtered = viewController.usersArray
        viewController.searchBar(viewController.searchBar, textDidChange: "jo")
        XCTAssertEqual(viewController!.usersTableView!.numberOfRows(inSection: 0), 3)
        
        viewController.searchBar(viewController.searchBar, textDidChange: "")
        XCTAssertEqual(viewController!.usersTableView!.numberOfRows(inSection: 0), array.count)
    }
    
    func testCell(){
        array.append(User(dict: ["id":1234]))
        viewController.usersArray = array
        viewController.filtered = viewController.usersArray
        
        
        
        for (index, user) in array.enumerated(){
            let cell = viewController.tableView(viewController.usersTableView, cellForRowAt: IndexPath(row: index, section: 0)) as! UsersTableViewCell
            
            if let login = user.login{
                XCTAssertEqual(login, cell.nameLabel.text)
            } else {
                XCTAssertEqual("Nickname não encontrado", cell.nameLabel.text)
            }
        }
        array.popLast()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

}
