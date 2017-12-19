//
//  ViewController.swift
//  InnoplexusContactsAssignment
//
//  Created by Shrikant Kanakatti on 12/18/17.
//  Copyright © 2017 Shrikant Kanakatti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:-
    //MARK: Variable declaration
    
    let apiClient =  APIClient()
    var contactList = [ContactDetails]()
    @IBOutlet weak var tableViewContacts: UITableView!
    var isAscendingContacts = true
    
    
    //MARK:-
    //MARK: View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.fetchContacts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:-
    //MARK: Helper methods & button events
    
    func setupUI() {
        
        CommonMethods.loaderShow()
        
        tableViewContacts.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCell")
    }
    
    func fetchContacts() {
        
        apiClient.fetchContactList { (isContactList, contactList) in
            
            if isContactList {
                CommonMethods.loaderHide()
                self.contactList = contactList.sorted { $0.name < $1.name }
                DispatchQueue.main.async() {
                    self.tableViewContacts.reloadData()
                }
            }
            else{
                CommonMethods.loaderError("Failed to fetch contact list")
            }
        }
        
    }
    
    @IBAction func buttonSortContactsClick(_ sender: Any) {
        
        if isAscendingContacts {
            self.contactList = contactList.sorted { $0.name > $1.name }
            isAscendingContacts = false
        }
        else{
            self.contactList = contactList.sorted { $0.name < $1.name }
            isAscendingContacts = true
        }
        self.tableViewContacts.reloadData()
        
    }

}

//MARK:-
//MARK:Table view data source

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as? ContactTableViewCell

        let contact = contactList[indexPath.row]
        
        cell?.labelName.text =  contact.name
        cell?.labelEmail.text = contact.email
        cell?.labelAddress.text = contact.addressDetails.street
        cell?.labelComapny.text = contact.companyDetails.name
        
        return cell!
    }
 
}
