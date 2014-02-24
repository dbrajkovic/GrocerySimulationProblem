//
//  Simulation.h
//  GroceryStoreSimulation
//
//  Created by Dan Brajkovic on 2/21/14.
//  Copyright (c) 2014 Dan Brajkovic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Simulation : NSObject

@property (strong, nonatomic) NSString *inputFilename;

- (id)initWithInputFileNamed:(NSString *)filename;
- (void)run;

@end
