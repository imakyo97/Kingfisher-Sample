//
//  PokemonViewController.swift
//  Kingfisher-Sample
//
//  Created by 今村京平 on 2021/12/08.
//

import UIKit

final class PokemonViewController: UIViewController {
    @IBOutlet private weak var pokemonTableView: UITableView!

    private let pokemonTotal: Float = 897
    private let numberOfPokemonInRow: Float = 3
    private var pokemonImageURLArray: [[URL?]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        pokemonImageURLArray = createPokemonImageURLArray()
    }

    private func setupTableView() {
        pokemonTableView.register(
            PokemonTableViewCell.nib,
            forCellReuseIdentifier: PokemonTableViewCell.identifier
        )
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
    }

    private func createPokemonImageURLArray() -> [[URL?]] {
        var pokemonURLArray: [[URL?]] = []
        var pokemonURLRowArray: [URL?] = []
        (1...Int(pokemonTotal)).forEach {
            let url = createPokemonImageURL(number: $0)
            pokemonURLRowArray.append(url)
            if $0 % Int(numberOfPokemonInRow) == 0 || $0 == Int(pokemonTotal) {
                pokemonURLArray.append(pokemonURLRowArray)
                pokemonURLRowArray.removeAll()
            }
        }
        return pokemonURLArray
    }

    private func createPokemonImageURL(number: Int) -> URL? {
        let stringURL = "https://cdn.traction.one/pokedex/pokemon/\(number).png"
        let url = URL(string: stringURL)
        return url
    }

    // MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let cellHeight = view.bounds.width / CGFloat(numberOfPokemonInRow)
        pokemonTableView.rowHeight = cellHeight
    }
}

// MARK: - UITableViewDelegate
extension PokemonViewController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource
extension PokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(ceil(pokemonTotal / numberOfPokemonInRow))
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PokemonTableViewCell.identifier
        ) as! PokemonTableViewCell // swiftlint:disable:this force_cast
        cell.configure(urls: pokemonImageURLArray[indexPath.row])
        return cell
    }
}
