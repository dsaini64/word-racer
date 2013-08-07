/*#import "textFieldTestAppDelegate.h"
@implementation MYSCENE
-(id) init
{
    self = [super init];
    isTouchEnabled = YES;
    return self;
}
-(BOOL)ccTouchesBegan:(NSSet  *)touches withEvent:(UIEvent *)event {
    [self specifyStartLevel];
    return kEventHandled;
}
-(void)specifyStartLevel {
    myText = [[UITextField alloc] initWithFrame:CGRectMake(60, 165, 200, 90)];
    [myText setDelegate:self];
    [myText setText:@""];
    [myText setTextColor: [UIColor colorWithRed:255 green:255 blue:255 alpha:1.0]];
    [[[[Director sharedDirector] openGLView] window] addSubview:myText];
    [myText becomeFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [myText resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing: (UITextField *)textField {
    if(textField == myText) {
        [myText endEditing:YES];
        [myText removeFromSuperview];
        NSString *result = myText.text;
        NSLog([NSString stringWithFormat:@"entered: %@", result]);
    } else {
        NSLog(@"textField did not match myText");
    }
}
-(void) dealloc
{
    [super dealloc];
}
@end
@implementation textFieldTestAppDelegate
- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window setUserInteractionEnabled:YES];
    [[Director sharedDirector] setDisplayFPS:YES];
    [[Director sharedDirector] attachInWindow:window];
    Scene *scene = [Scene node];
    [scene addChild: [MYSCENE node]];
    [window makeKeyAndVisible];
    [[Director sharedDirector] runWithScene: scene];
}
-(void)dealloc
{
    [super dealloc];
}
-(void) applicationWillResignActive:(UIApplication *)application
{
    [[Director sharedDirector] pause];
}
-(void) applicationDidBecomeActive:(UIApplication *)application
{
    [[Director sharedDirector] resume];
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[TextureMgr sharedTextureMgr] removeAllTextures];
}
@end */