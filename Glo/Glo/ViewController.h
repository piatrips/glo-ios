//
//  ViewController.h
//  Glo
//
//  Created by Purnima Singh on 16/03/18.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *skipTutorial;
@property (weak, nonatomic) IBOutlet UIButton *beginButton;
- (IBAction)beginButtonClick:(id)sender;

@end

