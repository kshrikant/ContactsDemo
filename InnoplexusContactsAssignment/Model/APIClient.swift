//
//  APIClient.swift
//  InnoplexusContactsAssignment
//
//  Created by Shrikant Kanakatti on 12/18/17.
//  Copyright © 2017 Shrikant Kanakatti. All rights reserved.
//

import UIKit

struct ContactDetails {
    
    var name, userName, phone, email, website : String
    var userId : Int?
    var addressDetails : ContactAddressDetails
    var companyDetails : ContactCompanyDetails

    init(jsonData: anyDict) {
        
        self.name = jsonData["name"] as? String ?? ""
        self.userName = jsonData["username"] as? String ?? ""
        self.phone = jsonData["phone"] as? String ?? ""
        self.website = jsonData["website"] as? String ?? ""
        self.email = jsonData["email"] as? String ?? ""
        self.userId = jsonData["id"] as? Int ?? 0
        
        let address = jsonData["address"] as? anyDict ?? anyDict()
        let company = jsonData["company"] as? anyDict ?? anyDict()
        
        self.addressDetails = ContactAddressDetails(jsonData: address)
        self.companyDetails = ContactCompanyDetails(jsonData: company)
        
    }
}


struct ContactAddressDetails {
    
    var street, city, zipcode,suite, latitude, longitude : String
    
    init(jsonData: anyDict) {
        
        self.street = jsonData["street"] as? String ?? ""
        self.city = jsonData["city"] as? String ?? ""
        self.zipcode = jsonData["zipcode"] as? String ?? ""
        self.suite = jsonData["suite"] as? String ?? ""
        self.latitude = ""
        self.longitude = ""
        
        if let geoDetails = jsonData["geo"] as? anyDict {
            self.latitude = geoDetails["lat"] as? String ?? ""
            self.longitude = geoDetails["lng"] as? String ?? ""
        }
        
    }
}

struct ContactCompanyDetails {
    
    var name, comapnyPharse, companyBs: String
    
    init(jsonData: anyDict) {
        
        self.name = jsonData["name"] as? String ?? ""
        self.comapnyPharse = jsonData["catchPhrase"] as? String ?? ""
        self.companyBs = jsonData["bs"] as? String ?? ""

    }
}


class APIClient: NSObject {
    
    
    func fetchContactList(completion: @escaping (_ isContactList : Bool, [ContactDetails]) -> Void) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print("Error unwrapping URL"); return }
        
        let session = URLSession.shared
        var contactList = [ContactDetails]()

        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            guard let unwrappedData = data else { print("Error getting data"); return }
            
            do {
              
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? [anyDict] {
                    
                    contactList = responseJSON.map({return ContactDetails(jsonData: $0)})
                    completion(true, contactList)
                    
                }
            } catch {
                completion(false, contactList)
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
         dataTask.resume()
    }

}
