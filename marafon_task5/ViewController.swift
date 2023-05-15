
import UIKit
import Foundation

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    lazy var buttonShowPopup = {
        let btn = UIButton()
        
        btn.setTitle("Present", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        
        btn.addTarget(self, action: #selector(showPopupController), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var popupController = PopupViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(buttonShowPopup)
    }
    
    func setupLayout() {
        view.backgroundColor = .white
    }

    func setupConstraints() {
        buttonShowPopup.translatesAutoresizingMaskIntoConstraints = false
        
        buttonShowPopup.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
            .isActive = true
        buttonShowPopup.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            .isActive = true
    }
    
    @objc func showPopupController() {
        popupController.segmentedControl.selectedSegmentIndex = 0
        popupController.preferredContentSize.height = 280
        
        popupController.modalPresentationStyle = .popover
        popupController.popoverPresentationController?.sourceRect = buttonShowPopup.frame
        popupController.popoverPresentationController?.sourceView = self.view
        popupController.popoverPresentationController?.permittedArrowDirections = .up
        popupController.popoverPresentationController?.delegate = self
        
        present(popupController, animated: true)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }

    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        buttonShowPopup.setTitleColor(.lightGray, for: .normal)
    }
     
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        buttonShowPopup.setTitleColor(.systemBlue, for: .normal)
    }
    
}

class PopupViewController: UIViewController {
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.insertSegment(withTitle: "280pt", at: 0, animated: true)
        segmented.insertSegment(withTitle: "150pt", at: 1, animated: true)
        segmented.selectedSegmentIndex = 0
        
        segmented.translatesAutoresizingMaskIntoConstraints = false
        
        segmented.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        return segmented
    }()
    
    lazy var closeButton: UIButton = {
        let btn = UIButton()
        
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
        let crossSymbol = UIImage(systemName: "multiply", withConfiguration: symbolConfig)
        
        btn.setImage(crossSymbol, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.8869980574, green: 0.8870462179, blue: 0.9085456133, alpha: 1)
        
        btn.tintColor = .gray
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font.withSize(30)
        btn.layer.cornerRadius = 15
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        setupLayout()
    }
    
    func setupLayout() {
        // controller
        view.backgroundColor = #colorLiteral(red: 0.9490073323, green: 0.9455509782, blue: 0.9702795148, alpha: 1)
        view.layer.cornerRadius = 15
        preferredContentSize = CGSize(width: 300, height: 280)
        
        // constraints
        // segmented control
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        segmentedControl.widthAnchor.constraint(equalToConstant: 110).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // close button
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        closeButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func addSubViews() {
        view.addSubview(segmentedControl)
        view.addSubview(closeButton)
    }
    
    @objc func segmentedControlValueChanged() {
        if (segmentedControl.selectedSegmentIndex == 0) {
            preferredContentSize.height = 280
        } else if (segmentedControl.selectedSegmentIndex == 1) {
            preferredContentSize.height = 150
        }
    }
    
    @objc func closePopup() {
        dismiss(animated: true, completion: nil)
    }
    
}
