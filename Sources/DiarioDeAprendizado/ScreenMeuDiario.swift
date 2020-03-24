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

public class ScreenMeuDiario {
    
     weak var delegate: DiaryOptionsDelegate?
    var options = SearchDiaryOptions.nome
    
    func run() {
        switch options {
        case .data:
            delegate?.searchByDate()
        case .disciplina:
            delegate?.searchByGrade()
        case .nome:
            delegate?.searchByName()
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
