//
//  Editor.m
//  Fractal Sketch
//
//  Created by Addison Leong on 5/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Editor.h"

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
void drawMe(CGContextRef context);
void axis(CGContextRef context);
void paintGUI4(struct TM t, struct TM s, struct TM r, int seg, CGContextRef context);
extern struct HC ApplyMatrixToPoint(int x, int y, struct TM Transform);
extern struct TM GenerateTranslationMatrix(double x, double y);
extern struct TM GenerateScalingMatrix(double scale);
extern struct TM MultiplyMatrices(struct TM M1, struct TM M2);
extern struct TM GenerateRotationMatrix(double angle);
struct TM outputer;
void paintGUI3(struct TM t, struct TM s, struct TM r, int seg, CGContextRef context);
void paintGUI2(struct TM t, struct TM s, struct TM r, int seg, CGContextRef context);
void paintGUI1(struct TM t, struct TM s, struct TM r, int seg, CGContextRef context);
void GUI1 (CGContextRef context);
float xtest;
float ytest;
CGPoint fromPoint;
CGPoint toPoint;
NSMutableArray *createPointSetC2(int step, int vertices);
NSMutableArray *initialListC2 (int step);
NSMutableArray *initialListC1 (int step);
NSMutableArray *createPointSetC1(int step, int vertices);
float s = 1;
BOOL g11, g12, g13, g14;
int gesture = 0;
float memd;
int gesturetype (float d1, float d3);
float scalesaver;
float rotationsaver;
float yfirst, xfirst;
extern struct TM CreateBasicMatrix();
extern float cx, cy;
extern NSMutableArray *xs;
extern NSMutableArray *ys;
extern NSMutableArray *R;
extern NSMutableArray *G;
extern NSMutableArray *B;
struct TM M1;
struct TM M2;
struct TM M3;
struct TM M4;
void createFractalSet31(int step, int vertices);
extern void drawFractal (CGContextRef context, NSMutableArray *cyx, NSMutableArray *cxy);
void RGB1(int generator);
int sel;
@implementation Editor



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        translate [0][0] = 100;
        translate [0][1] = 100;
        translate [1][0] = 300;
        translate [1][1] = 100;
        scale[0] = 1;
        scale[1] = 1;
        scale[2] = 1;
        scale[3] = 1;
        t1 = GenerateTranslationMatrix(100, 100);
        t2 = GenerateTranslationMatrix(300, 100);
        t3 = GenerateTranslationMatrix(100, 300);
        t4 = GenerateTranslationMatrix(300, 300);
        translate [0][0] = 100;
        translate [0][1] = 100;
        translate [1][0] = 300;
        translate [1][1] = 100;
        translate [2][0] = 100;
        translate [2][1] = 300;
        translate [3][0] = 300;
        translate [3][1] = 300;
        shape = 0;
        s1 = CreateBasicMatrix();
        s2 = CreateBasicMatrix();
        r1 = CreateBasicMatrix();
        r2 = CreateBasicMatrix();
        s3 = CreateBasicMatrix();
        s4 = CreateBasicMatrix();
        r3 = CreateBasicMatrix();
        r4 = CreateBasicMatrix();
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
        [self setNeedsDisplay];
    }
    return self;
}

struct HC ApplyMatrixToPoint(int x, int y, struct TM Transform) {
    struct HC Output;
    Output.c[0][0] = (Transform.t[0][0] * x) + (Transform.t[0][1] * y) + (Transform.t[0][2] * 1);
    Output.c[1][0] = (Transform.t[1][0] * x) + (Transform.t[1][1] * y) + (Transform.t[1][2] * 1);
    Output.c[2][0] = 1;
    return Output;
}
struct TM MultiplyMatrices(struct TM M1, struct TM M2) {
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
struct TM GenerateTranslationMatrix(double x, double y) {
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
struct TM GenerateScalingMatrix(double scale) {
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
struct TM GenerateRotationMatrix(double angle) {
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
double calculatedistance (int seg, double t[3][3], int xtouch, int ytouch) {
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
struct TM CreateBasicMatrix() {
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

- (void)drawRect:(CGRect)rect {
    CGContextRef    context = UIGraphicsGetCurrentContext();
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        [self setNeedsLayout];
        cx = self.frame.size.width/2;
        cy = self.frame.size.height/2;
    }
    else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight){
        [self setNeedsLayout];
        cy = self.frame.size.height/2;
        cx = self.frame.size.width/2;
    }
    axis(context);
    GUI1(context);
}

float distance(float x1, float y1, int gen) {
    float dist = sqrt(pow((x1 - translate[gen][0]), 2) + pow((y1 - translate[gen][1]), 2));
    return dist;
}

int gesturetype (float d1, float d3) {
    int gtyper;
    if (d1 <= (d3 + 2) && d1 >= (d3 - 2)) {
        gtyper = 2;
    }
    else {
        gtyper = 1;
    }
    return gtyper;
}

void createMasterMatrices() {
    M1 = MultiplyMatrices(MultiplyMatrices(r1, s1), MultiplyMatrices(t1, GenerateTranslationMatrix((-1 * (cx)), (-1 * (cy)))));
    M2 = MultiplyMatrices(MultiplyMatrices(r2, s2), MultiplyMatrices(t2, GenerateTranslationMatrix((-1 * (cx)), (-1 * (cy)))));
    M3 = MultiplyMatrices(MultiplyMatrices(r3, s3), MultiplyMatrices(t3, GenerateTranslationMatrix((-1 * (cx)), (-1 * (cy)))));
    M4 = MultiplyMatrices(MultiplyMatrices(r4, s4), MultiplyMatrices(t4, GenerateTranslationMatrix((-1 * (cx)), (-1 * (cy)))));
}

//Create Fractals
void createFractalSet31(int step, int vertices) {
    struct HC pt;
    [xs removeAllObjects];
    [ys removeAllObjects];
    xs = [[NSMutableArray alloc]init];
    ys = [[NSMutableArray alloc]init];
    [xs addObject:[NSNumber numberWithInt:-100]];
    [xs addObject:[NSNumber numberWithInt:100]];
    [xs addObject:[NSNumber numberWithInt:100]];
    [xs addObject:[NSNumber numberWithInt:-100 ]];
    [ys addObject:[NSNumber numberWithInt:100]];
    [ys addObject:[NSNumber numberWithInt:100]];
    [ys addObject:[NSNumber numberWithInt:-100 ]];
    [ys addObject:[NSNumber numberWithInt:-100 ]];
    [R removeAllObjects];
    [B removeAllObjects];
    [G removeAllObjects];
    int p = 0;
    createMasterMatrices();
    for (int i = 0; i != step + 1; i++) {
        if (g1 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M1);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(1);
            }
        }
        if (g2 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M2);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(2);
            }
        }
        if (g3 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M3);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(3);
            }
        }
        if (g4 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M4);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(4);
            }
        }
        startvalue = p;
        p = (int)(vertices * pow(gens, i)) + p;
    }
}
void createFractalSet32(int step, int vertices) {
    struct HC pt;
    [xs removeAllObjects];
    [ys removeAllObjects];
    xs = [[NSMutableArray alloc]init];
    ys = [[NSMutableArray alloc]init];
    [xs addObject:[NSNumber numberWithInt:0]];
    [xs addObject:[NSNumber numberWithInt:0]];
    [ys addObject:[NSNumber numberWithInt:-100]];
    [ys addObject:[NSNumber numberWithInt:100]];
    [R removeAllObjects];
    [B removeAllObjects];
    [G removeAllObjects];
    int p = 0;
    createMasterMatrices();
    for (int i = 0; i != step + 1; i++) {
        if (g1 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M1);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(1);
            }
        }
        if (g2 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M2);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(2);
            }
        }
        if (g3 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M3);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(3);
            }
        }
        if (g4 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M4);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(4);
            }
        }
        startvalue = p;
        p = (int)(vertices * pow(gens, i)) + p;
    }
}
void createFractalSet33(int step, int vertices) {
    struct HC pt;
    [xs removeAllObjects];
    [ys removeAllObjects];
    xs = [[NSMutableArray alloc]init];
    ys = [[NSMutableArray alloc]init];
    [xs addObject:[NSNumber numberWithInt:-100]];
    [xs addObject:[NSNumber numberWithInt:100]];
    [xs addObject:[NSNumber numberWithInt:0]];
    [ys addObject:[NSNumber numberWithInt:(sqrt(3) * 100) / -2]];
    [ys addObject:[NSNumber numberWithInt:(sqrt(3) * 100) / -2]];
    [ys addObject:[NSNumber numberWithInt:(sqrt(3) * 100) / 2]];
    [R removeAllObjects];
    [B removeAllObjects];
    [G removeAllObjects];
    int p = 0;
    createMasterMatrices();
    for (int i = 0; i != step + 1; i++) {
        if (g1 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M1);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(1);
            }
        }
        if (g2 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M2);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(2);
            }
        }
        if (g3 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M3);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(3);
            }
        }
        if (g4 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M4);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(4);
            }
        }
        startvalue = p;
        p = (int)(vertices * pow(gens, i)) + p;
    }
    
}
void createFractalSet34(int step, int vertices) {
    struct HC pt;
    [xs removeAllObjects];
    [ys removeAllObjects];
    xs = [[NSMutableArray alloc]init];
    ys = [[NSMutableArray alloc]init];
    [xs addObject:[NSNumber numberWithInt:-100]];
    [xs addObject:[NSNumber numberWithInt:100]];
    [ys addObject:[NSNumber numberWithInt:0]];
    [ys addObject:[NSNumber numberWithInt:0]];
    [R removeAllObjects];
    [B removeAllObjects];
    [G removeAllObjects];
    int p = 0;
    createMasterMatrices();
    for (int i = 0; i != step + 1; i++) {
        if (g1 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M1);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(1);
            }
        }
        if (g2 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M2);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(2);
            }
        }
        if (g3 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M3);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(3);
            }
        }
        if (g4 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], M4);
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB1(4);
            }
        }
        startvalue = p;
        p = (int)(vertices * pow(gens, i)) + p;
    }
}
void drawFractal (CGContextRef context, NSMutableArray *cyx, NSMutableArray *cxy) {
    if (gens > 1) {
    CGContextSetLineWidth(context,1);
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor]CGColor]);
        for (int a = ((int)(pow(gens, steps)) * vertices) + startvalue; a != [xs count]; a++) {
            CGContextMoveToPoint(context, [[xs objectAtIndex:([[cyx objectAtIndex:a]intValue])]intValue] + cx, [[ys objectAtIndex:([[cyx objectAtIndex:a]intValue])]intValue] + cy);
            CGContextAddLineToPoint(context, [[xs objectAtIndex:([[cxy objectAtIndex:a]intValue])]intValue] + cx, [[ys objectAtIndex:([[cxy objectAtIndex:a]intValue])]intValue] + cy);
            CGContextStrokePath(context);
            CGContextSaveGState(context);
        }
    }
}
void RGB1(int generator) {
    if (generator == 1) {
        [R addObject:[NSNumber numberWithInt:0]];
        [G addObject:[NSNumber numberWithInt:0]];
         [B addObject:[NSNumber numberWithInt:1]];
    }
    else if (generator == 2) {
        [R addObject:[NSNumber numberWithInt:0]];
        [G addObject:[NSNumber numberWithInt:1]];
        [B addObject:[NSNumber numberWithInt:0]];
    }
    else if (generator == 3) {
        [R addObject:[NSNumber numberWithInt:1]];
        [G addObject:[NSNumber numberWithInt:0]];
        [B addObject:[NSNumber numberWithInt:0]];
    }
    else if (generator == 4) {
        [R addObject:[NSNumber numberWithFloat:1]];
        [G addObject:[NSNumber numberWithFloat:0.96]];
        [B addObject:[NSNumber numberWithFloat:0.93]];
    }
}
void axis(CGContextRef context) {
    int w1 = cx;
    int h1 = cy;
    CGContextSetLineWidth(context,1);
    CGContextSetStrokeColorWithColor(context, [[UIColor grayColor]CGColor]);
    CGContextMoveToPoint(context, w1, 0);
    CGContextAddLineToPoint(context, w1, h1 * 2);
    CGContextMoveToPoint(context, 0, h1);
    CGContextAddLineToPoint(context, w1 * 2, h1);
    CGContextSaveGState(context);
    CGContextStrokePath(context);
}
void paintGUI4(struct TM t, struct TM s, struct TM r, int seg, CGContextRef context) {
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [[UIColor grayColor]CGColor]);
    CGContextSaveGState(context);
    if (seg == selector) {
        CGContextSetStrokeColorWithColor(context, [[UIColor blueColor]CGColor]);
    }
    else {
        CGContextSetStrokeColorWithColor(context, [[UIColor blackColor]CGColor]);
    }
    int points[3][2];
    int points2[3][2];
    struct HC tranPoint;
    struct TM t11;
    t11 = MultiplyMatrices(t, s);
    struct TM temp;
    temp = GenerateTranslationMatrix(-1*translate[seg][0], -1*translate[seg][1]);
    t11 = MultiplyMatrices(temp, t11);
    t11 = MultiplyMatrices(t11, r);
    temp = GenerateTranslationMatrix(1*translate[seg][0], 1*translate[seg][1]);
    t11 = MultiplyMatrices(temp, t11);
    points[0][0] = -100;
    points[0][1] = 0;
    points[1][0] = 100;
    points[1][1] = 0;
    tranPoint = ApplyMatrixToPoint(points[0][0], points[0][1], t11);
    points2 [0][0] = (int)(tranPoint.c[0][0]);
    points2 [0][1] = (int)(tranPoint.c[1][0]);
    tranPoint = ApplyMatrixToPoint(points[1][0], points[1][1], t11);
    points2 [1][0] = (int)(tranPoint.c[0][0]);
    points2 [1][1] = (int)(tranPoint.c[1][0]);
    xl1 = points2[0][0];
    yl1 = points2[0][1];
    xl2 = points2[1][0];
    yl2 = points2[1][1];
    CGContextMoveToPoint(context, xl1, yl1);
    CGContextAddLineToPoint(context, xl2, yl2);
    CGContextStrokePath(context);
}
void paintGUI3(struct TM t, struct TM s, struct TM r, int seg, CGContextRef context) {
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [[UIColor grayColor]CGColor]);
    CGContextSaveGState(context);
    if (seg == selector) {
        CGContextSetStrokeColorWithColor(context, [[UIColor blueColor]CGColor]);
    }
    else {
        CGContextSetStrokeColorWithColor(context, [[UIColor blackColor]CGColor]);
    }
    int points[3][2];
    int points2[3][2];
    struct HC tranPoint;
    struct TM t11;
    t11 = MultiplyMatrices(t, s);
    struct TM temp;
    temp = GenerateTranslationMatrix(-1*translate[seg][0], -1*translate[seg][1]);
    t11 = MultiplyMatrices(temp, t11);
    t11 = MultiplyMatrices(t11, r);
    temp = GenerateTranslationMatrix(1*translate[seg][0], 1*translate[seg][1]);
    t11 = MultiplyMatrices(temp, t11);
    points[0][0] = - 100;
    points[0][1] = (int)(-1 * (sqrt(3) * 100) /2);
    points[1][0] = 100;
    points[1][1] = (int)(-1 * (sqrt(3) * 100) /2);
    points[2][0] = 0;
    points[2][1] = (int)(1 * (sqrt(3) * 100) /2);
    tranPoint = ApplyMatrixToPoint(points[0][0], points[0][1], t11);
    points2 [0][0] = (int)(tranPoint.c[0][0]);
    points2 [0][1] = (int)(tranPoint.c[1][0]);
    tranPoint = ApplyMatrixToPoint(points[1][0], points[1][1], t11);
    points2 [1][0] = (int)(tranPoint.c[0][0]);
    points2 [1][1] = (int)(tranPoint.c[1][0]);
    tranPoint = ApplyMatrixToPoint(points[2][0], points[2][1], t11);
    points2 [2][0] = (int)(tranPoint.c[0][0]);
    points2 [2][1] = (int)(tranPoint.c[1][0]);
    xl1 = points2[0][0];
    yl1 = points2[0][1];
    xl2 = points2[1][0];
    yl2 = points2[1][1];
    xl3 = points2[2][0];
    yl3 = points2[2][1];
    CGContextMoveToPoint(context, xl1, yl1);
    CGContextAddLineToPoint(context, xl2, yl2);
    CGContextMoveToPoint(context, xl2, yl2);
    CGContextAddLineToPoint(context, xl3, yl3);
    CGContextMoveToPoint(context, xl3, yl3);
    CGContextAddLineToPoint(context, xl1, yl1);
    CGContextStrokePath(context);
    CGContextSaveGState(context);
}
void paintGUI2(struct TM t, struct TM s, struct TM r, int seg, CGContextRef context) {
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [[UIColor grayColor]CGColor]);
    CGContextSaveGState(context);
    if (seg == selector) {
        CGContextSetStrokeColorWithColor(context, [[UIColor blueColor]CGColor]);
    }
    else {
        CGContextSetStrokeColorWithColor(context, [[UIColor blackColor]CGColor]);
    }
    int points[3][2];
    int points2[3][2];
    struct HC tranPoint;
    struct TM t11;
    t11 = MultiplyMatrices(t, s);
    struct TM temp;
    temp = GenerateTranslationMatrix(-1*translate[seg][0], -1*translate[seg][1]);
    t11 = MultiplyMatrices(temp, t11);
    t11 = MultiplyMatrices(t11, r);
    temp = GenerateTranslationMatrix(1*translate[seg][0], 1*translate[seg][1]);
    t11 = MultiplyMatrices(temp, t11);
    points[0][0] = 0;
    points[0][1] = -100;
    points[1][0] = 0;
    points[1][1] = 100;
    tranPoint = ApplyMatrixToPoint(points[0][0], points[0][1], t11);
    points2 [0][0] = (int)(tranPoint.c[0][0]);
    points2 [0][1] = (int)(tranPoint.c[1][0]);
    tranPoint = ApplyMatrixToPoint(points[1][0], points[1][1], t11);
    points2 [1][0] = (int)(tranPoint.c[0][0]);
    points2 [1][1] = (int)(tranPoint.c[1][0]);
    xl1 = points2[0][0];
    yl1 = points2[0][1];
    xl2 = points2[1][0];
    yl2 = points2[1][1];
    CGContextMoveToPoint(context, xl1, yl1);
    CGContextAddLineToPoint(context, xl2, yl2);
    CGContextStrokePath(context);
    CGContextSaveGState(context);

}
void paintGUI1(struct TM t, struct TM s, struct TM r, int seg, CGContextRef context) {
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [[UIColor grayColor]CGColor]);
    CGContextSaveGState(context);
    if (seg == selector) {
        CGContextSetStrokeColorWithColor(context, [[UIColor blueColor]CGColor]);
    }
    else {
        CGContextSetStrokeColorWithColor(context, [[UIColor blackColor]CGColor]);
    }
    int points[3][2];
    int points2[3][2];
    struct HC tranPoint;
    struct TM t11;
    t11 = MultiplyMatrices(t, s);
    struct TM temp;
    temp = GenerateTranslationMatrix(-1*translate[seg][0], -1*translate[seg][1]);
    t11 = MultiplyMatrices(temp, t11);
    t11 = MultiplyMatrices(t11, r);
    temp = GenerateTranslationMatrix(1*translate[seg][0], 1*translate[seg][1]);
    t11 = MultiplyMatrices(temp, t11);
    points[0][0] = - 100;
    points[0][1] = -100;
    points[1][0] = -100;
    points[1][1] = 100;
    points[2][0] = 100;
    points[2][1] = 100;
    points[3][0] = 100;
    points[3][1] = -100;
    tranPoint = ApplyMatrixToPoint(points[0][0], points[0][1], t11);
    points2 [0][0] = (int)(tranPoint.c[0][0]);
    points2 [0][1] = (int)(tranPoint.c[1][0]);
    tranPoint = ApplyMatrixToPoint(points[1][0], points[1][1], t11);
    points2 [1][0] = (int)(tranPoint.c[0][0]);
    points2 [1][1] = (int)(tranPoint.c[1][0]);
    tranPoint = ApplyMatrixToPoint(points[2][0], points[2][1], t11);
    points2 [2][0] = (int)(tranPoint.c[0][0]);
    points2 [2][1] = (int)(tranPoint.c[1][0]);
    tranPoint = ApplyMatrixToPoint(points[3][0], points[3][1], t11);
    points2 [3][0] = (int)(tranPoint.c[0][0]);
    points2 [3][1] = (int)(tranPoint.c[1][0]);
    xl1 = points2[0][0];
    yl1 = points2[0][1];
    xl2 = points2[1][0];
    yl2 = points2[1][1];
    xl3 = points2[2][0];
    yl3 = points2[2][1];
    xl4 = points2[3][0];
    yl4 = points2[3][1];
    CGContextMoveToPoint(context, xl1, yl1);
    CGContextAddLineToPoint(context, xl2, yl2);
    CGContextMoveToPoint(context, xl2, yl2);
    CGContextAddLineToPoint(context, xl3, yl3);
    CGContextMoveToPoint(context, xl3, yl3);
    CGContextAddLineToPoint(context, xl4, yl4);
    CGContextMoveToPoint(context, xl4, yl4);
    CGContextAddLineToPoint(context, xl1, yl1);
    CGContextStrokePath(context);
    CGContextSaveGState(context);
}

NSMutableArray *initialListC1 (int step) {
    NSMutableArray *i = [[NSMutableArray alloc]init];
    if (shape == 0) {
        [i addObject:[NSNumber numberWithInt:0]];
        [i addObject:[NSNumber numberWithInt:1]];
        [i addObject:[NSNumber numberWithInt:2]];
        [i addObject:[NSNumber numberWithInt:3]];
    }
    else if (shape == 1) {
        [i addObject:[NSNumber numberWithInt:0]];
        [i addObject:[NSNumber numberWithInt:1]];
    }
    else if (shape == 2) {
        [i addObject:[NSNumber numberWithInt:0]];
        [i addObject:[NSNumber numberWithInt:1]];
        [i addObject:[NSNumber numberWithInt:2]];
    }
    else if (shape == 3) {
        [i addObject:[NSNumber numberWithInt:0]];
        [i addObject:[NSNumber numberWithInt:1]];
    }
    return i;
}
NSMutableArray *createPointSetC1(int step, int vertices) {
    NSMutableArray *points = initialListC1(step);
    int prevItem;
    for (int i = 0; i != ((int)(pow(gens, (step + 1)) * vertices) * 2); i++) {
        prevItem = [[points objectAtIndex:(i)]intValue];
        [points addObject:[NSNumber numberWithFloat:(prevItem + vertices)]];
    }
    return points;
}
NSMutableArray *initialListC2 (int step) {
    NSMutableArray *i = [[NSMutableArray alloc]init];
    if (shape == 0) {
        [i addObject:[NSNumber numberWithInt:1]];
        [i addObject:[NSNumber numberWithInt:2]];
        [i addObject:[NSNumber numberWithInt:3]];
        [i addObject:[NSNumber numberWithInt:0]];
    }
    else if (shape == 1) {
        [i addObject:[NSNumber numberWithInt:1]];
        [i addObject:[NSNumber numberWithInt:0]];
    }
    else if (shape == 2) {
        [i addObject:[NSNumber numberWithInt:1]];
        [i addObject:[NSNumber numberWithInt:2]];
        [i addObject:[NSNumber numberWithInt:0]];
    }
    else if (shape == 3) {
        [i addObject:[NSNumber numberWithInt:1]];
        [i addObject:[NSNumber numberWithInt:0]];
    }
    return i;
}

NSMutableArray *createPointSetC2(int step, int vertices) {
    NSMutableArray *points = initialListC2(step);
    int prevItem;
    for (int i = 0; i != ((int)(pow(gens, (step + 1)) * vertices) * 2); i++) {
        prevItem = [[points objectAtIndex:(i)]intValue];
        [points addObject:[NSNumber numberWithFloat:(prevItem + vertices)]];
    }
    return points;
}

void GUI1 (CGContextRef context) {
    steps = 3;
    if (shape == 0) {
        if (g1 == 1) {
            paintGUI1(t1, s1, r1, 0, context);
        }
        if (g2 == 1) {
            paintGUI1(t2, s2, r2, 1, context);
        }
        if (g3 == 1) {
            paintGUI1(t3, s3, r3, 2, context);
        }
        if (g4 == 1) {
            paintGUI1(t4, s4, r4, 3, context);
        }
    }
    else if (shape == 1) {
        if (g1 == 1) {
            paintGUI2(t1, s1, r1, 0, context);
        }
        if (g2 == 1) {
            paintGUI2(t2, s2, r2, 1, context);
        }
        if (g3 == 1) {
            paintGUI2(t3, s3, r3, 2, context);
        }
        if (g4 == 1) {
            paintGUI2(t4, s4, r4, 3, context);
        }
    }
    else if (shape == 2) {
        if (g1 == 1) {
            paintGUI3(t1, s1, r1, 0, context);
        }
        if (g2 == 1) {
            paintGUI3(t2, s2, r2, 1, context);
        }
        if (g3 == 1) {
            paintGUI3(t3, s3, r3, 2, context);
        }
        if (g4 == 1) {
            paintGUI3(t4, s4, r4, 3, context);
        }
    }
    else if (shape == 3) {
        if (g1 == 1) {
            paintGUI4(t1, s1, r1, 0, context);
        }
        if (g2 == 1) {
            paintGUI4(t2, s2, r2, 1, context);
        }
        if (g3 == 1) {
            paintGUI4(t3, s3, r3, 2, context);
        }
        if (g4 == 1) {
            paintGUI4(t4, s4, r4, 3, context);
        }
    }
    if (preview == 1) {
        if (shape == 0) {
            NSMutableArray *c1 = createPointSetC1(3, 4);
            NSMutableArray *c2 = createPointSetC2(3, 4);
            createFractalSet31(3, 4);
            drawFractal(context, c1, c2);
        }
        else if (shape == 1) {
            NSMutableArray *c1 = createPointSetC1(3, 2);
            NSMutableArray *c2 = createPointSetC2(3, 2);
            createFractalSet32(3, 2);
            drawFractal(context, c1, c2);
        }
        else if (shape == 2) {
            NSMutableArray *c1 = createPointSetC1(3, 3);
            NSMutableArray *c2 = createPointSetC2(3, 3);
            createFractalSet33(3, 3);
            drawFractal(context, c1, c2);
        }
        else if (shape == 3) {
            NSMutableArray *c1 = createPointSetC1(3, 2);
            NSMutableArray *c2 = createPointSetC2(3, 2);
            createFractalSet34(3, 2);
            drawFractal(context, c1, c2);
        }
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

@end
