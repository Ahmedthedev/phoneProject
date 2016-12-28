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
/*
NSString* (^block) (NSString*, char) = ^(NSString* txt, char nb) {
    NSMutableString * op = [[NSMutableString alloc] init];
    [op appendString:txt];
    [op appendFormat:@"%c", nb];

  return op;
};
*/

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


NSString *(^priority) (NSString*) = ^(NSString* calcul) {
  
    return @"lol";
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
     _op.text = add(_op.text,[sender currentTitle]);
}
- (IBAction)del:(id)sender {
    _op.text = @"";
}



// Operators
- (IBAction)equal:(id)sender {
    float result = 0;
    float a = 0;
    float b = 0;
    NSMutableString* operator = [[NSMutableString  alloc] init];
    NSMutableString* strA = [[NSMutableString  alloc] init];
    NSMutableString* strB = [[NSMutableString  alloc] init];
    NSMutableString* strX = [[NSMutableString  alloc] init];
    NSString * again = [[NSString alloc] init];
    int nbOperator = 0;
    int i;
    unsigned long len = [_op.text length];
    unsigned short index [len];
    bool operatorBefore = NO;
    
    [_op.text getCharacters:index range:NSMakeRange(0, len)];
    
    for(i = 0; i < len; i++) {
        if(operatorBefore == NO && (index[i] == '-')  ) {
            [strA appendFormat:@"%c",index[i]];
            i++;
        }
        if(index[i] >= '0' && index[i] <= '9' && nbOperator < 2) {
            
             [strA appendFormat:@"%c",index[i]];
             operatorBefore = YES;
            
        }else {
            if(nbOperator >= 1 ) {
                NSLog(@"entrer");
                [strX appendFormat:@"%c",index[i]];
                nbOperator++;
            }else {
                [strB appendString:strA];
                [strA setString:@""];
                [operator appendFormat:@"%c",index[i]];
                nbOperator++;
                
            }
         }
        //NSLog(@"a = %@ b = %@ operator = %@ nbOperator = %d strX = %@ index = %c ",strA,strB,operator,nbOperator,strX,index[i]);
    }
    
    a = [strA floatValue];
    b = [strB floatValue];
    
    NSLog(@"a = %.2f , b = %.2f ",a,b);
    
    if ([operator isEqual:@"-"]) {
        result = b - a;
    }else if([operator isEqual:@"+"]) {
        result = b + a;
    }else if ([operator  isEqual: @"x"]) {
        result = b * a;
    }else {
        result = b / a;
    }
    if(nbOperator >= 2) {
        again = [NSString stringWithFormat:@"%f", result];
        again = [again stringByAppendingString:strX];
        NSLog(@" again = %@ strX = %@ op = %@",again,strX,operator);
       //[self equal:again];
    }
    NSLog(@"a = %.2f , b = %.2f result = %.2f ",a,b,result);
    _res.text = [NSString stringWithFormat:@"%.2f",result];
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
