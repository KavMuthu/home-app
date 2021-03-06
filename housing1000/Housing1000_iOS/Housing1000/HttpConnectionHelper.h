//
//  HttpConnectionHelper.h
//  Housing1000
//
//  Created by David Horton on 3/21/14.
//  Copyright (c) 2014 Group 3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpConnectionHelper : NSObject

typedef void (^CallbackToDoWhenFinished)(NSMutableArray* results);

-(id)initWithView:(UIViewController*)viewController;

-(NSMutableArray*)getSurveys:(CallbackToDoWhenFinished)callback;
-(NSMutableArray*)getSingleSurvey:(CallbackToDoWhenFinished)callback :(int)surveyIndex;
-(NSMutableArray*)getPIT:(CallbackToDoWhenFinished)callback;
-(NSMutableArray*)postSurvey:(CallbackToDoWhenFinished)callback :(NSDictionary*)jsonData;
-(NSMutableArray*)postPit:(CallbackToDoWhenFinished)callback :(NSDictionary*)jsonData;
-(NSMutableArray*)postAuthentication:(CallbackToDoWhenFinished)callback :(NSString*)username :(NSString*)password;
-(NSMutableArray*)searchEncampment:(CallbackToDoWhenFinished)callback :(NSString*)searchString;
-(NSMutableArray*)getNewEncampment:(CallbackToDoWhenFinished)callback;

@property (nonatomic, strong) NSMutableData *responseData;
@property int httpArgument;

@end



