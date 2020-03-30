//
//  File.swift
//  
//
//  Created by Vinicius Mesquita on 22/03/20.
//

import Foundation

enum searchBy{
    case title
    case date
    case category
}
protocol DiaryOptionsDelegate: class {
    func addAnotation()
    func search(parameter: String, search: searchBy )
    func deleteAnotation(title: String?, index: Int?)
    func editAnotation(title: String?, index: Int?)
    func showAnotations()
}

public class DiaryOptions: DiaryOptionsDelegate {
    let folderPath = FileManager.default.currentDirectoryPath + "/json"
    let completePathSubject = FileManager.default.currentDirectoryPath + "/json/disciplina.txt"
    let completePathDiary = FileManager.default.currentDirectoryPath + "/json/diario.txt"
    let service = Service<Anotation>()
    
    func search(parameter: String, search: searchBy ){
        let diarios = service.read(filePath: completePathDiary)
        let anotations : [Anotation]
        switch search{
        case .date :
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
        } else {
            print("não foi registrado nenhuma anotacão na data: \(parameter)")
        }
    }
    
    func addAnotation() {
        var diario = Anotation()
        let gradeOptions = GradeOptions()
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
        
        if let disciplinaProcurada = gradeOptions.searchGradeByName(nome: nomeDisciplina) {
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
        
        let anotations = diary.map { (anotation) in
            return "\(anotation.id) - \(anotation.titulo)"
        }.reduce(""){ $0 + "\n" + $1 }
        
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
    //    func autoIncrement<T>(path:String, service: Service<T>) -> Int{
    //            let array[T] = service.read(filePath: path)
    //            let lengthArray = array.count
    //            var id = 0
    //            if(lengthArray == 0){
    //                id = 1
    //                return id
    //            } else {
    //                id = array[lengthArray-1].id + 1
    //                return id
    //            }
    //        }
    
    
}

