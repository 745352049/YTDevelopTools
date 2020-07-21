//
//  YTAVPlayer.m
//  

#import "YTAVPlayer.h"

@interface YTAVPlayer ()

@property (nonatomic, strong) id timeObserver;
@property (nonatomic, strong, readwrite) AVPlayer *player;

@end

@implementation YTAVPlayer

+ (instancetype)shareInstance {
    static YTAVPlayer *player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[YTAVPlayer alloc] init];
        player.timeObserverInterval = CMTimeMake(1.0, 100.0);
    });
    return player;
}

+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
}

- (void)pause {
    if (self.isPlaying == YES) {
        [self.player pause];
        [self playerState:YTPlayerStateType_Pause];
    }
}

- (void)play {
    if (self.isPlaying == NO) {
        [self.player play];
        [self playerState:YTPlayerStateType_Start];
    }
}

- (void)playerState:(YTPlayerStateType)state {
    [[NSNotificationCenter defaultCenter] postNotificationName:YTAVPlayerStateNotification object:nil userInfo:@{YTAVPlayerState : [NSString stringWithFormat:@"%lu", (unsigned long)state], YTAVPlayerPath : self.playMusicPath}];
    if (self.playerStateBlock) {
        self.playerStateBlock(self.player, self.playerItem, state);
    }
    if (state == YTPlayerStateType_Start) {
        _isPlaying = YES;
    } else {
        _isPlaying = NO;
    }
}

- (void)playerDidPlayEnd:(NSNotification *)notification {
    [self playerState:YTPlayerStateType_End];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.player.status) {
            case AVPlayerItemStatusUnknown:
            {
                [self playerState:YTPlayerStateType_Unknown];
            }
                break;
            case AVPlayerItemStatusReadyToPlay:
            {
                [self.player play];
                [self playerState:YTPlayerStateType_Start];
            }
                break;
            case AVPlayerItemStatusFailed:
            {
                [self playerState:YTPlayerStateType_Failed];
            }
                break;
            default:
                break;
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSArray *array = self.player.currentItem.loadedTimeRanges;
        /// 本次缓冲的时间范围
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        /// 缓冲总长度
        NSTimeInterval totalBuffer = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration);
        /// 音乐的总时间
        NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
        if (self.playerBufferBlock) {
            self.playerBufferBlock(self.player, self.playerItem, duration, totalBuffer);
        }
    }
}

- (void)removePlayerItemObserver {
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

- (void)addPlayerItemObserver {
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidPlayEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
}

- (void)setPlayMusicPath:(NSString *)playMusicPath {
    _playMusicPath = playMusicPath;
    
    if ([playMusicPath hasPrefix:@"http://"] || [playMusicPath hasPrefix:@"https://"]) {
        self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:[playMusicPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    } else {
        self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:playMusicPath]];
    }
    if (self.player.currentItem != self.playerItem) {
        [self removePlayerItemObserver];
        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
        [self addPlayerItemObserver];
    }
}

- (void)setTimeObserverInterval:(CMTime)timeObserverInterval {
    _timeObserverInterval = timeObserverInterval;
}

- (AVPlayer *)player {
    if (!_player) {
        _player = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
        [_player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [_player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidPlayEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
        __weak typeof(self) weakSelf = self;
        self.timeObserver = [self.player addPeriodicTimeObserverForInterval:self.timeObserverInterval queue:dispatch_queue_create("com.player.progress", DISPATCH_QUEUE_CONCURRENT) usingBlock:^(CMTime time) {
            // 当前播放的时间
            float current = CMTimeGetSeconds(time);
            // 总时间
            float total = CMTimeGetSeconds(weakSelf.playerItem.duration);
            if (weakSelf.playProgressBlock) {
                weakSelf.playProgressBlock(weakSelf.player, weakSelf.playerItem, current, total);
            }
        }];
    }
    return _player;
}

- (AVPlayerItem *)playerItem {
    if (!_playerItem) {
        _playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@""]];
    }
    return _playerItem;
}

@end
