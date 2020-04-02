//
//  File.swift
//  
//
//  Created by Vinicius Mesquita on 22/03/20.
//

import Foundation

enum DiarySearchBy {
    case title, date, category
}

enum edit{
    case title
    case note
    case category
    case grade
}
protocol DiaryOptionsDelegate: class {
    func addAnotation()
    func search(parameter: String, search: DiarySearchBy)-> Bool
    func deleteAnotation(noteId: Int)
    func editAnotation(anotation: Anotation, edit: edit, newValue : String)
    func showAnotations()
    func selectAnotationById() -> Anotation?
    func showFormattedAnotation(anotation: Anotation)
}

public class DiaryOptions: DiaryOptionsDelegate {
    
    let folderPath = FileManager.default.currentDirectoryPath + "/json"
    let completePathSubject = FileManager.default.currentDirectoryPath + "/json/disciplina.json"
    let completePathDiary = FileManager.default.currentDirectoryPath + "/json/diario.json"
    let service = Service<Anotation>()
    
    func search(parameter: String, search: DiarySearchBy) -> Bool{
        let diarios = service.read(filePath: completePathDiary)
        let anotations : [Anotation]
        switch search {
        case .date:
            anotations = diarios.filter { diario -> Bool in
                if diario.data == parameter {
                    return true
                }
                return false
            }
            
        case .title:
            anotations = diarios.filter { diario -> Bool in
                if diario.titulo == parameter {
                    return true
                }
                return false
            }
            
        case .category:
            anotations = diarios.filter { diario -> Bool in
                if diario.categoria == parameter {
                    return true
                }
                return false
            }
        }
        let filterNotes = anotations.map { (note) in
            return "\(note.id) - \(note.titulo)"
        }.reduce("") { $0 + "\n" + $1 }
        
        if !anotations.isEmpty {
            print("""
                RESULTADO DA PESQUISA:
                \(filterNotes)\n
                """)
            return true
        } else {
            print("Nenhum resultado para: \(parameter)")
            return false
        }
    }
    
    func addAnotation() {
        var diario = Anotation()
        let subjectOptions = SubjectOptions()
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
        
        diario.id = service.autoIncrement(path: completePathDiary)
        diario.data = stringData
        diario.titulo = tituloAnotacao
        diario.categoria = categoria
        diario.texto = anotacao
        
        if let disciplinaProcurada = subjectOptions.search(parameter: nomeDisciplina, search: .name) {
            diario.disciplina = disciplinaProcurada
        } else {
            let serviceDisciplina = Service<Subject>()
            disciplina.nome = nomeDisciplina

            disciplina.id = serviceDisciplina.autoIncrement(path: completePathSubject)
            serviceDisciplina.save(object: disciplina, folderPath: folderPath, fileName: "disciplina.json")
            diario.disciplina = disciplina
            print("Disciplina \(disciplina.nome) criada")
        }
        service.save(object: diario, folderPath: folderPath, fileName: "diario.json")
        print("Diario foi criado")
    }
    
    func deleteAnotation(noteId: Int) {
        service.deleteById(filePath: completePathDiary, id: noteId)
    }
    
    func editAnotation(anotation: Anotation, edit: edit, newValue: String) {
        var newAnotation = Anotation()
        newAnotation = anotation
        let service = Service<Anotation>()
        switch edit {
        case .category:
            newAnotation.categoria = newValue
        case .grade:
            newAnotation.disciplina.nome = newValue
        case .note:
            newAnotation.texto = newValue
        case .title:
            newAnotation.titulo = newValue
        }
        service.deleteById(filePath: completePathDiary, id: anotation.id)
        service.save(object: newAnotation, folderPath: completePathDiary)
        }
        
        func showAnotations() {
            let diary = service.read(filePath: completePathDiary)
            
            let anotations = diary.map { (anotation) in
                return "\(anotation.id) - \(anotation.titulo)"
            }.reduce(""){ $0 + "\n" + $1 }
            
            if !anotations.isEmpty {
                print("""
                    Anotações:
                    \(anotations)
                    
                    """)
            } else {
                print("Você não tem nenhuma anotação, crie uma agora :D")
            }
        }
        
        func showFormattedAnotation(anotation: Anotation) {
            print("""
                
                TÍTULO: \(anotation.titulo)
                DATA: \(anotation.data)
                DISCIPLINA: \(anotation.disciplina.nome)
                CATEGORIA: \(anotation.categoria)
                
                ANOTAÇÃO: \(anotation.texto)
                
                """)
        }
        
        func selectAnotationById() -> Anotation? {
            let completePathDiary = FileManager.default.currentDirectoryPath + "/json/diario.json"
            let service = Service<Anotation>()
            let anotations : [Anotation] = service.read(filePath: completePathDiary)
            
            if(!anotations.isEmpty){
                print("Digite o id para selecionar a anotação: ")
                if let input = readLine() {
                    if let input = Int(input) {
                        for anotation in anotations{
                            if (anotation.id == input){
                                return anotation
                            }
                        }
                        
                    }
                    
                }
                
            }
            return nil
        }
}

