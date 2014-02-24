//
//  main.m
//  GroceryStoreSimulation
//
//  Created by Dan Brajkovic on 2/21/14.
//  Copyright (c) 2014 Dan Brajkovic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Simulation.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSString *filename = [NSString stringWithUTF8String:(const char *)argv[1]];
        Simulation *simulation = [[Simulation alloc] initWithInputFileNamed:filename];
        [simulation run];        
    }
    return 0;
}

