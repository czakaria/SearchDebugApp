
import UIKit

class ViewController: UIViewController {

    let bouton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(red:1.00, green:0.84, blue:0.00, alpha:1.0)
        btn.tintColor  = .white
        btn.setTitle( "Choose lang", for: UIControlState())
        btn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let input: UITextField = {
        let input = UITextField()
        input.placeholder = "place"
        input.borderStyle = .none
        input.layer.cornerRadius = 20
        input.layer.borderWidth = 1.0
        input.layer.borderColor = UIColor.black.cgColor
        input.textAlignment = .center
        input.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        input.keyboardType = .default
        input.translatesAutoresizingMaskIntoConstraints = false
        input.returnKeyType = .next
        return input
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(bouton)
        self.view.addSubview(input)
        setupConstraint()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func buttonClicked(){
        let lv = LangViewController()
        lv.input = self.input
        let view  = UINavigationController(rootViewController: lv)
        present(view, animated: true, completion: nil)
    }
    func setupConstraint(){
    
        bouton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bouton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        bouton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bouton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        input.topAnchor.constraint(equalTo: self.bouton.bottomAnchor , constant: 10).isActive = true
        input.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        input.heightAnchor.constraint(equalToConstant: 40).isActive = true
        input.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
