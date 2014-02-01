//
//  AppListVC.m
//  LessAD
//
//  Created by xhan on 10/26/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import "AppListVC.h"
#import "LessAD.h"
#import "PLAlertView.h"


@implementation AppListVC
{
    NSMutableArray*array;
    NSBundle*_selectedBundle;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    array = [NSMutableArray arrayWithContentsOfFile:PLIST_APPS];
//    array = [NSMutableArray arrayWithContentsOfFile:@"/Users/less/Codes/ios/jailbreak/LessAD/com.xhan.LessAD.app.plist"];
    for (int i = array.count-1; i>=0; i--) {
        NSDictionary*item = [array objectAtIndex:i];
        if( [[item objectForKey:KEY_APP_IDENTIFY] isEqualToString:[NSBundle mainBundle].bundleIdentifier] )
            [array removeObjectAtIndex:i];
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"appcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSBundle* bundle =[self bundleAtIndexPath:indexPath];
    NSDictionary* info = [bundle infoDictionary];
    
    NSString*iconPath = [bundle pathForResource:[[info objectForKey:@"CFBundleIconFiles"] lastObject]
                                         ofType:nil];
    cell.imageView.image = [[UIImage alloc] initWithContentsOfFile:iconPath];
    cell.textLabel.text = [info objectForKey:@"CFBundleDisplayName"];
    
    return cell;
}

- (NSBundle*)bundleAtIndexPath:(NSIndexPath*)path
{
    NSDictionary* info = [array objectAtIndex:array.count - path.row - 1];
    NSBundle*bundle = [NSBundle bundleWithPath:[info objectForKey:KEY_APP_BUNDLE_PATH]];
    return bundle;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedBundle =[self bundleAtIndexPath:indexPath];
    NSString*appname  = [[_selectedBundle infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString*identify = _selectedBundle.bundleIdentifier;
    if (appname && identify) {
        PLAlert([NSString stringWithFormat:@"举报 %@ 有广告条",appname],
                @"请添加该软件有广告存在页面的截图( 按下Home+电源键截图)，并告诉我如何操作能重现广告", @"手贱点错", @"添加截图", ^(int i,BOOL c){
                    if (!c) {
                        UIImagePickerController*controller = [[UIImagePickerController alloc] init];
                        controller.delegate = self;
                        [self presentViewController:controller animated:YES completion:nil];
                    }

                });
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage*img = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self sendMail:img];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
- (void)sendMail:(UIImage*)img
{
    NSDictionary*info = [_selectedBundle infoDictionary];
    NSString*appname  = [info objectForKey:@"CFBundleDisplayName"];
    NSString*sversion = [info objectForKey:@"CFBundleShortVersionString"];
    NSString*identify = _selectedBundle.bundleIdentifier;
    
    MFMailComposeViewController*mailC = [[MFMailComposeViewController alloc] init];
    mailC.mailComposeDelegate = self;
    [mailC setSubject:[NSString stringWithFormat:@"<LessAD举报>%@(%@)",appname,sversion]];
    [mailC setToRecipients:@[kXhanMail]];
    [mailC setMessageBody:[NSString stringWithFormat:
                          @"重现步骤：\n\n"
                           "软件信息：\n"
                           "[%@ %@ %@]"
                           ,appname,identify,sversion
                         ]
                   isHTML:NO];
    NSData*attach = UIImageJPEGRepresentation(img, 0.6);
    [mailC addAttachmentData:attach mimeType:@"image/jpeg" fileName:[NSString stringWithFormat:@"%@_%@",appname,sversion]];
    [self presentViewController:mailC animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (error) {
        PLAlert(@"error", [error localizedDescription], nil, @"明白", nil);
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
