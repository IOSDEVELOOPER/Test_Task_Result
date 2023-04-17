import UIKit

class ViewController: UIViewController {
  private let server = Server()
  private var model: [Deal] = []
  private var selectedItem = "Price"
  private var selectedDirection = "Up"
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var filterItem: UINavigationItem!
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Deals"
        
    
    tableView.register(UINib(nibName: DealCell.reuseIidentifier, bundle: nil), forCellReuseIdentifier: DealCell.reuseIidentifier)
    tableView.register(UINib(nibName: HeaderCell.reuseIidentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderCell.reuseIidentifier)
    tableView.dataSource = self
    tableView.delegate = self
        
    filterItem.trailingItemGroups = [UIBarButtonItemGroup(barButtonItems: [UIBarButtonItem(title: "Price", style: .plain, target: self, action: #selector(filterPrice)), UIBarButtonItem(title: "Amount", style: .plain, target: self, action: #selector(filterAmount))], representativeItem: nil)]
                
    filterItem.leadingItemGroups = [UIBarButtonItemGroup(barButtonItems: [UIBarButtonItem(title: "Side", style: .plain, target: self, action: #selector(filterSide)), UIBarButtonItem(title: "Date", style: .plain, target: self, action: #selector(filterDate)), UIBarButtonItem(title: "Up", style: .plain, target: self, action: #selector(filterDate)), UIBarButtonItem(title: "Down", style: .plain, target: self, action: #selector(filterDate))], representativeItem: nil)]
    
    server.subscribeToDeals { deals in
        
        
        self.model.append(contentsOf: deals)
        
        switch (self.selectedItem, self.selectedDirection){

        case ("Price", "Down"):
            DispatchQueue.global(qos: .default).sync {
                self.model = self.model.sorted{$0.price > $1.price}
            }
            
        case ("Price", "Up"):
            DispatchQueue.global(qos: .default).sync {
                self.model = self.model.sorted{$0.price < $1.price}
            }


        case ("Amout", "Down"):
            DispatchQueue.global(qos: .default).sync {
                self.model = self.model.sorted{$0.amount > $1.amount}
            }
        case ("Amout", "Up"):
            DispatchQueue.global(qos: .default).sync {
                self.model = self.model.sorted{$0.amount < $1.amount}
            }


        case ("Side", "Down"):
            DispatchQueue.global(qos: .default).sync {
                self.model = self.model.sorted{$0.side.hashValue > $1.side.hashValue}
            }
        case ("Side", "Up"):
            DispatchQueue.global(qos: .default).sync {
                self.model = self.model.sorted{$0.side.hashValue < $1.side.hashValue}
            }


        case ("Date", "Down"):
            DispatchQueue.global(qos: .default).sync {
                self.model = self.model.sorted{$0.dateModifier.description > $1.dateModifier.description}
            }
        case ("Date", "Up"):
            DispatchQueue.global(qos: .default).sync {
                self.model = self.model.sorted{$0.dateModifier.description > $1.dateModifier.description}
            }

        default:
            DispatchQueue.global(qos: .default).sync {
                self.model = self.model.sorted{$0.price > $1.price}
            }
        }
        
      self.tableView.reloadData()
    }
  }
    
    @objc func filterPrice(){
        selectedItem = "Price"
        print(selectedItem)
    }
    @objc func filterAmount(){
        selectedItem = "Amount"
        print(selectedItem)
    }
    @objc func filterSide(){
        selectedItem = "Side"
        print(selectedItem)
    }
    @objc func filterDate(){
        selectedItem = "Date"
        print(selectedItem)
    }
    @objc func filterUp(){
        selectedDirection = "Up"
        print(selectedDirection)
    }
    @objc func filterDown(){
        selectedDirection = "Down"
        print(selectedDirection)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      model.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: DealCell.reuseIidentifier, for: indexPath) as! DealCell
      cell.configurate(instrumentName: model[model.startIndex + indexPath.row].instrumentName, price: model[model.startIndex + indexPath.row].price, amount: model[model.startIndex + indexPath.row].amount, side: model[model.startIndex + indexPath.row].side)
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCell.reuseIidentifier) as! HeaderCell
    return cell
  }
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return 60
//  }
}

