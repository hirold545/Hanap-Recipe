//
//  RecipeViewController.swift
//  HanapRecipe
//
//  Created by test test on 11/6/25.
//

import UIKit
import SDWebImage

class RecipeViewController: UIViewController {
    

    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let categories = ["All", "Chicken", "Pork", "Beef", "Fish"]
    
    var recipes: [RecipeModel] = []
    var recipeManager = RecipeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        searchBar.delegate = self
        recipeManager.delegate = self
    
        collectionView.reloadData()
        

    }
    
}



extension RecipeViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            recipeManager.fetchRecipe(recipeName: searchText)
        }
        searchBar.resignFirstResponder()
        for case let button as UIButton in categoryStackView.arrangedSubviews {
            button.backgroundColor = UIColor(white: 0.9, alpha: 0.4)
            button.setTitleColor(.darkGray, for: .normal)
        }
    }
    
}

extension RecipeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    func setupUI() {
        
        //Search Container
        searchContainer.layer.cornerRadius = 20
        searchContainer.layer.masksToBounds = true
        searchContainer.backgroundColor = UIColor.systemGray6
        searchBar.backgroundImage = UIImage()
        
        // Removes fixed background
        searchBar.isTranslucent = true
        searchBar.barTintColor = .clear
        searchBar.backgroundColor = .white
        searchBar.layer.cornerRadius = 20
        searchBar.searchBarStyle = .minimal
        
        // Make text field background clear
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField{
            textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            // light transparent white
            textField.clipsToBounds = true
            textField.textColor = .darkGray
            textField.tintColor = .darkGray
            // cursor color
            textField.leftView?.tintColor = .darkGray
            // magnifying glass tint
            textField.bounds.size.height = 50
            textField.layer.cornerRadius = 12
        }

    
        categoryStackView.spacing = 10
        categoryStackView.distribution = .fillEqually
        
        for cat in categories {
            let button = UIButton(type: .system)
            button.setTitle(cat, for: .normal)
            button.setTitleColor(.darkGray, for: .normal)
            button.backgroundColor = UIColor(white: 0.9, alpha: 0.4)
            button.layer.cornerRadius = 20
            
            button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
            
            categoryStackView.addArrangedSubview(button)
        }
        
        collectionView.backgroundColor = .clear
//        view.backgroundColor = UIColor(named: "BeigeBackground") // your main color

        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    @objc func categoryButtonTapped(_ sender: UIButton) {
        // Deselect all buttons
        for case let button as UIButton in categoryStackView.arrangedSubviews {
            button.backgroundColor = UIColor(white: 0.9, alpha: 0.4)
            button.setTitleColor(.darkGray, for: .normal)
        }
        // Select tapped button
        sender.backgroundColor = .systemGreen
        sender.setTitleColor(.white, for: .normal)
        recipeManager.fetchRecipe(recipeName: (sender.titleLabel?.text)!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        let recipe = recipes[indexPath.item]
        cell.titleLabel.text = recipe.title

        cell.recipeImageView.sd_setImage(with: URL(string: recipe.imageUrl)!)
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


extension RecipeViewController: RecipeManagerDelegate {
    
    func didUpdateRecipe(_ recipeManager: RecipeManager, recipe: [RecipeModel]) {
        DispatchQueue.main.async {
            self.recipes = recipe
            self.collectionView.reloadData()
        }
    }
    
    
    func didFailedWithError(error: any Error) {
        print(error)
    }
    
    
}
