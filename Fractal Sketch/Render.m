//
//  Render.m
//  Fractal Sketch
//
//  Created by Addison Leong on 6/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Render.h"

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
extern struct HC ApplyMatrixToPoint2(int x, int y, struct TM Transform);
extern struct TM GenerateTranslationMatrix2(double x, double y);
extern struct TM GenerateScalingMatrix2(double scale);
extern struct TM MultiplyMatrices2(struct TM M1, struct TM M2);
extern struct TM GenerateRotationMatrix2(double angle);
struct TM outputer;
void paintGUI3(struct TM t, struct TM s, struct TM r, int seg, CGContextRef context);
void paintGUI2(struct TM t, struct TM s, struct TM r, int seg, CGContextRef context);
void paintGUI1(struct TM t, struct TM s, struct TM r, int seg, CGContextRef context);
void GUI1 (CGContextRef context);
float xtest;
float ytest;
CGPoint fromPoint;
CGPoint toPoint;
NSMutableArray *createPointSetC21(int step, int vertices);
NSMutableArray *initialListC21 (int step);
NSMutableArray *initialListC11 (int step);
NSMutableArray *createPointSetC11(int step, int vertices);
extern BOOL g11, g12, g13, g14;
extern struct TM CreateBasicMatrix2();
extern float cx, cy;
extern NSMutableArray *xs;
extern NSMutableArray *ys;
extern NSMutableArray *R;
extern NSMutableArray *G;
extern NSMutableArray *B;
void createFractalSet311(int step, int vertices);
void createFractalSet321(int step, int vertices);
void createFractalSet331(int step, int vertices);
void createFractalSet341(int step, int vertices);
void drawFractal1 (CGContextRef context, NSMutableArray *cyx, NSMutableArray *cxy);
float xinit, yinit;
struct TM M1;
struct TM M2;
struct TM M3;
struct TM M4;
void DrawFractalMain(CGContextRef context, NSMutableArray *cyx, NSMutableArray *cxy);
void RGB10(int generator);
@implementation Render

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//Create Fractals
void createMasterMatrices2() {
    M1 = MultiplyMatrices2(MultiplyMatrices2(r1, s1), MultiplyMatrices2(t1, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
    M2 = MultiplyMatrices2(MultiplyMatrices2(r2, s2), MultiplyMatrices2(t2, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
    M3 = MultiplyMatrices2(MultiplyMatrices2(r3, s3), MultiplyMatrices2(t3, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
    M4 = MultiplyMatrices2(MultiplyMatrices2(r4, s4), MultiplyMatrices2(t4, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
}
void createFractalSet311(int step, int vertices) {
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
    R = [[NSMutableArray alloc]init];
    G = [[NSMutableArray alloc]init];
    B = [[NSMutableArray alloc]init];
    [R addObject:[NSNumber numberWithFloat:1]];
    [G addObject:[NSNumber numberWithFloat:0]];
    [B addObject:[NSNumber numberWithFloat:0]];
    [R addObject:[NSNumber numberWithFloat:1]];
    [G addObject:[NSNumber numberWithFloat:0]];
    [B addObject:[NSNumber numberWithFloat:0]];
    [R addObject:[NSNumber numberWithFloat:1]];
    [G addObject:[NSNumber numberWithFloat:0]];
    [B addObject:[NSNumber numberWithFloat:0]];
    [R addObject:[NSNumber numberWithFloat:1]];
    [G addObject:[NSNumber numberWithFloat:0]];
    [B addObject:[NSNumber numberWithFloat:0]];
    int p = 0;
    createMasterMatrices2();
    for (int i = 0; i != step + 1; i++) {
        if (g1 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r1);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s1);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t1, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(1);
            }
        }
        if (g2 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r2);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s2);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t2, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(2);
            }
        }
        if (g3 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r3);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s3);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t3, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(3);
            }
        }
        if (g4 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r4);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s4);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t4, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(4);
            }
        }
        startvalue = p;
        p = (int)(vertices * pow(gens, i)) + p;
    }
}
void createFractalSet321(int step, int vertices) {
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
    R = [[NSMutableArray alloc]init];
    G = [[NSMutableArray alloc]init];
    B = [[NSMutableArray alloc]init];
    [R addObject:[NSNumber numberWithFloat:1]];
    [G addObject:[NSNumber numberWithFloat:0]];
    [B addObject:[NSNumber numberWithFloat:0]];
    [R addObject:[NSNumber numberWithFloat:1]];
    [G addObject:[NSNumber numberWithFloat:0]];
    [B addObject:[NSNumber numberWithFloat:0]];
    int p = 0;
    createMasterMatrices2();
    for (int i = 0; i != step + 1; i++) {
        if (g1 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r1);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s1);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t1, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(1);
            }
        }
        if (g2 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r2);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s2);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t2, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(2);
            }
        }
        if (g3 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r3);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s3);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t3, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(3);
            }
        }
        if (g4 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r4);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s4);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t4, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(4);
            }
        }
        startvalue = p;
        p = (int)(vertices * pow(gens, i)) + p;
    }
}
void createFractalSet331(int step, int vertices) {
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
    R = [[NSMutableArray alloc]init];
    G = [[NSMutableArray alloc]init];
    B = [[NSMutableArray alloc]init];
    [R addObject:[NSNumber numberWithFloat:1]];
    [G addObject:[NSNumber numberWithFloat:0]];
    [B addObject:[NSNumber numberWithFloat:0]];
    [R addObject:[NSNumber numberWithFloat:1]];
    [G addObject:[NSNumber numberWithFloat:0]];
    [B addObject:[NSNumber numberWithFloat:0]];
    [R addObject:[NSNumber numberWithFloat:1]];
    [G addObject:[NSNumber numberWithFloat:0]];
    [B addObject:[NSNumber numberWithFloat:0]];
    int p = 0;
    createMasterMatrices2();
    for (int i = 0; i != step + 1; i++) {
        if (g1 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r1);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s1);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t1, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(1);
            }
        }
        if (g2 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r2);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s2);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t2, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(2);
            }
        }
        if (g3 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r3);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s3);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t3, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(3);
            }
        }
        if (g4 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r4);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s4);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t4, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(4);
            }
        }
        startvalue = p;
        p = (int)(vertices * pow(gens, i)) + p;
    }
    
}
void createFractalSet341(int step, int vertices) {
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
    R = [[NSMutableArray alloc]init];
    G = [[NSMutableArray alloc]init];
    B = [[NSMutableArray alloc]init];
    [R addObject:[NSNumber numberWithFloat:1]];
    [G addObject:[NSNumber numberWithFloat:0]];
    [B addObject:[NSNumber numberWithFloat:0]];
    [R addObject:[NSNumber numberWithFloat:1]];
    [G addObject:[NSNumber numberWithFloat:0]];
    [B addObject:[NSNumber numberWithFloat:0]];
    int p = 0;
    createMasterMatrices2();
    for (int i = 0; i != step + 1; i++) {
        if (g1 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r1);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s1);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t1, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(1);
            }
        }
        if (g2 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r2);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s2);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t2, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(2);
            }
        }
        if (g3 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r3);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s3);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t3, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(3);
            }
        }
        if (g4 == 1) {
            for (int a = p; a != p + pow(gens, i) * vertices; a++) {
                pt = ApplyMatrixToPoint2([[xs objectAtIndex:(a)]intValue], [[ys objectAtIndex:(a)]intValue], r4);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], s4);
                pt = ApplyMatrixToPoint2(pt.c[0][0], pt.c[1][0], MultiplyMatrices2(t4, GenerateTranslationMatrix2((-1 * (cx)), (-1 * (cy)))));
                NSNumber *xy = [NSNumber numberWithDouble:(pt.c[0][0])];
                NSNumber *yx = [NSNumber numberWithDouble:(pt.c[1][0])];
                [xs addObject:xy];
                [ys addObject:yx];
                RGB10(4);
            }
        }
        startvalue = p;
        p = (int)(vertices * pow(gens, i)) + p;
    }
}
void drawFractal1 (CGContextRef context, NSMutableArray *cyx, NSMutableArray *cxy) {
    if (gens > 1) {
        CGContextSetLineWidth(context,1);
        CGContextSetStrokeColorWithColor(context, [[UIColor blackColor]CGColor]);
        for (int a = ((int)(pow(gens, steps)) * vertices) + startvalue; a != [xs count]; a++) {
            CGContextMoveToPoint(context, ((([[xs objectAtIndex:([[cyx objectAtIndex:a]intValue])]intValue]))*zoom) + cx + panx, ((([[ys objectAtIndex:([[cyx objectAtIndex:a]intValue])]intValue]))*zoom) + cy + pany);
            CGContextAddLineToPoint(context, ((([[xs objectAtIndex:([[cxy objectAtIndex:a]intValue])]intValue]))*zoom) + cx + panx, ((([[ys objectAtIndex:([[cxy objectAtIndex:a]intValue])]intValue]))*zoom) + cy + pany);
            CGContextStrokePath(context);
            CGContextSaveGState(context);
        }
    }
}
void RenderColorFractal1 (CGContextRef context, NSMutableArray *cyx, NSMutableArray *cxy) {
    CGContextSetLineWidth(context,1);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor]CGColor]);
    CGRect rect = CGRectMake(0, 0, cx * 2, cy * 2);
    CGContextFillRect(context, rect);
    @try {
        for (int a = ((int)(pow(gens, steps)) * vertices) + startvalue; a != [xs count]; a++) {
            CGContextMoveToPoint(context, ((([[xs objectAtIndex:([[cyx objectAtIndex:a]intValue])]intValue]))*zoom) + cx + panx, ((([[ys objectAtIndex:([[cyx objectAtIndex:a]intValue])]intValue]))*zoom) + cy + pany);
            CGContextAddLineToPoint(context, ((([[xs objectAtIndex:([[cxy objectAtIndex:a]intValue])]intValue]))*zoom) + cx + panx, ((([[ys objectAtIndex:([[cxy objectAtIndex:a]intValue])]intValue]))*zoom) + cy + pany);
            CGContextStrokePath(context);
            CGContextSaveGState(context);
            int rand = arc4random();
            if (rand % 4 == 0) {
                CGContextSetStrokeColorWithColor(context, [[UIColor greenColor]CGColor]);
            }
            else if (rand % 6 == 0) {
                CGContextSetStrokeColorWithColor(context, [[UIColor redColor]CGColor]);
            }
            else if (rand % 5 == 0) {
                CGContextSetStrokeColorWithColor(context, [[UIColor blueColor]CGColor]);
            }
            else if (rand % 7 == 0) {
                CGContextSetStrokeColorWithColor(context, [[UIColor orangeColor]CGColor]);
            }
            else if (rand % 8 == 0) {
                CGContextSetStrokeColorWithColor(context, [[UIColor yellowColor]CGColor]);
            }
            else if (rand % 9 == 0) {
                CGContextSetStrokeColorWithColor(context, [[UIColor cyanColor]CGColor]);
            }
            else if (rand % 3 == 0) {
                CGContextSetStrokeColorWithColor(context, [[UIColor orangeColor]CGColor]);
            }
            else if (rand % 10 == 0) {
                CGContextSetStrokeColorWithColor(context, [[UIColor purpleColor]CGColor]);
            }
        }
    }
    @catch (NSException *e) {
        
    }
    
}
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    [self setNeedsDisplay];
}
//int gesture: "0" -> pan, "1" -> scale, "2" -> rotate
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    [self setNeedsDisplay];
}

void RenderColorFractal2 (CGContextRef context, NSMutableArray *cyx, NSMutableArray *cxy) {
    CGContextSetLineWidth(context,1);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor]CGColor]);
    CGRect rect = CGRectMake(0, 0, cx * 2, cy * 2);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [[UIColor blueColor]CGColor]);
    @try {
        for (int a = ((int)(pow(gens, steps)) * vertices) + startvalue; a != [xs count]; a++) {
            if (a < (((int)(pow(gens, steps)) * vertices) + startvalue) + (([xs count] - (((int)(pow(gens, steps)) * vertices) + startvalue)) / gens)) {
                CGContextSetStrokeColorWithColor(context, [[UIColor greenColor]CGColor]);
            }
            else if ((a >= (((int)(pow(gens, steps)) * vertices) + startvalue) + (([xs count] - (((int)(pow(gens, steps)) * vertices) + startvalue)) / gens)) && (a < (((int)(pow(gens, steps)) * vertices) + startvalue) + (([xs count] - (((int)(pow(gens, steps)) * vertices) + startvalue)) * 2 / gens))) {
                CGContextSetStrokeColorWithColor(context, [[UIColor redColor]CGColor]);
            }
            else if ((a >= (((int)(pow(gens, steps)) * vertices) + startvalue) + (([xs count] - (((int)(pow(gens, steps)) * vertices) + startvalue)) * 2 / gens)) && (a < (((int)(pow(gens, steps)) * vertices) + startvalue) + (([xs count] - (((int)(pow(gens, steps)) * vertices) + startvalue)) * 3 / gens))) {
                CGContextSetStrokeColorWithColor(context, [[UIColor blueColor]CGColor]);
            }
            else if ((a >= (((int)(pow(gens, steps)) * vertices) + startvalue) + (([xs count] - (((int)(pow(gens, steps)) * vertices) + startvalue)) * 3 / gens)) && (a < -1 + (((int)(pow(gens, steps)) * vertices) + startvalue) + (([xs count] - (((int)(pow(gens, steps)) * vertices) + startvalue)) * 4 / gens))) {
                CGContextSetStrokeColorWithColor(context, [[UIColor orangeColor]CGColor]);
            }
            CGContextMoveToPoint(context, ((([[xs objectAtIndex:([[cyx objectAtIndex:a]intValue])]intValue]))*zoom) + cx + panx, ((([[ys objectAtIndex:([[cyx objectAtIndex:a]intValue])]intValue]))*zoom) + cy + pany);
            CGContextAddLineToPoint(context, ((([[xs objectAtIndex:([[cxy objectAtIndex:a]intValue])]intValue]))*zoom) + cx + panx, ((([[ys objectAtIndex:([[cxy objectAtIndex:a]intValue])]intValue]))*zoom) + cy + pany);
            CGContextStrokePath(context);
            CGContextSaveGState(context);
        }
    }
    @catch (NSException *e) {
        
    }
    
}

void RenderColorFractal3 (CGContextRef context, NSMutableArray *cyx, NSMutableArray *cxy) {
    CGContextSetLineWidth(context,1);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor]CGColor]);
    CGRect rect = CGRectMake(0, 0, cx * 2, cy * 2);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [[UIColor blueColor]CGColor]);
    UIColor *color1 = NULL;
    @try {
        for (int a = ((int)(pow(gens, steps)) * vertices) + startvalue; a != [xs count]; a++) {
            if (a % 1 == 0) {
                color1 = [UIColor colorWithRed:0.0 green:0.0 blue:(1 * (sin(a * (M_PI/180)))) alpha:1];
            }
            CGContextSetStrokeColorWithColor(context, [color1 CGColor]);
            CGContextMoveToPoint(context, ((([[xs objectAtIndex:([[cyx objectAtIndex:a]intValue])]intValue]))*zoom) + cx + panx, ((([[ys objectAtIndex:([[cyx objectAtIndex:a]intValue])]intValue]))*zoom) + cy + pany);
            CGContextAddLineToPoint(context, ((([[xs objectAtIndex:([[cxy objectAtIndex:a]intValue])]intValue]))*zoom) + cx + panx, ((([[ys objectAtIndex:([[cxy objectAtIndex:a]intValue])]intValue]))*zoom) + cy + pany);
            CGContextStrokePath(context);
            CGContextSaveGState(context);
        }
    }
    @catch (NSException *e) {
        
    }
}

void RenderColorFractal4 (CGContextRef context, NSMutableArray *cyx, NSMutableArray *cxy) {
    CGContextSetLineWidth(context,1);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor]CGColor]);
    CGRect rect = CGRectMake(0, 0, cx * 2, cy * 2);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [[UIColor blueColor]CGColor]);
    UIColor *color1 = NULL;
    @try {
        for (int a = ((int)(pow(gens, steps)) * vertices) + startvalue; a != [xs count]; a++) {
            if (a % 1 == 0) {
                color1 = [UIColor colorWithRed:(( (1 * (cos(a * (M_PI/360)))))) green:(( (1 * (cos(a * (M_PI/180)))))) blue:(( (1 * (sin(a * (M_PI/180)))))) alpha:1];
            }
            CGContextSetStrokeColorWithColor(context, [color1 CGColor]);
            CGContextMoveToPoint(context, ((([[xs objectAtIndex:([[cyx objectAtIndex:a]intValue])]intValue]))*zoom) + cx + panx, ((([[ys objectAtIndex:([[cyx objectAtIndex:a]intValue])]intValue]))*zoom) + cy + pany);
            CGContextAddLineToPoint(context, ((([[xs objectAtIndex:([[cxy objectAtIndex:a]intValue])]intValue]))*zoom) + cx + panx, ((([[ys objectAtIndex:([[cxy objectAtIndex:a]intValue])]intValue]))*zoom) + cy + pany);
            CGContextStrokePath(context);
            CGContextSaveGState(context);
        }
    }
    @catch (NSException *e) {
        
    }
}

void RenderColorFractal5 (CGContextRef context, NSMutableArray *cyx, NSMutableArray *cxy) {
    CGContextSetLineWidth(context,1);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor]CGColor]);
    CGRect rect = CGRectMake(0, 0, cx * 2, cy * 2);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [[UIColor blueColor]CGColor]);
    UIColor *color1 = NULL;
    for (int a = 0; a != [xs count]; a++) {
        color1 = [UIColor colorWithRed:[[R objectAtIndex:a]floatValue] green:[[G objectAtIndex:a]floatValue] blue:[[B objectAtIndex:a]floatValue] alpha:1];
        CGContextSetStrokeColorWithColor(context, [color1 CGColor]);
        CGContextMoveToPoint(context, ((([[xs objectAtIndex:([[cyx objectAtIndex:a]intValue])]intValue]))*zoom) + cx + panx, ((([[ys objectAtIndex:([[cyx objectAtIndex:a]intValue])]intValue]))*zoom) + cy + pany);
        CGContextAddLineToPoint(context, ((([[xs objectAtIndex:([[cxy objectAtIndex:a]intValue])]intValue]))*zoom) + cx + panx, ((([[ys objectAtIndex:([[cxy objectAtIndex:a]intValue])]intValue]))*zoom) + cy + pany);
        CGContextStrokePath(context);
        CGContextSaveGState(context);
    }
}
- (void)drawRect:(CGRect)rect
{
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
    if (shape == 0) {
        NSMutableArray *c1 = createPointSetC11(steps, 4);
        NSMutableArray *c2 = createPointSetC21(steps, 4);
        createFractalSet311(steps, 4);
        DrawFractalMain(context, c1, c2);
    }
    else if (shape == 1) {
        NSMutableArray *c1 = createPointSetC11(steps, 2);
        NSMutableArray *c2 = createPointSetC21(steps, 2);
        createFractalSet321(steps, 2);
        DrawFractalMain(context, c1, c2);
    }
    else if (shape == 2) {
        NSMutableArray *c1 = createPointSetC11(steps, 3);
        NSMutableArray *c2 = createPointSetC21(steps, 3);
        createFractalSet331(steps, 3);
        DrawFractalMain(context, c1, c2);    }
    else if (shape == 3) {
        NSMutableArray *c1 = createPointSetC11(steps, 2);
        NSMutableArray *c2 = createPointSetC21(steps, 2);
        createFractalSet341(steps, 2);
        DrawFractalMain(context, c1, c2);    }
}
struct HC ApplyMatrixToPoint2(int x, int y, struct TM Transform) {
    struct HC Output;
    Output.c[0][0] = (Transform.t[0][0] * x) + (Transform.t[0][1] * y) + (Transform.t[0][2] * 1);
    Output.c[1][0] = (Transform.t[1][0] * x) + (Transform.t[1][1] * y) + (Transform.t[1][2] * 1);
    Output.c[2][0] = 1;
    return Output;
}
void RGB10(int generator) {
    if (generator == 1) {
        [R addObject:[NSNumber numberWithFloat:0]];
        [G addObject:[NSNumber numberWithFloat:0]];
        [B addObject:[NSNumber numberWithFloat:1]];
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
struct TM MultiplyMatrices2(struct TM M1, struct TM M2) {
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
void DrawFractalMain(CGContextRef context, NSMutableArray *cyx, NSMutableArray *cxy) {
    if (colortype == 0) {
        drawFractal1(context, cyx, cxy);
    }
    else if (colortype == 1) {
        RenderColorFractal1(context, cyx, cxy);
    }
    else if (colortype == 2) {
        RenderColorFractal2(context, cyx, cxy);
    }
    else if (colortype == 3) {
        RenderColorFractal3(context, cyx, cxy);
    }
    else if (colortype == 4) {
        RenderColorFractal4(context, cyx, cxy);
    }
    else if (colortype == 5) {
        RenderColorFractal5(context, cyx, cxy);
    }
}
struct TM GenerateTranslationMatrix2(double x, double y) {
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
struct TM GenerateScalingMatrix2(double scale) {
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
struct TM GenerateRotationMatrix2(double angle) {
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
struct TM CreateBasicMatrix2() {
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
NSMutableArray *initialListC11 (int step) {
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
NSMutableArray *createPointSetC11(int step, int vertices) {
    NSMutableArray *points = initialListC11(step);
    int prevItem;
    for (int i = 0; i != ((int)(pow(gens, (step + 1)) * vertices) * 2); i++) {
        prevItem = [[points objectAtIndex:(i)]intValue];
        [points addObject:[NSNumber numberWithFloat:(prevItem + vertices)]];
    }
    return points;
}
NSMutableArray *initialListC21 (int step) {
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

NSMutableArray *createPointSetC21(int step, int vertices) {
    NSMutableArray *points = initialListC21(step);
    int prevItem;
    for (int i = 0; i != ((int)(pow(gens, (step + 1)) * vertices) * 2); i++) {
        prevItem = [[points objectAtIndex:(i)]intValue];
        [points addObject:[NSNumber numberWithFloat:(prevItem + vertices)]];
    }
    return points;
}


- (void)dealloc
{
    [super dealloc];
}

@end
