//
//  GenreMapper.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

struct GenreMapper {
    static func map(response: GenreResultResponse) -> [Genre] {
        return response.genres.map { genre in
            Genre(
                id: genre.id.orEmpty(),
                name: genre.name.orEmpty()
            )
        }
    }
}
