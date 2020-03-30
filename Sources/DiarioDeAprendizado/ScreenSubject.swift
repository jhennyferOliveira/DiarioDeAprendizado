//
//  ScreenGrades.swift
//  
//
//  Created by Vinicius Mesquita on 24/03/20.
//

import Foundation

enum SubjectOptionsEnum {
    case showSubjects
    case showResuls
    case calculateAverage
    case createSubject
    case deleteSubject
    case editSubject
}

public class ScreenSubject {
    
    weak var delegate: SubjectOptionsDelegate?
    var options = SubjectOptionsEnum.showSubjects
    
    func run() {
        switch options {
        case .showSubjects:
            delegate?.details()
        case .showResuls:
            delegate?.details()
        case .calculateAverage:
            calculateAvarege()
        case .createSubject:
            delegate?.create()
        case .deleteSubject:
            delegate?.delete()
        case .editSubject:
            delegate?.edit()
        }
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
                options = .showSubjects
                run()
            case "2":
                options = .showResuls
                run()
            case "3":
                options = .calculateAverage
                run()
            case "4":
                options = .createSubject
                run()
            case "5":
                options = .editSubject
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
    
    func calculateAvarege() {
        
    }
}
