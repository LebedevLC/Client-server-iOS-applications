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
//        animationFirst()
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
    
    private func animationFirst() {
        let firstLayer = CAShapeLayer()
        let secondLayer = CAShapeLayer()
        
        firstLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 4, height: 4)).cgPath
        secondLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 4, height: 4)).cgPath
        
        firstLayer.backgroundColor = UIColor.black.cgColor
        secondLayer.backgroundColor = UIColor.black.cgColor
        
        firstLayer.frame = CGRect(x: view.center.x - 10, y: view.center.y - 200, width: 40, height: 40)
        secondLayer.frame = CGRect(x: view.center.x - 10, y: view.center.y - 200, width: 40, height: 40)
        
        firstLayer.masksToBounds = true
        secondLayer.masksToBounds = true
        firstLayer.cornerRadius = 20
        secondLayer.cornerRadius = 20
        
        self.view.layer.addSublayer(firstLayer)
        self.view.layer.addSublayer(secondLayer)
        
        let scale = CABasicAnimation(keyPath: "bounds.size.width")
        scale.byValue = 160
        scale.duration = 0.5
        scale.fillMode = CAMediaTimingFillMode.forwards
        scale.isRemovedOnCompletion = false
        
        let rotationLeft = CABasicAnimation(keyPath: "transform.rotation")
        rotationLeft.byValue = CGFloat.pi / 4
        rotationLeft.duration = 0.5
        rotationLeft.beginTime = CACurrentMediaTime() + 0.5
        rotationLeft.fillMode = CAMediaTimingFillMode.both
        rotationLeft.isRemovedOnCompletion = false
        
        let rotationRight = CABasicAnimation(keyPath: "transform.rotation")
        rotationRight.byValue = -CGFloat.pi / 4
        rotationRight.duration = 0.5
        rotationRight.beginTime = CACurrentMediaTime() + 0.5
        rotationRight.fillMode = CAMediaTimingFillMode.both
        rotationRight.isRemovedOnCompletion = false
        
        firstLayer.add(scale, forKey: nil)
        firstLayer.add(rotationLeft, forKey: nil)
        secondLayer.add(scale, forKey: nil)
        secondLayer.add(rotationRight, forKey: nil)
    }
    
}
