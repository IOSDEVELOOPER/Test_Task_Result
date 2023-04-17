import UIKit

class DealCell: UITableViewCell {
  static let reuseIidentifier = "DealCell"
  
  @IBOutlet weak var instrumentNameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var sideLabel: UILabel!
  
//  override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func configurate(instrumentName: String, price: Double, amount: Double, side: Deal.Side){
        instrumentNameLabel.text = instrumentName
        priceLabel.text = String(Double(round(100*price)/100))
        amountLabel.text = String(Double(round(amount)))
        switch side{
        case .sell:
            sideLabel.text = "sell"
            sideLabel.textColor = .red
        default:
            sideLabel.text = "buy"
            sideLabel.textColor = .green
        }
        
    }
    

}
