//
//  UtilManager.h
//  GooRanking
//
//  Created by k.katafuchi on 2012/09/04.
//
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface UtilManager : NSObject{
    NSMutableArray* itemsList;
    NSString *dir;
    NSString *name;
    NSString *description;
}

@property(nonatomic, retain)NSMutableArray* itemsList;

@property (nonatomic, retain) NSString *dir;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;

+(UtilManager*)sharedInstance;

/*
- (void) setDir:(NSString *)str;
- (void) setName:(NSString *)name;
*/
- (void) makeDir;
//- (void)addItemsList:(Item*)item;
- (void)addItemsList:(NSDictionary*)dic;
- (void)saveItemsList;
- (void)loadItemsList;
- (void)clearItemsList;
- (void)clear;

@end
