//
//  ViewController.swift
//  Rick And morty Api TableView
//
//  Created by Halis  Kara on 31.07.2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var selectedRow = 0
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let url = "https://rickandmortyapi.com/api/character"
        DispatchQueue.main.async {
            self.viewModel.requestApi(url: url){didFinish in
                switch didFinish {
                case .success(_):
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        }
                case .failure(_):
                    print("api req err")
                }
            }
        }
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MainTableViewCell")
    }
}

// MARK: - TableView Funcs
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.loading {
            return 1
        }
        else {
            return viewModel.dataSource.count
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        if viewModel.loading {
            
            cell.characterImage.backgroundColor = .gray
            cell.statusLabel.text = "loading..."
            cell.nameLabel.text = "loading..."
            cell.speciesLabel.text = "loading..."
        }
        else {
           
            let character = viewModel.dataSource[indexPath.row]
            let url = URL(string: character.image)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    cell.characterImage.image = UIImage(data: data!)
                }
            }
            cell.statusLabel.text = character.status
            cell.nameLabel.text = character.name
            cell.speciesLabel.text = character.species
           }
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsView") as! DetailsViewController
        detailsVC.character = viewModel.dataSource[self.selectedRow]
        self.present(detailsVC, animated:true, completion:nil)
    }
}
