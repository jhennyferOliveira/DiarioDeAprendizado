//
//  ScreenSearchDiary.swift
//  testeCLI
//
//  Created by Vinicius Mesquita on 16/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation


enum DiaryOptionsEnum {
    case showAnotations
    case search
    case addAnotation
    case editAnotation
    case deleteAnotation
}

public class ScreenMyDiary {
    let service = FileService<Anotation>()
    let utils = Utils()
    weak var delegate: DiaryOptionsDelegate?
    var options = DiaryOptionsEnum.search
    
    func run() {
        switch options {
        case .search:
            startSearchScreenDiary()
        case .addAnotation:
            delegate?.addAnotation()
        case .editAnotation:
            startEditScreenDiary()
        case .deleteAnotation:
            deleteAnotation()
        case .showAnotations:
            delegate?.showAnotations()
            guard let anotation = delegate?.selectAnotationById() else{
                return
            }
            delegate?.showFormattedAnotation(anotation: anotation)
        }
    }
    
    func show() {
        print("""

        MENU DIARIO:

        1 - Mostrar todas as anotações
        2 - Pesquisar por (nome, data, categoria)
        3 - Adicionar anotação
        4 - Editar anotação
        5 - Apagar anotação

        0 - voltar
        """)
    }

    func main() {
        show()
        while let input = readLine() {
            
            guard input != "0" else {
                break
            }
            switch input {
            case "1":
                options = .showAnotations
                utils.system("clear")
                run()
            case "2":
                options = .search
                utils.system("clear")
                run()
            case "3":
                options = .addAnotation
                utils.system("clear")
                run()
            case "4":
                options = .editAnotation
                utils.system("clear")
                run()
            case "5":
                options = .deleteAnotation
                utils.system("clear")
                run()
            default:
                print("?")
            }
            show()
        }
    }

    private func startSearchScreenDiary() {
        let screen = ScreenSearchNote()
        let options = DiaryOptions()
        screen.delegate = options
        screen.main()
    }
    
    private func startEditScreenDiary() {
        let screen = ScreenEditNote()
        let options = DiaryOptions()
        screen.delegate = options
        screen.main()
    }
    
    private func deleteAnotation() {
        delegate?.showAnotations()
        guard let anotation = delegate?.selectAnotationById() else{
            return
        }
        delegate?.deleteAnotation(noteId: anotation.id)
    }
    
}


