//
//  PopupView.swift
//  CustomTransitionTest
//
//  Created by NHN on 2021/07/23.
//

import Foundation
import UIKit

class PopupView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    let noBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        btn.setTitle("아니오", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.black.cgColor
        return btn
    }()
    
    let okBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        btn.setTitle("알겠습니다", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(red: 0xFF / 255, green: 0xA3 / 255, blue: 0x84 / 255, alpha: 1.0)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    private var viewModel: PopupViewModel!
    var closer: PopupClosingDelegate!
    
    // MARK: init
    init(viewModel: PopupViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        setUpView()
        updateView()
        setConstraints()
        setActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View
    private func setUpView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(subTitleLabel)
        addSubview(noBtn)
        addSubview(okBtn)
    }
    
    private func updateView() {
        titleLabel.text = viewModel.title
        imageView.image = UIImage(named: viewModel.imageName)
        subTitleLabel.text = viewModel.subTitle
    }
    
    // MARK: Constraint
    private func setConstraints() {
        setTitleLabelConstraint()
        setImageViewConstraint()
        setSubTitleLabelConstraint()
        setNoBtnConstraint()
        setOkBtnConstraint()
    }
    
    private func setTitleLabelConstraint() {
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setImageViewConstraint() {
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        imageView.bottomAnchor.constraint(lessThanOrEqualTo: subTitleLabel.topAnchor, constant: 10).isActive = true
    }
    
    private func setSubTitleLabelConstraint() {
        subTitleLabel.bottomAnchor.constraint(equalTo: noBtn.topAnchor, constant: -10).isActive = true
        subTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        subTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 10).isActive = true
        subTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setNoBtnConstraint() {
        noBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        noBtn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        noBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        noBtn.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -10).isActive = true
    }
    
    private func setOkBtnConstraint() {
        okBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        okBtn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        okBtn.bottomAnchor.constraint(equalTo: noBtn.bottomAnchor).isActive = true
        okBtn.topAnchor.constraint(equalTo: noBtn.topAnchor).isActive = true
        okBtn.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 10).isActive = true
    }
    
    // MARK: Actions
    private func setActions() {
        noBtn.addTarget(self, action: #selector(self.closePopup), for: .touchUpInside)
        okBtn.addTarget(self, action: #selector(self.closePopup), for: .touchUpInside)
    }
    
    @objc private func closePopup() {
        closer.closePopup()
    }
}
