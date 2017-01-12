//
//  ViewController.m
//  Facebook Login
//
//  Created by specter on 12/1/17.
//
//

#import "ViewController.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    
    // Add a custom login button to your app
    UIButton *myLoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    myLoginButton.backgroundColor=[UIColor darkGrayColor];
    myLoginButton.frame=CGRectMake(100,100,180,40);
//    myLoginButton.center = self.view.center;
    [myLoginButton setTitle: @"My Login Button" forState: UIControlStateNormal];
    
    // Handle clicks on the button
    [myLoginButton
     addTarget:self
     action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // Add the button to the view
    [self.view addSubview:myLoginButton];
    
    // FB自带的button
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.delegate = self;
    loginButton.readPermissions = @[@"public_profile",@"email",@"user_about_me"];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];

}

// Once the button is clicked, show the login dialog
-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             NSLog(@"%@",[FBSDKAccessToken currentAccessToken].appID);
             NSLog(@"%@",[FBSDKAccessToken currentAccessToken].userID);
             FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                           
                                           initWithGraphPath:result.token.userID
                                           
                                           parameters:@{@"fields": @"id,name,email"}
                                           
                                           HTTPMethod:@"GET"];
             
             [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result,NSError *error) {
                 
                 // Handle the result
                 
                 NSLog(@"%@,%@,%@",result[@"id"],result[@"name"],result[@"email"]);
                 
             }];
         }
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error
{
    if (error) {
        NSLog(@"Process error");
    } else if (result.isCancelled) {
        NSLog(@"Cancelled");
    } else {
        NSLog(@"Logged in");
    }

}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    
}
@end
