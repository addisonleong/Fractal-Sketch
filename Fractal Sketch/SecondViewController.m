//
//  SecondViewController.m
//  Fractal Sketch
//
//  Created by Addison Leong on 5/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import <QuartzCore/QuartzCore.h>
extern double scale[4];
extern double rotate[4];
extern int translate[4][2];
extern double C[3][3];
extern int selector;
extern int gens;
extern int g1, g2, g3, g4;
extern struct TM t1;
extern struct TM t2;
extern struct TM t3;
extern struct TM t4;
extern int xl1, yl1, xl2, yl2, xl3, yl3, xl4, yl4, xl5, yl5;
extern struct TM s1;
extern struct TM s2;
extern struct TM s3;
extern struct TM s4;
extern struct TM r1;
extern struct TM r2;
extern struct TM r3;
extern struct TM r4;
extern struct HC outputcoord;
extern struct TM outputmatrix;
extern int my, mx, arrows;
extern int preview, pan, steps, vertices, shape, panx, pany, dragx, dragy, startvalue;
extern double zoom;
extern NSMutableArray *xs;
extern NSMutableArray *ys;
extern int flip;
extern int colortyper;
extern int colortype, iterations;
extern int show;
extern struct TM GenerateTranslationMatrix2(double x, double y);
extern struct TM GenerateScalingMatrix2(double scale);
extern struct TM GenerateRotationMatrix2(double angle);
extern struct TM CreateBasicMatrix2();
extern float cx, cy;
int stop;

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrayNames = [[NSMutableArray alloc] init];
    [arrayNames addObject:@"Random"];
    [arrayNames addObject:@"Normal"];
    [arrayNames addObject:@"Segment"];
    [arrayNames addObject:@"Shade"];
    [arrayNames addObject:@"Oscillator"];
    [arrayNames addObject:@"Generator"];
    [pickerView selectRow:1 inComponent:0 animated:NO];
    menu = 0;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    menus.center = CGPointMake(menus.center.x, 1140);
    button.center = CGPointMake(button.center.x, 990);
    [[self view] setNeedsDisplay];
}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        [self.view setNeedsLayout];
        cx = self.view.frame.size.width/2;
        cy = self.view.frame.size.height/2;
        stop = 0;
        if (show == 1) {
            menus.center = CGPointMake(cx, menus.center.y);
            menus.center = CGPointMake(cx, 828.5 - stop);
            button.center = CGPointMake(cx, 672 - stop);
            show = 1;
        }
        else {
            menus.center = CGPointMake(cx, menus.center.y);
            menus.center = CGPointMake(cx, 1158 - stop);
            button.center = CGPointMake(cx, 928 -stop);
            show = 0;
        }
    }
    else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight){
        [self.view setNeedsLayout];
        cy = self.view.frame.size.height/2;
        cx = self.view.frame.size.width/2;
        stop = 250;
        if (show == 1) {
            menus.center = CGPointMake(cx, menus.center.y);
            menus.center = CGPointMake(cx, 828.5 - stop);
            button.center = CGPointMake(cx, 672 - stop);
        }
        else {
            menus.center = CGPointMake(cx, menus.center.y);
            menus.center = CGPointMake(cx, 1158 - stop);
            button.center = CGPointMake(cx, 928 -stop);
        }
    }
    [[self view]setNeedsDisplay];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row == 0) {
        colortype = 1;
    }
    else if (row == 1) {
        colortype = 0;
    }
    else if (row == 2) {
        colortype = 2;
    }
    else if (row == 3) {
        colortype = 3;
    }
    else if (row == 4) {
        colortype = 4;
    }
    else if (row == 5) {
        colortype = 5;
    }
    [[self view] setNeedsDisplay];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [arrayNames count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [arrayNames objectAtIndex:row];
}


- (void)dealloc
{
    [super dealloc];
}

- (IBAction)Menu:(id)sender {
    if (show == 0) {
        menus.center = CGPointMake(cx, 1158 - stop);
        button.center = CGPointMake(cx, 990 -stop);
        [UIView beginAnimations:@"ToggleViews" context:nil];
        [UIView setAnimationDuration:0.3];
        
        // Make the animatable changes.
        menus.center = CGPointMake(cx, menus.center.y);
        menus.center = CGPointMake(cx, 828.5 - stop);
        button.center = CGPointMake(cx, 672 - stop);
        
        // Commit the changes and perform the animation.
        [UIView commitAnimations];
        show = 1;
    }
    else {
        menus.center = CGPointMake(cx, 828.5 -stop);
        button.center = CGPointMake(cx, 672 - stop);
        [UIView beginAnimations:@"ToggleViews" context:nil];
        [UIView setAnimationDuration:0.3];
        
        // Make the animatable changes.
        menus.center = CGPointMake(cx, menus.center.y);
        menus.center = CGPointMake(cx, 1158 - stop);
        button.center = CGPointMake(cx, 928 -stop);
        
        // Commit the changes and perform the animation.
        [UIView commitAnimations];
        show = 0;
    }
}

- (IBAction)InZoom:(id)sender {
    zoom = zoom + 0.1;
    [[self view] setNeedsDisplay];
}

- (IBAction)OutZoom:(id)sender {
    zoom = zoom - 0.1;
    [[self view] setNeedsDisplay];
}

- (IBAction)Pan:(id)sender {
    if (pan == 0) {
        pan = 1;
    }
    else {
        pan = 0;
    }
    [[self view] setNeedsDisplay];
}

- (IBAction)Center:(id)sender {
    panx = 0;
    pany = 0;
    [[self view] setNeedsDisplay];
}

- (IBAction)Save:(id)sender {
    zoomin.hidden = YES;
    zoomout.hidden = YES;
    pane.hidden = YES;
    slidin.hidden = YES;
    slider.hidden = YES;
    pickerView.hidden = YES;
    center.hidden = YES;
    save.hidden = YES;
    button.hidden = YES;
    UIGraphicsBeginImageContext([[self view] frame].size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    zoomin.hidden = NO;
    zoomout.hidden = NO;
    pane.hidden = NO;
    slidin.hidden = NO;
    slider.hidden = NO;
    pickerView.hidden = NO;
    center.hidden = NO;
    save.hidden = NO;
    button.hidden = NO;
}

- (IBAction)Iter:(id)sender {
    steps = [slider value];
    [[self view]setNeedsDisplay];
}

- (IBAction)PanImage:(id)sender {
    if (pan == 0) {
    CGPoint point = [(UIGestureRecognizer *)sender locationInView:self.view];
    if (show == 0 || (show == 1 && point.y < 830)) {
        panx = point.x - cx;
        pany = point.y - cy;
    }
    [self.view setNeedsDisplay];
    }
}

- (IBAction)ZoomImage:(id)sender {
    if (pan == 0) {
    zoom = [(UIPinchGestureRecognizer *)sender scale];
    [self.view setNeedsDisplay];
    }
}

- (IBAction)LevelUp:(id)sender {
    steps = steps + 1;
    [[self view]setNeedsDisplay];
}

- (IBAction)LevelDown:(id)sender {
    if (steps >= 0) {
    steps = steps -1;
    }
    [[self view]setNeedsDisplay];
}

@end
