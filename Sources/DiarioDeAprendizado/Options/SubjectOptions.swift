//
//  File.swift
//  
//
//  Created by Vinicius Mesquita on 24/03/20.
//

import Foundation

enum SubjectSearchBy {
    case name, id
}

enum Edit{
    case name
    case grade1
    case grade2
}

protocol SubjectOptionsDelegate: class {
    func create(name: String, n1: String, n2: String, links: String?)
    func search(parameter: String, search: SubjectSearchBy) -> Subject?
    func details()
    func delete(subjectId:Int)
    func edit(subject: Subject, edit: Edit, newValue: String)
    func average(subject: Subject, weightN1: Int, weightN2: Int) throws -> Double
    func selectSubjectById() -> Subject?
    func showFormattedSubject(subject: Subject)
}

public class SubjectOptions: SubjectOptionsDelegate {
    
    let folderPath = FileManager.default.currentDirectoryPath + "/json"
    let completePathSubject = FileManager.default.currentDirectoryPath + "/json/disciplina.txt"
    let service = Service<Subject>()
    
    func create(name: String, n1: String, n2: String, links: String?) {
        var disciplina = Subject()
        
        if let n1_double = Double(n1) {
            if(n1_double > 10.0 || n1_double < 0.0) {
                print("Nota 1 com valor inválido, não foi possível salvar a disciplina")
                return
            }
            if let n2_double = Double(n2) {
                if(n2_double > 10.0 || n2_double < 0.0) {
                    print("Nota 2 com valor inválido, não foi possível salvar a disciplina")
                    return
                }
                disciplina.nota2 = String(format: "%.1f", n2_double)
            }
            disciplina.nota1 = String(format: "%.1f", n1_double)
        }
        
        disciplina.nome = name
        disciplina.id = service.autoIncrement(path: completePathSubject)
        
        service.save(object: disciplina, folderPath: folderPath, fileName: "disciplina.txt")
        print("A disciplina foi salva no arquivo disciplina.txt")
    }
    
    
    func search(parameter: String, search: SubjectSearchBy) -> Subject? {
        let subjects = service.read(filePath: completePathSubject)
        var results: [Subject]
        switch search {
        case .name:
            results = subjects.filter { subject -> Bool in
                if subject.nome == parameter {
                    return true
                }
                return false
            }
            
        case .id:
            results = subjects.filter { subject -> Bool in
                if subject.id == Int(parameter) {
                    return true
                }
                return false
            }
            
        }
        let filterResults = results.map { (subject) in
            return "\(subject.id) - \(subject.nome)"
        }.reduce("") { $0 + "\n" + $1 }
        
        if !results.isEmpty {
            print("""
                RESULTADO DA PESQUISA:
                \(filterResults)\n
                """)
        } else {
            print("Não foi encontrado nenhum resultado para: \(parameter)")
            return nil
        }
        return results[0] // tem q mudar este retorno
    }
    
    func details(){
        let grades = service.read(filePath: completePathSubject)
        let subjects = grades.map { subject in
            return "\(subject.id) - \(subject.nome)"
        }.reduce("") {$0 + "\n" + $1}
        
        if !subjects.isEmpty {
            print("""
                Disciplinas Cadastradas:
                \(subjects)
                """)
        } else {
            print("Você ainda não cadastrou nenhuma discplina")
        }
        
    }
    
    func delete(subjectId:Int) {
        service.deleteById(filePath: completePathSubject, id: subjectId)
    }
    
    
    func edit(subject: Subject, edit: Edit, newValue: String) {
        var newSubject = Subject()
        newSubject = subject
        
        switch edit {
        case .name:
            newSubject.nome = newValue
        case .grade1:
            newSubject.nota1 = newValue
        case .grade2:
            newSubject.nota2 = newValue
        }
        service.deleteById(filePath: completePathSubject, id: subject.id)
        service.save(object: newSubject, folderPath: completePathSubject)
    }
    
    func showFormattedSubject(subject: Subject){
        print("""
            
            NOME: \(subject.nome)
            NOTA 1: \(subject.nota1 ?? "sem nota cadastrada")
            NOTA 2: \(subject.nota2 ?? "sem nota cadastrada")
            
            """)
    }
    
    func selectSubjectById() -> Subject? {
        
        let subjects : [Subject] = service.read(filePath: completePathSubject)
        if(!subjects.isEmpty){
            print("Digite o id para selecionar a disciplina: ")
            if let input = readLine() {
                if let input = Int(input) {
                    for subject in subjects{
                        if (subject.id == input){
                            return subject
                        }
                    }
                    
                }
                
            }
            
        }
        return nil
    }
    
    // error propagation
    func average(subject: Subject, weightN1: Int, weightN2: Int) throws -> Double  {
        var scores: [Double] = []
        
        if let nota1 = subject.nota1 {
            guard let n1 = Double(nota1) else {
                throw AverageError.CastingError
            }
            for _ in 0 ... weightN1 {
                scores.append(n1)
            }
        }
        
        if let nota2 = subject.nota2 {
            guard let n2 = Double(nota2) else {
                throw AverageError.CastingError
            }
            for _ in 0 ... weightN2 {
                scores.append(n2)
            }
        }
        return mean(scores: scores)
    }
    
    private func mean(scores: [Double]) -> Double {
        return scores.reduce(0.0, +) / Double(scores.count)
    }
    
}

enum AverageError: Error {
    case insuficientScores
    case CastingError
}

extension SubjectOptionsDelegate {
    func create(name: String) {
        create(name: name, n1: "", n2: "", links: nil)
    }
}
