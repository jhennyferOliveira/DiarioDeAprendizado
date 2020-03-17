//
//  ScreenSearchDiary.swift
//  testeCLI
//
//  Created by Vinicius Mesquita on 16/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

enum SearchDiaryOptions {
    case data
    case nome
    case disciplina
}

public class ScreenSearchDiary {
    
    var options = SearchDiaryOptions.nome
    
    func run() {
        switch options {
        case .data:
            print("pesquisar por data")
        case .disciplina:
            print("pesquisar por discplina")
        case .nome:
            print("pesquisar por nome")
        }
    }
    
    func show() {
        print("""
        0 - voltar
        1 - pesquisar por data
        2 - pesquisar por nome
        3 - pesquisar por disciplina
        """)
    }
    
}
