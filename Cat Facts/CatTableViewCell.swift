import UIKit

struct CatViewModel {
    var name: String
    var text: String
    var lastname: String
    
    init(with catModel: Cat){
        text = catModel.text
        name = catModel.name?.first ?? ""
        lastname = catModel.name?.last ?? ""
    }
}

class CatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var textCell: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        imageCell.layer.cornerRadius = 5
        imageCell.layer.masksToBounds = true
        
        imageCell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageCell.layer.borderWidth = 1
        imageCell.layer.masksToBounds = true
    }
    
    func setup(with catModel: CatViewModel) {
        textCell.text = catModel.text
        name.text = "\(catModel.name) \(catModel.lastname)"
    }
}
