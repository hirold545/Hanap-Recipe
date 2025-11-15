import Foundation

protocol RecipeManagerDelegate{
    func didUpdateRecipe(_ recipeManager: RecipeManager, recipe: [RecipeModel])
    func didFailedWithError(error: Error)
}

struct RecipeManager {
    let recipeURL = "https://forkify-api.herokuapp.com/api/search?"
    
    var delegate: RecipeManagerDelegate?
    
    func fetchRecipe(recipeName: String) {
        let urlString = "\(recipeURL)&q=\(recipeName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1. Create a URL
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let recipe = self.parseJSON(with: safeData) {
                        self.delegate?.didUpdateRecipe(self, recipe: recipe)
                    }
                }
                
            }
            
            task.resume()
        }
    }
    
    func parseJSON(with recipeData: Data) -> [RecipeModel]? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(RecipeData.self, from: recipeData)
            let recipeModel = decoderData.recipes.map { recipe in
                RecipeModel(title: recipe.title, id: recipe.recipe_id, imageUrl: recipe.image_url)
            }
            return recipeModel
        } catch {
            print(error)
            return nil
        }
    }
}
