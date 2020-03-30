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

protocol SubjectOptionsDelegate: class {
    func create()
    func search(parameter: String, search: SubjectSearchBy) -> Subject?
    func details()
    func delete()
    func edit()
    func average(subject: Subject) throws -> Double
}

public class SubjectOptions: SubjectOptionsDelegate {
    
    let folderPath = FileManager.default.currentDirectoryPath + "/json"
    let completePathSubject = FileManager.default.currentDirectoryPath + "/json/disciplina.txt"
    let service = Service<Subject>()
    
    func create() {
        var disciplina = Subject()
        print("digite o nome da disciplina:")
        guard let nome = readLine() else {
            return
        }
        print("ja possui nota ? (s/n)")
        guard let response = readLine() else { return }
        if response == "s" {
            print("digite sua n1:")
            guard let n1 = readLine() else { return }
            disciplina.nota1 = n1
            
            print("digite sua n2:")
            guard let n2 = readLine() else { return }
            disciplina.nota2 = n2
        }
        disciplina.nome = nome
        disciplina.id = autoIncrementSubjectId()
        print(completePathSubject)
        service.save(object: disciplina, folderPath: folderPath, fileName: "disciplina.txt")
        print("sua disciplina foi salva no arquivo disciplina.txt")
    }
    
    
    func search(parameter: String, search: SubjectSearchBy) -> Subject? {
        let subjects = service.read(filePath: completePathSubject)
        let results: [Subject]
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
        let filterResults = subjects.map { (subject) in
            return "\(subject.id) - \(subject.nome)"
        }.reduce("") { $0 + "\n" + $1 }
        
        if !results.isEmpty {
            print("""
                RESULTADO DA PESQUISA:
                \(filterResults)\n
                """)
        } else {
            print("não foi encontrado nada para: \(parameter)")
        }
        return subjects[0] // tem q mudar este retorno
    }
    
    func details() {
        let grades = service.read(filePath: completePathSubject)
        let subjects = grades.enumerated().map { (index, subject) in
            return "\(index) - \(subject.nome)"
        }.reduce("") {$0 + "\n" + $1}
        
        print("""
            Disciplinas Cadastradas:
            \(subjects)
            """)
    }
    
    func delete() {
        
    }
    
    func edit() {
        
    }
    
    // error propagation
    func average(subject: Subject, ) throws -> Double  {
        var scores: [Double] = []
        
        if let nota1 = subject.nota1 {
            guard let n1 = Double(nota1) else {
                throw AverageError.CastingError
            }
            scores.append(n1)
        }
        
        if let nota2 = subject.nota2 {
            guard let n2 = Double(nota2) else {
                throw AverageError.CastingError
            }
            scores.append(n2)
        }
        return mean(scores: scores)
    }
    
    private func mean(scores: [Double]) -> Double {
        return scores.reduce(0.0, +) / Double(scores.count)
    }
    
    func autoIncrementSubjectId() -> Int {
        let arraySubject : [Subject] = service.read(filePath: completePathSubject)
        let lengthArraySubject = arraySubject.count
        var id = 0
        if(lengthArraySubject == 0){
            id = 1
            return id
        } else {
            id = arraySubject[lengthArraySubject-1].id + 1
            return id
        }
    }
    
}


enum AverageError: Error {
    case insuficientScores
    case CastingError
}
