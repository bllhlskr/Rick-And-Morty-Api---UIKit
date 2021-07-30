//
//  ViewController.swift
//  Rick And morty Api TableView
//
//  Created by Halis  Kara on 31.07.2021.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    @IBOutlet var tableView : UITableView!
    private var loading = true
    var dataSource = [Character]()
    var selectedRow = 0
//    init() {
//        let url = "https://rickandmortyapi.com/api/episode"
//        dataSource = RequestApi(url: url)
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let url = "https://rickandmortyapi.com/api/episode"
        
        let url = "https://rickandmortyapi.com/api/character"
        RequestApi(url: url)
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MainTableViewCell")
    }
    
    // MARK - TableView Funcs

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loading {
            return 1
        }else{
            return dataSource.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        if loading {
            cell.characterImage.backgroundColor = .gray
            cell.statusLabel.text = "loading..."
            cell.nameLabel.text = "loading..."
            cell.speciesLabel.text = "loading..."
            
            
        } else {
           
            let character = dataSource[indexPath.row]
            let url = URL(string: character.image)

            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
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
        performSegue(withIdentifier: "gotoDetails", sender: self)
        
    }
    
    
 
    
    // MARK - APi Request
    
    func RequestApi (url : String){
        
        let urlSession = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
            guard let data = data , err == nil else {
                print("something went wrong")
                return
                
            }
            
            var result : Response?
            do{
                result = try JSONDecoder().decode(Response.self,from: data)
                self.dataSource.append(contentsOf: result!.results)
                
            }catch{
                print("failed to convert")
            }
            
           
            
            
            self.loading = false
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
            
        }.resume()
        
    }
    
    
     //MARK - Seuge Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoDetails"{
            let secondVC = segue.destination as! DetailsViewViewController
            secondVC.character = self.dataSource[self.selectedRow]
        }
    }

   
    
    
    
    

}

// MARK - Character JSON MODEL
struct Response :Codable{
    let results : [Character]
}

struct Character : Codable{
    let name : String
    let status : String
    let species:String
    let image : String
    
}


