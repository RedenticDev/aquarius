#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import <EventKit/EventKit.h>
#import <Cephei/HBPreferences.h>
#import <sys/utsname.h>

#import <objc/runtime.h>
#import <dlfcn.h>

#import "JBBulletinManager.h"

#import <AVKit/AVKit.h>

#import <MediaRemote/MediaRemote.h>
#import <AudioToolbox/AudioServices.h>


#import "SparkColourPickerUtils.h"
#import "MarqueeLabel.h"
#import <QuartzCore/QuartzCore.h>
#import <Kitten/libKitten.h>
#import <AVKit/AVKit.h>

@interface SBApplication : NSObject
@property (nonatomic,readonly) NSString * bundleIdentifier;                                                                                     //@synthesize bundleIdentifier=_bundleIdentifier - In the implementation block
@end


@interface UIView (Private)
-(UIViewController *)_viewControllerForAncestor;
-(void)setOverrideUserInterfaceStyle:(NSInteger)style;
@end

@interface MTMaterialView: UIView

@end




@interface CSAdjunctItemView : UIView{ //player iOS 13 & 14
	UIView* _platterView;

}

@end

@interface SBDashBoardMediaControlsViewController : UIViewController // iOS 12
@end

@interface CSMediaControlsViewController : UIViewController // iOS 13
@end
@interface CSNotificationAdjunctListViewController : UIViewController

@end
@class MPCPlayerResponseItem, MRUVisualStylingProvider, UIView, UILabel, CAGradientLayer, CADisplayLink, AVTimeFormatter, NSString;
@interface MRUNowPlayingTimeControlsView : UIView // iOS 14

@property (nonatomic,retain) UILabel * elapsedTimeLabel;
@property (nonatomic,retain) UILabel * remainingTimeLabel;
@property (nonatomic,retain) UIView * elapsedTrack;
@property (nonatomic,retain) UIView * knobView;
@property (nonatomic,retain) UIView * remainingTrack;
@property (nonatomic,retain) AVTimeFormatter * elapsedTimeFormatter; 
@end



@interface MPVolumeSlider : UISlider
@property (nonatomic,readonly) UIView * thumbView;
@end

@interface MediaControlsVolumeSlider : MPVolumeSlider // iOS 12 & 13
-(void)setVisualStylingProvider:(id)arg1;
@end

@interface MRUNowPlayingVolumeSlider : MPVolumeSlider // iOS 14
-(void)setVisualStylingProvider:(id)arg1;
@property (nonatomic,readonly) UIView * growingThumbView;
@end

@interface MediaControlsVolumeContainerView : UIView // iOS 12 & 13
@property (nonatomic,retain) MediaControlsVolumeSlider * volumeSlider;
@end

@interface MRUNowPlayingVolumeControlsView : UIView // iOS 14
@property (nonatomic,retain) MRUNowPlayingVolumeSlider * slider;
@end

@interface MediaControlsTransportButton : UIButton // iOS 12 & 13
@property (nonatomic,retain) UIImageView *imageView;
@end

@interface MRUTransportButton : UIButton // iOS 14
@property (nonatomic,retain) UIImageView *imageView;
-(void)setStylingProvider:(id)arg1;
@end

@interface MediaControlsTransportStackView : UIView // iOS 12 & 13
@property (nonatomic,retain) MediaControlsTransportButton * tvRemoteButton;
@property (nonatomic,retain) MediaControlsTransportButton * leftButton;
@property (nonatomic,retain) MediaControlsTransportButton * middleButton;
@property (nonatomic,retain) MediaControlsTransportButton * rightButton;
@property (nonatomic,retain) MediaControlsTransportButton * languageOptionsButton;
@end

@interface MRUNowPlayingTransportControlsView : UIView // iOS 14
@property (nonatomic,retain) MRUTransportButton * tvRemoteButton;
@property (nonatomic,retain) MRUTransportButton * leftButton;
@property (nonatomic,retain) MRUTransportButton * middleButton;
@property (nonatomic,retain) MRUTransportButton * rightButton;
@property (nonatomic,retain) MRUTransportButton * languageOptionsButton;
@end

@interface MediaControlsParentContainerView : UIView
@end

@interface CCUICAPackageView : UIView
@property (assign,nonatomic) double scale; //only avaialble on iOS 13
@end

@interface MediaControlsRoutingButtonView : UIButton // iOS 12 & 13
@property (nonatomic,retain) CCUICAPackageView * packageView;
@end

@interface MRUNowPlayingRoutingButton : UIButton // iOS 14
@property (nonatomic,retain) CCUICAPackageView * packageView;
@end

@interface MPRouteLabel : UILabel
@property (nonatomic,retain) UILabel * titleLabel;
@property (assign,nonatomic) BOOL forcesUppercaseText;
@end

@interface MPUMarqueeView : UIView
@end

@interface MRUNowPlayingLabelView : UIView
@property (nonatomic,retain) UILabel * titleLabel;
@property (nonatomic,retain) UILabel * subtitleLabel;
@property (nonatomic,retain) MPUMarqueeView * titleMarqueeView;
@property (nonatomic,retain) MPUMarqueeView * subtitleMarqueeView;
@property (nonatomic,retain) MPRouteLabel * routeLabel;
@end

@interface MRUArtworkView : UIView
@property (nonatomic, retain) UIImage *iconImage;
@property (nonatomic, retain) UIImage *plceholderImage;
@property (nonatomic, retain) UIImage *artworkImage;
@property (nonatomic, retain) UIImageView *iconView;
@property (nonatomic, retain) UIView *iconShadowView;
@property (nonatomic, retain) UIImageView *artworkImageView;
@property (nonatomic, retain) UIView *artworkShadowView;
@property (nonatomic, retain) UIImageView *placeholderImageView;
@property (nonatomic, retain) UIView *placeholderBackground;
@end

@interface MRUNowPlayingHeaderView : UIView
@property (nonatomic,retain) MRUArtworkView * artworkView;
@property (nonatomic,retain) MRUNowPlayingLabelView * labelView;
@property (nonatomic,retain) MRUNowPlayingRoutingButton * routingButton;
@property (nonatomic,retain) MRUTransportButton * transportButton;
@end

@interface MRUNowPlayingControlsView : UIView
@property (nonatomic, retain) MRUNowPlayingHeaderView *headerView;
@property (nonatomic, retain) MRUNowPlayingTimeControlsView *timeControlsView;
@property (nonatomic, retain) MRUNowPlayingTransportControlsView *transportControlsView;
@property (nonatomic, retain) MRUNowPlayingVolumeControlsView *volumeControlsView;
@end

@interface MRUNowPlayingView : UIView
@property (nonatomic, retain) MRUNowPlayingControlsView *controlsView;
@end

@interface MRUNowPlayingViewController : UIViewController
@property (assign,nonatomic) id delegate;
@property (nonatomic,readonly) int context;
@property (nonatomic, retain) MRUNowPlayingView *viewIfLoaded;
@end

@interface SBMediaController : NSObject
+ (id)sharedInstance;
-(BOOL)beginSeek:(int)arg1 eventSource:(long long)arg2;
- (void)setNowPlayingInfo:(id)arg1;
-(void)sendNotif;
@property (nonatomic, weak,readonly) SBApplication * nowPlayingApplication;
-(BOOL)changeTrack:(int)arg1 eventSource:(long long)arg2 ;
@end



MarqueeLabel* songTitleLabel;
MarqueeLabel* artistNameLabel;
UIButton* songImageForSmall;
UIButton* songBackground;
UIImage *currentArtwork;
UIImage *currentArtwork2;
UIImage *currentArtwork3;
NSData* lastArtworkData;
NSData* lastArtworkData2;
UIView *coloredBackground;
UIView *test;
UIColor *customColor;
NSString *songLabel;
NSString *subtitleLabel;


@interface PLPlatterView : UIView
@property (nonatomic,retain) MTMaterialView * backgroundView;
@end





@interface CSCoverSheetViewController : UIViewController
@end



@interface NextUpViewController : UIViewController
- (id)initWithControlCenter:(BOOL)controlCenter defaultStyle:(long long)style;
@end
