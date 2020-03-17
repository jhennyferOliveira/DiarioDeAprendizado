//
//  Menu.swift
//  DiarioDeAprendizado
//
//  Created by Vinicius Mesquita on 15/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation


enum MenuOptionsEnum {
    case showGrades
    case showUserInformation
    case createNewGrade
    case createNewDiaryAnotation
    case searchDiary
}

public class ScreenMenu {
    
    weak var delegate: MenuOptionsDelegate?
    var options = MenuOptionsEnum.showGrades
    
    func run() {
        switch options {
        case .showGrades:
            delegate?.showGrades()
        case .showUserInformation:
            delegate?.showUserInformation()
        case .createNewGrade:
            delegate?.createNewGrade()
        case .createNewDiaryAnotation:
            delegate?.createNewDiary()
        case .searchDiary:
            delegate?.searchDiary()
        }
    }
    
    func show() {
        print("""
        1 - mostrar disciplina
        2 - mostrar informacoes de usuario
        3 - criar nova disciplina
        4 - criar novo diario
        5 - pesquisar anotacoes(data, nome, disciplina)
        """)
    }
    
}
