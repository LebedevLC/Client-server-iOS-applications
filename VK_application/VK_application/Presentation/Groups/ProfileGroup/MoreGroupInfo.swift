//
//  MoreGroupInfo.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 15.09.2021.
//

import UIKit

class MoreGroupInfo: UIViewController {

    var group: GroupModel?
    
    @IBOutlet var nameGroupLabel: UILabel!
    @IBOutlet var shortDescriptionLabel: UILabel!
    @IBOutlet var fullDescriptionLabel: UILabel!
    @IBOutlet var adressGroupLabel: UILabel!
    @IBOutlet var dateCreatingGroupLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo(info: group!)
    }

    func setInfo(info: GroupModel) {
        nameGroupLabel.text = info.nameGroup
        shortDescriptionLabel.text = info.shortDescription
        fullDescriptionLabel.text = info.fullDescription
        
        // test parameters
        adressGroupLabel.text = String(info.nameGroup) + "_adress"
        dateCreatingGroupLabel.text = "15.09.21"
    }
    
}

