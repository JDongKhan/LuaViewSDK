//
//  SMBaseRefreshManager.h
//  tableivewSimplifyDemo
//
//  Created by 王金东 on 14/12/15.
//  Copyright © 2015年 王金东. All rights reserved.
//


enum {
    SMBlockFlagsHasCopyDispose = (1 << 25),
    SMBlockFlagsHasCtor = (1 << 26), // helpers have C++ code
    SMBlockFlagsIsGlobal = (1 << 28),
    SMBlockFlagsHasStret = (1 << 29), // IFF BLOCK_HAS_SIGNATURE
    SMBlockFlagsHasSignature = (1 << 30)
};
typedef int CTBlockFlags;

#import <Foundation/Foundation.h>

@interface SMBlockDescription : NSObject

@property (nonatomic, readonly) CTBlockFlags flags;
@property (nonatomic, readonly) NSMethodSignature *blockSignature;
@property (nonatomic, readonly) unsigned long int size;
@property (nonatomic, readonly) id block;

- (id)initWithBlock:(id)block;

- (BOOL)isCompatibleForBlockSwizzlingWithMethodSignature:(NSMethodSignature *)methodSignature;

@end
