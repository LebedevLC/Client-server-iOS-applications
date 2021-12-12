//
//  FriendsCollectionTableViewCell.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 24.10.2021.
//

import UIKit

class FriendsCollectionTableViewCell: UITableViewCell {
    
    static let identifier = "FriendsCollectionTableViewCell"
    
    private let collectionView: UICollectionView
    private var models = [CollectionTableCellModel]()
    
    private let friendsCount: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let mutualFriendsCount: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let allFriends: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = "Все друзья"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90, height: 115)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(FriendsTableCollectionViewCell.self, forCellWithReuseIdentifier: FriendsTableCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        contentView.addSubview(collectionView)
        contentView.addSubview(friendsCount)
        contentView.addSubview(mutualFriendsCount)
        contentView.addSubview(allFriends)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        friendsCount.frame = CGRect(
            x: 16,
            y: 8,
            width: 100,
            height: 16)
        mutualFriendsCount.frame = CGRect(
            x:132,
            y:8,
            width: 150,
            height: 16)
        collectionView.frame = CGRect(
            x: 0,
            y: 32,
            width: contentView.frame.width,
            height: contentView.frame.height-35)
        allFriends.frame = CGRect(
            x: contentView.frame.width - 121,
            y: 8,
            width: 105,
            height: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        friendsCount.text = nil
        mutualFriendsCount.text = nil
    }
    
    func configure(models: [CollectionTableCellModel], mutal: Int) {
        friendsCount.text = "Друзья  \(models.count)"
        mutualFriendsCount.text = "Общие друзья  \(mutal)"
        self.models = models
        collectionView.reloadData()
    }
    
}

extension FriendsCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FriendsTableCollectionViewCell.identifier,
            for: indexPath) as! FriendsTableCollectionViewCell
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
