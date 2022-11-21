//
//  DetailViewController.swift
//  MyContact
//
//  Created by Alwi Shihab on 21/11/22.
//

import UIKit
import SDWebImage
import MapKit

class DetailViewController: UIViewController {
    let shareButton = UIButton()
    var pictureUrl = String()
    var fullName = String()
    var gender = String()
    var ages = String()
    var email = String()
    var phone = String()
    var cellPhone = String()
    var address = String()
    var koordinate = String()
    var lat = String()
    var long = String()
    //let userPassed = UserDefaults.standard
    private var model = [String]()
    
    let scrollView = UIScrollView();
    let contentView = UIView()
    
    let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let splitGender: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let splitAge: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let splitEmail: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let splitTelp: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let splitCell: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let splitAddress: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let splitCoor: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let nameText: UILabel = {
        let nameText = UILabel()
        nameText.translatesAutoresizingMaskIntoConstraints = false
        return nameText
    }()
    
    let genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.text = "Jenis kelamin"
        return genderLabel
    }()
    
    let genderText: UILabel = {
        let genderText = UILabel()
        genderText.translatesAutoresizingMaskIntoConstraints = false
        return genderText
    }()
    
    let ageLabel: UILabel = {
        let ageLabel = UILabel()
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.text = "Usia"
        return ageLabel
    }()
    
    let ageText: UILabel = {
        let ageText = UILabel()
        ageText.translatesAutoresizingMaskIntoConstraints = false
        return ageText
    }()
    
    let emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.text = "Email"
        return emailLabel
    }()
    
    let emailText: UILabel = {
        let emailText = UILabel()
        emailText.translatesAutoresizingMaskIntoConstraints = false
        emailText.textColor = .blue
        return emailText
    }()
    
    let telpLabel: UILabel = {
        let telpLabel = UILabel()
        telpLabel.translatesAutoresizingMaskIntoConstraints = false
        telpLabel.text = "Telepon"
        return telpLabel
    }()
    
    let telpText: UILabel = {
        let telpText = UILabel()
        telpText.translatesAutoresizingMaskIntoConstraints = false
        telpText.textColor = .blue
        return telpText
    }()
    
    let cellLabel: UILabel = {
        let cellLabel = UILabel()
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.text = "Seluler"
        return cellLabel
    }()
    
    let cellText: UILabel = {
        let cellText = UILabel()
        cellText.translatesAutoresizingMaskIntoConstraints = false
        cellText.textColor = .blue
        return cellText
    }()
    
    let addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.text = "Alamat"
        return addressLabel
    }()
    
    let addressText: UILabel = {
        let addressText = UILabel()
        addressText.translatesAutoresizingMaskIntoConstraints = false
        addressText.numberOfLines = 0
        return addressText
    }()
    
    let coorLabel: UILabel = {
        let coorLabel = UILabel()
        coorLabel.translatesAutoresizingMaskIntoConstraints = false
        coorLabel.text = "Koordinat"
        return coorLabel
    }()
    
    let coorText: UILabel = {
        let coorText = UILabel()
        coorText.translatesAutoresizingMaskIntoConstraints = false
        coorText.textColor = .blue
        return coorText
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "Rincian Kontak"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(scrollView)
        setupScrollView()
        setupLayoutView()
        
        applyOnClick()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    

    override func viewDidAppear(_ animated: Bool) {
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        let buttonItem = UIBarButtonItem(customView: shareButton)
        navigationItem.rightBarButtonItem = buttonItem
        
        shareButton.addTarget(self, action: #selector(presentShare), for: .touchUpInside)
    }
    
    private func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
    }
    
    private func setupLayoutView(){
        
        contentView.addSubview(headerImageView)
        contentView.addSubview(nameText)
        contentView.addSubview(genderLabel)
        contentView.addSubview(genderText)
        contentView.addSubview(splitGender)
        contentView.addSubview(splitAge)
        contentView.addSubview(splitEmail)
        contentView.addSubview(splitTelp)
        contentView.addSubview(splitCell)
        contentView.addSubview(splitAddress)
        contentView.addSubview(splitCoor)
        contentView.addSubview(ageLabel)
        contentView.addSubview(ageText)
        contentView.addSubview(emailLabel)
        contentView.addSubview(emailText)
        contentView.addSubview(telpLabel)
        contentView.addSubview(telpText)
        contentView.addSubview(cellLabel)
        contentView.addSubview(cellText)
        contentView.addSubview(addressLabel)
        contentView.addSubview(addressText)
        contentView.addSubview(coorLabel)
        contentView.addSubview(coorText)
        
        guard let url = URL(string: pictureUrl) else{
            return
        }
        
        headerImageView.sd_setImage(with: url, completed: nil)
        headerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        headerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        headerImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        headerImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        nameText.text = fullName
        nameText.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 15).isActive = true
        nameText.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        nameText.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        genderLabel.bottomAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 25).isActive = true
        genderLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        genderLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        genderText.text = gender
        genderText.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10).isActive = true
        genderText.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        genderText.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        splitGender.topAnchor.constraint(equalTo: genderText.bottomAnchor, constant: 5).isActive = true
        splitGender.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        splitGender.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

        ageLabel.topAnchor.constraint(equalTo: splitGender.bottomAnchor, constant: 10).isActive = true
        ageLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        ageLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

        ageText.text = ages
        ageText.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10).isActive = true
        ageText.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        ageText.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        splitAge.topAnchor.constraint(equalTo: ageText.bottomAnchor, constant: 5).isActive = true
        splitAge.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        splitAge.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: splitAge.bottomAnchor, constant: 10).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

        emailText.text = email
        emailText.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        emailText.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        emailText.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        splitEmail.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 5).isActive = true
        splitEmail.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        splitEmail.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        telpLabel.topAnchor.constraint(equalTo: splitEmail.bottomAnchor, constant: 10).isActive = true
        telpLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        telpLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

        telpText.text = phone
        telpText.topAnchor.constraint(equalTo: telpLabel.bottomAnchor, constant: 10).isActive = true
        telpText.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        telpText.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        splitTelp.topAnchor.constraint(equalTo: telpText.bottomAnchor, constant: 5).isActive = true
        splitTelp.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        splitTelp.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        cellLabel.topAnchor.constraint(equalTo: splitTelp.bottomAnchor, constant: 10).isActive = true
        cellLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        cellLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

        cellText.text = cellPhone
        cellText.topAnchor.constraint(equalTo: cellLabel.bottomAnchor, constant: 10).isActive = true
        cellText.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        cellText.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        splitCell.topAnchor.constraint(equalTo: cellText.bottomAnchor, constant: 5).isActive = true
        splitCell.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        splitCell.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: splitCell.bottomAnchor, constant: 10).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        addressLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

        addressText.text = address
        addressText.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10).isActive = true
        addressText.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        addressText.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        splitAddress.topAnchor.constraint(equalTo: addressText.bottomAnchor, constant: 5).isActive = true
        splitAddress.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        splitAddress.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        coorLabel.topAnchor.constraint(equalTo: splitAddress.bottomAnchor, constant: 10).isActive = true
        coorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        coorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

        coorText.text = koordinate
        coorText.topAnchor.constraint(equalTo: coorLabel.bottomAnchor, constant: 10).isActive = true
        coorText.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        coorText.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        splitCoor.topAnchor.constraint(equalTo: coorText.bottomAnchor, constant: 5).isActive = true
        splitCoor.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        splitCoor.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc private func presentShare(){
        let value = [fullName, email, cellPhone]
        let shareSheet = UIActivityViewController(activityItems: value as [Any], applicationActivities: nil)
        
        present(shareSheet, animated: true)
        
    }
    
    private func applyOnClick(){
        let tapName = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapName(sender:)))
        nameText.isUserInteractionEnabled = true
        nameText.addGestureRecognizer(tapName)
        
        let tapMail = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapEmail(sender:)))
        emailText.isUserInteractionEnabled = true
        emailText.addGestureRecognizer(tapMail)
        
        let tapPhone = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapPhone(sender:)))
        telpText.isUserInteractionEnabled = true
        telpText.addGestureRecognizer(tapPhone)
        
        let tapCell = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapCell(sender:)))
        cellText.isUserInteractionEnabled = true
        cellText.addGestureRecognizer(tapCell)
        
//        let tapCoor = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapCoordinate(sender:)))
        let tapCoor = UITapGestureRecognizer(target: self, action:
            #selector(DetailViewController.askToOpenMap))
        coorText.isUserInteractionEnabled = true
        coorText.addGestureRecognizer(tapCoor)
        
    }
    
    @objc func tapName(sender:UITapGestureRecognizer) {
        print("name clicked")
        UIPasteboard.general.string = fullName
        self.showToast(message: "Berhasil disalin", font: .systemFont(ofSize: 12.0))
    }
    
    @objc func tapEmail(sender:UITapGestureRecognizer) {
        print("email clicked")
        if let mailUrl = URL(string: "mailto:\(email)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(mailUrl)) {
                application.open(mailUrl, options: [:], completionHandler: nil)
            }else{
                self.showToast(message: "App not found", font: .systemFont(ofSize: 12.0))
            }
        }
        return
    }
    
    @objc func tapPhone(sender:UITapGestureRecognizer) {
        print("phone clicked")
        let a = phone.replacingOccurrences(of: " ", with: "")
        let b = a.replacingOccurrences(of: "-", with: "")
        let c = b.replacingOccurrences(of: "(", with: "")
        let filterPhone = c.replacingOccurrences(of: ")", with: "")
        
        if let phoneCallURL = URL(string: "tel://\(filterPhone)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }else{
                self.showToast(message: "App not found", font: .systemFont(ofSize: 12.0))
            }
        }
        return
    }
    
    @objc func tapCell(sender:UITapGestureRecognizer) {
        print("cell clicked")
        let a = cellPhone.replacingOccurrences(of: " ", with: "")
        let b = a.replacingOccurrences(of: "-", with: "")
        let c = b.replacingOccurrences(of: "(", with: "")
        let filterPhone = c.replacingOccurrences(of: ")", with: "")
        
        if let phoneCallURL = URL(string: "tel://\(filterPhone)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }else{
                self.showToast(message: "App not found", font: .systemFont(ofSize: 12.0))
            }
        }
        return
    }
    
    @objc func askToOpenMap() {
        OpenMapDirections.present(in: self, sourceView: coorText, fullName: fullName, lat: Double(lat) ?? 0, long: Double(long) ?? 0)
    }
    
    @objc func tapCoordinate(sender:UITapGestureRecognizer) {
        print("coordinate clicked")
        
        //uncomment bellow var to test in simualtor, nearest place map simulator
        //lat = "37.7826737"
        //long = "-122.410428"
        let latDob = Double(lat) ?? 0
        let longDob = Double(long) ?? 0
        let coordinate = CLLocationCoordinate2DMake(latDob,longDob)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = "\(fullName) location"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        
    }

}


extension DetailViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-500, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
