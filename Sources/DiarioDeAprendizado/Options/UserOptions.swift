//
//  UserOptions.swift
//  
//
//  Created by Vinicius Mesquita on 24/03/20.
//

import Foundation
import CryptoSwift

protocol UserOptionsDelegate: class {
    func details()
    func editInformation(edit: EditUserBy, newValue: String)
    func saveInformation(nome: String, username: String, matricula: String, password: String)
    func checkInformation(username: String, password: String) -> Bool
}

enum AuthenticationError: Error {
    case refusedLogin
    case ecryptError
    case decryptError
    case usernameError
}

enum EditUserBy {
    case name
    case password
}

public class UserOptions: UserOptionsDelegate {
    
    let folderPath = FileManager.default.currentDirectoryPath + "/json"
    let completePathUser = FileManager.default.currentDirectoryPath + "/json/user.txt"
    let service = ServiceEncrypter<User>()
    let currentUser = CurrentUser.instance
    
    /* Mostra os detalhes e informações da conta logada */
    func details() {
        
        if currentUser.isLogged {
            print("""
                olá \(currentUser.nome)
                sua Matricula é \(currentUser.matricula)
                """)
        } else {
            print("Por favor, realize o login primeiro!")
        }
        
    }
    
    /* Edita as informações do usuario logado no momento */
    func editInformation(edit: EditUserBy, newValue: String) {
        let editedUser = currentUser
        
        switch edit {
        case .name:
            editedUser.nome = newValue
        case .password:
            editedUser.senha = newValue.md5()
        }
        
        if editedUser.isLogged {
            service.deleteEncrypted(filePath: completePathUser, id: editedUser.id)
            service.saveEcrypted(object: editedUser, folderPath: folderPath, fileName: "user.txt")
            print("...")
        } else {
            print("Por favor, realize o login primeiro!")
        }
        print("finish!")
    }
    
    /* Salva as informações e realiza a criptografia dos dados do usuário */
    func saveInformation(nome: String, username: String, matricula: String, password: String) {
        
        if usernameIsAvailable(username) {
            let user = User(username: username, nome: nome, matricula: matricula, senha: password)
            user.id = service.autoIncrement(path: completePathUser)
            service.saveEcrypted(object: user, folderPath: folderPath, fileName: "user.txt")
        } else {
            print("Erro: Username indisponivel")
        }
    }
    
    /* Realiza a verificação dos dados e retorna true caso seja possivel criar uma conta */
    func checkInformation(username: String, password: String) -> Bool {
        let users = service.readEncrypted(filePath: completePathUser)
        var result = false
        
        users.forEach { user in
            if (user.username == username && user.senha == password) {
                setCurrentUser(user: user)
                result = true
            }
        }
        return result
    }
    /* Salva os dados no usuario que está logado no momento! */
    func saveProgress(subjects: [Subject], anotations: [Anotation], user: CurrentUser) {
        let completePathSubject = FileManager.default.currentDirectoryPath + "/json/disciplina.json"
        let completePathDiary = FileManager.default.currentDirectoryPath + "/json/diario.json"
        let arraySubject = FileService<Subject>().read(filePath: completePathSubject)
        let arrayAnotations = FileService<Anotation>().read(filePath: completePathDiary)
        
        user.disciplinas = arraySubject
        user.diario = arrayAnotations
        service.deleteEncrypted(filePath: completePathUser, id: user.id)
        service.saveEcrypted(object: user, folderPath: folderPath, fileName: "user.txt")
        
    }
    /* Armazena os dados do usuario que está logado no momento */
    private func setCurrentUser(user: User) {
        let currentUser = CurrentUser.instance
        currentUser.nome = user.nome
        currentUser.matricula = user.matricula
        currentUser.diario = user.diario
        currentUser.disciplinas = user.disciplinas
        currentUser.id = user.id
    }
    
    /* Verifica a disponibilidade de username a partir dos dados atuais */
    private func usernameIsAvailable(_ username: String) -> Bool {
        let users = service.readEncrypted(filePath: completePathUser)
        var result = true
        users.forEach {  user in
            if user.username == username {
                result = false
            }
        }
        return result
    }
}

