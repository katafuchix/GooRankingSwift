//
//  Item.m
//  GooRanking
//
//  Created by k.katafuchi on 10/08/01.
//  Copyright 2010 deskplate. All rights reserved.
//

#import "Item.h"


@implementation Item

@synthesize title;
@synthesize link;
@synthesize description;
@synthesize pubDate;
@synthesize rdf;

- (void)dealloc {
	//[title release];
	//[link release];
	//[description release];
	//[pubDate release];
	//[super dealloc];
}

- (void) setValue:(id)value forUndefinedKey: (NSString *)key {
	if ([key isEqualToString:@"dc:date"]) {
		pubDate = value;
	}
}


@end
