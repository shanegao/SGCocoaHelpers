//
//  SGCocoaHelpersDemoTests.m
//  SGCocoaHelpersDemoTests
//
//  Created by Shane Gao on 8/6/13.
//  Copyright (c) 2013 touchmob.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Helpers.h"

@interface SGCocoaHelpersDemoTests : XCTestCase

@end

@implementation SGCocoaHelpersDemoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSString *hello = [@"hello" md5String];
    
    XCTAssertNotNil(hello, @"");
}

@end
