//
//  MediaMemoryStore.swift
//  SwiftyPress
//
//  Created by Basem Emara on 2018-06-04.
//

import ZamzamKit

public struct MediaFileStore: MediaStore {
    private let store: SeedStore
    
    public init(store: SeedStore) {
        self.store = store
    }
}

public extension MediaFileStore {
    
    func fetch(id: Int, completion: @escaping (Result<MediaType, DataError>) -> Void) {
        store.fetch {
            // Handle errors
            guard $0.isSuccess else {
                return completion(.failure($0.error ?? .unknownReason(nil)))
            }
            
            // Find match
            guard let value = $0.value?.media.first(where: { $0.id == id }) else {
                return completion(.failure(.nonExistent))
            }
            
            completion(.success(value))
        }
    }
}

public extension MediaFileStore {
    
    func fetch(ids: Set<Int>, completion: @escaping (Result<[MediaType], DataError>) -> Void) {
        store.fetch {
            // Handle errors
            guard $0.isSuccess else {
                return completion(.failure($0.error ?? .unknownReason(nil)))
            }
            
            let value = $0.value?.media.filter { ids.contains($0.id) } ?? []
            
            completion(.success(value))
        }
    }
}