//
//  File.swift
//  
//
//  Created by VInicius Mesquita on 07/04/20.
//

import Foundation
import CryptoSwift

public final class ServiceEncrypter<Type: Codable & Incrementable> {
    
    let key = "keykeykeykeykeyk"
    let iv = "drowssapdrowssap"
    
    let fileManager = FileManager.default
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    var arrayObject = [Type]()
    
    func writeEncrypted(array: [Type]? = nil, filePath: String) {
        encoder.outputFormatting = .prettyPrinted
        if let arrayType = array {
            arrayObject = arrayType
        }
        
        do { // write
            let jsonData = try encoder.encode(arrayObject)
            let aes = try AES(key: key, iv: iv)
            let encrypted = try jsonData.encrypt(cipher: aes)
            try encrypted.write(to: URL(fileURLWithPath: filePath))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func increment(path: String) -> Int {
           let array = readEncrypted(filePath: path)
           let lengthArray = array.count
           var id = 0
           if(lengthArray == 0) {
               id = 1
               return id
           } else {
               id = array[lengthArray - 1].id + 1
               return id
           }
       }
    
    func saveEcrypted(object: Type, folderPath: String, fileName: String? = nil) {
        var filePath = folderPath
        
        if let filename = fileName {
            filePath = folderPath + "/\(filename)"
        }
        
        if fileManager.fileExists(atPath: filePath) {
            do { // read & append
                arrayObject = readEncrypted(filePath: filePath)
                arrayObject.append(object)
                writeEncrypted(filePath: filePath)
            }
        } else { // if dont exist will create a new directory
            createDirectory(folderPath: folderPath, filePath: filePath)
            arrayObject.append(object)
            writeEncrypted(filePath: filePath)
        }
    }
    
    
    func readEncrypted(filePath: String) -> [Type] {
        var arrayType = [Type]()
        
        if fileManager.fileExists(atPath: filePath) {
            do {
                let aes = try AES(key: key, iv: iv)
                let decrypted = try Data(contentsOf: URL(fileURLWithPath: filePath)).decrypt(cipher: aes)
                arrayType = try decoder.decode([Type].self, from: decrypted)
                return arrayType
            } catch {
                 print(error.localizedDescription)
            }
        }
        return arrayType
    }
    
    
    func deleteEncrypted(filePath: String, id: Int) {
        
        if fileManager.fileExists(atPath: filePath) {
            var arrayObject = readEncrypted(filePath: filePath)
            if !arrayObject.isEmpty {
                arrayObject.enumerated().forEach { index, element in
                    if element.id == id {
                        arrayObject.remove(at: index)
                        writeEncrypted(filePath: filePath)
                    }
                }
            }
        }
    }
    
    private func createDirectory(folderPath: String, filePath: String) {
         do {
             try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
             let jsonData = try encoder.encode(arrayObject)
             if let jsonString = String(data: jsonData, encoding: .utf8) {
                 let url = URL(fileURLWithPath: filePath)
                 try jsonString.write(to: url, atomically: true, encoding: .utf8)
             }
         }
         catch {
             print(error.localizedDescription)
         }
     }
    
}
