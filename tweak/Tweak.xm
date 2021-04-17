#import "headers.h"
BOOL musicPlayerEnabled, musicPlayerColorsEnabled;
BOOL isTimeHidden,showPercentage, modernStatusBar, isCellularThingyHidden, isWifiThingyHidden, isRoutingButtonHidden, isBackgroundColored, isDarkImage, isArtworkBackground, haveNotifs, haveOutline, statusBarSectionEnabled, isBatteryHidden;
//TODO: fucking fix the default player and the progress bar player u dunce
id preferences, file, yes;
long int configurations;
NSString *previousTitle = @"poggers";
double musicPlayerAlpha, outlineSize, rightOffsetForText;
NSDictionary *preferencesDictionary = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/aquariusprefs.plist"];
%group musicplayer
%hook MRUNowPlayingHeaderView // hides the little routing button
- (void)setShowRoutingButton:(BOOL)arg1 {
	MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
	if(![controller respondsToSelector:@selector(context)]){
		%orig;
	}
	else if ( controller.context == 2 && isRoutingButtonHidden) {
		arg1 = NO;
	}
	%orig(arg1);
}
%end
%hook MRUNowPlayingControlsView 
-(void)setNeedsLayout{

	MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor]; //s/o lightmann for this it allows me to only change the lockscreen player and not the cc player
	if (isArtworkBackground) [self.headerView.artworkView setHidden:YES]; // for the artwork background option, looks shit with the standard artwork there, unfortunately not working right noew along with the rest of the artwork background stuff
	if (controller.context == 2 && configurations == 0) {
		[self.transportControlsView setFrame:CGRectMake(CGRectGetMidX(self.headerView.artworkView.frame) + 5,CGRectGetMidY(self.headerView.frame)-15, self.transportControlsView.frame.size.width, self.transportControlsView.frame.size.height)];
		//resizing controls, almost same for everytime i do this
		[self.headerView.artworkView setHidden:YES];
		if (!songImageForSmall) {
			songImageForSmall = [UIButton new];
			[songImageForSmall setContentMode:UIViewContentModeScaleAspectFill];
			[songImageForSmall setClipsToBounds:YES];
			[songImageForSmall setAdjustsImageWhenHighlighted:NO];
			[songImageForSmall setAlpha:1];
			[songImageForSmall.layer setCornerRadius:8];
			[self addSubview:songImageForSmall];
			[songImageForSmall setTranslatesAutoresizingMaskIntoConstraints:YES];
			[songImageForSmall setFrame:CGRectMake(self.headerView.artworkView.frame.origin.x,self.headerView.artworkView.frame.origin.y-10, 100, 100)];
			if (!artistNameLabel) {
			artistNameLabel = [MarqueeLabel new];
			[artistNameLabel setFont:[UIFont systemFontOfSize:15]];
			[artistNameLabel setTextAlignment:NSTextAlignmentLeft];
			[artistNameLabel setAlpha:1];
			[self addSubview:artistNameLabel];
			UIColor *customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customTitleLabelColor"] withFallback:@"#000000"];
			[songTitleLabel setTextColor:customColor];
			[artistNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
			[artistNameLabel.widthAnchor constraintEqualToConstant:230].active = YES;
			[artistNameLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
			[artistNameLabel.leftAnchor constraintEqualToAnchor:songImageForSmall.rightAnchor constant:rightOffsetForText].active = YES;
			[artistNameLabel.bottomAnchor constraintEqualToAnchor:self.transportControlsView.topAnchor constant:3].active = YES;
		}
		if (!songTitleLabel) {
			songTitleLabel = [MarqueeLabel new];
			[songTitleLabel setFont:[UIFont systemFontOfSize:15]];
			[songTitleLabel setTextAlignment:NSTextAlignmentLeft];
			[songTitleLabel setAlpha:1];
			[self addSubview:songTitleLabel];
			UIColor *customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customSubtitleLabelColor"] withFallback:@"#000000"];
			[songTitleLabel setTextColor:customColor];
			[songTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
			[songTitleLabel.widthAnchor constraintEqualToConstant:230].active = YES;
			[songTitleLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
			[songTitleLabel.leftAnchor constraintEqualToAnchor:songImageForSmall.rightAnchor constant:rightOffsetForText].active = YES;
			[songTitleLabel.bottomAnchor constraintEqualToAnchor:self.transportControlsView.centerYAnchor constant:-20].active = YES;
		}
			//couldnt adjust the size of the player so i just made a thing myself (its a button because i have the plan of adding gestures in the future)
		}
	} else if (configurations == 1 && controller.context == 2) {	
		[self.headerView.artworkView setHidden:YES];
		[self.transportControlsView setFrame:CGRectMake(CGRectGetMidX(self.headerView.artworkView.frame) + 5,CGRectGetMinY(self.headerView.frame) + 40, self.transportControlsView.frame.size.width, self.transportControlsView.frame.size.height)];
		[self.timeControlsView setFrame: CGRectMake(CGRectGetMinX(self.headerView.artworkView.frame),CGRectGetMinY(self.frame) + 53, self.timeControlsView.frame.size.width, self.timeControlsView.frame.size.height)];
		[self.headerView.artworkView setHidden:YES];
		if (!songImageForSmall) {
			songImageForSmall = [UIButton new];
			[songImageForSmall setContentMode:UIViewContentModeScaleAspectFill];
			[songImageForSmall setClipsToBounds:YES];
			[songImageForSmall setAdjustsImageWhenHighlighted:NO];
			[songImageForSmall setAlpha:1];
			[songImageForSmall.layer setCornerRadius:8];
			[self addSubview:songImageForSmall];
			[songImageForSmall setTranslatesAutoresizingMaskIntoConstraints:YES];
			[songImageForSmall setFrame:CGRectMake(self.headerView.artworkView.frame.origin.x,self.headerView.artworkView.frame.origin.y-10, 90, 90)];
		}
			if (!artistNameLabel) {
			artistNameLabel = [MarqueeLabel new];
			[artistNameLabel setFont:[UIFont systemFontOfSize:15]];
			[artistNameLabel setTextAlignment:NSTextAlignmentLeft];
			[artistNameLabel setAlpha:1];
			[self addSubview:artistNameLabel];
			UIColor *customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customTitleLabelColor"] withFallback:@"#000000"];
			[songTitleLabel setTextColor:customColor];
			[artistNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
			[artistNameLabel.widthAnchor constraintEqualToConstant:230].active = YES;
			[artistNameLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
			[artistNameLabel.leftAnchor constraintEqualToAnchor:songImageForSmall.rightAnchor constant:rightOffsetForText].active = YES;
			[artistNameLabel.bottomAnchor constraintEqualToAnchor:self.transportControlsView.topAnchor constant:3].active = YES;
		}
		if (!songTitleLabel) {
			songTitleLabel = [MarqueeLabel new];
			[songTitleLabel setFont:[UIFont systemFontOfSize:15]];
			[songTitleLabel setTextAlignment:NSTextAlignmentLeft];
			[songTitleLabel setAlpha:1];
			[self addSubview:songTitleLabel];
			UIColor *customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customSubtitleLabelColor"] withFallback:@"#000000"];
			[songTitleLabel setTextColor:customColor];
			[songTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
			[songTitleLabel.widthAnchor constraintEqualToConstant:230].active = YES;
			[songTitleLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
			[songTitleLabel.leftAnchor constraintEqualToAnchor:songImageForSmall.rightAnchor constant:rightOffsetForText].active = YES;
			[songTitleLabel.bottomAnchor constraintEqualToAnchor:self.transportControlsView.centerYAnchor constant:-20].active = YES;
		}
	} else if (configurations == 2 && controller.context == 2) {
		[self.volumeControlsView setFrame:CGRectMake(CGRectGetMinX(self.headerView.artworkView.frame),CGRectGetMinY(self.frame) + 55, self.timeControlsView.frame.size.width, self.timeControlsView.frame.size.height)];
		[self.timeControlsView setHidden:YES];
		[self.headerView.artworkView setHidden:YES];
		[self.transportControlsView setFrame:CGRectMake(CGRectGetMidX(self.headerView.artworkView.frame) + 5,CGRectGetMinY(self.headerView.frame) + 40, self.transportControlsView.frame.size.width, self.transportControlsView.frame.size.height)];
		if (!songImageForSmall) {
			songImageForSmall = [UIButton new];
			[songImageForSmall setContentMode:UIViewContentModeScaleAspectFill];
			[songImageForSmall setClipsToBounds:YES];
			[songImageForSmall setAdjustsImageWhenHighlighted:NO];
			[songImageForSmall setAlpha:1];
			[songImageForSmall.layer setCornerRadius:8];
			[self addSubview:songImageForSmall];
			[songImageForSmall setTranslatesAutoresizingMaskIntoConstraints:YES];
			[songImageForSmall setFrame:CGRectMake(self.headerView.artworkView.frame.origin.x,self.headerView.artworkView.frame.origin.y-10, 85, 85)];
			//couldnt adjust the size of the artwork so i just made a thing myself (its a button because i have the plan of adding gestures in the future)
		}
		if (!artistNameLabel) {
			artistNameLabel = [MarqueeLabel new];
			[artistNameLabel setFont:[UIFont systemFontOfSize:15]];
			[artistNameLabel setTextAlignment:NSTextAlignmentLeft];
			[artistNameLabel setAlpha:1];
			[self addSubview:artistNameLabel];
			UIColor *customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customTitleLabelColor"] withFallback:@"#000000"];
			[songTitleLabel setTextColor:customColor];
			[artistNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
			[artistNameLabel.widthAnchor constraintEqualToConstant:230].active = YES;
			[artistNameLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
		    [artistNameLabel.leftAnchor constraintEqualToAnchor:songImageForSmall.rightAnchor constant:rightOffsetForText].active = YES;
			[artistNameLabel.bottomAnchor constraintEqualToAnchor:songImageForSmall.centerYAnchor constant:3].active = YES;
		}
		if (!songTitleLabel) {
		songTitleLabel = [MarqueeLabel new];
				[songTitleLabel setFont:[UIFont systemFontOfSize:15]];
				[songTitleLabel setTextAlignment:NSTextAlignmentLeft];
				[songTitleLabel setAlpha:1];
				[self addSubview:songTitleLabel];
				{
				UIColor *customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customSubtitleLabelColor"] withFallback:@"#000000"];
				[songTitleLabel setTextColor:customColor];
				}
				[songTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
				[songTitleLabel.widthAnchor constraintEqualToConstant:230].active = YES;
				[songTitleLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
				[songTitleLabel.leftAnchor constraintEqualToAnchor:songImageForSmall.rightAnchor constant:rightOffsetForText].active = YES;
				[songTitleLabel.bottomAnchor constraintEqualToAnchor:self.transportControlsView.centerYAnchor constant:-20].active = YES;
		}
	} else if (configurations == 3  && controller.context == 2) {
		//small option
		[self.headerView.artworkView setHidden:YES];
		[self.transportControlsView setFrame:CGRectMake(CGRectGetMidX(self.headerView.artworkView.frame) + 5,CGRectGetMinY(self.headerView.frame) + 30, self.transportControlsView.frame.size.width, self.transportControlsView.frame.size.height)];
		if (!songImageForSmall) {
			songImageForSmall = [UIButton new];
			[songImageForSmall setContentMode:UIViewContentModeScaleAspectFill];
			[songImageForSmall setClipsToBounds:YES];
			[songImageForSmall setAdjustsImageWhenHighlighted:NO];
			[songImageForSmall setAlpha:1];
			[songImageForSmall.layer setCornerRadius:8];
			[self addSubview:songImageForSmall];
			[songImageForSmall setTranslatesAutoresizingMaskIntoConstraints:YES];
			[songImageForSmall setFrame:CGRectMake(self.headerView.artworkView.frame.origin.x,self.headerView.artworkView.frame.origin.y-10, 85, 85)];
			//couldnt adjust the size of the player so i just made a thing myself (its a button because i have the plan of adding gestures in the future)
		}
		if (!artistNameLabel) {
			artistNameLabel = [MarqueeLabel new];
			[artistNameLabel setFont:[UIFont systemFontOfSize:15]];
			[artistNameLabel setTextAlignment:NSTextAlignmentLeft];
			[artistNameLabel setAlpha:1];
			[self addSubview:artistNameLabel];
			UIColor *customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customTitleLabelColor"] withFallback:@"#000000"];
			[songTitleLabel setTextColor:customColor];
			[artistNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
			[artistNameLabel.widthAnchor constraintEqualToConstant:230].active = YES;
			[artistNameLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
			[artistNameLabel.leftAnchor constraintEqualToAnchor:songImageForSmall.rightAnchor constant:rightOffsetForText].active = YES;
			[artistNameLabel.bottomAnchor constraintEqualToAnchor:songImageForSmall.centerYAnchor constant:3].active = YES;
		}
		if (!songTitleLabel) {
			songTitleLabel = [MarqueeLabel new];
			[songTitleLabel setFont:[UIFont systemFontOfSize:15]];
			[songTitleLabel setTextAlignment:NSTextAlignmentLeft];
			[songTitleLabel setAlpha:1];
			[self addSubview:songTitleLabel];
			if (musicPlayerColorsEnabled) {
				UIColor *customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customSubtitleLabelColor"] withFallback:@"#000000"];
				[songTitleLabel setTextColor:customColor];
			}
			[songTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
			[songTitleLabel.widthAnchor constraintEqualToConstant:230].active = YES;
			[songTitleLabel.heightAnchor constraintEqualToConstant:21.0].active = YES;
			[songTitleLabel.leftAnchor constraintEqualToAnchor:songImageForSmall.rightAnchor constant:rightOffsetForText].active = YES;
			[songTitleLabel.bottomAnchor constraintEqualToAnchor:self.transportControlsView.centerYAnchor constant:-20].active = YES;
		}
	} else{ 
		%orig;
		}
}
%end

%hook MRUNowPlayingLabelView  // hide the original label

- (void)setFrame:(CGRect)arg1{
	MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
	if (![controller respondsToSelector:@selector(context)] ){
		%orig;
	}
	else if ( controller.context == 2){
		[self setHidden:YES];
	}
	else %orig;
}



%end
%hook MRUNowPlayingTransportControlsView // coloring for the buttons

- (void)setNeedsLayout { //ik this is bad but i need it to updaye a lot and there are no other methods that update upon the song changing

	MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
	if (musicPlayerColorsEnabled && controller.context == 2) {
		UIColor *leftColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customLeftButtonColor"] withFallback:@"#000000"];
		[self.leftButton setStylingProvider:nil];
		self.leftButton.imageView.layer.filters = nil;
		[self.leftButton.imageView setTintColor:leftColor];
		
		UIColor *middleColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customMiddleButtonColor"] withFallback:@"#000000"];
		[self.middleButton setStylingProvider:nil];
		self.middleButton.imageView.layer.filters = nil;
		[self.middleButton.imageView setTintColor:middleColor];
		
		UIColor *rightColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"customRightButtonColor"] withFallback:@"#000000"];
		[self.rightButton setStylingProvider:nil];
		self.rightButton.imageView.layer.filters = nil;
		[self.rightButton.imageView setTintColor:rightColor];
	}
}

%end

%hook CSAdjunctItemView // sets the height and opacity of the player

-(void)_updateSizeToMimic{
	%orig;
PLPlatterView *platterView = (PLPlatterView*)MSHookIvar<UIView*>(self, "_platterView");
[platterView.backgroundView setAlpha: musicPlayerAlpha];

if(configurations == 0){

 if (haveOutline){
  self.layer.borderWidth = outlineSize;
  UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"outlineColor"] withFallback:@"#000000"];
  self.layer.borderColor = [customColor CGColor];
  self.layer.cornerRadius = 10;
  }
[self.heightAnchor constraintEqualToConstant:115].active = true; //height
if (isArtworkBackground){
songBackground = [UIButton new];
[songBackground setContentMode:UIViewContentModeScaleAspectFill];
[songBackground setClipsToBounds:YES];
[songBackground setAdjustsImageWhenHighlighted:NO];
[songBackground setAlpha:musicPlayerAlpha];
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
  [coloredBackground setAlpha:musicPlayerAlpha];
  [self addSubview: coloredBackground];
  [self sendSubviewToBack:coloredBackground];
}



}
else if(configurations == 1 || configurations == 2){

   if (haveOutline){
  self.layer.borderWidth = outlineSize;
  UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"outlineColor"] withFallback:@"#000000"];
  self.layer.borderColor = [ customColor CGColor];
  self.layer.cornerRadius = 10;
  }
[self.heightAnchor constraintEqualToConstant:130].active = true;
//if (isArtworkBackground){
songBackground = [UIButton new];
 [platterView.backgroundView setAlpha: 0];
[songBackground setContentMode:UIViewContentModeScaleAspectFill];
[songBackground setClipsToBounds:YES];
[songBackground setAdjustsImageWhenHighlighted:NO];
[songBackground setAlpha:musicPlayerAlpha];
[songBackground.layer setCornerRadius:8];
[self addSubview:songBackground];
[self sendSubviewToBack: songBackground];
[songBackground setAlpha:musicPlayerAlpha];
[songBackground setTranslatesAutoresizingMaskIntoConstraints:YES];
[songBackground setFrame: CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height)];
//}

if (isBackgroundColored){
 [platterView.backgroundView setAlpha: 0];
  coloredBackground = [UIView new];
  [coloredBackground setFrame: CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height)];
  [coloredBackground.layer setCornerRadius:10];
  [coloredBackground setAlpha:musicPlayerAlpha];
  [self addSubview: coloredBackground];
  [self sendSubviewToBack:coloredBackground];
}


}
else if(configurations == 3){
  if (haveOutline){
  self.layer.borderWidth = outlineSize;
  UIColor* customColor = [SparkColourPickerUtils colourWithString:[preferencesDictionary objectForKey:@"outlineColor"] withFallback:@"#000000"];
  self.layer.borderColor = [customColor CGColor];
  self.layer.cornerRadius = 10;
  }
  [self.heightAnchor constraintEqualToConstant:100].active = true;
if (isArtworkBackground){
   [platterView.backgroundView setAlpha: 0];
songBackground = [UIButton new];
[songBackground setContentMode:UIViewContentModeScaleAspectFill];
[songBackground setClipsToBounds:YES];
[songBackground setAdjustsImageWhenHighlighted:NO];
[songBackground setAlpha:musicPlayerAlpha];
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
  [coloredBackground setAlpha:musicPlayerAlpha];
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
			NSDictionary *dict = (__bridge NSDictionary *)information;

			currentArtwork = [UIImage imageWithData:[dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData]]; 
			if (dict) {
				[songTitleLabel setText:[NSString stringWithFormat:@"%@ ", [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoTitle]]]; // set song title
				lastArtworkData = [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData];

				[artistNameLabel setText:[NSString stringWithFormat:@"%@ - %@ ", [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtist], [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoAlbum]]]; // set artist and album name
			 // set artwork            

				subtitleLabel = [NSString stringWithFormat:@"%@ - %@ ", [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtist], [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoAlbum]];
				songLabel = [NSString stringWithFormat:@"%@ ", [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoTitle]];

				[songBackground setImage:currentArtwork forState:UIControlStateNormal];
				[songImageForSmall setImage:currentArtwork forState:UIControlStateNormal]; 
				[coloredBackground setBackgroundColor:[libKitten primaryColor:currentArtwork]];
			}
			lastArtworkData = [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData];
        }
  	});

	if (haveNotifs) {
			if (![songLabel isEqualToString:previousTitle]){
			[[objc_getClass("JBBulletinManager") sharedInstance] showBulletinWithTitle:subtitleLabel message:songLabel bundleID:[[[%c(SBMediaController) sharedInstance] nowPlayingApplication] bundleIdentifier]];
			}
			previousTitle = songLabel; //notifications
	}

}          
%end


%end

%group statusbar
%hook _UIBatteryView
-(void)setFillColor:(UIColor *)arg1{
	%orig;
	if (isBatteryHidden){
	self.hidden = YES;
	}
}
%end

%hook _UIStatusBarWifiSignalView
-(void)didMoveToWindow{
	%orig;
	if (isWifiThingyHidden){
	self.hidden = YES;
	}
}
%end
%hook _UIStatusBarCellularSignalView
-(void)setNeedsLayout{
	%orig;
	if (isCellularThingyHidden){
	self.hidden = YES;
	}
	self.tintColor = [UIColor redColor];
}
%end

%hook _UIStatusBarStringView
-(void)didMoveToWindow{
	%orig;
	if (isTimeHidden){
	self.hidden = YES;
	}
}
%end
%hook _UIStatusBar
-(void)setNeedsLayout{
	%orig;
	self.visualProviderClass =  @"_UIStatusBarVisualProvider_Split54";
}

%end
%hook _UIBatteryView 
-(BOOL)_currentlyShowsPercentage {
	if(showPercentage) return YES;
	else return NO;
}
-(BOOL)_shouldShowBolt {
    if (showPercentage || modernStatusBar) return NO;
	else return YES;

}
%end
%end

void reloadPrefs() { //prefs
	musicPlayerEnabled = [file boolForKey:@"isMusicSectionEnabled"];
	statusBarSectionEnabled = [file boolForKey:@"isStausBarSectionEnabled"];
	isBatteryHidden = [file boolForKey:@"isBatteryHidden"];
	isWifiThingyHidden = [file boolForKey:@"isWifiHidden"];
	isCellularThingyHidden = [file boolForKey:@"isCellularHidden"];
	isTimeHidden = [file boolForKey:@"isTimeHidden"];
	modernStatusBar = [file boolForKey:@"modernStatusBar"];
	isRoutingButtonHidden = [file boolForKey:@"isRoutingButtonHidden"];
	configurations = [file integerForKey:@"configuration"];
	musicPlayerAlpha = [file doubleForKey:@"musicPlayerAlpha"];
	rightOffsetForText = [file doubleForKey:@"textOffset"];
	musicPlayerColorsEnabled = [file boolForKey:@"isRoutingButtonHidden"];
	haveNotifs = [file boolForKey:@"notifications?"]; 
	showPercentage = [file boolForKey:@"showPercentage"]; 
	isBackgroundColored = [file boolForKey:@"isBackgroundColorEnabled"];
	isArtworkBackground = [file boolForKey:@"isArtworkBackground"];
	haveOutline = [file boolForKey:@"haveOutline?"];
	outlineSize = [file doubleForKey:@"sizeOfOutline?"];
}

%ctor {
	HBPreferences *file = [[HBPreferences alloc] initWithIdentifier:@"aquariusprefs"];
	[file registerBool:&musicPlayerEnabled default:YES forKey:@"isMusicSectionEnabled"];
	[file registerBool:&isTimeHidden default:NO forKey:@"isTimeHidden"];
	[file registerBool:&isBatteryHidden default:NO forKey:@"isBatteryHidden"];
	[file registerBool:&isCellularThingyHidden default:NO forKey:@"isCellularHidden"];
	[file registerBool:&isWifiThingyHidden default:NO forKey:@"isWifiHidden"];

	[file registerBool:&modernStatusBar default:YES forKey:@"modernStatusBar"];
	[file registerBool:&statusBarSectionEnabled default:YES forKey:@"isStausBarSectionEnabled"];
	[file registerBool:&isRoutingButtonHidden default:YES forKey:@"isRoutingButtonHidden"];
	[file registerDouble:&musicPlayerAlpha default:1 forKey:@"musicPlayerAlpha"];
	[file registerDouble:&rightOffsetForText default:1 forKey:@"textOffset"];
	[file registerInteger:&configurations default:0 forKey:@"configuration"];
	[file registerBool:&musicPlayerColorsEnabled default:NO forKey:@"isColorsEnabled"];
	[file registerBool:&haveNotifs default:YES forKey:@"notifications?"];
	[file registerBool:&isBackgroundColored default:NO forKey:@"isBackgroundColorEnabled"];
	[file registerBool:&isArtworkBackground default:NO forKey:@"isArtworkBackground"];
	[file registerBool:&haveOutline default:NO forKey:@"haveOutline?"];
	[file registerBool:&showPercentage default:NO forKey:@"showPercentage"];
	[file registerDouble:&outlineSize default:5 forKey:@"sizeOfOutline?"];

	if (musicPlayerEnabled) {
        %init(musicplayer);
	}
	if (statusBarSectionEnabled){
		%init(statusbar)
	}
	%init
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR("com.nico671.preferenceschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}