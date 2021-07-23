//
//  PopupViewController.swift
//  CustomTransitionTest
//
//  Created by NHN on 2021/07/23.
//

import Foundation
import UIKit

protocol PopupClosingDelegate {
    func closePopup()
}

class PopupViewController: UIViewController {
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        return view
    }()
    
    let backBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Back", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(red: 0x74 / 255, green: 0xBD / 255, blue: 0xCB / 255, alpha: 1.0)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    let dimmedBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        return view
    }()
    
    let popUpView: PopupView = {
        let model = PopupViewModel(entity: PopupContent(title: "Looking for a new laptop?", imageName: "macbook", subTitle: "Your coupon code:LAPTOP123"))
        let view = PopupView(viewModel: model)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewModel: PopupCatViewModel!
    
    init(viewModel: PopupCatViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setUpView()
        setConstraints()
        addActions()
    }
    
    // MARK: View
    private func setUpView() {
        view.backgroundColor = .white
        setUpTableView()
        setUpBackBtnView()
        setUpDimmedView()
        setUpPopupView()
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    private func setUpBackBtnView() {
        view.addSubview(backBtn)
    }
    
    private func setUpDimmedView() {
        view.addSubview(dimmedBackView)
    }
    
    private func setUpPopupView() {
        popUpView.closer = self
        view.addSubview(popUpView)
    }
    
    // MARK: Constraints
    private func setConstraints() {
        setTableViewConstraints()
        setBackBtnConstraints()
        setDimmedViewConstraints()
        setPopupViewConstraints()
    }
    
    private func setTableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setBackBtnConstraints() {
        backBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        backBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        backBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backBtn.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
    }
    
    private func setDimmedViewConstraints() {
        dimmedBackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dimmedBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dimmedBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dimmedBackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setPopupViewConstraints() {
        popUpView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        popUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        popUpView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        popUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    }
    
    // MARK: Action
    private func addActions() {
        backBtn.addTarget(self, action: #selector(self.touchBackBtn), for: .touchUpInside)
    }
    
    @objc private func touchBackBtn() {
        dismiss(animated: true, completion: nil)
    }
}

extension PopupViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.catList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = viewModel.catList[indexPath.row].name
        
        return cell
    }
}

extension PopupViewController: PopupClosingDelegate {
    func closePopup() {
        popUpView.removeFromSuperview()
        dimmedBackView.removeFromSuperview()
    }
}
