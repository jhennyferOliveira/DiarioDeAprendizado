//
//  File.swift
//  
//
//  Created by Vinicius Mesquita on 24/03/20.
//

import Foundation

protocol GradeOptionsDelegate: class {
    func createNewGrade()
    func searchGradeByName(nome : String)
}


public class GradeOptions: GradeOptionsDelegate {
    
    let folderPath = FileManager.default.currentDirectoryPath + "/json"
    let completePathDisciplinas = FileManager.default.currentDirectoryPath + "/json/disciplina.txt"
    let completePathAluno = FileManager.default.currentDirectoryPath + "/json/aluno.txt"
    
    func searchGradeByName(nome: String) {
        
    }
    
    func createNewGrade() {
        let service = Service<Grade>()
        
        var disciplina = Grade()
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
        print(completePathDisciplinas)
        service.override(object: disciplina, folderPath: folderPath, fileName: "disciplina.txt")
        // limparTela()
        print("sua disciplina foi salva no arquivo disciplina.txt")
    }
    
}
