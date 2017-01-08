//
//  CalculatorViewController.m
//  projectPhone
//
//  Created by apple on 13/12/2016.
//  Copyright © 2016 apple. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** Block who return the reverse string **/
NSMutableString * (^reverse) (NSMutableString*) = ^(NSMutableString* txt) {
    NSMutableString *reversedString = [NSMutableString stringWithCapacity:[txt length]];
    
    [txt enumerateSubstringsInRange:NSMakeRange(0,[txt length])
     
                                 options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
                              usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                  [reversedString appendString:substring];
                                  
                              }];
    
    return reversedString;

};

/** Block who add operator and numbers he cans also delete operator  **/
NSString* (^add) (NSString*, NSString*) = ^(NSString* txt, NSString * nb) {
    bool way = false;
    unsigned long len = [txt length];
    NSString * last = [[NSString alloc]init] ;
    NSMutableString * op = [[NSMutableString alloc] init];
    if (len >= 1) {
        
        last = [txt substringFromIndex:[txt length] - 1];
        
        if([nb isEqualToString:(@"-")] || [nb isEqualToString:(@"x")]
           || [nb isEqualToString:(@"+")] || [nb isEqualToString:(@"÷")]) {
            
            if([last isEqualToString:(@"-")] || [last isEqualToString:(@"x")]
               || [last isEqualToString:(@"+")] || [last isEqualToString:(@"÷")]) {
            
                if(len == 1 && [last isEqualToString:(@"-")] ) {
                    [op appendString:txt];
                     return op;
                }
                way = true;
            }
        }
    }
    
    if(way) {
        NSRange target = NSMakeRange ( ([txt length]-1), 1 );
        [op appendString:txt];
        [op appendString:nb];
        [op deleteCharactersInRange:(target)];
    }else{
        [op appendString:txt];
        [op appendString:nb];
    }

    return op;
};

// Block who can know if the calculation got a priority and the number of "x / ÷" also he detects if the first number is a negative number
NSMutableArray* (^Withpriority) (NSString *,unsigned long) = ^(NSString * txt,unsigned long len) {
    unsigned short index [len];
    unsigned int prio = 0;
    unsigned int Nprio = 0;
    unsigned int nbPriority = 0;
    bool interupt = NO;
    NSMutableArray * myArray = [[NSMutableArray alloc] init];
    unsigned int i;
    
    [txt getCharacters:index range:NSMakeRange(0, len)];
    for(i = 0; i < len; i++) {
        if(index[0] == '-' && interupt == NO ) {
            interupt = YES;
            continue;
        }
        if((index[i] >= '0' && index[i] <= '9') || index[i] == '.') {

        }else {
            if( index[i]  == '-' || (index[i] == '+'  && Nprio == 0 )) {
                prio++;
            }else if(prio > 0) {
                Nprio++;
            }
            if( index[i]  != '-' && index[i] != '+' ) {
                nbPriority++;
            }
        }
    }
    NSNumber *number = [NSNumber numberWithInt:nbPriority];
    [myArray addObject:number];
    
    if(prio > 0 && Nprio > 0 ) {
       [myArray addObject:@YES];
       [myArray addObject:[NSNumber numberWithBool:interupt]];
        return myArray;
    }else {
        [myArray addObject:@NO];
        [myArray addObject:[NSNumber numberWithBool:interupt]];
        return myArray;
    }
};

/** Block who do the calculation recursively  **/
NSString *(^priority) (NSString*) = ^NSString*(NSString* txt) {
    float result = 0;
    float a = 0;
    float b = 0;
    NSMutableString* operator = [[NSMutableString  alloc] init];
    NSMutableString* strA = [[NSMutableString  alloc] init];
    NSMutableString* strB = [[NSMutableString  alloc] init];
    NSMutableString* strXBefore = [[NSMutableString  alloc] init];
    NSMutableString* strXAfter = [[NSMutableString  alloc] init];
    NSMutableString * again = [[NSMutableString alloc] init];
    int nbOperator = 0;
    int i;
    int x = 0;
    int cptPriotity = 1;
    bool reste = NO;
    NSMutableArray* ifPriorityAndNb = [[NSMutableArray alloc] init];
    unsigned long len = [txt length];
    unsigned long j;
    unsigned short index [len];
    bool operatorBefore = NO;
    bool aContainOp = NO;
    NSNumber * nbPriority = [[NSNumber alloc] init];
    
    ifPriorityAndNb = Withpriority(txt,len);
    // ifPriorityAndNb[0] = number of "x / ÷"
    // ifPriorityAndNb[1] = (x == 0) ? it's not a calculation who contain priority : contain priority
    // ifPriorityAndNb[2] = know if the first number is a negative number
    nbPriority = [ifPriorityAndNb objectAtIndex:0];
    [txt getCharacters:index range:NSMakeRange(0, len)];

    int cpt = 0;
    // iterate through my array for the second time but now I know exactly how he's done
    for(i = 0; i < len; i++) {
        if([[ifPriorityAndNb objectAtIndex:1] boolValue]  == 1 ) {
            
            // StrA = my number b
            if(reste == YES){
                [strA appendFormat:@"%c",index[i]];
            }
            // I have done this condition because I do not whant this char
            if(index[i] == '-' || index[i] == '+' || index[i] == '.' || (index[i] >= '0' && index[i] <= '9')) {
                //do nothing
            }else if( [nbPriority intValue] == cptPriotity){
                cpt = i;
                [operator appendFormat:@"%c",index[i]];
                cpt--;
                // after get the special signe I iterate my loop in reverse order to get the numbers before
                while(cpt > -1 ) {
                    NSLog(@" index = %c",index[cpt]);
                    if(index[cpt] != '-' && index[cpt] != '+' && reste == NO ) {
                        if( index[cpt] >= '0' && index[cpt] <= '9') {
                            [strB appendFormat:@"%c",index[cpt]];
                        }else {
                             reste = YES;
                            cpt++;
                        }
                    }else {
                        [strXBefore appendFormat:@"%c",index[cpt]];
                        reste = YES;
                    }
                    cpt--;
                }
            }else {
                cptPriotity++;
            }
        }else {
            // else the calculation can be do in the normal order
            if(operatorBefore == 0 && (index[i] == '-')  ) {
                [strA appendFormat:@"%c",index[i]];
                i++;
            }
            if((index[i] >= '0' && index[i] <= '9' && nbOperator < 2) || (index[i] == '.' && nbOperator < 2)) {
                [strA appendFormat:@"%c",index[i]];
                operatorBefore = YES;
                
            }else {
                if(nbOperator >= 1 ) {
                    [strXBefore appendFormat:@"%c",index[i]];
                    nbOperator++;
                }else {
                    [strB appendString:strA];
                    [strA setString:@""];
                    [operator appendFormat:@"%c",index[i]];
                    nbOperator++;
                    
                }
            }
        }
    }
    
    if([[ifPriorityAndNb objectAtIndex:1] boolValue] == 1  && [nbPriority intValue] >= 2 ) {
        strB = reverse(strB);
        nbOperator = 2;
        strXBefore = reverse(strXBefore);
    }
    if([[ifPriorityAndNb objectAtIndex:2] boolValue] == 1) {
        strXBefore = reverse(strXBefore);
    }
    
    if([[ifPriorityAndNb objectAtIndex:1] boolValue] == 1 ) {
        len = [strA length];
        [strA getCharacters:index range:NSMakeRange(0, len)];
        for(j = 0; j < len ; j++) {
            if(index[j] == '-' || index[j] == '+' || aContainOp == YES) {
                [strXAfter appendFormat:@"%c",index[j]];
                aContainOp = YES;
                x++;
            }
        }
        [strA deleteCharactersInRange:NSMakeRange((j-x), (len-1))];
    }
    a = [strA floatValue];
    b = [strB floatValue];
    
    if(isnan(a)) {
        result = b;
    }else if(isnan(b)) {
        result = a;
    }else {
        if ([operator isEqual:@"-"]) {
            result = b - a;
        }else if([operator isEqual:@"+"]) {
            result = b + a;
        }else if ([operator  isEqual: @"x"]) {
            result = b * a;
        }else {
            result = b / a;
        }
    }
    again = [NSMutableString stringWithFormat:@"%g", result];
    NSLog(@"strA = %@ strB = %@ operator = %@ again = %@, strXBefore = %@ result = %g",strA,strB,operator,again,strXBefore,result);
    if(nbOperator == 1 ) {
        return again;
    }else {
        if( [[ifPriorityAndNb objectAtIndex:1] boolValue] == 1  && nbOperator >= 1 ) {
            [strXBefore appendString:again];
           [again setString:(priority(strXBefore))];
        } else {
            [again appendString:strXAfter];
            [again appendString:strXBefore];
           [again setString:(priority(again))];
        }
    }
    NSLog(@" again = %@",again);
    return again;
};

// Numbers
- (IBAction)zero:(id)sender {
    _op.text = add(_op.text,[sender currentTitle]);
}
- (IBAction)one:(id)sender {
    _op.text = add(_op.text,[sender currentTitle]);
}
- (IBAction)two:(id)sender {
    _op.text = add(_op.text,[sender currentTitle]);
}
- (IBAction)three:(id)sender {
    _op.text = add(_op.text,[sender currentTitle]);
}
- (IBAction)four:(id)sender {
    _op.text = add(_op.text,[sender currentTitle]);
}
- (IBAction)five:(id)sender {
    _op.text = add(_op.text,[sender currentTitle]);
}
- (IBAction)six:(id)sender {
    _op.text = add(_op.text,[sender currentTitle]);
}
- (IBAction)seven:(id)sender {
    _op.text = add(_op.text,[sender currentTitle]);
}
- (IBAction)height:(id)sender {
    _op.text = add(_op.text,[sender currentTitle]);
}
- (IBAction)nine:(id)sender {
    _op.text = add(_op.text,[sender currentTitle]);
    NSString *foo = [[NSString alloc] init];
    foo = [sender currentTitle];
    NSLog(@"%@", foo);
    
}

// Point & delete
- (IBAction)point:(id)sender {
    if(![_op.text isEqualToString:@""] ) {
        _op.text = add(_op.text,[sender currentTitle]);
    }
}
- (IBAction)del:(id)sender {
    _op.text = @"";
}



// Operators
- (IBAction)equal:(id)sender {

    _res.text = priority(_op.text);
    _op.text = @"";
    
}
- (IBAction)divisor:(id)sender {
    if(![_op.text isEqualToString:@""] ) {
     _op.text = add(_op.text,[sender currentTitle]);
    }
}
- (IBAction)multiply:(id)sender {
    if(![_op.text isEqualToString:@""] ) {
        _op.text = add(_op.text,[sender currentTitle]);
    }
}
- (IBAction)subtract:(id)sender {
    _op.text = add(_op.text,[sender currentTitle]);
}
- (IBAction)add:(id)sender {
    if(![_op.text isEqualToString:@""] ) {
        _op.text = add(_op.text,[sender currentTitle]);
    }
}









/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
