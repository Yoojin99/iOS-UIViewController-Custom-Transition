//
//  PopupViewModel.swift
//  CustomTransitionTest
//
//  Created by NHN on 2021/07/23.
//

import Foundation

protocol PopupOutputModel {
    var title: String {get}
    var imageName: String {get}
    var subTitle: String {get}
}

protocol PopupModel: PopupOutputModel {}

final class PopupViewModel: PopupModel {
    let title: String
    let imageName: String
    let subTitle: String
    
    init(entity: PopupContent) {
        self.title = entity.title
        self.imageName = entity.imageName
        self.subTitle = entity.subTitle
    }
}
