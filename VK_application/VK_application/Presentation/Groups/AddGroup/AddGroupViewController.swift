//
//  AddGroupViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 13.07.2021.
//

import UIKit

final class AddGroupViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tapedInAvatar: Bool = false
    var indexPathForAddGroup: IndexPath?
    
    var groups = [GroupModel]()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        groups = GroupStorage().allGroups
    }
}

extension AddGroupViewController: UITabBarDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: AddGroupCell.reusedIdentifire, for: indexPath) as? AddGroupCell
        else {
            return UITableViewCell()
        }
        groups = groups.sorted(by: { $0.nameGroup < $1.nameGroup})
        let group = groups[indexPath.row]
        cell.configure(group: group)
        cell.avatarTapped = { [weak self] in
            self?.tapedInAvatar = true
            self?.indexPathForAddGroup = indexPath
            self?.performSegue(withIdentifier: "addGroup", sender: indexPath)
        }
        return cell
    }
     
}
