#import "headers.h"
#import "Kitten/libKitten.h"
#import <Cephei/HBPreferences.h>

BOOL enabled = true;

BOOL colorsEnabled, isRoutingButtonHidden, isBackgroundColored, isDarkImage, isArtworkBackground, haveNotifs, haveOutline;
id preferences;
int configurations;
NSString * previousTitle;
float musicPlayerAlpha, outlineSize;
NSDictionary* preferencesDictionary = [NSDictionary dictionaryWithContentsOfFile: @"/var/mobile/Library/Preferences/com.nico671.aquariusprefs.plist"];
%group tweaky

%hook MRUNowPlayingHeaderView //hides the little routing button
  -(void)setShowRoutingButton:(BOOL)arg1{
      MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
    if(![controller respondsToSelector:@selector(context)]){
		%orig;
	}

    else if(controller.context == 2){
      if (isRoutingButtonHidden)
      %orig(NO);
      else{
        %orig;
        [self setFrame: CGRectMake(self.frame.origin.x,self.frame.origin.y-20,self.frame.size.width,self.frame.size.height)];
      }
      }
  }




%end


%hook MRUNowPlayingControlsView 
-(void)layoutSubviews{
  %orig;
  MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor]; //s/o lightmann for this it allows me to only change the lockscreen player and not the cc player
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
  %orig;
}


}
%end

%hook MRUNowPlayingLabelView  // hide the original label
-(void)setFrame:(CGRect)arg1{

  MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
if(![controller respondsToSelector:@selector(context)]){
%orig;
}
  else if (controller.context == 2)
  [self setHidden:YES];
else{
  %orig;
}
}

%end

%hook MRUNowPlayingTransportControlsView // coloring for the buttons

-(void)layoutSubviews{ //ik this is bad but i need it to updaye a lot and there are no other methods that update upon the song changing
  %orig;
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
%orig;

}

%end

%hook CSAdjunctItemView // sets the height and opacity of the player

-(void) _updateSizeToMimic

{
PLPlatterView *platterView = (PLPlatterView*)MSHookIvar<UIView*>(self, "_platterView");
[platterView.backgroundView setAlpha: musicPlayerAlpha];

if(configurations == 0){
%orig;
 if (haveOutline){
  self.layer.borderWidth = outlineSize;
        
          UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"outlineColor"] withFallback:@"#000000"];
        self.layer.borderColor = [customColor CGColor];
        
  
  self.layer.cornerRadius = 10;
  }
[self.heightAnchor constraintEqualToConstant:130].active = true; //height
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
  %orig;
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
  %orig;
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


%end

%hook SBMediaController

- (void)setNowPlayingInfo:(id)arg1 { // set now playing info
    %orig;
    MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {
        if (information) {

            NSDictionary* dict = (__bridge NSDictionary *)information;
       
    currentArtwork = [UIImage imageWithData:[dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData]]; 
            if (dict) {
                 [songTitleLabel setText:[NSString stringWithFormat:@"%@ ", [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoTitle]]]; // set song title
                    lastArtworkData = [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData];
                   
       
          
         
          
        
                 [artistNameLabel setText:[NSString stringWithFormat:@"%@ - %@ ", [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtist], [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoAlbum]]]; // set artist and album name
                 currentArtwork = [UIImage imageWithData:[dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData]]; // set artwork            
                
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
			if(![songLabel isEqualToString:previousTitle] && currentArtwork)//TODO: add option to choose between artwork and now playing app as the icon  {
[[objc_getClass("JBBulletinManager") sharedInstance] showBulletinWithTitle:subtitleLabel message:songLabel overrideBundleImage:currentArtwork];
        previousTitle = songLabel;
      }
}
  }          
%end
%end

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
        %init(tweaky);
	}
}

%ctor {
loadPrefs();
CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.nico671.preferenceschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}