//
//  MovieDetailsViewController.swift
//  CinemaApp
//
//  Created by Ana on 13/12/2019.
//  Copyright © 2019 Ana Popilian. All rights reserved.
//

import UIKit

final class MovieDetailsViewController: UIViewController, MovieDetailsViewControllerProtocol {
    
    var genreData: Genres!
    var currentMovie: MovieModel!
    private var movieDetailsView: MovieDetailsView!
    
    required init(movie: MovieModel, genres: Genres) {
        super.init(nibName: nil, bundle: nil)
        currentMovie = movie
        genreData = genres
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        movieDetailsView = MovieDetailsView()
        
        navigationController?.navigationBar.barTintColor = ColorHelper.customGray
        navigationController?.navigationBar.tintColor = UIColor.white
        
        view = movieDetailsView
        movieDetailsView.bindView(movie: currentMovie)
        setGenres()
        
        setTitle()
    }
    
    func setTitle() {
        let font =  UIFont.systemFont(ofSize: 16)
        let label = UILabel(text: currentMovie.title, font: font, textAlignment: .center, textColor: .white)
        label.numberOfLines = 2
        self.navigationItem.titleView = label
    }
    
    func setGenres() {
        let genresNames = genreData.genres
            .filter { currentMovie.genre.contains($0.id) }
            .map { $0.name }
        
        movieDetailsView.setGenres(genresNames)
    }
}
