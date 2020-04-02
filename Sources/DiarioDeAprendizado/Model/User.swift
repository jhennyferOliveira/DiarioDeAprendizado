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
    var username: String
    var nome: String
    var matricula: String
    var senha: String
    var disciplinas: [Subject]
    var diario: [Anotation]
    
    
    public init(username: String,
        nome: String, matricula: String, senha: String) {
        id = 0
        self.username = username
        self.nome = nome
        self.matricula = matricula
        self.senha = senha
        self.disciplinas = [Subject]()
        self.diario = [Anotation]()
    }
    
    public init() {
        id = 0
        self.username = ""
        self.nome = ""
        self.matricula = ""
        self.senha = ""
        self.disciplinas = [Subject]()
        self.diario = [Anotation]()
    }
}
