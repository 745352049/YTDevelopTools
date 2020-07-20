//
//  YTAVPlayer.h
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSUInteger, PlayerStateType) {
    PlayerStateType_Start = 0,
    PlayerStateType_Stop,
    PlayerStateType_Unknown,
    PlayerStateType_Failed,
    PlayerStateType_Pause
};

@interface YTAVPlayer : NSObject

/// 单例模式(避免同时播放多首歌)
+ (instancetype)shareInstance;
/// 音频播放器
@property (nonatomic, strong) AVPlayer *player;
/// 音频会话
@property (nonatomic, strong) AVAudioSession *audioSession;

@property (nonatomic, assign) CMTime interval;

/// [[YTAVPlayer shareInstance] playNetAudioWithPath:@"https://m3.8js.net/20200306/58_yelangDISCO.mp3"];
/// 播放网络音频
- (void)playNetAudioWithPath:(NSString *)path;

/// [[YTAVPlayer shareInstance] playLocalAudioWithPath:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"mp3"]];
/// 播放本地音频
- (void)playLocalAudioWithPath:(NSString *)path;

- (void)pause;

- (void)play;

- (void)stop;

- (void)stopNoBlock;

@property (nonatomic,   copy) void(^playProgressBlock)(float current, float total, AVPlayer *player);
@property (nonatomic,   copy) void(^playerStateBlock)(AVPlayer *player, PlayerStateType state);

@end
