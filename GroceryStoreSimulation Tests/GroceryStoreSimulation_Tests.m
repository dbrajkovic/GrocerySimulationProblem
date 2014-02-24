//
//  GroceryStoreSimulation_Tests.m
//  GroceryStoreSimulation Tests
//
//  Created by Dan Brajkovic on 2/21/14.
//  Copyright (c) 2014 Dan Brajkovic. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Simulation.h"
#import "GroceryStore.h"
#import "Register.h"
#import "Customer.h"

@interface Simulation ()

@property GroceryStore *groceryStore;

- (void)setupStore;

@end

@interface GroceryStoreSimulation_Tests : XCTestCase
{
    Simulation *simulation;
}

@end

@implementation GroceryStoreSimulation_Tests

- (void)setUp
{
    [super setUp];
    simulation = [[Simulation alloc] init];
}

- (void)tearDown
{
    simulation = nil;
    [super tearDown];
}

- (void)testSimulator
{
    XCTAssertNotNil(simulation, @"Cannot find Simulation instance.");
}

- (void)testInitWithFilename
{
    NSString *filename = @"Example.txt";
    simulation = [[Simulation alloc] initWithInputFileNamed:filename];
    XCTAssertTrue([simulation.inputFilename isEqualToString:filename], @"Input filename does not equal filename that the simulation was initialized with");
}

- (void)testExample1
{
    simulation.inputFilename = @"Example1.txt";
    [simulation run];
    XCTAssertEqual(simulation.groceryStore.minuteCounter, (NSInteger)7, @"The simulation did not produce the expected result for example 1.");
}

- (void)testExample2
{
    simulation.inputFilename = @"Example2.txt";
    [simulation run];
    XCTAssertEqual(simulation.groceryStore.minuteCounter, (NSInteger)13, @"The simulation did not produce the expected result for example 2.");
}

- (void)testExample3
{
    simulation.inputFilename = @"Example3.txt";
    [simulation run];
    XCTAssertEqual(simulation.groceryStore.minuteCounter, (NSInteger)6, @"The simulation did not produce the expected result for example 3.");
}

- (void)testExample4
{
    simulation.inputFilename = @"Example4.txt";
    [simulation run];
    XCTAssertEqual(simulation.groceryStore.minuteCounter, (NSInteger)9, @"The simulation did not produce the expected result for example 4.");
}

- (void)testExample5
{
    simulation.inputFilename = @"Example5.txt";
    [simulation run];
    XCTAssertEqual(simulation.groceryStore.minuteCounter, (NSInteger)11, @"The simulation did not produce the expected result for example 5.");
}
@end
