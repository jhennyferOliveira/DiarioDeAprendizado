//
//  File.swift
//  
//
//  Created by Vinicius Mesquita on 22/03/20.
//

import Foundation

protocol DiaryOptionsDelegate: class {
    func searchByDate()
    func searchByTitle()
    func searchByCategory()
    func addAnotation()
    func deleteAnotation()
    func editAnotation()
    func showAnotatitons()
}

public class DiaryOptions: DiaryOptionsDelegate {
  
    let folderPath = FileManager.default.currentDirectoryPath + "/json"
    let completePathDisciplinas = FileManager.default.currentDirectoryPath + "/json/disciplina.txt"
    let completePathAluno = FileManager.default.currentDirectoryPath + "/json/aluno.txt"
    
    let service = Service<Anotation>()
    let completePathDiary = FileManager.default.currentDirectoryPath + "/json/diario.txt"
    
    func searchByDate() {
        let diarios = service.read(filePath: completePathDiary)
        let diariosByDate = diarios.filter { diario -> Bool in
            if diario.data == "22/03/2020" {
                return true
            }
            return false
        }
        
        if !diariosByDate.isEmpty {
            print("--------------------------------------")
            print("diarios do dia 22/03/2020: \n")
            diariosByDate.enumerated().forEach { (index, diario) in
                print("\(index) - \(diario.titulo)")
            }
            print("--------------------------------------\n\n")
        } else {
            print("não foi registrado nenhuma anotacão na data informada")
        }
        
    }
    
    func searchByTitle() {
        
    }
    
    func searchByCategory() {
        
    }
    
    func addAnotation() {
        let service = Service<Anotation>()
        var diario = Anotation()
        var disciplina = Grade()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let stringData = formatter.string(from: Date())

        print("Digite o nome da disciplina: ")
        guard let nomeDisciplina = readLine() else {
         return
        }

        print("Digite o título da Anotação: ")
        guard let tituloAnotacao = readLine() else {
         return
        }

        print("Digite a anotação: ")
        guard let anotacao = readLine() else {
         return
        }

        print("Digite a categoria(Faculdade, Trabalho): ")
        guard let categoria = readLine() else {
         return
        }

        diario.data = stringData
        diario.titulo = tituloAnotacao
        diario.categoria = categoria
        diario.texto = anotacao

        if let disciplinaProcurada = searchGradeByName(nome: nomeDisciplina) {
         diario.disciplina = disciplinaProcurada
        } else {
         let serviceDisciplina = Service<Grade>()
         disciplina.nome = nomeDisciplina
         serviceDisciplina.override(object: disciplina, folderPath: folderPath, fileName: "disciplina.txt")
         diario.disciplina = disciplina
        }
        service.override(object: diario, folderPath: folderPath, fileName: "diario.txt")
        print("Diario foi criado")
    }
    
    func deleteAnotation() {
        
    }
    
    func editAnotation() {
        
    }
    
    func showAnotations() {
        let service = Service<Anotation>()
        let diarios = service.read(filePath: completePathDisciplinas)
        diarios.enumerated().forEach { (index, diario) in
            print("\(index) \(diario.titulo)")
        }
    }
    
    func searchGradeByName(nome : String) -> Grade?{
          let service = Service<Grade>()
          let arrayDisciplinas : [Grade] = service.read(filePath: completePathDisciplinas)
          for disciplina in arrayDisciplinas{
              if(disciplina.nome == nome){
                  return disciplina
              }
          }
          return nil
      }

}
