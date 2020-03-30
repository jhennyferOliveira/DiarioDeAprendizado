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
            createSubject()
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
                clearScreen()
                run()
            case "2":
                options = .showResuls
                clearScreen()
                run()
            case "3":
                options = .calculateAverage
                clearScreen()
                run()
            case "4":
                options = .createSubject
                clearScreen()
                run()
            case "5":
                options = .editSubject
                clearScreen()
                run()
            default:
                print("?")
            }
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
    
    private func calculateAvarege() {
        print("digite o id de que deseja tirar a media")
        guard let input = readLine() else {
            return
        }
        
        if let subject = delegate?.search(parameter: input, search: .id) {
            do {
                print("digite os pesos da n1 e n2, respectivamente: ")
                guard let n1 = Int(readLine()!), let n2 = Int(readLine()!) else {
                    print("erro! digite um numero valido.")
                    return
                }
                if let average = try delegate?.average(subject: subject, weightN1: n1, weightN2: n2) {
                    print("MEDIA: \(average)")
                }
            } catch {
                print(error)
            }
            
            
        }
        
    }
    
    private func createSubject() {
        print("digite o nome da disciplina:")
        guard let nome = readLine() else {
            return
        }
        print("ja possui nota ? (s/n)")
        guard let response = readLine() else {
            return
        }
        
        switch response {
        case "s":
            print("digite sua n1:")
            guard let n1 = readLine() else { return }
            print("digite sua n2:")
            guard let n2 = readLine() else { return }
            delegate?.create(name: nome, n1: n1, n2: n2, links: nil)
        case "n":
            delegate?.create(name: nome)
        default:
            print("...")
        }
    }
}
