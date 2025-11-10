//
//  RecipeViewController.swift
//  HanapRecipe
//
//  Created by test test on 11/6/25.
//

import UIKit

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let categories = ["All", "Chicken", "Pork", "Beef", "Fish"]
    let recipes = [
        ("Avocado toast", "avocado_toast"),
        ("Caesar Salad", "caesar_salad"),
        ("Mushroom Risotto", "mushroom_risotto"),
        ("Chocolate mousse", "mousse")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    
        view.backgroundColor = UIColor(red: 0.98, green: 0.91, blue: 0.84, alpha: 1.0) // beige
        collectionView.backgroundColor = .clear
        
    }
    

    
}

extension RecipeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func setupUI() {
        
        searchBar.backgroundImage = UIImage() // removes the outer background
        searchBar.barTintColor = .clear
        searchBar.backgroundColor = .white
        searchBar.layer.cornerRadius = 16

        // Make text field background clear
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.white.withAlphaComponent(0.2) // light transparent white
            textField.layer.cornerRadius = 10
            textField.clipsToBounds = true
            textField.textColor = .darkGray
            textField.tintColor = .darkGray // cursor color
            textField.leftView?.tintColor = .darkGray // magnifying glass tint
        }

        categoryStackView.spacing = 10
        categoryStackView.distribution = .fillProportionally
        
        for cat in categories {
            let button = UIButton(type: .system)
            button.setTitle(cat, for: .normal)
            button.setTitleColor(.darkGray, for: .normal)
            button.backgroundColor = UIColor(white: 1.0, alpha: 0.4)
            button.layer.cornerRadius = 10
            categoryStackView.addArrangedSubview(button)
        }
        
        collectionView.backgroundColor = .clear
        view.backgroundColor = UIColor(named: "BeigeBackground") // your main color

        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        let recipe = recipes[indexPath.item]
        cell.titleLabel.text = recipe.0
        cell.recipeImageView.image = UIImage(named: recipe.1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let sectionInsets = layout.sectionInset
        let spacing = layout.minimumInteritemSpacing
        let totalSpacing = sectionInsets.left + sectionInsets.right + spacing
        
        let availableWidth = collectionView.bounds.width - totalSpacing
        let width = availableWidth / 2
        
        layout.collectionView?.backgroundColor = .clear
        
        return CGSize(width: width, height: 200)
    }

    
    
}
