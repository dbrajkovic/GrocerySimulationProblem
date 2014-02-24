//
//  Simulation.m
//  GroceryStoreSimulation
//
//  Created by Dan Brajkovic on 2/21/14.
//  Copyright (c) 2014 Dan Brajkovic. All rights reserved.
//

#import "Simulation.h"
#import "GroceryStore.h"
#import "Customer.h"
#import "Register.h"

@interface Simulation ()

@property GroceryStore *groceryStore;

- (void)setUpStore;

@end

@implementation Simulation

- (id)initWithInputFileNamed:(NSString *)filename
{
    self = [super init];
    if (self) {
        _inputFilename = filename;
    }
    return self;
}

- (void)run
{
    [self setUpStore];
    if (!self.groceryStore) {
        return;
    }
    self.groceryStore.minuteCounter = 0;
    while ([self.groceryStore.customers count] > 0) {
        [self.groceryStore incrementMinuteCounter];
        
    }
    printf("Finished at: t=%ld minutes\n\n", (long)self.groceryStore.minuteCounter);
}

- (void)setUpStore
{
    NSError *fileError;
    
    NSArray *filenameArray = [self.inputFilename componentsSeparatedByString:@"."];
    NSURL *url = [[NSBundle bundleForClass:[self class]] URLForResource:filenameArray[0] withExtension:filenameArray[1]];
    NSString *inputString = [NSString stringWithContentsOfURL:url
                                                     encoding:NSUTF8StringEncoding
                                                        error:&fileError];
    if (fileError) {
        printf("Simulation could not run because input file could not be read.\n");
        return;
    }
    self.groceryStore = [[GroceryStore alloc] initWithInputString:inputString];
}

@end
