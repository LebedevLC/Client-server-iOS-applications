//
//  LoadingViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 11.09.2021.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet var animationView: UIView!
    
    private var firstPoint: UILabel = {
        let firstPoint = UILabel()
        firstPoint.translatesAutoresizingMaskIntoConstraints = false
        firstPoint.text = "."
        firstPoint.textColor = UIColor.label
        firstPoint.font = UIFont.boldSystemFont(ofSize: 150)
        return firstPoint
    }()
    private var secondPoint: UILabel = {
        let secondPoint = UILabel()
        secondPoint.translatesAutoresizingMaskIntoConstraints = false
        secondPoint.text = "."
        secondPoint.textColor = UIColor.label
        secondPoint.font = UIFont.boldSystemFont(ofSize: 150)
        return secondPoint
    }()
    private var thirdPoint: UILabel = {
        let thirdPoint = UILabel()
        thirdPoint.translatesAutoresizingMaskIntoConstraints = false
        thirdPoint.text = "."
        thirdPoint.textColor = UIColor.label
        thirdPoint.font = UIFont.boldSystemFont(ofSize: 150)
        return thirdPoint
    }()
    private var loadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Идет загрузка..."
        label.textColor = UIColor.label
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstr()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationSecond()
    }
    
    private func setConstr() {
        view.addSubview(firstPoint)
        NSLayoutConstraint.activate([
            firstPoint.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
            firstPoint.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        view.addSubview(secondPoint)
        NSLayoutConstraint.activate([
            secondPoint.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            secondPoint.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.addSubview(thirdPoint)
        NSLayoutConstraint.activate([
            thirdPoint.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            thirdPoint.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 40)
        ])
        view.addSubview(loadingLabel)
        NSLayoutConstraint.activate([
            loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func animationSecond() {
        UIView.animateKeyframes(withDuration: 1,
                                delay: 0,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0.15,
                                                       relativeDuration: 0.16,
                                                       animations: {
                                                        self.firstPoint.alpha = 0
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 0.30,
                                                       relativeDuration: 0.16,
                                                       animations: {
                                                        self.secondPoint.alpha = 0
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 0.45,
                                                       relativeDuration: 0.16,
                                                       animations: {
                                                        self.thirdPoint.alpha = 0
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 0.60,
                                                       relativeDuration: 0.16,
                                                       animations: {
                                                        self.firstPoint.alpha = 1
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 0.75,
                                                       relativeDuration: 0.16,
                                                       animations: {
                                                        self.secondPoint.alpha = 1
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 0.9,
                                                       relativeDuration: 0.16,
                                                       animations: {
                                                        self.thirdPoint.alpha = 1
                                                       })
                                },
                                completion: { _ in
                                    self.performSegue(withIdentifier: "goToTabBar", sender: nil)
                                })
    }
    
}
