#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <Cephei/HBPreferences.h>

#import <CepheiPrefs/HBRootListController.h>

@interface AQRRootListController : PSListController
@property (nonatomic, retain) UISwitch *switchy;
@property (nonatomic, retain) UIBarButtonItem *respringButton;
@end

@interface PSListController (WelcomeDisplay)
-(BOOL)containsSpecifier:(id)arg1;
@end

@interface HalFiPadSpecifier : PSListController
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *bundleIdentifier;
-(NSDictionary *)trimDataSource:(NSDictionary *)dataSource;
-(NSMutableArray *)appSpecifiers;
@end

@interface HalFiPadRootListController : PSListController
@property (nonatomic, retain) NSMutableDictionary *savedSpecifiers;
@property (nonatomic, retain) UISwitch *enableSwitch;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *iconView;
@end

@interface HalFiPadAppCustomizationController : PSListController
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *bundleIdentifier;
@end

@interface OBButtonTray : UIView
-(void)addButton:(id)arg1;
-(void)addCaptionText:(id)arg1;
@end

@interface OBBoldTrayButton : UIButton
-(void)setTitle:(id)arg1 forState:(unsigned long long)arg2;
+(id)buttonWithType:(long long)arg1;
@end

@interface OBWelcomeController : UIViewController
-(OBButtonTray *)buttonTray;
-(id)initWithTitle:(id)arg1 detailText:(id)arg2 icon:(id)arg3;
-(void)addBulletedListItemWithTitle:(id)arg1 description:(id)arg2 image:(id)arg3;
@end

OBWelcomeController *welcomeController;
