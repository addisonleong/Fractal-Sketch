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
    IBOutlet UIView *Inputer;
    IBOutlet UITextField *Input;
    IBOutlet UIView *Shapes;
    IBOutlet UITextField *Input2;
    IBOutlet UISwitch *AxesOn;
    IBOutlet UISwitch *GuidesOn;
    IBOutlet UISwitch *GridOn;
    int shapes;
    IBOutlet UIView *menu;
    IBOutlet UIButton *button;
    IBOutlet UILabel *Matrix;
    IBOutlet UITextField *rota1;
    IBOutlet UITextField *scal1;
}
- (IBAction)Click:(id)sender;
- (IBAction)AddElement:(id)sender;
- (IBAction)DeleteElement:(id)sender;
- (IBAction)PreviewOnOFf:(id)sender;
- (IBAction)ResetAll:(id)sender;
- (IBAction)T:(id)sender;
- (IBAction)OK:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)ChooseShape:(id)sender;
- (IBAction)Square:(id)sender;
- (IBAction)Triangle:(id)sender;
- (IBAction)Line:(id)sender;
- (IBAction)Bar:(id)sender;
- (IBAction)R:(id)sender;
- (IBAction)S:(id)sender;
- (IBAction)RemoveTransform:(id)sender;
- (IBAction)ClearTransforms:(id)sender;
- (IBAction)AxesOn:(id)sender;
- (IBAction)GuidesOn:(id)sender;
- (IBAction)GridOn:(id)sender;
- (IBAction)Trans1:(id)sender;
- (IBAction)Rota1:(id)sender;
- (IBAction)Scal1:(id)sender;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
