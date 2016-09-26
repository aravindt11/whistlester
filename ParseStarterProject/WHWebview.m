//
//  UIView+WHWebview.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 10/5/14.
//
//

#import "WHWebview.h"

@interface WHWebview ()



@end



@implementation WHWebview

-(void)viewDidLoad
{
    
    NSString *urlAddress = @"http://whistle-ster.com/TermsofUse.htm";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.privacy loadRequest:requestObj];

    
}

@end
