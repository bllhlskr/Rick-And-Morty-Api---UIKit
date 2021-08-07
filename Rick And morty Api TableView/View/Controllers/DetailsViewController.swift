//
//  DetailsViewViewController.swift
//  Rick And morty Api TableView
//
//  Created by Halis  Kara on 31.07.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    var character: Character?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        nameLabel.text = character?.name
        let url = URL(string: character!.image)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.characterImage.image = UIImage(data: data!)
            }
        }
        speciesLabel.text = "specie : \(character!.species)"
        statusLabel.text = "status : \(character!.status)"
    }
}
