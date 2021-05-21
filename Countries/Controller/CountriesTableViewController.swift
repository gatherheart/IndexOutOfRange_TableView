import UIKit

struct Country {
    var isoCode: String
    var name: String
}

class CountriesTableViewController: UITableViewController {

    let enableSafeUpdate: Bool = false
    
    var countries = [
        Country(isoCode: "at", name: "Austria"),
        Country(isoCode: "be", name: "Belgium"),
        Country(isoCode: "de", name: "Germany"),
        Country(isoCode: "el", name: "Greece"),
        Country(isoCode: "fr", name: "France"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.1) { [unowned self] in
            if self.enableSafeUpdate {
                DispatchQueue.main.async {
                    self.countries.remove(at: 0)
                    print("asyncAfter update datasource", self.countries.count)
                }
            } else {
                self.countries.remove(at: 0)
                print("asyncAfter update datasource", self.countries.count)
            }
            
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        print("numberOfSections", countries.count)
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection", countries.count)
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)

        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.isoCode
        cell.imageView?.image = UIImage(named: country.isoCode)
        
        print("cellForRowAt", countries.count, indexPath)
        return cell
    }
}
