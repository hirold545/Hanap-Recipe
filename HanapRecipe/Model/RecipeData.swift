import Foundation

struct RecipeData: Codable {
    let recipes : [Recipe]
}

struct Recipe: Codable {
    let title: String
    let recipe_id: String
    let image_url: String
}
