//
//  Note.swift
//  testeCLI
//
//  Created by Vinicius Mesquita on 15/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

public struct Diario: Codable {
    var titulo: String = ""
    var anotacao: String? = nil
    var data: String? = nil
    var categoria: String? = nil
    var disciplina: Disciplina = Disciplina()
}
