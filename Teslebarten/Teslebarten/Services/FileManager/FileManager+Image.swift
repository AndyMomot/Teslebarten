import Foundation

extension FileManagerService {
    func saveImage(data: Data, for id: String) async {
        let path = FileManagerService.Keys.image(id: id).path
        saveFile(data: data, forPath: path)
    }
    
    func fetchImage(with id: String) async -> Data? {
        let path = FileManagerService.Keys.image(id: id).path
        let imageData = getFile(forPath: path)
        return imageData
    }
    
    func removeImage(with id: String) async {
        let path = FileManagerService.Keys.image(id: id).path
        removeFile(forPath: path)
    }
}
