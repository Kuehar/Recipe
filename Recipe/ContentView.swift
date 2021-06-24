//
//  ContentView.swift
//  Recipe
//
//  Created by kuehar on 2021/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var recipeDataList = RecipeData()
    @State var inputText = ""
    
    var body: some View {
        VStack{
            TextField("キーワードを入力してください",text:$inputText,onCommit:{
                recipeDataList.searchRecipe(keyword: inputText)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
