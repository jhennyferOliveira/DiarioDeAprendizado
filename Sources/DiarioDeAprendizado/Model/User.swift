//
//  Aluno.swift
//  testeCLI
//
//  Created by Vinicius Mesquita on 14/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

public class User: Codable, Incrementable {
    public var id: Int
    var uuid: String
    var username: String
    var nome: String
    var matricula: String
    var senha: String
    var disciplinas: [Subject]
    
    
    public init(username: String,
        nome: String, matricula: String, senha: String) {
        id = 1
        self.uuid = "generate uiid"
        self.username = username
        self.nome = nome
        self.matricula = matricula
        self.senha = senha
        self.disciplinas = [Subject]()
    }
    
    public init() {
        id = 1
        self.uuid = ""
        self.username = ""
        self.nome = ""
        self.matricula = ""
        self.senha = ""
        self.disciplinas = [Subject]()
    }
}
