//
//  AlbumListTableViewController.swift
//  PacelineDemo
//
//  Created by Jonathan  Fotland on 7/25/22.
//

import UIKit

class AlbumListTableViewController: UITableViewController, AlbumListViewModelDelegate {

    var viewModel: AlbumListViewModel?
    let reuseIdentifier = "albumCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AlbumListViewModel(delegate: self)
        
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 120
    }
    
    // MARK: - View Model Delegate Methods
    
    func didFinishLoading() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.title = self.viewModel?.albumData?.title
        }
    }
    
    func loadingFailed(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error Loading Data", message: "Couldn't load album list. Please try again later.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfAlbums() ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        // Configure the cell...
        if let album = viewModel?.albumAtIndex(index: indexPath.row),
            let albumCell = cell as? AlbumTableViewCell {
            albumCell.configure(album: album)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let album = viewModel?.albumAtIndex(index: indexPath.row) {
            let detailController = AlbumDetailViewController()
            detailController.album = album
            navigationController?.pushViewController(detailController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}
