//
//  File.swift
//  
//
//  Created by Vinicius Mesquita on 22/03/20.
//

import Foundation

protocol DiaryOptionsDelegate: class {
    func searchByDate(date: String)
    func searchByTitle(title: String)
    func searchByCategory(category: String)
    func addAnotation()
    func deleteAnotation(title: String?, index: Int?)
    func editAnotation(title: String?, index: Int?)
    func showAnotations()
}

public class DiaryOptions: DiaryOptionsDelegate {
    
    let folderPath = FileManager.default.currentDirectoryPath + "/json"
    let completePathSubject = FileManager.default.currentDirectoryPath + "/json/disciplina.txt"
    let completePathDiary = FileManager.default.currentDirectoryPath + "/json/diario.txt"
    let service = Service<Anotation>()
    
    func searchByDate(date: String) {
        let diarios = service.read(filePath: completePathDiary)
        let anotations = diarios.filter { diario -> Bool in
            if diario.data == date {
                return true
            }
            return false
        }
        
        let filterNotes = anotations.map { (note) in
            return note.titulo
        }.reduce("") { $0 + "\n" + $1 }
        
        if !anotations.isEmpty {
            print("""
                RESULTADO DA PESQUISA:
                \(filterNotes)
                """)
        } else {
            print("não foi registrado nenhuma anotacão na data: \(date)")
        }
    }
    
    func searchByTitle(title: String) {
        let diarios = service.read(filePath: completePathDiary)
        let anotations = diarios.filter { diario -> Bool in
            if diario.titulo == title {
                return true
            }
            return false
        }
        
        let filterNotes = anotations.map { (note) in
            return note.titulo
        }.reduce("") { $0 + "\n" + $1 }
        
        if !anotations.isEmpty {
            print("""
                RESULTADO DA PESQUISA:
                \(filterNotes)
                """)
        } else {
            print("não foi registrado nenhuma anotacão com o titulo: \(title)")
        }
    }
    
    func searchByCategory(category: String) {
        let diarios = service.read(filePath: completePathDiary)
        let anotations = diarios.filter { diario -> Bool in
            if diario.categoria == category {
                return true
            }
            return false
        }
        
        let filterNotes = anotations.map { (note) in
            return note.titulo
        }.reduce("") { $0 + "\n" + $1 }
        
        if !anotations.isEmpty {
            print("""
                RESULTADO DA PESQUISA:
                \(filterNotes)
                """)
        } else {
            print("não foi registrado nenhuma anotacão para categoria: \(category)")
        }
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
        diario.id = autoIncrementNoteId()
        diario.data = stringData
        diario.titulo = tituloAnotacao
        diario.categoria = categoria
        diario.texto = anotacao
        
        if let disciplinaProcurada = searchGradeByName(nome: nomeDisciplina) {
            diario.disciplina = disciplinaProcurada
        } else {
            let serviceDisciplina = Service<Subject>()
            disciplina.nome = nomeDisciplina
            disciplina.id = autoIncrementSubjectId()
            serviceDisciplina.override(object: disciplina, folderPath: folderPath, fileName: "disciplina.txt")
            diario.disciplina = disciplina
        }
        service.override(object: diario, folderPath: folderPath, fileName: "diario.txt")
        print("Diario foi criado")
    }
    
    func deleteAnotation(title: String? = nil, index: Int? = nil) {
        var diary = service.read(filePath: completePathDiary)
        
        // caso o usuario digite um titulo
//        if let _ = title {
//            let newDiary = diary.filter { anotation -> Bool in
//                if anotation.titulo == title {
//                    return true
//                }
//                return false
//            }
//            service.write(array: newDiary, filePath: completePathDiary)
//            print("anotacao deletada!")
//        }
//
        if let _ = title {
            diary.enumerated().forEach { foundIndex, anotation in
                if anotation.titulo == title {
                    var anotationEdited = anotation
                    anotationEdited.titulo = "EDITED \(anotation.titulo)"
                    diary.remove(at: foundIndex)
                    service.write(array: diary, filePath: completePathDiary)
                    print("for removido")
                } else {
                    print("este titulo não existe, digite outro:")
                }
            }
        }
        
        // caso o usuario digite um indice
        if let index = index {
            if diary.indices.contains(index) { // if is on range
                diary.remove(at: index)
                service.write(array: diary, filePath: completePathDiary)
            } else {
                print("não existe nada dentro desse range")
            }
        }
        
    }
    
    func editAnotation(title: String? = nil, index: Int? = nil) {
        var diary = service.read(filePath: completePathDiary)
        // caso o usuario digite um titulo
        if let _ = title {
            diary.enumerated().forEach { foundIndex, anotation in
                if anotation.titulo == title {
                    var anotationEdited = anotation
                    anotationEdited.titulo = "EDITED \(anotation.titulo)"
                    diary.remove(at: foundIndex)
                    diary.insert(anotationEdited, at: foundIndex)
                    service.write(array: diary, filePath: completePathDiary)
                    print("foi editado")
                } else {
                    print("este titulo não existe, digite outro:")
                }
            }
        }
        // caso o usuario digite um indice
        if let index = index {
            if diary.indices.contains(index) { // if is on range
                var anotationEdited = diary[index]
                anotationEdited.titulo = "EDITED \(diary[index].titulo)"
                diary.remove(at: index)
                diary.insert(anotationEdited, at: index)
                service.write(array: diary, filePath: completePathDiary)
                print("anotação alterada!")
            } else {
                print("não existe nada dentro desse range")
            }
            
        }
    }
    
    func showAnotations() {
        let diary = service.read(filePath: completePathDiary)
        
        let anotations = diary.enumerated().map { (index, anotation) in
            return "\(index) - \(anotation.titulo)" // array: String = ["0 - teste". "1 - teste" ," 2 - teste"]
        }.reduce(""){ $0 + "\n" + $1 } // junta elementos do array -> 0 - teste \n 1 - teste
        
        if !anotations.isEmpty {
            print("""
                Anotações:
                \(anotations)
                
                """)
        } else {
            print("você não tem nenhuma anotação, crie uma agora!")
        }
        
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
    
    func autoIncrementNoteId() -> Int{
        let service = Service<Anotation>()
        let arrayNotes : [Anotation] = service.read(filePath: completePathDiary)
        let lengthArrayNotes = arrayNotes.count
        var id = 0
        if(lengthArrayNotes == 0){
            id = 1
            return id
        } else {
            id = arrayNotes[lengthArrayNotes-1].id + 1
            return id
        }
    }
    func autoIncrementSubjectId() -> Int{
        let service = Service<Subject>()
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
