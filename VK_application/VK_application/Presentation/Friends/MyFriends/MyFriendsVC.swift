//
//  AllFriendsViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 10.07.2021.
//

import UIKit

class MyFriendsVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var afFriends = FriendsGet()
    var friedsAloma: [FriendsItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getFriensAloma()
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFriensAloma()
    }
    
    func getFriensAloma() {
        afFriends.getFriends() {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let friends):
                self.friedsAloma = friends
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure:
                print("getFriensAloma FAIL")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "moveToPhoto",
            let destinationController = segue.destination as? PhotoFriendViewController
        else { return }
        guard let indexPath = sender as? IndexPath else {return}
        let friend = friedsAloma[indexPath.row]
        destinationController.userID = friend.id
        destinationController.title = friend.first_name + " " + friend.last_name
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        tableView.reloadData()
    }
}

// MARK: - Extension MyFriends Delegate, DataSourse

extension MyFriendsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friedsAloma.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reusedIdentifire, for: indexPath) as? FriendsTableViewCell
        else {
            return UITableViewCell()
        }
        friedsAloma = friedsAloma.sorted(by: { $0.first_name < $1.first_name})
        let friend = friedsAloma[indexPath.row]
        cell.configure(friend: friend, indexPathFromTable: indexPath)
        cell.avatarTapped = { [weak self] in
            self?.performSegue(withIdentifier: "moveToPhoto", sender: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friedsAloma.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "moveToPhoto", sender: indexPath)
    }
}

