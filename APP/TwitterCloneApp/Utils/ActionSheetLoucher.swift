//
//  ActionSheetLoucher.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 09/09/21.
//

import UIKit

private let reuseIdentifier = "actionSheetViewCell"

protocol ActionSheetLoucherDelegate: class {
    func didSelect(option: ActionSheetOptions)
}

class ActionSheetLoucher: NSObject {
    
    weak var delegate: ActionSheetLoucherDelegate?
    
    private let tableView = UITableView()
    private var window: UIWindow?
    let tableViewHEight = CGFloat(3 * 60) + 100
    private lazy var viewModel = ActionSheetViewModel(user: "me")
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.alpha = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.addSubview(cancelButton)
        cancelButton.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 12, paddingRight: 12)
        cancelButton.centerY(inView: view)
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(width: 300, height: 50)
        button.layer.cornerRadius = 50/2
        button.setTitle("Cancelar", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemGroupedBackground
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    override init() {
        super.init()
        configureTableView()
    }
    
    func show() {
        DEBUGMessage("Show action sheet")
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        self.window = window
        
        window.addSubview(blackView)
        blackView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
        
        window.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: (window.frame.height),
                                 width: (window.frame.width), height: (tableViewHEight))
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 1
            self.tableView.frame.origin.y -= (self.tableViewHEight)
        }
        
    }
    
    func configureTableView() {
//        tableView.backgroundColor = .red
        
        tableView.register(ActionSheetViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = false
    }
    
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.tableView.frame.origin.y += (self.tableViewHEight)
        }
    }
}

extension ActionSheetLoucher: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = viewModel.options[indexPath.row]
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.tableView.frame.origin.y -= self.tableViewHEight
        } completion: { _ in
            self.delegate?.didSelect(option: option)
        }
        
    }
}


extension ActionSheetLoucher: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ActionSheetViewCell
        cell.options = viewModel.options[indexPath.row]
        return cell
    }
    
}
