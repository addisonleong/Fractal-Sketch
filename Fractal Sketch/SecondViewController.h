//
//  SecondViewController.h
//  Fractal Sketch
//
//  Created by Addison Leong on 5/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecondViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UIPickerView *pickerView;
    IBOutlet UISlider *slider;
    IBOutlet UIButton *zoomin;
    IBOutlet UIButton *zoomout;
    IBOutlet UIButton *pane;
    IBOutlet UIButton *center;
    IBOutlet UIButton *save;
    IBOutlet UILabel *slidin;
    IBOutlet UIButton *button;
    NSMutableArray *arrayNames;
    IBOutlet UIView *menus;
    int menu;
}
- (IBAction)Menu:(id)sender;
- (IBAction)InZoom:(id)sender;
- (IBAction)OutZoom:(id)sender;
- (IBAction)Pan:(id)sender;
- (IBAction)Center:(id)sender;
- (IBAction)Save:(id)sender;
- (IBAction)Iter:(id)sender;
- (IBAction)PanImage:(id)sender;
- (IBAction)ZoomImage:(id)sender;
- (IBAction)LevelUp:(id)sender;
- (IBAction)LevelDown:(id)sender;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
