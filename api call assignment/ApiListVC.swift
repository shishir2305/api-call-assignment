import UIKit
import CoreData

class ApiListVC: UIViewController {
    var dataStore: [String: Any] = [:]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DataCell")
    }
    
    func fetchData() {
        
        guard let apiUrl = URL(string: "https://www.boredapi.com/api/activity") else {
            print("Invalid URL")
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: apiUrl) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    self.dataStore = jsonObject
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    print("Response: \(jsonObject)")
                } else {
                    print("Invalid JSON format")
                }
            } catch {
                print("JSON Error: \(error)")
            }
        }
        
        task.resume()
    }
}

extension ApiListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath)
        if let fact = dataStore["type"] as? String {
            cell.textLabel?.text = fact
        } else {
            cell.textLabel?.text = "Unknown"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToApiDetailVC", sender: dataStore)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ApiDetailVC
        destVC.dataStore = (sender as! [String:Any])
    }
    
    
}

