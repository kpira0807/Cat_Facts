import UIKit
import Alamofire

class CatFactsTableViewController: UITableViewController {
    
    private var catsList: [CatViewModel] = []
    let catsService = CatsService.shared
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private func loadCats() {
        activityIndicator.startAnimating()
        catsService.catsList(completed: { [weak self] cats in
            guard let strongSelf = self else { return }
            strongSelf.catsList = cats.filter{ cat -> Bool in
                if cat.name != nil {
                    return true
                }
                return false
                }.map{ CatViewModel(with: $0) }
            strongSelf.tableView.reloadData()
            self!.activityIndicator.stopAnimating()
            }, failed: {
                self.showError(with: ErrorType.loading)
                self.activityIndicator.stopAnimating()
        })
    }
    
    func showError(with type: ErrorType) {
        let myAlert = UIAlertController(title: "Error", message: type.rawValue, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Okey", style: .default, handler: nil)
        myAlert.addAction(okeyAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        self.loadCats()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CatTableViewCell
            else {
                return UITableViewCell()
        }
        
        let catModel = catsList[indexPath.row]
        cell.setup(with: catModel)
        cell.imageCell?.image = #imageLiteral(resourceName: "Cat_image")
        cell.textCell?.text = catModel.text
        cell.name?.text = "\(catModel.name) \(catModel.lastname)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
