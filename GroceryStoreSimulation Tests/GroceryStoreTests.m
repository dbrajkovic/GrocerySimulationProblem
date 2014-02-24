//
//  GroceryStoreTests.m
//  GroceryStoreSimulation
//
//  Created by Dan Brajkovic on 2/23/14.
//  Copyright (c) 2014 Dan Brajkovic. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GroceryStore.h"
#import "Customer.h"
#import "Register.h"

@interface GroceryStoreTests : XCTestCase
{
    GroceryStore *store;
}

@end

@implementation GroceryStoreTests

- (void)setUp
{
    [super setUp];
    store = [[GroceryStore alloc] init];
}

- (void)setUpWithFileName:(NSString *)filename
{
    NSURL *url = [[NSBundle bundleForClass:[self class]] URLForResource:filename withExtension:@"txt"];
    NSString *inputString = [NSString stringWithContentsOfURL:url
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
    store = [[GroceryStore alloc] initWithInputString:inputString];
}


- (void)tearDown
{
    store = nil;
    [super tearDown];
}

- (void)testInitWithInputString
{
    NSString *inputString = @"2\nA 1 5\nB 2 1\nA 3 5\nB 5 3\nA 8 2";
    store = [[GroceryStore alloc] initWithInputString:inputString];
    XCTAssertEqual(store.registers.count, (NSUInteger)2, @"The number of registers set up does not match the input file.");
    XCTAssertEqual(store.customers.count, (NSUInteger)5, @"The number of registers set up does not match the input file.");
    Customer *customer = store.customers[1];
    XCTAssertEqual(customer.customerType, CustomerTypeB, @"Customer type does not match input file.");
    XCTAssertEqual(customer.arrivalTime, (NSInteger)2, @"Customer arrival time does not match input file.");
    XCTAssertEqual(customer.numberOfUncheckedItems, (NSInteger)1, @"Customer's number of items does not match input file.");
}

- (void)testSetCustomers
{
    Customer *customer1 = [[Customer alloc] init];
    Customer *customer2 = [[Customer alloc] init];
    NSArray *customers = @[customer1, customer2];
    store.customers = customers;
    XCTAssertNotEqual(store.customers, customers, @"Customers property should be a copy of the passed in array.");
}

- (void)testSetRegisters
{
    Register *cashRegister1 = [[Register alloc] init];
    Register *cashRegister2 = [[Register alloc] init];
    NSArray *registers = @[cashRegister1, cashRegister2];
    store.registers = registers;
    XCTAssertNotEqual(store.registers, registers, @"Registers property should be a copy of the passed in array.");
}

- (void)testCustomerLeaving
{
    Customer *customer1 = [[Customer alloc] init];
    Customer *customer2 = [[Customer alloc] init];
    NSArray *customers = @[customer1, customer2];
    store.customers = customers;
    [store customerDidLeave:customer1];
    XCTAssertFalse([store.customers containsObject:customer1], @"Leaving customer not removed from customers array.");
}

- (void)testExample1Highlights
{
    [self setUpWithFileName:@"Example1"];
    
    XCTAssertEqual(store.registers.count, (NSUInteger)1, @"The number of registers set up does not match the input file.");
    XCTAssertTrue([store.registers.lastObject isTrainee], @"The last register should be a trainee.");
    
    Customer *customer1 = store.customers[0];
    XCTAssertEqual(customer1.customerType, CustomerTypeA, @"Customer is not expected Customer Type.");
    
    Customer *customer2 = store.customers[1];
    XCTAssertEqual(customer2.customerType, CustomerTypeA, @"Customer is not expected Customer Type.");
    
    
    [store incrementMinuteCounter]; //  t = 1
    XCTAssertEqual([[store.registers[0] customerQueue] count], (NSUInteger)1, @"Incorrect number of customers in queue");
    XCTAssertEqualObjects([[store.registers[0] customerQueue] objectAtIndex:0], customer1, @"Customer in queue is not the expected customer.");
    XCTAssertEqual(customer1.numberOfUncheckedItems, (NSInteger)2, @"Customer does not have expected number of unchecked items");
    
    [store incrementMinuteCounter]; //  t = 2
    XCTAssertEqual([[store.registers[0] customerQueue] count], (NSUInteger)2, @"Incorrect number of customers in queue");
    XCTAssertEqualObjects([[store.registers[0] customerQueue] objectAtIndex:1], customer2, @"Customer in queue is not the expected customer.");
    XCTAssertEqual(customer2.numberOfUncheckedItems, (NSInteger)1, @"Customer does not have expected number of unchecked items");
    
    [store incrementMinuteCounter]; //  t = 3
    XCTAssertEqual(customer1.numberOfUncheckedItems, (NSInteger)1, @"Customer does not have expected number of unchecked items");
    
    [store incrementMinuteCounter]; //  t = 4
    [store incrementMinuteCounter]; //  t = 5
    XCTAssertEqual([[store.registers[0] customerQueue] count], (NSUInteger)1, @"Incorrect number of customers in queue");
    XCTAssertEqualObjects([[store.registers[0] customerQueue] objectAtIndex:0], customer2, @"Customer in queue is not the expected customer.");
    
    [store incrementMinuteCounter]; //  t = 6
    [store incrementMinuteCounter]; //  t = 7
    XCTAssertEqual([[store.registers[0] customerQueue] count], (NSUInteger)0, @"Incorrect number of customers in queue");
    
    XCTAssertEqual(store.customers.count, (NSUInteger)0, @"Store should be empty now.");
}

- (void)testExample2Highlights
{
    [self setUpWithFileName:@"Example2"];
    
    XCTAssertEqual(store.registers.count, (NSUInteger)2, @"The number of registers set up does not match the input file.");
    Register *reg1 = store.registers[0];
    XCTAssertFalse([reg1 isTrainee], @"The last register should not be a trainee.");
                      
  Register *reg2 =store.registers.lastObject;
    XCTAssertTrue([reg2 isTrainee], @"The last register should be a trainee.");
    
    Customer *customer1 = store.customers[0];
    XCTAssertEqual(customer1.customerType, CustomerTypeA, @"Customer is not expected Customer Type.");
    
    Customer *customer2 = store.customers[1];
    XCTAssertEqual(customer2.customerType, CustomerTypeB, @"Customer is not expected Customer Type.");
    
    Customer *customer3 = store.customers[2];
    XCTAssertEqual(customer3.customerType, CustomerTypeA, @"Customer is not expected Customer Type.");
    
    Customer *customer4 = store.customers[3];
    XCTAssertEqual(customer4.customerType, CustomerTypeB, @"Customer is not expected Customer Type.");
    
    Customer *customer5 = store.customers[4];
    XCTAssertEqual(customer5.customerType, CustomerTypeA, @"Customer is not expected Customer Type.");
    
    
    [store incrementMinuteCounter]; //  t = 1
    XCTAssertEqual([reg1.customerQueue count], (NSUInteger)1, @"Incorrect number of customers in queue");
    XCTAssertEqualObjects(reg1.customerQueue[0], customer1, @"Customer in queue is not the expected customer.");
    XCTAssertEqual(customer1.numberOfUncheckedItems, (NSInteger)5, @"Customer does not have expected number of unchecked items");
    
    [store incrementMinuteCounter]; //  t = 2
    XCTAssertEqual([reg2.customerQueue count], (NSUInteger)1, @"Incorrect number of customers in queue");
    XCTAssertEqualObjects(reg2.customerQueue[0], customer2, @"Customer in queue is not the expected customer.");
    XCTAssertEqual(customer2.numberOfUncheckedItems, (NSInteger)1, @"Customer does not have expected number of unchecked items");

    [store incrementMinuteCounter]; //  t = 3
    XCTAssertEqual([reg1.customerQueue count], (NSUInteger)2, @"Incorrect number of customers in queue");
    XCTAssertEqualObjects(reg1.customerQueue[1], customer3, @"Customer in queue is not the expected customer.");
    XCTAssertEqual(customer3.numberOfUncheckedItems, (NSInteger)5, @"Customer does not have expected number of unchecked items");
    
    [store incrementMinuteCounter]; //  t = 4
    XCTAssertEqual([reg2.customerQueue count], (NSUInteger)0, @"Incorrect number of customers in queue");
    XCTAssertEqual(customer1.numberOfUncheckedItems, (NSInteger)2, @"Customer does not have expected number of unchecked items");
    XCTAssertEqual(customer3.numberOfUncheckedItems, (NSInteger)5, @"Customer does not have expected number of unchecked items");
    
    [store incrementMinuteCounter]; //  t = 5
    XCTAssertEqual([reg2.customerQueue count], (NSUInteger)1, @"Incorrect number of customers in queue");
    XCTAssertEqual(customer1.numberOfUncheckedItems, (NSInteger)1, @"Customer does not have expected number of unchecked items");
    XCTAssertEqual(customer3.numberOfUncheckedItems, (NSInteger)5, @"Customer does not have expected number of unchecked items");
    XCTAssertEqualObjects(reg2.customerQueue[0], customer4, @"Customer in queue is not the expected customer.");
    XCTAssertEqual(customer4.numberOfUncheckedItems, (NSInteger)3, @"Customer does not have expected number of unchecked items");
    
    [store incrementMinuteCounter]; //  t = 6
    XCTAssertEqual([reg1.customerQueue count], (NSUInteger)1, @"Incorrect number of customers in queue");
    XCTAssertEqualObjects(reg1.customerQueue[0], customer3, @"Customer in queue is not the expected customer.");
   
    [store incrementMinuteCounter]; //  t = 7
    [store incrementMinuteCounter]; //  t = 8
    XCTAssertEqual([reg1.customerQueue count], (NSUInteger)2, @"Incorrect number of customers in queue");
    XCTAssertEqualObjects(reg1.customerQueue[1], customer5, @"Customer in queue is not the expected customer.");
    XCTAssertEqual(customer5.numberOfUncheckedItems, (NSInteger)2, @"Customer does not have expected number of unchecked items");
    
    [store incrementMinuteCounter]; //  t = 9
    [store incrementMinuteCounter]; //  t = 10
    [store incrementMinuteCounter]; //  t = 11
    XCTAssertEqual([reg1.customerQueue count], (NSUInteger)1, @"Incorrect number of customers in queue");
    XCTAssertEqualObjects(reg1.customerQueue[0], customer5, @"Customer in queue is not the expected customer.");
    XCTAssertEqual([reg2.customerQueue count], (NSUInteger)0, @"Incorrect number of customers in queue");
    
    [store incrementMinuteCounter]; //  t = 12
    [store incrementMinuteCounter]; //  t = 13
    XCTAssertEqual([reg1.customerQueue count], (NSUInteger)0, @"Incorrect number of customers in queue");
    
    XCTAssertEqual(store.customers.count, (NSUInteger)0, @"Store should be empty now.");
}


@end
