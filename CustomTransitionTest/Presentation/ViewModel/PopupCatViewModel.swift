//
//  PopupCatViewModel.swift
//  CustomTransitionTest
//
//  Created by NHN on 2021/07/23.
//

import Foundation

protocol CatModelOutput {
    var catList: [Cat] {get}
    func getCatList() -> [Cat]
}

protocol CatModel: CatModelOutput {}

final class PopupCatViewModel: CatModel {
    var catList: [Cat]
    
    init(catList: [Cat]) {
        self.catList = catList
    }

    func getCatList() -> [Cat] {
        return catList
    }
}
