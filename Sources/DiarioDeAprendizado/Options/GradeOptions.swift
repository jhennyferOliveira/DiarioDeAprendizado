//
//  File.swift
//  
//
//  Created by Vinicius Mesquita on 24/03/20.
//

import Foundation

protocol GradeOptionsDelegate: class {
    func createNewGrade()
    func searchGradeByName(nome : String) -> Subject?
    func showGrades()
}

public class GradeOptions: GradeOptionsDelegate {
    
    let folderPath = FileManager.default.currentDirectoryPath + "/json"
    let completePathSubject = FileManager.default.currentDirectoryPath + "/json/disciplina.txt"
    // let completePathAluno = FileManager.default.currentDirectoryPath + "/json/aluno.txt"
    
    func createNewGrade() {
        let service = Service<Subject>()
        
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
        disciplina.id = service.autoIncrement(path: completePathSubject)
        print(completePathSubject)
        service.save(object: disciplina, folderPath: folderPath, fileName: "disciplina.txt")
        // limparTela()
        print("sua disciplina foi salva no arquivo disciplina.txt")
    }
    
    func searchGradeByName(nome: String) -> Subject?{
        let service_subject = Service<Subject>()
        let arrayDisciplinas : [Subject] = service_subject.read(filePath: completePathSubject)
        for disciplina in arrayDisciplinas {
            if(disciplina.nome == nome) {
                return disciplina
            }
        }
        return nil
    }
    
    func showGrades() {
        let service = Service<Subject>()
        let grades = service.read(filePath: completePathSubject)
        let subjects = grades.enumerated().map { (index, subject) in
            return "\(index) - \(subject.nome)"
        }.reduce("") {$0 + "\n" + $1}
        
        print("""
            Disciplinas Cadastradas:
            \(subjects)
            
            """)
    }
    
}
