import UIKit

import UIKit

class RecipeCell: UICollectionViewCell {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Transparent layers
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        recipeImageView.backgroundColor = .clear
        backgroundView?.backgroundColor = .clear
        
//         Card styling
        cardView.backgroundColor = UIColor(red: 0.898, green: 0.584, blue: 0.282, alpha: 1.0)
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = false
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cardView.layer.shadowRadius = 6
        
        // Image styling
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.layer.cornerRadius = 16
        recipeImageView.clipsToBounds = true
        
        // Label
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.backgroundColor = .clear
    }
}

