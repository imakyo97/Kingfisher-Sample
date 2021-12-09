//
//  PokemonTableViewCell.swift
//  Kingfisher-Sample
//
//  Created by 今村京平 on 2021/12/08.
//

import UIKit

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
            ImageLoader().loadImgae(url: url) { image in
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }
}

final class ImageLoader {
    func loadImgae(url: URL?, uiImage: @escaping (UIImage?) -> Void) {
        let monsterBall = "monsterBall"
        guard let url = url else { return uiImage(UIImage(named: monsterBall)) }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                uiImage(image)
            } catch {
                uiImage(UIImage(named: monsterBall))
            }
        }
    }
}
