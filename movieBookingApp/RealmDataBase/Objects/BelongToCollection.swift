import Foundation
import RealmSwift

class BelongsToCollectionObject : Object {
    @Persisted var backdropPath : String
    @Persisted var id : Int
    @Persisted var name : String
    @Persisted var posterPath : String
    
    @Persisted var movies : List<MovieObject>
}
