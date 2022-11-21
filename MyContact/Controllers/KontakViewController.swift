//
//  ViewController.swift
//  MyContact
//
//  Created by Alwi Shihab on 21/11/22.
//

import UIKit

class KontakViewController: UIViewController {
    //let userPassing = UserDefaults.standard
    let refreshControl = UIRefreshControl()
    private var contacts: [Contacts] = [Contacts]()
    private var filterContacts: [Contacts] = [Contacts]()
    
    private let contactTable: UITableView = {
        let table = UITableView()
        table.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        return table
    }()

    //create searchController
    private let searchCustomController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        //activate keyboard focus
        controller.searchBar.becomeFirstResponder()
        
        controller.searchBar.sizeToFit()
        controller.searchBar.placeholder = "Search for a contact"
        controller.searchBar.searchBarStyle = .prominent
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "Kontak"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(contactTable)
        contactTable.delegate = self
        contactTable.dataSource = self
        
        //init updater search result?
        navigationItem.searchController = searchCustomController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchCustomController.searchResultsUpdater = self
        
        //add refresh pull
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        contactTable.addSubview(refreshControl)
        
        fetchContactData()
    }
    
    @objc func refresh(_ sender: Any) {
        //  your code to reload tableView
        fetchContactData()
        refreshControl.endRefreshing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //searchCustomController.isActive = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contactTable.frame = view.bounds
    }
    
    private func fetchContactData(){
        APICaller.shared.getContactList{ [weak self] result in
            switch result{
            //set result success and update when search
            case.success(let contacts):
                self?.contacts = contacts
                DispatchQueue.main.async {
                    self?.contactTable.reloadData()
                }
            //set failed fetch data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}


extension KontakViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchCustomController.isActive && (searchCustomController.searchBar.text != "")){
            return filterContacts.count
        }else{
            return contacts.count
        }
    }
    
    
    //init configureimage to tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell else {
            return UITableViewCell()
        }
        
        if(searchCustomController.isActive && (searchCustomController.searchBar.text != "")){
            let filters = filterContacts[indexPath.row]
            let name: String = ((filters.name.first ?? "") + " " + (filters.name.last ?? ""))
            
            cell.configureImage(with: ContactViewModel(fullName: (name), phoneNumber: (filters.cell ?? filters.phone) ?? "" ,pictureUrl: (filters.picture.thumbnail ?? filters.picture.medium) ?? ""))
        }else{
            let contact = contacts[indexPath.row]
            let name: String = ((contact.name.first ?? "") + " " + (contact.name.last ?? ""))
            
            cell.configureImage(with: ContactViewModel(fullName: (name), phoneNumber: (contact.cell ?? contact.phone) ?? "" ,pictureUrl: (contact.picture.thumbnail ?? contact.picture.medium) ?? ""))
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        
        if(searchCustomController.isActive && (searchCustomController.searchBar.text != "")){
            let filter = filterContacts[indexPath.row]
            
            
            vc.pictureUrl = filter.picture.large ?? ""
            vc.fullName = ((filter.name.first ?? "") + " " + (filter.name.last ?? ""))
            if(filter.gender == "female"){
                vc.gender = "Perempuan"
            }else{
                vc.gender = "Laki-Laki"
            }
            let ageString = "\(filter.dob.age ?? 0) tahun"
            vc.ages = ageString
            vc.email = filter.email ?? ""
            vc.phone = filter.phone ?? ""
            vc.cellPhone = filter.cell ?? ""
            vc.address = ((filter.location.street.name ?? "") + "\n" + (filter.location.city ?? "") + "\n" + (filter.location.state ?? "") + "\n" + (filter.location.country ?? ""))
            vc.koordinate = ((filter.location.coordinates.latitude ?? "") + "," + (filter.location.coordinates.longitude ?? ""))
            vc.lat = filter.location.coordinates.latitude ?? ""
            vc.long = filter.location.coordinates.longitude ?? ""
        }else{
            let contact = contacts[indexPath.row]
            //userPassing.set(contact.picture.large, forKey: "pictureUrl")
            //didTapItem()
            //print(contact)
            
            vc.pictureUrl = contact.picture.large ?? ""
            vc.fullName = ((contact.name.first ?? "") + " " + (contact.name.last ?? ""))
            if(contact.gender == "female"){
                vc.gender = "Perempuan"
            }else{
                vc.gender = "Laki-Laki"
            }
            let ageString = "\(contact.dob.age ?? 0) tahun"
            vc.ages = ageString
            vc.email = contact.email ?? ""
            vc.phone = contact.phone ?? ""
            vc.cellPhone = contact.cell ?? ""
            vc.address = ((contact.location.street.name ?? "") + "\n" + (contact.location.city ?? "") + "\n" + (contact.location.state ?? "") + "\n" + (contact.location.country ?? ""))
            vc.koordinate = ((contact.location.coordinates.latitude ?? "") + "," + (contact.location.coordinates.longitude ?? ""))
            vc.lat = contact.location.coordinates.latitude ?? ""
            vc.long = contact.location.coordinates.longitude ?? ""
        }
        
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapItem(){
        let vc = DetailViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension KontakViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchCustomController: UISearchController) {
        let searchBar = searchCustomController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else{
            
            self.contactTable.reloadData()
            return
        }
        
        filterForSearch(searchText: searchCustomController.searchBar.text!)
    }
    
    func filterForSearch(searchText:String, scope:String="ALL"){
        filterContacts = contacts.filter{($0.name.first?.contains(searchText) ?? $0.name.last?.contains(searchText) ?? false) || ($0.name.last?.contains(searchText) ?? $0.name.first?.contains(searchText) ?? false) }
        
        self.contactTable.reloadData()
    }
    
}
