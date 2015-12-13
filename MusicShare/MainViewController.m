//
//  MainViewController.m
//  MusicShare
//
//  Created by shirai.makoto on 2015/12/14.
//  Copyright © 2015年 MACT. All rights reserved.
//

#import "MainViewController.h"

#import <MediaPlayer/MediaPlayer.h>

@interface MainViewController ()
/*! @abstract ミュージックプレイヤーコントローラー */
@property (strong, nonatomic) MPMusicPlayerController *player;

#pragma mark IBOutlets
@property (weak, nonatomic) IBOutlet UIImageView *artworkImageView;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *albumTitleText;
@property (weak, nonatomic) IBOutlet UITextField *artistNameText;
@property (weak, nonatomic) IBOutlet UITextField *commentText;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.player = [MPMusicPlayerController systemMusicPlayer];
    self.player = [MPMusicPlayerController iPodMusicPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onNowPlayingItemChanged:)
                                                 name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                               object:self.player];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*! @abstract 再生中の曲情報を取得する */
- (void)getMusicInformation:(MPMediaItem *)mediaItem
{
    self.titleText.text = [mediaItem valueForProperty:MPMediaItemPropertyTitle];
    self.albumTitleText.text = [mediaItem valueForProperty:MPMediaItemPropertyAlbumTitle];
    self.artistNameText.text = [mediaItem valueForProperty:MPMediaItemPropertyArtist];
    MPMediaItemArtwork *artwork = [mediaItem valueForProperty:MPMediaItemPropertyArtwork];
    self.artworkImageView.image = [artwork imageWithSize:self.artworkImageView.frame.size];
}

/*! @abstract 曲が変わった時の処理 */
- (void)onNowPlayingItemChanged:(NSNotification *)notification
{
    MPMediaItem *mediaItem = self.player.nowPlayingItem;
    NSInteger mediaType = [[mediaItem valueForProperty:MPMediaItemPropertyMediaType] integerValue];
    if (mediaType == MPMediaTypeMusic) {
        [self getMusicInformation:mediaItem];
    }
}

#pragma mark - IBActions
/*! @abstract 曲情報取得ボタン押下時処理 */
- (IBAction)onTapGetNowPlaying:(id)sender {
    [self onNowPlayingItemChanged:nil];
}
- (IBAction)onTapGetMusicInformationFromiTunes:(id)sender {
}
- (IBAction)onTapCommit:(id)sender {
    UIAlertView *alertView = [[UIAlertView new] initWithTitle:@"確認"
                                                      message:@"投稿します"
                                                     delegate:self
                                            cancelButtonTitle:@"いいえ"
                                            otherButtonTitles:@"はい", nil];
    [alertView show];
}

@end
