//
//  RecipeData.swift
//  Recipe
//
//  Created by kuehar on 2021/06/24.
//

import Foundation
import UIKit


// JSONデータ
struct  RecipeItem:Identifiable {
    let id = UUID()
    let name: String
    let link: URL
    let image: UIImage
}

// レシピ検索用クラス
class RecipeData: ObservableObject{
    
    struct ResultJson:Codable {
        struct Item:Codable {
            let name: String?
            let url: URL?
            let image:URL?
        }
        let item: [Item]?
    }
    
    @Published var RecipeList: [RecipeItem] = []
    
    func searchRecipe(keyword:String){
        print(keyword)
        
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else {
            return
        }
        print(req_url)
        
        let req = URLRequest(url:req_url)
        let session = URLSession(configuration: .default,delegate: nil,delegateQueue: OperationQueue.main)
        let task = session.dataTask(with:req,completionHandler: {
            (data,response,error) in
            session.finishTasksAndInvalidate()
            do{
                let decoder = JSONDecoder()
                let json = try decoder.decode(ResultJson.self, from: data!)
                
                print(json)
            }catch{
                print("エラーが出ました")
            }
        })
        task.resume()
    }
}
