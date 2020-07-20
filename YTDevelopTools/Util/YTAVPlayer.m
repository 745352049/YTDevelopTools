//
//  YTAVPlayer.m
//  

#import "YTAVPlayer.h"

@interface YTAVPlayer ()

@property (nonatomic, strong) id timeObserver;

@end

@implementation YTAVPlayer

+ (instancetype)shareInstance {
    static YTAVPlayer *player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[YTAVPlayer alloc] init];
        player.interval = CMTimeMake(1.0, 100.0);
    });
    return player;
}

- (void)playNetAudioWithPath:(NSString *)path {
    [self removeTimeObserver];
    [self removePlayStatus];
    [self.audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    if ([path hasPrefix:@"http://"] || [path hasPrefix:@"https://"]) {
        url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
    __weak typeof(self) weakSelf = self;
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:self.interval queue:dispatch_queue_create("com.player.progress", DISPATCH_QUEUE_CONCURRENT) usingBlock:^(CMTime time) {
        // 当前播放的时间
        float current = CMTimeGetSeconds(time);
        // 总时间
        float total = CMTimeGetSeconds(playerItem.duration);
        if (weakSelf.playProgressBlock) {
            weakSelf.playProgressBlock(current, total, weakSelf.player);
        }
    }];
}

- (void)playLocalAudioWithPath:(NSString *)path {
    [self removeTimeObserver];
    [self removePlayStatus];
    [self.audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:path]];
    self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
    __weak typeof(self) weakSelf = self;
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:self.interval queue:dispatch_queue_create("com.player.progress", DISPATCH_QUEUE_CONCURRENT) usingBlock:^(CMTime time) {
        // 当前播放的时间
        float current = CMTimeGetSeconds(time);
        // 总时间
        float total = CMTimeGetSeconds(playerItem.duration);
        if (weakSelf.playProgressBlock) {
            weakSelf.playProgressBlock(current, total, weakSelf.player);
        }
    }];
}

- (void)playerDidPlayToEnd:(NSNotification *)notification {
    [self stopNoBlock];
    
    if (self.playerStateBlock) {
        self.playerStateBlock(self.player, PlayerStateType_Stop);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.player.status) {
            case AVPlayerItemStatusUnknown:
            {
                [self stopNoBlock];
                if (self.playerStateBlock) {
                    self.playerStateBlock(self.player, PlayerStateType_Unknown);
                }
            }
                break;
            case AVPlayerItemStatusReadyToPlay:
            {
                [self.player play];
                if (self.playerStateBlock) {
                    self.playerStateBlock(self.player, PlayerStateType_Start);
                }
            }
                break;
            case AVPlayerItemStatusFailed:
            {
                [self stopNoBlock];
                if (self.playerStateBlock) {
                    self.playerStateBlock(self.player, PlayerStateType_Failed);
                }
            }
                break;
            default:
                break;
        }
    }
}

- (void)pause {
    if (_player && _player.rate == 1.0) {
        [self.player pause];
        if (self.playerStateBlock) {
            self.playerStateBlock(self.player, PlayerStateType_Pause);
        }
    }
}

- (void)play {
    if (_player && _player.rate == 0.0) {
        [self.player play];
        if (self.playerStateBlock) {
            self.playerStateBlock(self.player, PlayerStateType_Start);
        }
    }
}

- (void)stop {
    if (_player) {
        [self removeTimeObserver];
        [self removePlayStatus];
        [self.player pause];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        if (self.playerStateBlock) {
            self.playerStateBlock(self.player, PlayerStateType_Stop);
        }
        self.player = nil;
    }
}

- (void)setInterval:(CMTime)interval {
    _interval = interval;
}

- (void)stopNoBlock {
    if (_player) {
        [self removeTimeObserver];
        [self removePlayStatus];
        [self.player pause];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        self.player = nil;
    }
}

- (void)removeTimeObserver {
    if (_timeObserver) {
        [self.player removeTimeObserver:self.timeObserver];
        self.timeObserver = nil;
    }
}

- (void)removePlayStatus {
    if (_player.currentItem != nil) {
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
}

- (AVAudioSession *)audioSession {
    if (!_audioSession) {
        _audioSession = [AVAudioSession sharedInstance];
        [_audioSession setActive:YES error:nil];
    }
    return _audioSession;
}

@end
