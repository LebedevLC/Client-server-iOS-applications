//
//  MoreGroupInfo.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 15.09.2021.
//

import UIKit

class MoreGroupInfo: UIViewController {
    
    var moreGroup = GroupsItems()
    
    @IBOutlet var nameGroupLabel: UILabel!
    @IBOutlet var shortDescriptionLabel: UILabel!
    @IBOutlet var fullDescriptionLabel: UILabel!
    @IBOutlet var adressGroupLabel: UILabel!
    @IBOutlet var dateCreatingGroupLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo(info: moreGroup)
    }

    func setInfo(info: GroupsItems) {
        nameGroupLabel.text = info.name
        shortDescriptionLabel.text = info.screen_name
        fullDescriptionLabel.text = info.descriptionGroup
        
        // test parameters
        adressGroupLabel.text = String(info.screen_name) + "_adress"
        dateCreatingGroupLabel.text = "15.09.21"
    }
    
}
