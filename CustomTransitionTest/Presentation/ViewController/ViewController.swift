//
//  ViewController.swift
//  CustomTransitionTest
//
//  Created by NHN on 2021/07/23.
//

import UIKit

class ViewController: UIViewController {

    let goBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Go", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(red: 0xB6 / 255, green: 0xE2 / 255, blue: 0xD3 / 255, alpha: 1.0)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
        setConstraints()
        setActions()
    }

    private func setUpView() {
        view.backgroundColor = .white
        view.addSubview(goBtn)
    }
    
    private func setConstraints() {
        goBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        goBtn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        goBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        goBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setActions() {
        goBtn.addTarget(self, action: #selector(self.touchGoBtn), for: .touchUpInside)
    }
    
    @objc private func touchGoBtn() {
        let model = PopupCatViewModel(catList: [
            Cat(name: "삼색"),
            Cat(name: "야통"),
            Cat(name: "도도"),
            Cat(name: "Marilyn"),
            Cat(name: "길막"),
            Cat(name: "무"),
            Cat(name: "래기")
        ])
        
        let vc = PopupViewController(viewModel: model)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

