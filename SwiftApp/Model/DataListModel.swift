//
//  DataListModel.swift
//  SwiftApp
//
//  Created by WYH_MAC001 on 05/09/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import Foundation

typealias DataListModel = [DataListModelElement]

// MARK: - DataListModelElement
struct DataListModelElement: Codable {
    let id: String?
    let type: TypeEnum?
    let date: String?
    let data: String?
}

enum TypeEnum: String, Codable {
    case image = "image"
    case other = "other"
    case text = "text"
}


