//
//  RegisterTests.m
//  GroceryStoreSimulation
//
//  Created by Dan Brajkovic on 2/23/14.
//  Copyright (c) 2014 Dan Brajkovic. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Register.h"
#import "Customer.h"

@interface Register ()

@property (strong, nonatomic) NSMutableArray *mutableQueue;
@property (assign, nonatomic) NSInteger itemProcessTime;

@end

@interface RegisterTests : XCTestCase
{
    Register *cashRegister;
}

@end

@implementation RegisterTests

- (void)setUp
{
    [super setUp];
    cashRegister = [[Register alloc] init];
}

- (void)tearDown
{
    cashRegister = nil;
    [super tearDown];
}

- (void)testInit
{
    XCTAssertNotNil(cashRegister.customerQueue, @"Could not find instance of the customer queue.");
    XCTAssertEqual(cashRegister.itemProcessTime, (NSInteger)0, @"itemProcessTime should be '0' on init.");
}

- (void)testCustomerArrivedInQueue
{
    Customer *customer = [[Customer alloc] init];
    [cashRegister customerArrived:customer];
    XCTAssertEqualObjects(cashRegister.customerQueue.firstObject, customer, @"Customer not added to queue.");
}

- (void)testServiceCustomer_NonTrainee
{
    Customer *customer = [[Customer alloc] init];
    customer.numberOfUncheckedItems = 1;
    [cashRegister customerArrived:customer];
    [cashRegister serviceCustomer];
    XCTAssertEqual(customer.numberOfUncheckedItems, (NSInteger)0, @"Customer item not checked out.");
    XCTAssertEqual(cashRegister.customerQueue.count, (NSUInteger)0, @"Customer not removed from queue after last item checked.");
}

- (void)testServiceCustomerWithNotLastItem_NonTrainee
{
    Customer *customer = [[Customer alloc] init];
    customer.numberOfUncheckedItems = 2;
    [cashRegister customerArrived:customer];
    [cashRegister serviceCustomer];
    XCTAssertEqual(customer.numberOfUncheckedItems, (NSInteger)1, @"Customer item not checked out.");
    XCTAssertEqual(cashRegister.customerQueue.count, (NSUInteger)1, @"Customer should still be in queue.");
}

- (void)testServiceCustomer_Trainee
{
    cashRegister.trainee = YES;
    Customer *customer = [[Customer alloc] init];
    customer.numberOfUncheckedItems = 1;
    [cashRegister customerArrived:customer];
    
    [cashRegister serviceCustomer]; // t = 1
    XCTAssertEqual(customer.numberOfUncheckedItems, (NSInteger)1, @"Customer item should not yet be checked out.");
    
    [cashRegister serviceCustomer]; // t = 2
    XCTAssertEqual(customer.numberOfUncheckedItems, (NSInteger)0, @"Customer item not checked out.");
}

@end
