//
//  File.swift
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
    let service = Service<User>()
    
    func details() {
        let currentUser = CurrentUser.instance
        
        if currentUser.isLogged {
            print("""
                olá \(currentUser.nome)
                sua Matricula é \(currentUser.matricula)
                """)
        } else {
            print("Por favor, realize o login primeiro!")
        }
        
    }
    
    func editInformation(edit: EditUserBy, newValue: String) {
        /* not implemented yet **/
        let editedUser = CurrentUser.instance
        
        
        switch edit {
        case .name:
            editedUser.nome = newValue
        case .password:
            editedUser.senha = newValue.md5()
        }
        
        if editedUser.isLogged {
            service.deleteById(filePath: completePathUser, id: editedUser.id)
            service.saveEcrypted(object: editedUser, folderPath: folderPath, fileName: "user.txt")
        } else {
            print("Por favor, realize o login primeiro!")
        }
        
    }
    
    /* faltam ajustes */
    func saveInformation(nome: String, username: String, matricula: String, password: String) {
        
        if usernameIsAvailable(username) {
            let user = User(username: username, nome: nome, matricula: matricula, senha: password)
            user.id = service.autoIncrement(path: completePathUser)
            service.saveEcrypted(object: user, folderPath: folderPath, fileName: "user.txt")
        } else {
            print("Erro: Username indisponivel")
        }
    }
    
    /* em testes */
    func checkInformation(username: String, password: String) -> Bool {
        let users = service.read(filePath: completePathUser, encryptionKey: "keykeykeykeykeyk",iv: "drowssapdrowssap")
        var result = false
        
        users.forEach { user in
            if (user.username == username && user.senha == password) {
                setCurrentUser(user: user)
                result = true
            }
        }
        return result
    }
    
    private func setCurrentUser(user: User) {
        let currentUser = CurrentUser.instance
        currentUser.nome = user.nome
        currentUser.matricula = user.matricula
    }
    
    private func usernameIsAvailable(_ username: String) -> Bool {
        let users = service.read(filePath: completePathUser, encryptionKey: "keykeykeykeykeyk",iv: "drowssapdrowssap")
        var result = true
        users.forEach {  user in
            if user.username == username {
                result = false
            }
        }
        return result
    }
}

