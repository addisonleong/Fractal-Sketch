//
//  Fractal_SketchAppDelegate.h
//  Fractal Sketch
//
//  Created by Addison Leong on 5/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
struct TM {
    double t[3][3];
};
struct HC {
    double c[3][1];
};
double scale[4];
double rotate[4];
int translate[4][2];
double C[3][3];
int selector;
int gens;
int g1, g2, g3, g4;
struct TM t1;
struct TM t2;
struct TM t3;
struct TM t4;
int xl1, yl1, xl2, yl2, xl3, yl3, xl4, yl4, xl5, yl5;
struct TM s1;
struct TM s2;
struct TM s3;
struct TM s4;
struct TM r1;
struct TM r2;
struct TM r3;
struct TM r4;
struct HC outputcoord;
struct TM outputmatrix;
int my, mx, arrows;
int preview, pan, steps, vertices, shape, panx, pany, dragx, dragy, startvalue;
double zoom;
NSMutableArray *xs;
NSMutableArray *ys;
int flip;
int colortyper;
int colortype, iterations;
int show;
NSMutableArray *xs;
NSMutableArray *ys;
NSMutableArray *R;
NSMutableArray *G;
NSMutableArray *B;
float cx, cy;
int designtype;
NSMutableArray *Sequence;
NSMutableArray *Values;
int axes;
int guides;
int grid;
NSMutableString *trans;
@interface Fractal_SketchAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    IBOutlet UIImageView *imageView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
