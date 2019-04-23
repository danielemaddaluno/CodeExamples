//
//  UYLWebViewController.m
//  Restorer
//
// Created by Keith Harrison http://useyourloaf.com
// Copyright (c) 2013 Keith Harrison. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//
// Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
//
// Neither the name of Keith Harrison nor the names of its contributors
// may be used to endorse or promote products derived from this software
// without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <WebKit/WebKit.h>
#import "UYLWebViewController.h"

@interface UYLWebViewController () <UIViewControllerRestoration>
@property (strong, nonatomic) IBOutlet WKWebView *webView;
@end

@implementation UYLWebViewController

static NSString *UYLKeyURL = @"UYLKeyURL";

#pragma mark -
#pragma mark === View Life Cycle Management ===
#pragma mark -

- (void)setUrlString:(NSString *)urlString {
    if (_urlString != urlString) {
        _urlString = [urlString copy];
        [self loadPage];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadPage];
}

- (void)loadPage
{
    NSURL *URL = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
}

#pragma mark -
#pragma mark === State Restoration ===
#pragma mark -

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.urlString forKey:UYLKeyURL];
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super decodeRestorableStateWithCoder:coder];
    self.urlString = [coder decodeObjectForKey:UYLKeyURL];
}

#pragma mark -
#pragma mark === UIViewControllerRestoration Protocol ===
#pragma mark -

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    UIViewController *viewController = [[UYLWebViewController alloc] initWithNibName:@"UYLWebViewController" bundle:nil];
    viewController.restorationIdentifier = [identifierComponents lastObject];
    viewController.restorationClass = [UYLWebViewController class];
    return viewController;
}

@end
