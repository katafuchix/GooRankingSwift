//
//  Item.h
//  GooRanking
//
//  Created by k.katafuchi on 10/08/01.
//  Copyright 2010 deskplate. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Item : NSObject {
	NSString *title;
	NSString *link;
	NSString *description;
	NSString *pubDate;
	NSString *rdf;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *pubDate;
@property (nonatomic, retain) NSString *rdf;


@end
