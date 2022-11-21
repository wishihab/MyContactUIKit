//
//  MainViewController.swift
//  MyContact
//
//  Created by Alwi Shihab on 21/11/22.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
        
        //create NavigaitonController
        let randomUserCustomView = UINavigationController(rootViewController:  KontakViewController())
        
        randomUserCustomView.tabBarItem.image = UIImage(systemName: "person.crop.circle.badge.questionmark")
        
        randomUserCustomView.title = "Kontak"
        
        tabBar.tintColor = .label
        //init controller
        setViewControllers([randomUserCustomView], animated: true)
        
        var first = ["Cook", "Jobs"]
        let second = ["Ive", "Craig", "Chaterine"]

        //before append
        print(first)
        print(second)
                
        first.append(contentsOf: second) // why first? bcs second let != change
        print(first) // after append ["Cook", "Jobs", "Ive", "Craig", "Chaterine"]


    }


}
