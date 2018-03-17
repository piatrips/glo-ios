//
//  PageContentViewController.h
//  Glo
//
//  Created by Purnima Singh on 16/03/18.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property NSUInteger pageIndex;
@property NSString *imageFile;

@property (weak, nonatomic) IBOutlet UIImageView *tutorialImageView;

@end
