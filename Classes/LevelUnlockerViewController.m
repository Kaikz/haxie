    //
//  LevelUnlockerViewController.m
//  haxie
//
//  Created by Kaikz on 7/01/11.
//  Copyright 2011 Pedanic-dev. All rights reserved.
//

#import "LevelUnlockerViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation LevelUnlockerViewController
@synthesize navbar;

-(IBAction) info {
	UIAlertView *info = [[UIAlertView alloc]
						 initWithTitle:@"haxie 1.3"
						 message:@"LevelUnlocker by Ramsey\n\nTwitter: @iamramsey"
						 delegate:self
						 cancelButtonTitle:@"Ok!"
						 otherButtonTitles:nil];
	[info show];
	[info release];
}

-(void) viewDidLoad {
	UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
	self.view.backgroundColor = background;
	[background release];
//	navbar.layer.contents = (id)[UIImage imageNamed:@"navbar.png"].CGImage;
}

-(IBAction) run {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Remember to close all apps before running LevelUnlocker!" 
															 delegate:self 
													cancelButtonTitle:nil
											   destructiveButtonTitle:@"Cancel" 
													otherButtonTitles:@"Continue", nil];
	[actionSheet setActionSheetStyle:UIBarStyleBlackTranslucent];
	[actionSheet showInView:[[self tabBarController] tabBar]];
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)sheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if([sheet buttonTitleAtIndex:buttonIndex] == @"Continue") {
		HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
		[self.view.window addSubview:HUD];
		HUD.delegate = self;
		HUD.labelText = @"Running...";
		[HUD showWhileExecuting:@selector(runScript) onTarget:self withObject:nil animated:YES];
	}
}

-(void) runScript {
	task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/bash"];
	NSString *script;
	script = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/levelunlocker.sh"];
	NSArray *args = [NSArray arrayWithObjects:script, nil];
	[task setArguments: args];
	[task launch];
	[NSThread sleepForTimeInterval:10.0];
	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark.png"]] autorelease];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = @"Complete!";
	[NSThread sleepForTimeInterval:1.0];
}

- (void)hudWasHidden {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
}

-(IBAction) supported {
	stask = [[NSTask alloc] init];
    [stask setLaunchPath:@"/bin/bash"];
	NSString *script;
	script = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/levelunlocker.sh"];
	NSArray *sargs = [NSArray arrayWithObjects:script, @"-s", nil];
	[stask setArguments: sargs];
	[stask launch];
	NSString *apps;
	apps = [NSString stringWithContentsOfFile:@"/var/mobile/supported_levelunlocker.txt" encoding:NSUTF8StringEncoding error:nil];
	NSFileManager *fm = [NSFileManager defaultManager];
	if ([fm fileExistsAtPath:apps]) {
	UIAlertView *supported = [[UIAlertView alloc] initWithTitle:@"Your Supported Apps" message:apps delegate:self cancelButtonTitle:@"Ok!" otherButtonTitles:nil];
	[supported show];
	[supported release];
	} else {
		UIAlertView *supported = [[UIAlertView alloc] initWithTitle:@"Your Supported Apps" message:@"Error generating list." delegate:self cancelButtonTitle:@"Ok!" otherButtonTitles:nil];
		[supported show];
		[supported release];
	}
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
