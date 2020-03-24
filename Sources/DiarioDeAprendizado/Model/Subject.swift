//
//  Disciplina.swift
//  testeCLI
//
//  Created by Vinicius Mesquita on 14/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

public struct Subject: Codable {
    var nome: String = ""
    var nota1: String? = "-"
    var nota2: String? = "-"
    var frequencia: String? = nil
    var links: String? = nil
}
