//
//  Aluno.swift
//  testeCLI
//
//  Created by Vinicius Mesquita on 14/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

public struct User: Codable {
    var nome: String
    var matricula: String
    var senha: String
    var disciplinas: [Subject]
}
