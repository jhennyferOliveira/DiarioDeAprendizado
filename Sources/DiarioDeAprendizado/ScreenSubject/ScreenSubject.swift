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
    
    let service = FileService<Subject>()
    let utils = Utils()
    weak var delegate: SubjectOptionsDelegate?
    var options = SubjectOptionsEnum.showSubjects
    
    func run() {
        switch options {
        case .showSubjects:
            delegate?.details()
        case .showResuls:
            delegate?.details()
            guard let subject = selectSubjectById() else { return }
            delegate?.showFormattedSubject(subject: subject)
        case .calculateAverage:
            calculateAvarege()
        case .createSubject:
            createSubject()
        case .deleteSubject:
            deleteSubject()
        case .editSubject:
            startScreenEditSubject()
        }
    }
    
    func startScreenEditSubject() {
        let screen = ScreenEditSubject()
        let options = SubjectOptions()
        screen.delegate = options
        screen.main()
    }
    
    func show() {
        print("""

        MENU DISCIPLINA:

        1 - Visualizar disciplinas
        2 - Visualizar notas
        3 - Calcular média
        4 - Cadastrar disciplina
        5 - Deletar disciplina
        6 - Editar disciplina

        0 - Voltar
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
                utils.system("clear")
                run()
            case "2":
                options = .showResuls
                utils.system("clear")
                run()
            case "3":
                options = .calculateAverage
                utils.system("clear")
                run()
            case "4":
                options = .createSubject
                utils.system("clear")
                run()
            case "5":
                options = .deleteSubject
                utils.system("clear")
                run()
            case "6":
                options = .editSubject
                utils.system("clear")
                run()
            default:
                print("?")
            }
            show()
        }
    }
    
    private func calculateAvarege() {
        delegate?.details()
        guard let subject = selectSubjectById() else{
            return
        }
        delegate?.showFormattedSubject(subject: subject)
        
        if(subject.nota1 == "-" || subject.nota2 == "-"){
            print("Operação inválida! Cadastre as notas da disciplina.")
        } else {
            do {
                print("Digite o peso da n1: ")
                guard let n1 = Int(readLine()!) else {
                    print("Erro! Digite um número válido.")
                    return
                }
                
                print("Digite o peso da n2: ")
                guard let n2 = Int(readLine()!)else {
                    print("Erro! Digite um número válido.")
                    return
                }
                
                if let average = try delegate?.average(subject: subject, weightN1: n1, weightN2: n2) {
                    print("MÉDIA: \(average)")
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    private func createSubject() {
        print("Digite o nome da disciplina:")
        guard let nome = readLine() else {
            return
        }
        print("Já possui nota ? (s/n)")
        guard let response = readLine() else {
            return
        }
        
        switch response {
        case "s":
            print("Digite sua n1:")
            guard let n1 = readLine() else { return }
            print("Digite sua n2:")
            guard let n2 = readLine() else { return }
            delegate?.create(name: nome, n1: n1, n2: n2, links: nil)
        case "n":
            delegate?.create(name: nome)
        default:
            print("...")
        }
    }
    
    private func deleteSubject() {
        delegate?.details()
        guard let subject = selectSubjectById() else {
            return
        }
        delegate?.delete(subjectId: subject.id)
    }
    
    private func selectSubjectById() -> Subject? {
        guard let input = readLine() else {
            return nil
        }
        guard let id = Int(input) else {
            print("digite um valor valido")
            return nil
        }
        guard let subject = delegate?.selectSubject(id: id) else {
            return nil
        }
        return subject
    }
}
