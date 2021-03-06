//
//  PokemonTableViewCell.swift
//  Kingfisher-Sample
//
//  Created by 今村京平 on 2021/12/08.
//

import UIKit
import Kingfisher

final class PokemonTableViewCell: UITableViewCell {
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: identifier, bundle: nil) }

    @IBOutlet private weak var pokemonImageView1: UIImageView!
    @IBOutlet private weak var pokemonImageView2: UIImageView!
    @IBOutlet private weak var pokemonImageView3: UIImageView!

    private lazy var pokemonImageViews: [UIImageView] = [
        pokemonImageView1,
        pokemonImageView2,
        pokemonImageView3
    ]

    func configure(urls: [URL?]) {
        zip(pokemonImageViews, urls).forEach { imageView, url in
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "monsterBall"))
        }
    }
}
