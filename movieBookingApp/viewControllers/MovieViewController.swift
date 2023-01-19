import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var castcollectionView: UICollectionView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var ivBack: UIImageView!
    
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var rate: UILabel!
    
    
    @IBOutlet weak var summary: UILabel!
    
    var profiledata : LoginDataClass?
    var movieID : Int?
    var networkAgent = NetworkAgent.shared
    let movieModel = MovieModelImpl.shared
    var movieDetailData : MovieDetail?
    
    var dataObject: DataObject = DataObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.layer.cornerRadius = 30
        detailView.layer.maskedCorners = [ .layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        castcollectionView.dataSource=self
        castcollectionView.delegate=self
        castcollectionView.registerCell(identifier: CastCollectionViewCell.idenfifier)
        
        
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
        genreCollectionView.registerCell(identifier: GenreCollectionViewCell.idenfifier)
        
        tapGestureRecognizer()
        
        getDetail(id: movieID ?? 0)
        
    }
    
    func getDetail(id: Int){
        movieModel.movieDetail(id: id) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.dataObject.movieDetail = data
                //dvmovieDetail = data
                self.movieDetailData = data
                self.bindData(data)
                self.castcollectionView.reloadData()
                self.genreCollectionView.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
    
    func bindData(_ data: MovieDetail){
        let posterpath = "\(imageBaseUrl)\(data.posterPath ?? "")"
        backDropImage.sd_setImage(with: URL(string: posterpath))
        movieTitle.text = data.originalTitle ?? ""
        let hour = Int((data.runtime ?? 0)/60)
        let hourmin = hour * 60
        let min = Int( (data.runtime ?? 0) - hourmin )
        
        duration.text = "\(hour)hr \(min)m"
        ratingControl.rating = Int((data.rating ?? 0)/2)
        rate.text = "IMDb \(data.rating ?? 0)"
        
        summary.text = data.overview ?? ""
    }
    
    @IBAction func getTicketButton(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ChooseDateTimeViewController.self)) as! ChooseDateTimeViewController
        vc.dataObject = dataObject
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
        
    }
    
    func tapGestureRecognizer(){
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapIV))
        ivBack.isUserInteractionEnabled=true
        ivBack.addGestureRecognizer(tapGestRecognizer)
    }
    
    @objc func onTapIV(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MainScreenViewController.self)) as! MainScreenViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
    }
}

extension MovieViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == castcollectionView {
            return movieDetailData?.casts?.count ?? 0
        }else {
            return movieDetailData?.genres?.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == castcollectionView {
            let cell = collectionView.dequeCell(identifier: CastCollectionViewCell.idenfifier, indexPath: indexPath) as! CastCollectionViewCell
            cell.data = movieDetailData?.casts?[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeCell(identifier: GenreCollectionViewCell.idenfifier, indexPath: indexPath) as! GenreCollectionViewCell
            cell.genre = movieDetailData?.genres?[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == genreCollectionView {
            return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.height)
        } else if collectionView == castcollectionView {
            return CGSize(width: 90, height: 90)
        } else{
            return CGSize()
        }
    }
}
