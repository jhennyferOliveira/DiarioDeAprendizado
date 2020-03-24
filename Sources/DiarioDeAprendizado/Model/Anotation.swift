//
//  Note.swift
//  testeCLI
//
//  Created by Vinicius Mesquita on 15/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

public struct Anotation: Codable {
    var titulo: String = ""
    var texto: String = ""
    var data: String? = ""
    var categoria: String? = ""
    var disciplina: Subject = Subject()
}
