//
//  YTAVPlayer.h
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

#define kYTAVPlayer [YTAVPlayer shareInstance]

static NSString *YTAVPlayerStateNotification = @"YTAVPlayerStateNotification";
static NSString *YTAVPlayerState = @"YTAVPlayerState";
static NSString *YTAVPlayerPath = @"YTAVPlayerPath";

typedef NS_ENUM(NSUInteger, YTPlayerStateType) {
    YTPlayerStateType_Start = 0,
    YTPlayerStateType_Pause,
    YTPlayerStateType_End,
    YTPlayerStateType_Unknown,
    YTPlayerStateType_Failed
};

@interface YTAVPlayer : NSObject

/// 单例模式（避免同时播放多首歌）
+ (instancetype)shareInstance;
/// 音频播放器
@property (nonatomic, strong, readonly) AVPlayer *player;
/// 资源对象
@property (nonatomic, strong) AVPlayerItem *playerItem;
/// 是否在播放
@property (nonatomic, assign, readonly) BOOL isPlaying;
/// 时间的结构体
@property (nonatomic, assign) CMTime timeObserverInterval;
/// [kYTAVPlayer setPlayMusicPath:@"https://m3.8js.net/20200306/58_yelangDISCO.mp3"]
/// [kYTAVPlayer setPlayMusicPath:[[NSBundle mainBundle] pathForResource:@"111" ofType:@"mp3"]];
/// 设置音乐地址 播放前要设置 AVAudioSession
@property (nonatomic, strong) NSString *playMusicPath;
/// 暂停
- (void)pause;
/// 暂停后的播放
- (void)play;
/// 播放进度的闭包
@property (nonatomic,   copy) void(^playProgressBlock)(AVPlayer *player, AVPlayerItem *playerItem, float current, float total);
/// 播放状态的闭包
@property (nonatomic,   copy) void(^playerStateBlock)(AVPlayer *player, AVPlayerItem *playerItem, YTPlayerStateType state);
/// 播放缓存的闭包
@property (nonatomic,   copy) void(^playerBufferBlock)(AVPlayer *player, AVPlayerItem *playerItem, NSTimeInterval duration, NSTimeInterval totalBuffer);

@end
