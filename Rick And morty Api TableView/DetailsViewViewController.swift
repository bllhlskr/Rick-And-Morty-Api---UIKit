//
//  DetailsViewViewController.swift
//  Rick And morty Api TableView
//
//  Created by Halis  Kara on 31.07.2021.
//

import UIKit

class DetailsViewViewController: UIViewController {
    @IBOutlet var nameLabel :UILabel!
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var speciesLabel:UILabel!
    @IBOutlet var statusLabel : UILabel!
   
    @IBOutlet weak var characterImage: UIImageView!
    
    var character : Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = character?.name
        let url = URL(string: character!.image)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.characterImage.image = UIImage(data: data!)
            }
        }
        
        speciesLabel.text = "specie : \(character!.species)"
        statusLabel.text = "status : \(character!.status)"
        
        //detailsLabel.text = character?.status

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
