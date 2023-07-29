//
//  MovieViewController.swift
//  MovieGesture
//
//  Created by 張丰澤 on 2023/7/27.
//

import UIKit
import AVFoundation
import OSLog

class MovieViewController: UIViewController {
    
    let logger = Logger()
    let audioPlayer = AVPlayer()
    var audioPlayerItem : AVPlayerItem?
    
    let movieImageArray = ["HurryPorter","YourName","SweetHome"]
    let movieTitleArray = ["Harry Prtter","你的名字","SweetHome"]
    let movieSubTitleArray = ["The Deathly Hallows – Part 2","君の名は","스위트홈"]
    let movieContentArray = ["在終極篇的第二部，正邪一戰將會全面爆發。危機升級至前所未見的凶險，沒有一個人能置身事外。但是，只有哈利波特一人會需要獨自與佛地魔展開終極一戰。到底誰勝誰負呢？","故事敘述居住在東京的少年立花瀧與糸守町出身的少女宮水三葉，偶然發現彼此的意識會互換至對方身上後，所延伸的連串奇異際遇。","講述主角家人離世後獨自搬到「綠之家」居住。在自殺的那天，發生一連串恐怖事件，在公寓被怪物襲擊後，跟鄰居並肩作戰對抗怪物。"]
    
    let musicArray = [["Statues","Harry's Sacrifice","Lily's Theme"],["なんでもないや","夢灯籠","憧れカフェ"],["Sweet Home","Dark Sun","Monster Slayers"]]
    var index = 0
    var currentAudio = 0

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieSubTitle: UILabel!
    @IBOutlet weak var movieContent: UITextView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var playIcon: UIButton!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var fullTime: UILabel!
    
    
    
    override func viewDidLoad() {

        // Do any additional setup after loading the view.
    }
    
    func audioStop() {
        playIcon.setImage(UIImage(systemName: "play.fill"), for: .normal)
        audioPlayer.pause()
    }
    
    func updateUI() {
        movieImageView.image = UIImage(named: movieImageArray[index])
        movieTitle.text = movieTitleArray[index]
        movieSubTitle.text = movieSubTitleArray[index]
        movieContent.text = movieContentArray[index]
        pageControl.currentPage = index
        
        
        currentAudio = 0
        if audioPlayer.timeControlStatus == .playing { audioStop() }
        let musicItem = AVPlayerItem(url: Bundle.main.url(forResource: musicArray[index].first, withExtension: "mp3")!)
        audioPlayer.replaceCurrentItem(with: musicItem)
    }
    
    func audioChang(_ index: Int, current: Int, changed: Int ) -> Int {
        let audioCount = musicArray[index].count
        let audioNumber = ( current + changed + audioCount ) % audioCount
        return audioNumber
    }
    

//    func updatePlayItem() {
//        currentTime.text = String(audioPlayer.currentTime().seconds)
//    }
    

    @IBAction func PageControl(_ sender: Any) {
        index = pageControl.currentPage
        updateUI()
    }
    
    @IBAction func nextPage(_ sender: Any) {
        index = ( index + 1 + movieTitleArray.count ) % movieTitleArray.count
        updateUI()
    }
    
    @IBAction func PreviewPage(_ sender: Any) {
        index = ( index - 1 + movieTitleArray.count ) % movieTitleArray.count
        updateUI()
    }
    
    //MUSIC CONTROL
    
    @IBAction func playButton(_ sender: UIButton) {
        let musicList = musicArray[index]
        if audioPlayer.timeControlStatus == .paused {
            playIcon.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            if audioPlayer.currentItem == nil {
                let musicItem = AVPlayerItem(url: Bundle.main.url(forResource: musicList.first, withExtension: "mp3")!)
                audioPlayer.replaceCurrentItem(with: musicItem)
            }
            audioPlayer.play()
        } else {
            audioStop()
        }
//        updatePlayItem()
    }
    let aaa = Bundle.main

    
    @IBAction func nextMusic(_ sender: Any) {
        let musicList = musicArray[index]
        let musicNumber =  audioChang( index, current: currentAudio, changed: 1)
        let musicItem = AVPlayerItem(url: Bundle.main.url(forResource: musicList[musicNumber], withExtension: "mp3")!)
        audioPlayer.replaceCurrentItem(with: musicItem)
        currentAudio = musicNumber
    }
    
    @IBAction func preMusic(_ sender: Any) {
        let musicList = musicArray[index]
        let musicNumber =  audioChang( index, current: currentAudio, changed: -1)
        let musicItem = AVPlayerItem(url: Bundle.main.url(forResource: musicList[musicNumber], withExtension: "mp3")!)
        audioPlayer.replaceCurrentItem(with: musicItem)
        currentAudio = musicNumber
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
