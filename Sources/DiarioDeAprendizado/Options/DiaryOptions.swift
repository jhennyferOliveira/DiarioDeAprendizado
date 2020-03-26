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
    func deleteAnotation(title: String?, index: Int?)
    func editAnotation()
    func showAnotations()
}

public class DiaryOptions: DiaryOptionsDelegate {
    
    let folderPath = FileManager.default.currentDirectoryPath + "/json"
    let completePathSubject = FileManager.default.currentDirectoryPath + "/json/disciplina.txt"
    let completePathDiary = FileManager.default.currentDirectoryPath + "/json/diario.txt"
    let service = Service<Anotation>()
    
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
        var diario = Anotation()
        var disciplina = Subject()
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
         let serviceDisciplina = Service<Subject>()
         disciplina.nome = nomeDisciplina
         serviceDisciplina.override(object: disciplina, folderPath: folderPath, fileName: "disciplina.txt")
         diario.disciplina = disciplina
        }
        service.override(object: diario, folderPath: folderPath, fileName: "diario.txt")
        print("Diario foi criado")
    }
    
    func deleteAnotation(title: String? = nil, index: Int? = nil) {
        var diary = service.read(filePath: completePathDiary)
    
        // caso o usuario digite um titulo
        if let _ = title {
            let newDiary = diary.filter { anotation -> Bool in
                if anotation.titulo == title {
                    return false
                }
                return true
            }
            service.write(array: newDiary, filePath: completePathDiary)
        }
        
        // caso o usuario digite um indice
        if let index = index {
            if diary.indices.contains(index) { // if is on range
                diary.remove(at: index)
                service.write(array: diary, filePath: completePathDiary)
            }
            print("não existe nada dentro desse range")
        }
        
    }
    
    func editAnotation() {
        
    }
    
    func showAnotations() {
        let diary = service.read(filePath: completePathDiary)
        
        let anotations = diary.enumerated().map { (index, anotation) in
            return "\(index) - \(anotation.titulo)" // array: String = ["0 - teste". "1 - teste" ," 2 - teste"]
        }.reduce(""){ $0 + "\n" + $1 } // junta elementos do array -> 0 - teste \n 1 - teste
        
        print("""
            Anotações:
            \(anotations)
            
            Obs: para visualizar a anotação, basta escrever o indice ou titulo da anotação.
            """)
        /* not implemented yet [submenu select anotation]
         
         let screen_select_anotation = ScreenSelectAnotation()
         screen_select_anotation.main()
        */
    }
    
    // essa função deveria estar no grade function mas ela é necessaria aqui então não sei :œ
    func searchGradeByName(nome : String) -> Subject? {
          let service_subject = Service<Subject>()
          let arrayDisciplinas : [Subject] = service_subject.read(filePath: completePathSubject)
          for disciplina in arrayDisciplinas {
              if(disciplina.nome == nome) {
                  return disciplina
              }
          }
          return nil
      }

}
