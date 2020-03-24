//
//  ScreenGrades.swift
//  
//
//  Created by Vinicius Mesquita on 24/03/20.
//

import Foundation

enum GradeOptionsEnum {
    case showAnotations
    case searchScreenDiary
    case addAnotation
    case editAnotation
    case deleteAnotation
}

public class ScreenGrades {
    
    weak var delegate: GradeOptionsDelegate?
    var options = DiaryOptionsEnum.searchScreenDiary
    
    func run() {
        
    }
    
    func show() {
        print("""

        MENU DISCIPLINA:

        1 - mostrar disciplina
        2 - visualizar notas
        3 - calcular media
        4 - cadastrar disciplina
        5 - deletar disciplina
        6 - editar disciplina

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
                run()
            case "2":
                options = .searchScreenDiary
                run()
            case "3":
                options = .addAnotation
                run()
            case "4":
                options = .editAnotation
                run()
            case "5":
                options = .deleteAnotation
                run()
            default:
                print("?")
        }
        clearScreen()
        show()
        }
    }
    
    private func clearScreen() {
        let clear = Process()
        clear.launchPath = "/usr/bin/clear"
        clear.arguments = []
        clear.launch()
        clear.waitUntilExit()
    }
}
