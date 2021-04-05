#line 1 "Tweak.xm"
#import "headers.h"
#import "Kitten/libKitten.h"
#import <Cephei/HBPreferences.h>

BOOL enabled = true;


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class CSAdjunctItemView; @class MRUNowPlayingHeaderView; @class MRUNowPlayingControlsView; @class MRUNowPlayingLabelView; @class MRUNowPlayingTransportControlsView; @class SBMediaController; 


#line 7 "Tweak.xm"
BOOL colorsEnabled, isRoutingButtonHidden, isBackgroundColored, isDarkImage, isArtworkBackground, haveNotifs, haveOutline;
id preferences;
int configurations;
NSString * previousTitle;
float musicPlayerAlpha, outlineSize;
NSDictionary* preferencesDictionary = [NSDictionary dictionaryWithContentsOfFile: @"/var/mobile/Library/Preferences/com.nico671.aquariusprefs.plist"];
static void (*_logos_orig$tweaky$MRUNowPlayingHeaderView$setShowRoutingButton$)(_LOGOS_SELF_TYPE_NORMAL MRUNowPlayingHeaderView* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$tweaky$MRUNowPlayingHeaderView$setShowRoutingButton$(_LOGOS_SELF_TYPE_NORMAL MRUNowPlayingHeaderView* _LOGOS_SELF_CONST, SEL, BOOL); static void (*_logos_orig$tweaky$MRUNowPlayingControlsView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL MRUNowPlayingControlsView* _LOGOS_SELF_CONST, SEL); static void _logos_method$tweaky$MRUNowPlayingControlsView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MRUNowPlayingControlsView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$tweaky$MRUNowPlayingLabelView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL MRUNowPlayingLabelView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$tweaky$MRUNowPlayingLabelView$setFrame$(_LOGOS_SELF_TYPE_NORMAL MRUNowPlayingLabelView* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$tweaky$MRUNowPlayingTransportControlsView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL MRUNowPlayingTransportControlsView* _LOGOS_SELF_CONST, SEL); static void _logos_method$tweaky$MRUNowPlayingTransportControlsView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MRUNowPlayingTransportControlsView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$tweaky$CSAdjunctItemView$_updateSizeToMimic)(_LOGOS_SELF_TYPE_NORMAL CSAdjunctItemView* _LOGOS_SELF_CONST, SEL); static void _logos_method$tweaky$CSAdjunctItemView$_updateSizeToMimic(_LOGOS_SELF_TYPE_NORMAL CSAdjunctItemView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$tweaky$SBMediaController$setNowPlayingInfo$)(_LOGOS_SELF_TYPE_NORMAL SBMediaController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$tweaky$SBMediaController$setNowPlayingInfo$(_LOGOS_SELF_TYPE_NORMAL SBMediaController* _LOGOS_SELF_CONST, SEL, id); 

 
  static void _logos_method$tweaky$MRUNowPlayingHeaderView$setShowRoutingButton$(_LOGOS_SELF_TYPE_NORMAL MRUNowPlayingHeaderView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL arg1){
      MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
    if(![controller respondsToSelector:@selector(context)]){
		_logos_orig$tweaky$MRUNowPlayingHeaderView$setShowRoutingButton$(self, _cmd, arg1);
	}

    else if(controller.context == 2){
      if (isRoutingButtonHidden)
      _logos_orig$tweaky$MRUNowPlayingHeaderView$setShowRoutingButton$(self, _cmd, NO);
      else{
        _logos_orig$tweaky$MRUNowPlayingHeaderView$setShowRoutingButton$(self, _cmd, arg1);
        [self setFrame: CGRectMake(self.frame.origin.x,self.frame.origin.y-20,self.frame.size.width,self.frame.size.height)];
      }
      }
  }







 
static void _logos_method$tweaky$MRUNowPlayingControlsView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MRUNowPlayingControlsView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
  _logos_orig$tweaky$MRUNowPlayingControlsView$layoutSubviews(self, _cmd);
  MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor]; 
if (isArtworkBackground){
[self.headerView.artworkView setHidden:YES];
}
if(controller.context == 2 && configurations == 0){

[self.transportControlsView setFrame: CGRectMake(CGRectGetMidX(self.headerView.artworkView.frame)+5,CGRectGetMidY(self.headerView.frame),self.transportControlsView.frame.size.width,self.transportControlsView.frame.size.height)];
if (!artistNameLabel){
artistNameLabel = [MarqueeLabel new];
        [artistNameLabel setFont:[UIFont systemFontOfSize:15]];
        [artistNameLabel setTextAlignment:NSTextAlignmentLeft];
        [artistNameLabel setAlpha:1];
        [self addSubview:artistNameLabel];
{
          UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customTitleLabelColor"] withFallback:@"#000000"];
          [songTitleLabel setTextColor: customColor];
        }
        [artistNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [artistNameLabel.widthAnchor constraintEqualToConstant:230].active = YES;
        [artistNameLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
        [artistNameLabel.leftAnchor constraintEqualToAnchor:self.headerView.artworkView.rightAnchor].active = YES;
        [artistNameLabel.bottomAnchor constraintEqualToAnchor:self.transportControlsView.topAnchor constant:3].active = YES;
}
if (!songTitleLabel){
songTitleLabel = [MarqueeLabel new];
        [songTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [songTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [songTitleLabel setAlpha:1];
        [self addSubview:songTitleLabel];
{
          UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customSubtitleLabelColor"] withFallback:@"#000000"];
          [songTitleLabel setTextColor: customColor];
        }
        [songTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [songTitleLabel.widthAnchor constraintEqualToConstant:230].active = YES;
        [songTitleLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
        [songTitleLabel.leftAnchor constraintEqualToAnchor:self.headerView.artworkView.rightAnchor].active = YES;
        [songTitleLabel.bottomAnchor constraintEqualToAnchor:self.transportControlsView.topAnchor constant: -30].active = YES;
}



}

else if (configurations == 1 && controller.context == 2){

 
[self.transportControlsView setFrame: CGRectMake(CGRectGetMidX(self.headerView.artworkView.frame)+5,CGRectGetMidY(self.headerView.frame),self.transportControlsView.frame.size.width,self.transportControlsView.frame.size.height)];
[self.timeControlsView setFrame: CGRectMake(CGRectGetMinX(self.frame)-13,CGRectGetMinY(self.frame)+80,self.timeControlsView.frame.size.width,self.timeControlsView.frame.size.height)];
if (!artistNameLabel){
artistNameLabel = [MarqueeLabel new];
        [artistNameLabel setFont:[UIFont systemFontOfSize:15]];
        [artistNameLabel setTextAlignment:NSTextAlignmentLeft];
        [artistNameLabel setAlpha:1];
        [self addSubview:artistNameLabel];
{
          UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customTitleLabelColor"] withFallback:@"#000000"];
          [songTitleLabel setTextColor: customColor];
        }
        [artistNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [artistNameLabel.widthAnchor constraintEqualToConstant:230].active = YES;
        [artistNameLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
        [artistNameLabel.leftAnchor constraintEqualToAnchor:self.headerView.artworkView.rightAnchor].active = YES;
        [artistNameLabel.bottomAnchor constraintEqualToAnchor:self.transportControlsView.topAnchor constant:3].active = YES;
}

if (!songTitleLabel){
songTitleLabel = [MarqueeLabel new];
        [songTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [songTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [songTitleLabel setAlpha:1];
        [self addSubview:songTitleLabel];
{
          UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customSubtitleLabelColor"] withFallback:@"#000000"];
          [songTitleLabel setTextColor: customColor];
        }
        [songTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [songTitleLabel.widthAnchor constraintEqualToConstant:230].active = YES;
        [songTitleLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
        [songTitleLabel.leftAnchor constraintEqualToAnchor:self.headerView.artworkView.rightAnchor ].active = YES;
        [songTitleLabel.bottomAnchor constraintEqualToAnchor:self.transportControlsView.topAnchor constant:-30].active = YES;
}

}

else if (configurations == 2 && controller.context == 2){

  [self.transportControlsView setFrame: CGRectMake(CGRectGetMidX(self.headerView.artworkView.frame)+5,CGRectGetMidY(self.headerView.frame),self.transportControlsView.frame.size.width,self.transportControlsView.frame.size.height)];
[self.volumeControlsView setFrame: CGRectMake(CGRectGetMinX(self.headerView.artworkView.frame)-13,CGRectGetMinY(self.frame)+85,self.timeControlsView.frame.size.width,self.timeControlsView.frame.size.height)];
[self.timeControlsView setHidden:YES];
if (!artistNameLabel){
artistNameLabel = [MarqueeLabel new];
        [artistNameLabel setFont:[UIFont systemFontOfSize:15]];
        [artistNameLabel setTextAlignment:NSTextAlignmentLeft];
        [artistNameLabel setAlpha:1];
        [self addSubview:artistNameLabel];
{
          UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customTitleLabelColor"] withFallback:@"#000000"];
          [songTitleLabel setTextColor: customColor];
        }
        [artistNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [artistNameLabel.widthAnchor constraintEqualToConstant:230].active = YES;
        [artistNameLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
        [artistNameLabel.leftAnchor constraintEqualToAnchor:self.headerView.artworkView.rightAnchor].active = YES;
        [artistNameLabel.bottomAnchor constraintEqualToAnchor:self.transportControlsView.topAnchor constant:3].active = YES;
}
if (!songTitleLabel){
songTitleLabel = [MarqueeLabel new];
        [songTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [songTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [songTitleLabel setAlpha:1];
        [self addSubview:songTitleLabel];
        {
          UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customSubtitleLabelColor"] withFallback:@"#000000"];
          [songTitleLabel setTextColor: customColor];
        }
        [songTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [songTitleLabel.widthAnchor constraintEqualToConstant:230].active = YES;
        [songTitleLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
        [songTitleLabel.leftAnchor constraintEqualToAnchor:self.headerView.artworkView.rightAnchor ].active = YES;
        [songTitleLabel.bottomAnchor constraintEqualToAnchor:self.transportControlsView.topAnchor constant: -30].active = YES;
}
}

else if (configurations == 3 && controller.context == 2){
  [self.headerView.artworkView setHidden:YES];
  [self.transportControlsView setFrame: CGRectMake(CGRectGetMidX(self.headerView.artworkView.frame)+5,CGRectGetMinY(self.headerView.frame)+30,self.transportControlsView.frame.size.width,self.transportControlsView.frame.size.height)];
[self.volumeControlsView setHidden:YES];
[self.timeControlsView setHidden:YES];
if (!songImageForSmall){
           songImageForSmall = [UIButton new];
          
          [songImageForSmall setContentMode:UIViewContentModeScaleAspectFill];
          [songImageForSmall setClipsToBounds:YES];
          [songImageForSmall setAdjustsImageWhenHighlighted:NO];
          [songImageForSmall setAlpha:1];
          [songImageForSmall.layer setCornerRadius:8];
          [self addSubview:songImageForSmall];
          [songImageForSmall setTranslatesAutoresizingMaskIntoConstraints:YES];
          [songImageForSmall setFrame: CGRectMake(CGRectGetMinX(self.frame)-20,CGRectGetMinY(self.frame)-25,85,85)];
}
if (!artistNameLabel){
artistNameLabel = [MarqueeLabel new];
        [artistNameLabel setFont:[UIFont systemFontOfSize:15]];
        [artistNameLabel setTextAlignment:NSTextAlignmentLeft];
        [artistNameLabel setAlpha:1];
        [self addSubview:artistNameLabel];
{
          UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customTitleLabelColor"] withFallback:@"#000000"];
          [songTitleLabel setTextColor: customColor];
        }
        [artistNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [artistNameLabel.widthAnchor constraintEqualToConstant:230].active = YES;
        [artistNameLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
        [artistNameLabel.leftAnchor constraintEqualToAnchor:self.headerView.artworkView.rightAnchor].active = YES;
        [artistNameLabel.bottomAnchor constraintEqualToAnchor:self.transportControlsView.topAnchor constant:3].active = YES;
}

if (!songTitleLabel){
songTitleLabel = [MarqueeLabel new];
        [songTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [songTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [songTitleLabel setAlpha:1];
        [self addSubview:songTitleLabel];
        if (colorsEnabled)
        {
          UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customSubtitleLabelColor"] withFallback:@"#000000"];
          [songTitleLabel setTextColor: customColor];
        }
        [songTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [songTitleLabel.widthAnchor constraintEqualToConstant:230].active = YES;
        [songTitleLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
        [songTitleLabel.leftAnchor constraintEqualToAnchor:self.headerView.artworkView.rightAnchor].active = YES;
        [songTitleLabel.bottomAnchor constraintEqualToAnchor:self.transportControlsView.topAnchor constant:-20].active = YES;
}

}


else
{
  _logos_orig$tweaky$MRUNowPlayingControlsView$layoutSubviews(self, _cmd);
}


}


  
static void _logos_method$tweaky$MRUNowPlayingLabelView$setFrame$(_LOGOS_SELF_TYPE_NORMAL MRUNowPlayingLabelView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){

  MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
if(![controller respondsToSelector:@selector(context)]){
_logos_orig$tweaky$MRUNowPlayingLabelView$setFrame$(self, _cmd, arg1);
}
  else if (controller.context == 2)
  [self setHidden:YES];
else{
  _logos_orig$tweaky$MRUNowPlayingLabelView$setFrame$(self, _cmd, arg1);
}
}



 

static void _logos_method$tweaky$MRUNowPlayingTransportControlsView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MRUNowPlayingTransportControlsView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){ 
  _logos_orig$tweaky$MRUNowPlayingTransportControlsView$layoutSubviews(self, _cmd);
  MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
if (enabled && controller.context == 2){
  if (colorsEnabled){
customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customLeftButtonColor"] withFallback:@"#000000"];
}
[self.leftButton setStylingProvider:nil];
self.leftButton.imageView.layer.filters = nil;
[self.leftButton.imageView setTintColor: customColor];
}

if (enabled && colorsEnabled && controller.context == 2){
customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customMiddleButtonColor"] withFallback:@"#000000"];
[self.middleButton setStylingProvider:nil];
self.middleButton.imageView.layer.filters = nil;
[self.middleButton.imageView setTintColor: customColor];
}

if (enabled && colorsEnabled && controller.context == 2){
customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customRightButtonColor"] withFallback:@"#000000"];
[self.rightButton setStylingProvider:nil];
self.rightButton.imageView.layer.filters = nil;
[self.rightButton.imageView setTintColor: customColor];
}
_logos_orig$tweaky$MRUNowPlayingTransportControlsView$layoutSubviews(self, _cmd);

}



 



static void _logos_method$tweaky$CSAdjunctItemView$_updateSizeToMimic(_LOGOS_SELF_TYPE_NORMAL CSAdjunctItemView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd)  {
PLPlatterView *platterView = (PLPlatterView*)MSHookIvar<UIView*>(self, "_platterView");
[platterView.backgroundView setAlpha: musicPlayerAlpha];

if(configurations == 0){
_logos_orig$tweaky$CSAdjunctItemView$_updateSizeToMimic(self, _cmd);
 if (haveOutline){
  self.layer.borderWidth = outlineSize;
        
          UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"outlineColor"] withFallback:@"#000000"];
        self.layer.borderColor = [customColor CGColor];
        
  
  self.layer.cornerRadius = 10;
  }
[self.heightAnchor constraintEqualToConstant:130].active = true; 
if (isArtworkBackground){
songBackground = [UIButton new];
[songBackground setContentMode:UIViewContentModeScaleAspectFill];
[songBackground setClipsToBounds:YES];
[songBackground setAdjustsImageWhenHighlighted:NO];
[songBackground setAlpha:1];
[songBackground.layer setCornerRadius:8];
 [platterView.backgroundView setAlpha: 0];
[self addSubview:songBackground];
[self sendSubviewToBack: songBackground];
[songBackground setTranslatesAutoresizingMaskIntoConstraints:YES];
[songBackground setFrame: CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height)];
}

if (isBackgroundColored){
 [platterView.backgroundView setAlpha: 0];
  coloredBackground = [UIView new];
  [coloredBackground setFrame: CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height)];
  [coloredBackground.layer setCornerRadius:10];
  [self addSubview: coloredBackground];
  [self sendSubviewToBack:coloredBackground];
}



}
else if(configurations == 1 || configurations == 2){
  _logos_orig$tweaky$CSAdjunctItemView$_updateSizeToMimic(self, _cmd);
   if (haveOutline){
  self.layer.borderWidth = outlineSize;
    
          UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"outlineColor"] withFallback:@"#000000"];
        
        
  self.layer.borderColor = [ customColor CGColor];
  self.layer.cornerRadius = 10;
  }
[self.heightAnchor constraintEqualToConstant:170].active = true;
if (isArtworkBackground){
songBackground = [UIButton new];
 [platterView.backgroundView setAlpha: 0];
[songBackground setContentMode:UIViewContentModeScaleAspectFill];
[songBackground setClipsToBounds:YES];
[songBackground setAdjustsImageWhenHighlighted:NO];
[songBackground setAlpha:1];
[songBackground.layer setCornerRadius:8];
[self addSubview:songBackground];
[self sendSubviewToBack: songBackground];

[songBackground setTranslatesAutoresizingMaskIntoConstraints:YES];
[songBackground setFrame: CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height)];
}

if (isBackgroundColored){
 [platterView.backgroundView setAlpha: 0];
  coloredBackground = [UIView new];
  [coloredBackground setFrame: CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height)];
  [coloredBackground.layer setCornerRadius:10];
  [self addSubview: coloredBackground];
  [self sendSubviewToBack:coloredBackground];
}


}
else if(configurations == 3){
  _logos_orig$tweaky$CSAdjunctItemView$_updateSizeToMimic(self, _cmd);
  if (haveOutline){
  self.layer.borderWidth = outlineSize;
    
          UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"outlineColor"] withFallback:@"#000000"];
        
        
  self.layer.borderColor = [customColor CGColor];
  self.layer.cornerRadius = 10;
  }
  [self.heightAnchor constraintEqualToConstant:100].active = true;
if (isArtworkBackground){
   [platterView.backgroundView setAlpha: 0];
   	[platterView.backgroundView.layer setCornerRadius:2];
songBackground = [UIButton new];
[songBackground setContentMode:UIViewContentModeScaleAspectFill];
[songBackground setClipsToBounds:YES];
[songBackground setAdjustsImageWhenHighlighted:NO];
[songBackground setAlpha:1];
[songBackground.layer setCornerRadius:8];
[self addSubview:songBackground];
[self sendSubviewToBack: songBackground];
[songBackground setTranslatesAutoresizingMaskIntoConstraints:YES];

[songBackground setFrame: CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height)];
}

if (isBackgroundColored){
 [platterView.backgroundView setAlpha: 0];
  coloredBackground = [UIView new];
  [coloredBackground setFrame: CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height)];
  [coloredBackground.layer setCornerRadius:10];
  [self addSubview: coloredBackground];
  [self sendSubviewToBack:coloredBackground];
}

}


}






static void _logos_method$tweaky$SBMediaController$setNowPlayingInfo$(_LOGOS_SELF_TYPE_NORMAL SBMediaController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) { 
    _logos_orig$tweaky$SBMediaController$setNowPlayingInfo$(self, _cmd, arg1);
    MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {
        if (information) {

            NSDictionary* dict = (__bridge NSDictionary *)information;
       
    currentArtwork = [UIImage imageWithData:[dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData]]; 
            if (dict) {
                 [songTitleLabel setText:[NSString stringWithFormat:@"%@ ", [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoTitle]]]; 
                    lastArtworkData = [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData];
                   
       
          
         
          
        
                 [artistNameLabel setText:[NSString stringWithFormat:@"%@ - %@ ", [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtist], [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoAlbum]]]; 
                 currentArtwork = [UIImage imageWithData:[dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData]]; 
                
                  subtitleLabel = [NSString stringWithFormat:@"%@ - %@ ", [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtist], [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoAlbum]];
                 songLabel = [NSString stringWithFormat:@"%@ ", [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoTitle]];
              
       
                      [songBackground setImage:currentArtwork forState:UIControlStateNormal];
[songImageForSmall setImage:currentArtwork forState:UIControlStateNormal];
                    [coloredBackground setBackgroundColor:[libKitten primaryColor:currentArtwork]];
                    }

  
    
            
lastArtworkData2 = [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData];

                }
                 
           
  	});
    
if (haveNotifs){
  if (songLabel && subtitleLabel) {
			if(![songLabel isEqualToString:previousTitle] && currentArtwork)
[[objc_getClass("JBBulletinManager") sharedInstance] showBulletinWithTitle:subtitleLabel message:songLabel overrideBundleImage:currentArtwork];
        previousTitle = songLabel;
      }
}
NSLog(@"[aquarius] is enabled? %i", enabled);
  }          









void loadPrefs(){
  HBPreferences *file = [[HBPreferences alloc] initWithIdentifier:@"aquariusprefs"];
enabled = [([file objectForKey:@"isEnabled"] ?: @(YES)) boolValue];
isRoutingButtonHidden = [([file objectForKey:@"isRoutingHidden"] ?: @(YES)) boolValue];
    configurations = [([file objectForKey:@"configuration"] ?: @(3)) intValue];
        musicPlayerAlpha = [([file objectForKey:@"musicPlayerAlpha"] ?: @(1)) floatValue];
   colorsEnabled = [([file objectForKey:@"isColorsEnabled"] ?: @(YES)) boolValue];
       haveNotifs = [([file objectForKey:@"notifications?"] ?: @(YES)) boolValue];
   isRoutingButtonHidden = [([file objectForKey:@"isRoutingButtonHidden"] ?: @(YES)) boolValue];
   isBackgroundColored = [([file objectForKey:@"isBackgroundColorEnabled"] ?: @(YES)) boolValue];
  isArtworkBackground = [([file objectForKey:@"isArtworkBackground"] ?: @(NO)) boolValue];
 haveOutline = [([file objectForKey:@"haveOutline?"] ?: @(YES)) boolValue];
 outlineSize = [([file objectForKey:@"sizeOfOutline?"] ?: @(5)) floatValue];

if (enabled) {
        {Class _logos_class$tweaky$MRUNowPlayingHeaderView = objc_getClass("MRUNowPlayingHeaderView"); { MSHookMessageEx(_logos_class$tweaky$MRUNowPlayingHeaderView, @selector(setShowRoutingButton:), (IMP)&_logos_method$tweaky$MRUNowPlayingHeaderView$setShowRoutingButton$, (IMP*)&_logos_orig$tweaky$MRUNowPlayingHeaderView$setShowRoutingButton$);}Class _logos_class$tweaky$MRUNowPlayingControlsView = objc_getClass("MRUNowPlayingControlsView"); { MSHookMessageEx(_logos_class$tweaky$MRUNowPlayingControlsView, @selector(layoutSubviews), (IMP)&_logos_method$tweaky$MRUNowPlayingControlsView$layoutSubviews, (IMP*)&_logos_orig$tweaky$MRUNowPlayingControlsView$layoutSubviews);}Class _logos_class$tweaky$MRUNowPlayingLabelView = objc_getClass("MRUNowPlayingLabelView"); { MSHookMessageEx(_logos_class$tweaky$MRUNowPlayingLabelView, @selector(setFrame:), (IMP)&_logos_method$tweaky$MRUNowPlayingLabelView$setFrame$, (IMP*)&_logos_orig$tweaky$MRUNowPlayingLabelView$setFrame$);}Class _logos_class$tweaky$MRUNowPlayingTransportControlsView = objc_getClass("MRUNowPlayingTransportControlsView"); { MSHookMessageEx(_logos_class$tweaky$MRUNowPlayingTransportControlsView, @selector(layoutSubviews), (IMP)&_logos_method$tweaky$MRUNowPlayingTransportControlsView$layoutSubviews, (IMP*)&_logos_orig$tweaky$MRUNowPlayingTransportControlsView$layoutSubviews);}Class _logos_class$tweaky$CSAdjunctItemView = objc_getClass("CSAdjunctItemView"); { MSHookMessageEx(_logos_class$tweaky$CSAdjunctItemView, @selector(_updateSizeToMimic), (IMP)&_logos_method$tweaky$CSAdjunctItemView$_updateSizeToMimic, (IMP*)&_logos_orig$tweaky$CSAdjunctItemView$_updateSizeToMimic);}Class _logos_class$tweaky$SBMediaController = objc_getClass("SBMediaController"); { MSHookMessageEx(_logos_class$tweaky$SBMediaController, @selector(setNowPlayingInfo:), (IMP)&_logos_method$tweaky$SBMediaController$setNowPlayingInfo$, (IMP*)&_logos_orig$tweaky$SBMediaController$setNowPlayingInfo$);}}
	}
}

static __attribute__((constructor)) void _logosLocalCtor_62a0097d(int __unused argc, char __unused **argv, char __unused **envp) {
NSLog(@"[aquarius] is enabled? %i", enabled);
loadPrefs();
CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.nico671.preferenceschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
