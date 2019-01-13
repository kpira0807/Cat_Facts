import Foundation
import Alamofire

struct Cat: Decodable{
    enum CodingKeys: String, CodingKey {
        case text, user
    }
    
    enum UserKeys: String, CodingKey {
        case name
    }
    let text: String
    let name: CatName?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)
        
        let user = try? container.nestedContainer(keyedBy: UserKeys.self, forKey: .user)
        name = try user?.decodeIfPresent(CatName.self, forKey: .name)
    }
}

struct CatName: Decodable {
    let first: String
    let last: String
}

class CatsService {
    static let shared =  CatsService()
    
    struct CatsBox: Decodable {
        let all: [Cat]
    }
    
    func catsList(completed: @escaping ([Cat]) -> Void, failed: @escaping() -> Void) {
        AF.request("https://cat-fact.herokuapp.com/facts").responseDecodable { (response: DataResponse<CatsBox>) in
            switch response.result {
            case .success(let value):
                completed(value.all)
            case .failure(let error):
                print(" error \(error)")
                failed()
            }
        }
    }
}
