//
//  ViewController.m
//  Fractal Sketch
//
//  Created by Addison Leong on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
bool pageControlBeingUsed;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    pageControlBeingUsed = NO;
    [view1 setCenter:CGPointMake([scroll frame].size.width * 0.5, [scroll frame].size.height / 2)];
    [view2 setCenter:CGPointMake([scroll frame].size.width * 1.5, [scroll frame].size.height / 2)];
    [view3 setCenter:CGPointMake([scroll frame].size.width * 2.5, [scroll frame].size.height / 2)];
    [view4 setCenter:CGPointMake([scroll frame].size.width * 3.5, [scroll frame].size.height / 2)];
    [scroll addSubview:view1];
    [scroll addSubview:view2];
    [scroll addSubview:view3];
    [scroll addSubview:view4];
    scroll.contentSize = CGSizeMake([scroll frame].size.width * 4, [scroll frame].size.height);
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scroll.frame.size.width;
    int page = floor((scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    control.currentPage = page;
}

- (IBAction)changePage {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = scroll.frame.size.width * control.currentPage;
    frame.origin.y = 0;
    frame.size = scroll.frame.size;
    [scroll scrollRectToVisible:frame animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

@end
