//
//  ViewController.m
//  Glo
//
//  Created by Purnima Singh on 16/03/18.
//

#import "ViewController.h"
#import "PageContentViewController.h"
#import "GLHomeViewController.h"

@interface ViewController () <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageImages;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _pageImages = @[@"IOS-02.png", @"IOS-03.png", @"IOS-04.png", @"IOS-05.png", @"IOS-06.png", @"IOS-07.png"];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    
    [self.skipTutorial setTextColor:[UIColor whiteColor]];
    [self.beginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view bringSubviewToFront:self.skipTutorial];
    [self.view bringSubviewToFront:self.beginButton];
    
    self.skipTutorial.userInteractionEnabled = true;
    UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openHomePage)];
    labelTap.numberOfTapsRequired = 1;
    [self.skipTutorial addGestureRecognizer:labelTap];
    
    self.beginButton.hidden = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    [self ButtonView:index];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    [self ButtonView:index];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    
    index++;
    if (index == [self.pageImages count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageImages count] == 0) || (index >= [self.pageImages count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}



- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

-(void)ButtonView:(NSUInteger)index {
    if (index == [self.pageImages count] - 1) {
        
        self.beginButton.alpha = 0.0;
        self.skipTutorial.alpha = 1.0;
        
        self.beginButton.hidden = NO;
        self.skipTutorial.hidden = YES;
        
        //fade in
        [UIView animateWithDuration:1.5f animations:^{
            
            [_beginButton setAlpha:1.0f];
            
        } completion:^(BOOL finished) {
            
            //fade out
            [UIView animateWithDuration:1.5f animations:^{
                
                [_skipTutorial setAlpha:0.0f];
                
            } completion:nil];
            
        }];
    }
    else {
        
        self.skipTutorial.alpha = 1.0;
        self.beginButton.hidden = YES;
        self.skipTutorial.hidden = NO;
        
        
    }
}

- (IBAction)beginButtonClick:(id)sender {
    [self openHomePage];
}

-(void)openHomePage {
    
    [self performSegueWithIdentifier:@"homePage" sender:self];
//    GLHomeViewController *homepage = [self.storyboard instantiateViewControllerWithIdentifier:@"GLHomeViewController"];
//    [self.navigationController pushViewController:homepage animated:YES];
}
@end
