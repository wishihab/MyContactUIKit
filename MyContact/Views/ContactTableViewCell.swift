//
//  ContactTableViewCell.swift
//  MyContact
//
//  Created by Alwi Shihab on 21/11/22.
//

import UIKit
import SDWebImage

class ContactTableViewCell: UITableViewCell {
    
    //create identifier for register
    static let identifier = "ContactTableViewCell"

    //create imageview
    private let contactPictureImageView: UIImageView = {
        let picture = UIImageView()
        picture.contentMode = .scaleAspectFill
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.clipsToBounds = true
        
        //make it rounded/circle
            
        return picture
    }()
    
    //create textview
    private let contactLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //create textview
    private let contactNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contactLabel)
        contentView.addSubview(contactNumber)
        contentView.addSubview(contactPictureImageView)
        
        //create custom constraints
        applyConstraints()
        contactPictureImageView.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints(){
        let contactPictureImageViewConstrains = [
            contactPictureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contactPictureImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contactPictureImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        let contactLabelConstraints = [
            contactLabel.leadingAnchor.constraint(equalTo: contactPictureImageView.trailingAnchor, constant: 20),
            contactLabel.topAnchor.constraint(equalTo: contentView.firstBaselineAnchor, constant: 10)
        ]
        
        let contactNumberConstraints = [
            contactNumber.leadingAnchor.constraint(equalTo: contactPictureImageView.trailingAnchor, constant: 20),
            contactNumber.bottomAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 15)
        ]
        
        NSLayoutConstraint.activate(contactPictureImageViewConstrains)
        NSLayoutConstraint.activate(contactLabelConstraints)
        NSLayoutConstraint.activate(contactNumberConstraints)
    }
    
    
    //create set image load with sdimageview package
    public func configureImage(with model: ContactViewModel){
        guard let url = URL(string: model.pictureUrl) else{
            return
        }
        
        contactPictureImageView.sd_setImage(with: url, completed: nil)
        contactLabel.text = model.fullName
        contactNumber.text = model.phoneNumber
    }

}
