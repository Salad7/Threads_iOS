//
//  ContactViewController.swift
//  Threads
//
//  Created by cci-loaner on 11/6/17.
//  Copyright © 2017 YurpInc. All rights reserved.
//

import UIKit
import Contacts
import MessageUI

class ContactViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMessageComposeViewControllerDelegate {
    @IBAction func sendInvite(_ sender: UIButton) {
        for i in 0 ... contacts.count-1 {
            if(contacts[i].getSend()){
                phoneNumbersSelected.append(contacts[i].getPhone())
            }
        }
            let controller = MFMessageComposeViewController()
            controller.body = "Check out this post on Threads! "+self.threadInvite
            controller.recipients = phoneNumbersSelected
            controller.messageComposeDelegate = self as! MFMessageComposeViewControllerDelegate
            self.present(controller, animated: true, completion: nil)
        
        
    }
    @IBOutlet var contactsTableView: UITableView!
    var cncontacts = [CNContact]()
    var contacts = [Contact]()
    var phoneNumbersSelected = [String]()
    var threadInvite = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        cncontacts = fetchContacts()
        for i in 0 ... cncontacts.count-1 {
            var contact = Contact()
            contact.setName(n: cncontacts[i].givenName)
            contact.setPhone(p: String(describing: cncontacts[i].phoneNumbers[0]))
            contact.setInitial(i: cncontacts[i].givenName[0])
            contacts.append(contact)
            
        }
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func fetchContacts() -> [CNContact]{
        var contactStore = CNContactStore()
        var contacts = [CNContact]()
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            try contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                // Array containing all unified contacts from everywhere
                contacts.append(contact)
            }
        }
        catch {
            print("unable to fetch contacts")
        }
        return contacts
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            //print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
            //print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            //print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        default:
            break;
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact_cell") as! ContactTableViewCell
        
         cell.contactInital.text = contacts[indexPath.row].getInitial()
         cell.contactName.text = contacts[indexPath.row].getName()
         cell.phoneNumber.text = contacts[indexPath.row].getPhone()
        
        return cell
    }
    
    

}
extension String {

subscript (i: Int) -> String {
return String(self[i])
    }
}
