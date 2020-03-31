//
//  Note.swift
//  testeCLI
//
//  Created by Vinicius Mesquita on 15/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

public protocol Incrementable {
    var id: Int {get set}
}
public struct Anotation: Codable, Incrementable {
    public var id : Int = 0
    var titulo: String = ""
    var texto: String = ""
    var data: String = ""
    var categoria: String? = ""
    var disciplina: Subject = Subject()
        
}
