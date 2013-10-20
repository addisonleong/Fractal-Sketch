//
//  FirstViewController.m
//  Fractal Sketch
//
//  Created by Addison Leong on 5/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import <UIKit/UIBezierPath.h>
struct TM {
    double t[3][3];
};
struct HC {
    double c[3][1];
};
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
extern struct TM GenerateTranslationMatrix1(double x, double y);
extern struct TM GenerateScalingMatrix1(double scale);
extern struct TM GenerateRotationMatrix1(double angle);
extern struct TM CreateBasicMatrix1();
extern float cx, cy;
int sel;
float yfirst, xfirst;
BOOL g11, g12, g13, g14;
float distance1(float x1, float y1, int gen);
CGPoint l1, l2;
struct HC ApplyMatrixToPoint1(int x, int y, struct TM Transform);
struct TM MultiplyMatrices1(struct TM M1, struct TM M2);
int set;
float memrot;
float memscal;
int run;
extern int designtype;
extern NSMutableArray *Sequence;
extern NSMutableArray *Values;
int TransformType;
extern int axes;
extern int guides;
extern int grid;
extern NSMutableString *trans;
int stop;
struct TM M1, M2, M3, M4;
int down;
int selecter;

@implementation FirstViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    show = 0;
    scale[0] = 1;
    scale[1] = 1;
    scale[2] = 1;
    scale[3] = 1;
    shape = 0;
    gens = 1;
    Inputer.hidden = YES;
    shapes = 0;
    Shapes.center = CGPointMake(Shapes.center.x, -184);
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        [self.view setNeedsLayout];
        cx = self.view.frame.size.width/2;
        cy = self.view.frame.size.height/2;
    }
    else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight){
        [self.view setNeedsLayout];
        cy = self.view.frame.size.height/2;
        cx = self.view.frame.size.width/2;
    }
    cx = 768/2;
    cy = 955/2;
    t1 = GenerateTranslationMatrix1((cx) - 100, (cy) - 100);
    t2 = GenerateTranslationMatrix1((cx) + 100, (cy) - 100);
    t3 = GenerateTranslationMatrix1((cx) + 100, (cy) + 100);
    t4 = GenerateTranslationMatrix1((cx) - 100, (cy) + 100);
    translate [0][0] = (cx) - 100;
    translate [0][1] = (cy) - 100;
    translate [1][0] = (cx) + 100;
    translate [1][1] = (cy) - 100;
    translate [2][0] = (cx) + 100;
    translate [2][1] = (cy) + 100;
    translate [3][0] = (cx) - 100;
    translate [3][1] = (cy) + 100;
    shape = 0;
    s1 = CreateBasicMatrix1();
    s2 = CreateBasicMatrix1();
    r1 = CreateBasicMatrix1();
    r2 = CreateBasicMatrix1();
    s3 = CreateBasicMatrix1();
    s4 = CreateBasicMatrix1();
    r3 = CreateBasicMatrix1();
    r4 = CreateBasicMatrix1();
    gens = 1;
    g1 = 1;
    g2 = 0;
    g3 = 0;
    g4 = 0;
    steps = 2;
    preview = 0;
    vertices = 4;
    zoom = 1;
    iterations = 1;
    colortyper = 1;
    selector = 0;
    axes = 1;
    guides = 0;
    stop = 0;
    down = 0;
    menu.center = CGPointMake(menu.center.x, 1176);
    button.center = CGPointMake(button.center.x, 990);
    [trans appendString: @"0   0   0"];
    axes = 1;
    guides = 0;
    grid = 0;
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(handlePinchGesture:)];
    [self.view addGestureRecognizer:pinchGesture];
    pinchGesture.delegate = self;
    [pinchGesture release];
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]
                                                    initWithTarget:self action:@selector(handleRotation:)];
    [self.view addGestureRecognizer:rotationGesture];
    rotationGesture.delegate = self;
    [rotationGesture release];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGesture];
    [panGesture release];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(handleTapGesture:)];
    [self.view addGestureRecognizer:tapGesture];
    [tapGesture release];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];

}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        [self.view setNeedsLayout];
        cx = self.view.frame.size.width/2;
        cy = self.view.frame.size.height/2;
        stop = 0;
        if (show == 1) {
            menu.center = CGPointMake(cx, menu.center.y);
            menu.center = CGPointMake(cx, 846.5 - stop);
            button.center = CGPointMake(cx, 703 - stop);
            show = 1;
        }
        else {
            menu.center = CGPointMake(cx, menu.center.y);
            menu.center = CGPointMake(cx, 1176 - stop);
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
            menu.center = CGPointMake(cx, menu.center.y);
            menu.center = CGPointMake(cx, 846.5 - stop);
            button.center = CGPointMake(cx, 703 - stop);
        }
        else {
            menu.center = CGPointMake(cx, menu.center.y);
            menu.center = CGPointMake(cx, 1176 - stop);
            button.center = CGPointMake(cx, 928 -stop);
        }
    }
    [[self view] setNeedsDisplay];
}
void createMasterMatrices1() {
    M1 = MultiplyMatrices1(MultiplyMatrices1(r1, s1), MultiplyMatrices1(t1, GenerateTranslationMatrix1((-1 * (cx)), (-1 * (cy)))));
    M2 = MultiplyMatrices1(MultiplyMatrices1(r2, s2), MultiplyMatrices1(t2, GenerateTranslationMatrix1((-1 * (cx)), (-1 * (cy)))));
    M3 = MultiplyMatrices1(MultiplyMatrices1(r3, s3), MultiplyMatrices1(t3, GenerateTranslationMatrix1((-1 * (cx)), (-1 * (cy)))));
    M4 = MultiplyMatrices1(MultiplyMatrices1(r4, s4), MultiplyMatrices1(t4, GenerateTranslationMatrix1((-1 * (cx)), (-1 * (cy)))));
}
void writeMatrix(int selected) {
    if (selected == 0) {
        trans = nil;
        NSString *string = [[[[[NSString stringWithFormat:@"%d", M1.t[0][0]] stringByAppendingString:@"   "] stringByAppendingString:[NSString stringWithFormat:@"%d", M1.t[0][1]]] stringByAppendingString:@"   "] stringByAppendingString:[NSString stringWithFormat:@"%d", M1.t[0][2]]];
        [trans appendString:string];
    }
}

float distance1(float x1, float y1, int gen) {
    float dist = ((x1 - translate[gen][0])*(x1 - translate[gen][0])) + ((y1 - translate[gen][1])*(y1 - translate[gen][1]));
    dist = fabsf(dist);
    dist = sqrtf(dist);
    return dist;
}
- (IBAction)handleTapGesture:(UIGestureRecognizer *)sender {
    CGPoint point = [(UITapGestureRecognizer *)sender locationInView:self.view];
    float dist10 = distance1(point.x, point.y, 0);
    float dist20 = distance1(point.x, point.y, 1);
    float dist30 = distance1(point.x, point.y, 2);
    float dist40 = distance1(point.x, point.y, 3);
    if (dist10 <= scale[0] * 100) {
        g11 = TRUE;
    }
    else {
        g11 = FALSE;
    }
    if (dist20 <= scale[1] * 100) {
        g12 = TRUE;
    }
    else {
        g12 = FALSE;
    }
    if (dist30 <= scale[2] * 100) {
        g13 = TRUE;
    }
    else {
        g13 = FALSE;
    }
    if (dist40 <= scale[3] * 100) {
        g14 = TRUE;
    }
    else {
        g14 = FALSE;
    }
    if (g11 == TRUE) {
        selector = 0;
    }
    else {
        if (g12 == TRUE) {
            selector = 1;
        }
        else {
            if (g13 == TRUE) {
                selector = 2;
            }
            else {
                if (g14 == TRUE) {
                    selector = 3;
                }
                else {
                    selector = 4;
                }
            }
        }
    }
    writeMatrix(selector);
    Matrix.text = trans;
[self.view setNeedsDisplay];
    
}
- (IBAction)handlePinchGesture:(UIGestureRecognizer *)sender {
    float factor = [(UIPinchGestureRecognizer *)sender scale];
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (selector == 0) {
            memscal = scale[0];
        }
        else if (selector == 1) {
            memscal = scale[1];
        }
        else if (selector == 2) {
            memscal = scale[2];
        }
        else if (selector == 3) {
            memscal = scale[3];
        }
    }
    if (selector == 0) {
        if (factor > 1 && (scale[0] == 1 || scale[0] > 1)) {
            
        }
            else {
    scale[0] = memscal * factor;
    s1 = GenerateScalingMatrix1(scale[0]);
            }
    }
    else if (selector == 1) {
        if (factor > 1 && (scale[1] == 1 || scale[1] > 1)) {
            
        }
        else {
        scale[1] = memscal * factor;
        s2 = GenerateScalingMatrix1(scale[1]);
        }
    }
    else if (selector == 2) {
        if (factor > 1 && (scale[2] == 1 || scale[2] > 1)) {
            
        }
        else {
        scale[2] = memscal * factor;
        s3 = GenerateScalingMatrix1(scale[2]);
        }
    }
    else if (selector == 3) {
        if (factor > 1 && (scale[3] == 1 || scale[3] > 1)) {
            
        }
        else {
        scale[3] = memscal * factor;
        s4 = GenerateScalingMatrix1(scale[3]);
        }
    }
    [self.view setNeedsDisplay];
}

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender {
    @try{
    float xnow = [(UIPanGestureRecognizer *)sender locationInView:self.view].x;
    float ynow = [(UIPanGestureRecognizer *)sender locationInView:self.view].y;
    struct HC tranPoint;
    if (selector == 0){
        tranPoint = ApplyMatrixToPoint1(0, 0, t1);
        translate[0][0] = tranPoint.c[0][0];
        translate[0][1] = tranPoint.c[1][0];
        struct TM tran = GenerateTranslationMatrix1(xnow - translate[0][0], ynow - translate[0][1]);
        t1 = MultiplyMatrices1(t1, tran);
        tranPoint = ApplyMatrixToPoint1(0, 0, t1);
        translate[0][0] = tranPoint.c[0][0];
        translate[0][1] = tranPoint.c[1][0];
    }
    else if (selector == 1) {
        tranPoint = ApplyMatrixToPoint1(0, 0, t2);
        translate[1][0] = tranPoint.c[0][0];
        translate[1][1] = tranPoint.c[1][0];
        struct TM tran = GenerateTranslationMatrix1(xnow - translate[1][0], ynow - translate[1][1]);
        t2 = MultiplyMatrices1(t2, tran);
        tranPoint = ApplyMatrixToPoint1(0, 0, t2);
        translate[1][0] = tranPoint.c[0][0];
        translate[1][1] = tranPoint.c[1][0];
    }
    else if (selector == 2) {
        tranPoint = ApplyMatrixToPoint1(0, 0, t3);
        translate[2][0] = (int)tranPoint.c[0][0];
        translate[2][1] = (int)tranPoint.c[1][0];
        struct TM tran = GenerateTranslationMatrix1(xnow - translate[2][0], ynow - translate[2][1]);
        t3 = MultiplyMatrices1(t3, tran);
        tranPoint = ApplyMatrixToPoint1(0, 0, t3);
        translate[2][0] = tranPoint.c[0][0];
        translate[2][1] = tranPoint.c[1][0];
    }
    else if (selector == 3) {
        tranPoint = ApplyMatrixToPoint1(0, 0, t4);
        translate[3][0] = tranPoint.c[0][0];
        translate[3][1] = tranPoint.c[1][0];
        struct TM tran = GenerateTranslationMatrix1(xnow - translate[3][0], ynow - translate[3][1]);
        t4 = MultiplyMatrices1(t4, tran);
        tranPoint = ApplyMatrixToPoint1(0, 0, t4);
        translate[3][0] = tranPoint.c[0][0];
        translate[3][1] = tranPoint.c[1][0];
    }
}
@catch (NSException *e) {
    
}
    [self.view setNeedsDisplay];
}

- (IBAction)handleRotation:(UIGestureRecognizer *)sender {
    float rot = [(UIRotationGestureRecognizer *)sender rotation];
    rot = rot * (180/M_PI);
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (selector == 0) {
            memrot = rotate[0];
        }
        else if (selector == 1) {
            memrot = rotate[1];
        }
        else if (selector == 2) {
            memrot = rotate[2];
        }
        else if (selector == 3) {
            memrot = rotate[3];
        }
    }
    if (selector == 0) {
        r1 = GenerateRotationMatrix1(memrot + rot);
        rotate[0] = memrot + rot;
    }
    else if (selector == 1) {
        r2 = GenerateRotationMatrix1(memrot + rot);
        rotate[1] = memrot + rot;
    }
    else if (selector == 2) {
        r3 = GenerateRotationMatrix1(memrot + rot);
        rotate[2] = memrot + rot;
    }
    else if (selector == 3) {
        r4 = GenerateRotationMatrix1(memrot + rot);
        rotate[3] = memrot + rot;
    }
    [self.view setNeedsDisplay];
}

struct TM GenerateTranslationMatrix1(double x, double y) {
    struct TM output;
    output.t[0][0] = 1;
    output.t[1][0] = 0;
    output.t[2][0] = 0;
    output.t[0][1] = 0;
    output.t[1][1] = 1;
    output.t[2][1] = 0;
    output.t[0][2] = x;
    output.t[1][2] = y;
    output.t[2][2] = 1;
    return output;
}
struct TM GenerateScalingMatrix1(double scale) {
    struct TM output;
    output.t[0][0] = scale;
    output.t[1][0] = 0;
    output.t[2][0] = 0;
    output.t[0][1] = 0;
    output.t[1][1] = scale;
    output.t[2][1] = 0;
    output.t[0][2] = 0;
    output.t[1][2] = 0;
    output.t[2][2] = 1;
    return output;
}
struct TM GenerateRotationMatrix1(double angle) {
    struct TM output;
    output.t[0][0] = cos(angle * (M_PI / 180));
    output.t[1][0] = sin(angle * (M_PI / 180));
    output.t[2][0] = 0;
    output.t[0][1] = -1 * sin(angle * (M_PI / 180));
    output.t[1][1] = cos(angle * (M_PI / 180));
    output.t[2][1] = 0;
    output.t[0][2] = 0;
    output.t[1][2] = 0;
    output.t[2][2] = 1;
    return output;
}
double calculatedistance1 (int seg, double t[3][3], int xtouch, int ytouch) {
    double distance = 0;
    @try {
        int x = t[seg][0];
        int y = (t[seg][1]);
        distance = sqrt(((x - xtouch) * (x - xtouch)) + ((y - (ytouch)) * (y - (ytouch))));
    }
    @catch (NSException *e) {
        
    }
    return distance;
}
struct TM CreateBasicMatrix1() {
    struct TM output;
    output.t [0][0] = 1;
    output.t [0][1] = 0;
    output.t [0][2] = 0;
    output.t [1][0] = 0;
    output.t [1][1] = 1;
    output.t [1][2] = 0;
    output.t [2][0] = 0;
    output.t [2][1] = 0;
    output.t [2][2] = 1;
    return output;
}

struct HC ApplyMatrixToPoint1(int x, int y, struct TM Transform) {
    struct HC Output;
    Output.c[0][0] = (Transform.t[0][0] * x) + (Transform.t[0][1] * y) + (Transform.t[0][2] * 1);
    Output.c[1][0] = (Transform.t[1][0] * x) + (Transform.t[1][1] * y) + (Transform.t[1][2] * 1);
    Output.c[2][0] = 1;
    return Output;
}

struct TM MultiplyMatrices1(struct TM M1, struct TM M2) {
    struct TM output;
    output.t[0][0] = M1.t[0][0] * M2.t[0][0] + M1.t[0][1] * M2.t[1][0] + M1.t[0][2] * M2.t[2][0];
    output.t[1][0] = M1.t[1][0] * M2.t[0][0] + M1.t[1][1] * M2.t[1][0] + M1.t[1][2] * M2.t[2][0];
    output.t[2][0] = M1.t[2][0] * M2.t[0][0] + M1.t[2][1] * M2.t[1][0] + M1.t[2][2] * M2.t[2][0];
    output.t[0][1] = M1.t[0][0] * M2.t[0][1] + M1.t[0][1] * M2.t[1][1] + M1.t[0][2] * M2.t[2][1];
    output.t[1][1] = M1.t[1][0] * M2.t[0][1] + M1.t[1][1] * M2.t[1][1] + M1.t[1][2] * M2.t[2][1];
    output.t[2][1] = M1.t[2][0] * M2.t[0][1] + M1.t[2][1] * M2.t[1][1] + M1.t[2][2] * M2.t[2][1];
    output.t[0][2] = M1.t[0][0] * M2.t[0][2] + M1.t[0][1] * M2.t[1][2] + M1.t[0][2] * M2.t[2][2];
    output.t[1][2] = M1.t[1][0] * M2.t[0][2] + M1.t[1][1] * M2.t[1][2] + M1.t[1][2] * M2.t[2][2];
    output.t[2][2] = M1.t[2][0] * M2.t[0][2] + M1.t[2][1] * M2.t[1][2] + M1.t[2][2] * M2.t[2][2];
    return output;
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
        shape = 2;
        vertices = 3;
    }
    else if (row == 1) {
    shape = 0;
        vertices = 4;
    }
    else if (row == 2) {
        shape = 3;
        vertices = 2;
    }
    else if (row == 3) {
        shape = 1;
        vertices = 2;
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

- (IBAction)Click:(id)sender {
    selecter = selector;
    if (show == 0) {
        menu.center = CGPointMake(cx, 1176 - stop);
        button.center = CGPointMake(cx, 990 -stop);
        [UIView beginAnimations:@"ToggleViews" context:nil];
        [UIView setAnimationDuration:0.3];
        
        // Make the animatable changes.
        menu.center = CGPointMake(cx, menu.center.y);
        menu.center = CGPointMake(cx, 846.5 - stop);
        button.center = CGPointMake(cx, 703 - stop);
        
        // Commit the changes and perform the animation.
        [UIView commitAnimations];
        show = 1;
    }
    else {
        menu.center = CGPointMake(cx, 846.5 -stop);
        button.center = CGPointMake(cx, 703 - stop);
        [UIView beginAnimations:@"ToggleViews" context:nil];
        [UIView setAnimationDuration:0.3];
        
        // Make the animatable changes.
        menu.center = CGPointMake(cx, menu.center.y);
        menu.center = CGPointMake(cx, 1176 - stop);
        button.center = CGPointMake(cx, 928 -stop);
        
        // Commit the changes and perform the animation.
        [UIView commitAnimations];
        show = 0;
    }
    selector = selecter;
    [self.view setNeedsDisplay];
}

- (IBAction)AddElement:(id)sender {
    if (gens != 4) {
        gens = gens + 1;
    }
    if (g1 != 1) {
        g1 = 1;
        t1 = GenerateTranslationMatrix1((cx) - 100, (cy) - 100);
        translate [0][0] = (cx) - 100;
        translate [0][1] = (cy) - 100;
        scale[0] = 1;
        s1 = CreateBasicMatrix1();
        r1 = CreateBasicMatrix1();
        rotate[0] = 0;
    }
    else if (g2 != 1) {
        g2 = 1;
        t2 = GenerateTranslationMatrix1((cx) + 100, (cy) - 100);
        translate [1][0] = (cx) + 100;
        translate [1][1] = (cy) - 100;
        scale[1] = 1;
        s2 = CreateBasicMatrix1();
        r2 = CreateBasicMatrix1();
        rotate[1] = 0;
    }
    else if (g3 != 1) {
        g3 = 1;
        t3 = GenerateTranslationMatrix1((cx) + 100, (cy) + 100);
        translate [2][0] = (cx) + 100;
        translate [2][1] = (cy) + 100;
        scale[2] = 1;
        s3 = CreateBasicMatrix1();
        r3 = CreateBasicMatrix1();
        rotate[2] = 0;
    }
    else if (g4 != 1) {
        g4 = 1;
        t4 = GenerateTranslationMatrix1((cx) - 100, (cy) + 100);
        translate [3][0] = (cx) - 100;
        translate [3][1] = (cy) + 100;
        scale[3] = 1;
        s4 = CreateBasicMatrix1();
        r4 = CreateBasicMatrix1();
        rotate[3] = 0;
    }
    [[self view] setNeedsDisplay];
}

- (IBAction)DeleteElement:(id)sender {
    if (selector == 0) {
        if (g1 == 1) {
            g1 = 0;
            gens = gens - 1;
            [[self view] setNeedsDisplay];
        }
    }
    else if (selector == 1) {
        if (g2 == 1) {
            g2 = 0;
            gens = gens - 1;
            [[self view] setNeedsDisplay];
        }
    }
    else if (selector == 2) {
        if (g3 == 1) {
            g3 = 0;
            gens = gens - 1;
            [[self view] setNeedsDisplay];
        }
    }
    else if (selector == 3) {
        if (g4 == 1) {
            g4 = 0;
            gens = gens - 1;
            [[self view] setNeedsDisplay];
        }
    }
}

- (IBAction)PreviewOnOFf:(id)sender {
    if ([Switch isOn]) {
    preview = 1;
    }
    else {
        preview = 0;
    }
    [[self view]setNeedsDisplay];
}

- (IBAction)ResetAll:(id)sender {
    if (selector == 0) {
        t1 = GenerateTranslationMatrix1((cx) - 100, (cy) - 100);
        translate [0][0] = (cx) - 100;
        translate [0][1] = (cy) - 100;
        s1 = CreateBasicMatrix1();
        r1 = CreateBasicMatrix1();
    }
    else if (selector == 1) {
        t2 = GenerateTranslationMatrix1((cx) + 100, (cy) - 100);
        translate [1][0] = (cx) + 100;
        translate [1][1] = (cy) - 100;
        s2 = CreateBasicMatrix1();
        r2 = CreateBasicMatrix1();
    }
    else if (selector == 2) {
        t3 = GenerateTranslationMatrix1((cx) + 100, (cy) + 100);
        translate [2][0] = (cx) + 100;
        translate [2][1] = (cy) + 100;
         s3 = CreateBasicMatrix1();
        r3 = CreateBasicMatrix1();

    }
    else if (selector == 3) {
        t4 = GenerateTranslationMatrix1((cx) - 100, (cy) + 100);
        
        
        
        translate [3][0] = (cx) - 100;
        translate [3][1] = (cy) + 100;
        
        s4 = CreateBasicMatrix1();
        r4 = CreateBasicMatrix1();
    }
    
       
    [[self view]setNeedsDisplay];
}

- (IBAction)T:(id)sender {
    Input.placeholder = @"Translate X";
    Input2.placeholder = @"Translate Y";
    Inputer.hidden = NO;
    Input2.hidden = NO;
    Inputer.center = CGPointMake(Inputer.center.x, -82);
    [UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:0.3];
    
    // Make the animatable changes.
    Inputer.center = CGPointMake(Inputer.center.x, Inputer.center.y);
    Inputer.center = CGPointMake(Inputer.center.x, 396);
    
    // Commit the changes and perform the animation.
    [UIView commitAnimations];

}

- (IBAction)OK:(id)sender {
    Inputer.hidden = YES;
    [Values addObject:[[Input.text stringByAppendingString:@"|"] stringByAppendingString:Input2.text]];
    selector = selecter;
    if (TransformType == 1) {
        //[Sequence addObject:@"T"];
        struct HC tranPoint;
        if (selector == 0){
            struct TM tran = GenerateTranslationMatrix1([Input.text floatValue], [Input2.text floatValue]);
            t1 = MultiplyMatrices1(t1, tran);
            tranPoint = ApplyMatrixToPoint1(0, 0, t1);
            translate[0][0] = tranPoint.c[0][0];
            translate[0][1] = tranPoint.c[1][0];
        }
        else if (selector == 1) {
            struct TM tran = GenerateTranslationMatrix1([Input.text floatValue], [Input2.text floatValue]);
            t2 = MultiplyMatrices1(t2, tran);
            tranPoint = ApplyMatrixToPoint1(0, 0, t2);
            translate[1][0] = tranPoint.c[0][0];
            translate[1][1] = tranPoint.c[1][0];
        }
        else if (selector == 2) {
            struct TM tran = GenerateTranslationMatrix1([Input.text floatValue], [Input2.text floatValue]);
            t3 = MultiplyMatrices1(t3, tran);
            tranPoint = ApplyMatrixToPoint1(0, 0, t3);
            translate[2][0] = tranPoint.c[0][0];
            translate[2][1] = tranPoint.c[1][0];
        }
        else if (selector == 3) {
            struct TM tran = GenerateTranslationMatrix1([Input.text floatValue], [Input2.text floatValue]);
            t4 = MultiplyMatrices1(t4, tran);
            tranPoint = ApplyMatrixToPoint1(0, 0, t4);
            translate[3][0] = tranPoint.c[0][0];
            translate[3][1] = tranPoint.c[1][0];
        }
        [self.view setNeedsDisplay];
    }
    else if (TransformType == 2) {
        float rot = [Input.text floatValue];
        rot = rot * (180/M_PI);
        if (selector == 0) {
            r1 = GenerateRotationMatrix1(rot);
            rotate[0] = rot;
        }
        else if (selector == 1) {
            r2 = GenerateRotationMatrix1(rot);
            rotate[1] = rot;
        }
        else if (selector == 2) {
            r3 = GenerateRotationMatrix1(rot);
            rotate[2] = rot;
        }
        else if (selector == 3) {
            r4 = GenerateRotationMatrix1(rot);
            rotate[3] = rot;
        }
        [self.view setNeedsDisplay];
    }
    else if (TransformType == 3) {
        if (selector == 0) {
            scale[0] = [Input.text doubleValue];
            s1 = GenerateScalingMatrix1(scale[0]);
        }
        else if (selector == 1) {
            scale[1] = [Input.text doubleValue];
            s2 = GenerateScalingMatrix1(scale[1]);
        }
        else if (selector == 2) {
            scale[2] = [Input.text doubleValue];
            s3 = GenerateScalingMatrix1(scale[2]);
        }
        else if (selector == 3) {
            scale[3] = [Input.text doubleValue];
            s4 = GenerateScalingMatrix1(scale[3]);
        }
        [self.view setNeedsDisplay];
    }
}

- (IBAction)Cancel:(id)sender {
    Inputer.hidden = YES;
    Input.text = nil;
}

- (IBAction)ChooseShape:(id)sender {
    if (shapes == 0) {
    Shapes.center = CGPointMake(Shapes.center.x, -86);
    [UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:0.3];
    
    // Make the animatable changes.
    Shapes.center = CGPointMake(Shapes.center.x, Shapes.center.y);
    Shapes.center = CGPointMake(Shapes.center.x, 184);
    
    // Commit the changes and perform the animation.
    [UIView commitAnimations];
    shapes = 1;
    }
    else if (shapes == 1) {
        Shapes.center = CGPointMake(Shapes.center.x, 184);
        [UIView beginAnimations:@"ToggleViews" context:nil];
        [UIView setAnimationDuration:0.3];
        
        // Make the animatable changes.
        Shapes.center = CGPointMake(Shapes.center.x, Shapes.center.y);
        Shapes.center = CGPointMake(Shapes.center.x, -86);
        
        // Commit the changes and perform the animation.
        [UIView commitAnimations];
        shapes = 0;
    }
        
}

- (IBAction)Square:(id)sender {
    shape = 0;
    vertices = 4;
    Shapes.center = CGPointMake(Shapes.center.x, 184);
    [UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:0.3];
    
    // Make the animatable changes.
    Shapes.center = CGPointMake(Shapes.center.x, Shapes.center.y);
    Shapes.center = CGPointMake(Shapes.center.x, -86);
    
    // Commit the changes and perform the animation.
    [UIView commitAnimations];
    shapes = 0;
}

- (IBAction)Triangle:(id)sender {
    shape = 2;
    vertices = 3;
    Shapes.center = CGPointMake(Shapes.center.x, 184);
    [UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:0.3];
    
    // Make the animatable changes.
    Shapes.center = CGPointMake(Shapes.center.x, Shapes.center.y);
    Shapes.center = CGPointMake(Shapes.center.x, -86);
    
    // Commit the changes and perform the animation.
    [UIView commitAnimations];
    shapes = 0;
}

- (IBAction)Line:(id)sender {
    shape = 3;
    vertices = 2;
    Shapes.center = CGPointMake(Shapes.center.x, 184);
    [UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:0.3];
    
    // Make the animatable changes.
    Shapes.center = CGPointMake(Shapes.center.x, Shapes.center.y);
    Shapes.center = CGPointMake(Shapes.center.x, -86);
    
    // Commit the changes and perform the animation.
    [UIView commitAnimations];
    shapes = 0;
}

- (IBAction)Bar:(id)sender {
    shape = 1;
    vertices = 2;
    Shapes.center = CGPointMake(Shapes.center.x, 184);
    [UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:0.3];
    
    // Make the animatable changes.
    Shapes.center = CGPointMake(Shapes.center.x, Shapes.center.y);
    Shapes.center = CGPointMake(Shapes.center.x, -86);
    
    // Commit the changes and perform the animation.
    [UIView commitAnimations];
    shapes = 0;
}

- (IBAction)R:(id)sender {
    Input.placeholder = @"Rotation (In Degrees)";
    Inputer.hidden = NO;
    Input2.hidden = YES;
    Inputer.center = CGPointMake(Inputer.center.x, -82);
    [UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:0.3];
    
    // Make the animatable changes.
    Inputer.center = CGPointMake(Inputer.center.x, Inputer.center.y);
    Inputer.center = CGPointMake(Inputer.center.x, 396);
    
    // Commit the changes and perform the animation.
    [UIView commitAnimations];
}

- (IBAction)S:(id)sender {
    Input.placeholder = @"Scale (Decimal Value)";
    Inputer.hidden = NO;
    Input2.hidden = YES;
    Inputer.center = CGPointMake(Inputer.center.x, -82);
    [UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:0.3];
    
    // Make the animatable changes.
    Inputer.center = CGPointMake(Inputer.center.x, Inputer.center.y);
    Inputer.center = CGPointMake(Inputer.center.x, 396);
    
    // Commit the changes and perform the animation.
    [UIView commitAnimations];
}

- (IBAction)RemoveTransform:(id)sender {
    [Values removeLastObject];
    [Sequence removeLastObject];
}

- (IBAction)ClearTransforms:(id)sender {
    [Values removeAllObjects];
    [Sequence removeAllObjects];
}

- (IBAction)AxesOn:(id)sender {
    if (AxesOn.on) {
        axes = 1;
        [[self view]setNeedsDisplay];
    }
    else {
        axes = 0;
        [[self view]setNeedsDisplay];
    }
}

- (IBAction)GuidesOn:(id)sender {
    if (GuidesOn.on) {
        guides = 1;
        [[self view]setNeedsDisplay];
        
    }
    else {
        guides = 0;
        [[self view]setNeedsDisplay];
    }
}

- (IBAction)GridOn:(id)sender {
    if (GridOn.on) {
        grid = 1;
        [[self view]setNeedsDisplay];
    }
    else {
        grid = 0;
        [[self view]setNeedsDisplay];
    }
}

- (IBAction)Trans1:(id)sender {
    selecter = selector;
    TransformType = 1;
    Input.placeholder = @"Translate X";
    Input2.placeholder = @"Translate Y";
    Inputer.hidden = NO;
    Input2.hidden = NO;
    Inputer.center = CGPointMake(Inputer.center.x, -82);
    [UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:0.3];

    // Make the animatable changes.
    Inputer.center = CGPointMake(Inputer.center.x, Inputer.center.y);
    Inputer.center = CGPointMake(Inputer.center.x, 396);
    
    // Commit the changes and perform the animation.
    [UIView commitAnimations];
    selector = selecter;
    [self.view setNeedsDisplay];
}

- (IBAction)Rota1:(id)sender {
    selecter = selector;
    TransformType = 2;
    Input.placeholder = @"Rotation (In Degrees)";
    Inputer.hidden = NO;
    Input2.hidden = YES;
    Inputer.center = CGPointMake(Inputer.center.x, -82);
    [UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:0.3];
    
    // Make the animatable changes.
    Inputer.center = CGPointMake(Inputer.center.x, Inputer.center.y);
    Inputer.center = CGPointMake(Inputer.center.x, 396);
    
    // Commit the changes and perform the animation.
    [UIView commitAnimations];
    selector = selecter;
    [self.view setNeedsDisplay];
}

- (IBAction)Scal1:(id)sender {
    selecter = selector;
    TransformType = 3;
    Input.placeholder = @"Scale (Decimal Value)";
    Inputer.hidden = NO;
    Input2.hidden = YES;
    Inputer.center = CGPointMake(Inputer.center.x, -82);
    [UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:0.3];
    
    // Make the animatable changes.
    Inputer.center = CGPointMake(Inputer.center.x, Inputer.center.y);
    Inputer.center = CGPointMake(Inputer.center.x, 396);
    
    // Commit the changes and perform the animation.
    [UIView commitAnimations];
    selector = selecter;
    [self.view setNeedsDisplay];
}

@end
