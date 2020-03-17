//
//  Service.swift
//  DiarioDeAprendizado
//
//  Created by Vinicius Mesquita on 14/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

public final class Service<Type: Codable> {
    
    let fileManager = FileManager.default
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    var arrayObject = [Type]()
    
    func read(filePath: URL) -> [Type] {
        var arrayType = [Type]()
        if fileManager.fileExists(atPath: filePath.relativePath) {
            do {
                let json = try String(contentsOf: filePath)
                let jsonData = json.data(using: .utf8)!
                
                arrayType = try decoder.decode([Type].self, from: jsonData)
                return arrayType
            } catch {
                print(error.localizedDescription)
            }
        }
        return arrayType
    }
    
    func write(filePath: URL) {
        do { // write
            let jsonData = try encoder.encode(arrayObject)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                try jsonString.write(to: filePath, atomically: true, encoding: .utf8)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func override(object: Type, folderPath: URL, fileName: String) {
        
        encoder.outputFormatting = .prettyPrinted
        let filePath = folderPath.appendingPathComponent(fileName)
        
        if fileManager.fileExists(atPath: filePath.relativePath) {
            do { // read & append
                arrayObject = read(filePath: filePath)
                arrayObject.append(object)
                write(filePath: filePath)
            }
        } else { // if dont exist will create a new directory
            createDirectory(folderPath: folderPath, fileName: fileName)
            arrayObject.append(object)
            write(filePath: filePath)
        }
    }
    
    func delete() {
        
    }
    
    private func createDirectory(folderPath: URL, fileName: String) {
        do {
            try fileManager.createDirectory(atPath: folderPath.relativePath, withIntermediateDirectories: true, attributes: nil)
            let jsonData = try encoder.encode(arrayObject)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                try jsonString.write(to: folderPath.appendingPathComponent(fileName), atomically: true, encoding: .utf8)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
