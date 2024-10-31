//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Basith on 30/10/24.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not read \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        do {
            return try  decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Could not find key \(key) in \(context.codingPath)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Type mismatch for \(context.codingPath)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) due to missing \(type) value in \(context.codingPath)")
        } catch DecodingError.dataCorrupted(let context) {
            fatalError("Failed to decode \(file) due to corrupted data in \(context.codingPath)")
        } catch {
            fatalError("Failed to decode \(file): \(error.localizedDescription)")
        }
    }
}
