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
    NSMutableString * op = [[NSMutableString alloc] init];
    [op appendString:txt];
    [op appendString:nb];
    
    return op;
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
    
    int result = 0;
    int a = 0;
    int b = 0;
    NSMutableString* operator = [[NSMutableString  alloc] init];
    NSMutableString* strA = [[NSMutableString  alloc] init];
    NSMutableString* strB = [[NSMutableString  alloc] init];
    int i;
    //char current;
    unsigned long len = [_op.text length];
    unsigned short index [len];
    [_op.text getCharacters:index range:NSMakeRange(0, len)];
    
    for(i = 0; i < len; i++) {
        if(index[i] >= '0' && index[i] <= '9' ) {
             [strA appendFormat:@"%c",index[i]];
        } else {
             [strB appendString:strA];
             [strA setString:@""];
             [operator appendFormat:@"%c",index[i]];
         }
    }
    
    a = [strA intValue];
    b = [strB intValue];
    NSLog(@"%d %d",b,a);
    
    if ([operator isEqual:@"-"]) {
        NSLog(@"0");
        result = b - a;
    }else if([operator isEqual:@"+"]) {
        NSLog(@"1");
        result = b + a;
    }else if ([operator  isEqual: @"x"]) {
        NSLog(@"2");
        result = b * a;
    }else {
        NSLog(@"3");
        result = b / a;
    }
    _res.text = [NSString stringWithFormat:@"%d",result];
    _op.text = @"";
    
}
- (IBAction)divisor:(id)sender {
     _op.text = add(_op.text,[sender currentTitle]);
}
- (IBAction)multiply:(id)sender {
    _op.text = add(_op.text,[sender currentTitle]);
}
- (IBAction)subtract:(id)sender {
    _op.text = add(_op.text,[sender currentTitle]);
}
- (IBAction)add:(id)sender {
    _op.text = add(_op.text,[sender currentTitle]);
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
