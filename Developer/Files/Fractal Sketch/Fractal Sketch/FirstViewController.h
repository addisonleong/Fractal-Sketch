//
//  FirstViewController.h
//  Fractal Sketch
//
//  Created by Addison Leong on 5/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UIPickerView *pickerView;
    IBOutlet UIButton *Plus;
    IBOutlet UIButton *Subtract;
    IBOutlet UIButton *reset;
    IBOutlet UISwitch *Switch;
    IBOutlet UILabel *Preview;
    NSMutableArray *arrayNames;
    IBOutlet UIView *Popup;
    
}
- (IBAction)Click:(id)sender;
- (IBAction)AddElement:(id)sender;
- (IBAction)DeleteElement:(id)sender;
- (IBAction)PreviewOnOFf:(id)sender;
- (IBAction)ResetAll:(id)sender;
- (IBAction)T:(id)sender;
- (IBAction)R:(id)sender;
- (IBAction)S:(id)sender;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
