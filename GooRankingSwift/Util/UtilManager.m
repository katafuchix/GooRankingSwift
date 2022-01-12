//
//  UtilManager.m
//  GooRanking
//
//  Created by k.katafuchi on 2012/09/04.
//
//

#import "UtilManager.h"


// 区切り
#define SEPARATER @"[SEPARATER]"
#define SEP @"[SEP]"

@implementation UtilManager
@synthesize dir;

static UtilManager *_instance = nil;

-(id)init {
	if ([super init]) {
        self.dir = nil;
        self.itemsList = [[NSMutableArray alloc]init];
    }
    return self;
}

+(UtilManager*)sharedInstance {
	if (_instance == nil) {
		_instance = [[UtilManager alloc] init];
	}
	return _instance;
}
/*
- (void)dealloc {
    //[super dealloc];
}
*/

/*
- (void) setDir:(NSString *)str{
    self.dir = str;
}
- (void) setname:(NSString *)str{
    self.name = str;
}
*/

- (void) makeDir{
    
    // ディレクトリ作成
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *pathName = [documentsDirectory stringByAppendingPathComponent:self.dir];
    NSError* error = nil;
    //NSLog(pathName);
    
    // 文字列型の変数 path で指定したディレクトリを作成します。
    [[NSFileManager defaultManager] createDirectoryAtPath:pathName withIntermediateDirectories:YES attributes:nil error:&error];
}

- (void) checkInterValTime{
    
	NSString *datname = [[NSString alloc] initWithFormat:@"%@.dat", self.name ];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathName = [documentsDirectory stringByAppendingPathComponent:self.dir];
    NSLog(@"%@", pathName);
	NSString *fileName = [pathName stringByAppendingPathComponent:datname];
	NSLog(@"%@", fileName);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        
        NSFileManager *fm = [NSFileManager defaultManager];
        NSDictionary *att = [fm fileAttributesAtPath:fileName traverseLink:YES];
        // ファイル生生年月日
        //NSLog(@"%@", att);
        NSLog(@"%@", [att objectForKey:@"NSFileModificationDate"]); // 2012-09-09 05:23:07 +0000
        //NSLog(@"%@", [att objectForKey:@"NSFileCreationDate"]);
        
        // 本日
        NSDate *today = [NSDate date];
        //NSLog(@"today   %@", today);
        
        NSTimeInterval  since = [today timeIntervalSinceDate:[att objectForKey:@"NSFileModificationDate"]];
        
        //NSLog(@"%f", since/60);
        // ２４時間以上経過していたらクリア
        if(since > 60*60*24){
        //if(since > 60){
            //NSLog(@"%@", @"clear");
            [self clearItemsList];
        }
    }
}

- (void)loadItemsList{
    [self checkInterValTime];
    
    //if ( self.itemsList == nil ) {
        self.itemsList = [[NSMutableArray alloc] init];
	//}
	NSString *datname = [[NSString alloc] initWithFormat:@"%@.dat", self.name ];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathName = [documentsDirectory stringByAppendingPathComponent:self.dir];
    //NSLog(@"%@", pathName);
	NSString *fileName = [pathName stringByAppendingPathComponent:datname];
	//NSLog(@"%@", fileName);
	NSData *data = [NSData dataWithContentsOfFile:fileName];
    //NSLog(@"data : %@", data);
    
	if( data != nil ){
        @try {
            //self.itemsList = (NSMutableArray *)[NSArray arrayWithContentsOfFile:fileName];
            
            NSArray *array = [NSArray arrayWithContentsOfFile:fileName];
            NSMutableArray *newArray = (NSMutableArray *)[array mutableCopy];
            //[newArray addObject:newObject];
            self.itemsList = newArray;
        }@catch (NSException *exception) {
            NSLog(@"[ERROR] exception [%@]", exception);
            self.itemsList = [[NSMutableArray alloc] init];
        }
        /*
		NSString *bodyText = [[NSString alloc] initWithData:data encoding:NSShiftJISStringEncoding];
		NSArray *items = [bodyText componentsSeparatedByString:SEPARATER];
		NSInteger count = [[items objectAtIndex:0] intValue];
		
        Item *currentItem;
		for ( NSInteger i= 0; i< count; i++ ) {
			NSString* str = [[NSString alloc] initWithFormat:@"%@", [items objectAtIndex:(i+1)] ];
            NSArray *tmp = [str componentsSeparatedByString:SEP];
            
            currentItem = [[Item alloc] init];
            currentItem.title = [tmp objectAtIndex:0];
            currentItem.rdf = [tmp objectAtIndex:1];
            currentItem.description = [tmp objectAtIndex:2];
            NSLog(@"%@", currentItem.title);
            [self.itemsList addObject:currentItem];
		}*/
    }
}


//- (void)addItemsList:(Item *)item{
- (void)addItemsList:(NSDictionary *)dic{
    //NSLog(@"self.itemsList");
    //NSLog(@"%@", self.itemsList);
    [self.itemsList addObject:dic];
    //NSLog(@" count - %d", [self.itemsList count]);
    //[self saveItemsList];
}

- (void)saveItemsList{
    
	NSInteger count = 0;
	if( self.itemsList != nil ){
		count = [self.itemsList count];
	}
    
	NSString *datname = [[NSString alloc] initWithFormat:@"%@.dat", self.name ];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathName = [documentsDirectory stringByAppendingPathComponent:self.dir];
    //NSLog(@"%@", pathName);
	NSString *fileName = [pathName stringByAppendingPathComponent:datname];
    NSLog(@"fileName : %@", fileName);
	//NSError *error;
	/*
	NSString* bodyText = [[NSString alloc] initWithFormat:@"%d", count];
	
    //NSLog(@"%d", count);
    for ( int i= 0; i < count; i++ ) {
        // item
        Item *currentItem = [self.itemsList objectAtIndex:i];
		NSString *itemText = [[NSString alloc] initWithFormat:@"%@%@%@%@%@", currentItem.title, SEP, currentItem.rdf, SEP, currentItem.description];
        
        bodyText = [[NSString alloc] initWithFormat:@"%@%@%@", bodyText,SEPARATER, itemText ];
    }*/
    NSLog(@"%@", @"self.itemsList");
    NSLog(@"%lu", (unsigned long)self.itemsList.count);
    
    BOOL ok = [self.itemsList writeToFile:fileName atomically:YES];
    NSLog(@"save bool : %d", ok);
	//BOOL ok = [bodyText writeToFile:fileName atomically:YES encoding:NSShiftJISStringEncoding error:&error];
	
	if( ok != true ){
    }else{
        self.itemsList = (NSMutableArray *)[NSArray arrayWithContentsOfFile:fileName];
    }
}
- (void)clearItemsList{

    self.itemsList = [[NSMutableArray alloc] init];
    [self saveItemsList];
}
-(void) clear{
    self.itemsList = [[NSMutableArray alloc]init];
}
@end
