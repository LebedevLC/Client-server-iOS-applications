//
//  NewsCellFooter.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 07.08.2021.
//

import UIKit

final class NewsCellFooter: UITableViewCell {
    
    @IBOutlet private var footerView: UIView!
    
    static let reusedIdentifier = "NewsCellFooter"
    
    var likeTapped: (() -> Void)?
    var repostTapped: (() -> Void)?
    var commentTapped: (() -> Void)?
    var viewsTapped: (() -> Void)?

    private let likeView: LikeControl2 = {
        let likeView = LikeControl2()
        likeView.translatesAutoresizingMaskIntoConstraints = false
        return likeView
    }()
    
    private let repostView: RepostControl2 = {
        let repostView = RepostControl2()
        repostView.translatesAutoresizingMaskIntoConstraints = false
        return repostView
    }()
    
    private let commentControl: CommentControl2 = {
        let commentControl = CommentControl2()
        commentControl.translatesAutoresizingMaskIntoConstraints = false
        return commentControl
    }()
    
    private let viewsControl: ViewsControl = {
        let viewsControl = ViewsControl()
        viewsControl.translatesAutoresizingMaskIntoConstraints = false
        return viewsControl
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(comments: Comments, likes: Likes, reposts: Reposts, views: Views) {
        var isLike = false
        if likes.user_likes == 1 {
            isLike = true
        }
        likeView.configure(isLike: isLike,
                           likeCount: likes.count
        )
        likeView.controlTapped = {[weak self] in
            self?.likeTapped?()
        }
        repostView.configure(isRepost: false,
                             repostCount: reposts.count
        )
        repostView.controlTapped = {[weak self] in
            self?.repostTapped?()
        }
        commentControl.configure(isComment: false)
        commentControl.controlTapped = {[weak self] in
            self?.commentTapped?()
        }
        viewsControl.configure(viewsCount: views.count)
    }
    
    private func setView() {
        contentView.addSubview(likeView)
        NSLayoutConstraint.activate([
            likeView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            likeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            likeView.heightAnchor.constraint(equalToConstant: 25),
            likeView.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        contentView.addSubview(repostView)
        NSLayoutConstraint.activate([
            repostView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            repostView.trailingAnchor.constraint(equalTo: likeView.trailingAnchor, constant: -60),
            repostView.heightAnchor.constraint(equalToConstant: 25),
            repostView.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        contentView.addSubview(commentControl)
        NSLayoutConstraint.activate([
            commentControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            commentControl.trailingAnchor.constraint(equalTo: repostView.trailingAnchor, constant: -60),
            commentControl.heightAnchor.constraint(equalToConstant: 25),
            commentControl.widthAnchor.constraint(equalToConstant: 25)
        ])
        contentView.addSubview(viewsControl)
        NSLayoutConstraint.activate([
            viewsControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            viewsControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            viewsControl.heightAnchor.constraint(equalToConstant: 25),
            viewsControl.widthAnchor.constraint(equalToConstant: 25)
        ])
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    }
    
}
