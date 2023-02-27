//
//  ViewController.swift
//  Aging People
//
//  Created by 라완 💕 on 21/04/1444 AH.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    var names: [Result] = []
    
    

    @IBOutlet weak var nameTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let main = names[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainLabel", for: indexPath) as! MyTableViewCell
        cell.nameLabel.text = main.name
            
//        cell.detailTextLabel?.text = ("\(Int.random(in: 5...95)) years old")
            return cell
        }
    func fetch() {
        
        let jsonURLstring = "https://swapi.dev/api/people"
        guard let url = URL(string : jsonURLstring) else {return }
        URLSession.shared.dataTask(with: url) { data , response, error in
            let decoder = JSONDecoder()
            guard let data = data else { return }

           do {
               let namePeople = try decoder.decode(Name.self ,from: data )
               guard let namepeople = namePeople.results else { return }
               self.names = namepeople

               DispatchQueue.main.async { [weak self] in
                   
                   self?.nameTable.reloadData()
               }
               print (namepeople)
           }catch let jsonErr{
               print("Error :" ,jsonErr )
           }
       }
        .resume()
    }
}
    

