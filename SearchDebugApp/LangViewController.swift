 
import UIKit

private let reuseIdentifier = "Cell"

class LangViewController: UITableViewController, UISearchBarDelegate,UISearchResultsUpdating {
    
    // MARK: - Properties
    
    var languages = [Language]()
    var filteredLanguages = [Language]()
    let searchController = UISearchController(searchResultsController: nil)
    var input : UITextField?
   
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().barTintColor = UIColor(red:1.00, green:0.84, blue:0.00, alpha:1.0)

        setupSearchController()
        self.definesPresentationContext = true
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        fetchlangData()
        
        
    }
    
    func fetchlangData(){
        if let path = Bundle.main.path(forResource: "languages", ofType: "json") {
            do {
                let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
                let jsonDictionary = try(JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any]
                
                if let languagesArray = jsonDictionary?["languages"] as? [[String: AnyObject]] {
                    self.languages = [Language]()
                    for languageDictionary in languagesArray {
                        let language = Language(dictionary: languageDictionary)
                        self.languages.append(language)
                    }
                }
            } catch let err {
                print(err)
            }
        }
    }
    
    
    func setupSearchController(){
        self.navigationItem.titleView = self.searchController.searchBar;
        
        searchController.searchBar.layer.cornerRadius = 25
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.subviews[0].subviews.flatMap(){ $0 as? UITextField }.first?.tintColor = UIColor.black
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.searchBarStyle = .default
        searchController.searchBar.keyboardType = .default
        searchController.searchBar.returnKeyType = .done
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredLanguages.count
        }
        return languages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let language: Language
        if searchController.isActive && searchController.searchBar.text != "" {
            language = filteredLanguages[indexPath.row]
        } else {
            language = languages[indexPath.row]
        }
        cell.textLabel!.text = language.language
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
            input?.text = filteredLanguages[indexPath.row].language
        } else {
            input?.text = languages[indexPath.row].language
        }
        searchController.isActive = false
        self.searchController.view.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func filterContentForSearchText(_ searchText: String) {
        filteredLanguages = languages.filter({( langSearched : Language) -> Bool in
            return (langSearched.language?.lowercased().contains(searchText.lowercased()))!
        })
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.view.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}



