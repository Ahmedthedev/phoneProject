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

NSMutableString * (^reverse) (NSMutableString*) = ^(NSMutableString* txt) {
    NSMutableString *reversedString = [NSMutableString stringWithCapacity:[txt length]];
    
    [txt enumerateSubstringsInRange:NSMakeRange(0,[txt length])
     
                                 options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
                              usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                  [reversedString appendString:substring];
                                  
                              }];
    
    return reversedString;

};

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


NSString *(^priority) (NSString*) = ^NSString*(NSString* txt) {
    float result = 0;
    
    float a = 0;
    float b = 0;
    NSMutableString* operator = [[NSMutableString  alloc] init];
    NSMutableString* strA = [[NSMutableString  alloc] init];
    NSMutableString* strB = [[NSMutableString  alloc] init];
    NSMutableString* strX = [[NSMutableString  alloc] init];
    NSMutableString* strXAfter = [[NSMutableString  alloc] init];
    NSMutableString * again = [[NSMutableString alloc] init];
    int nbOperator = 0;
    int i;
    int x = 0;
    int nbPriority = 0;
    int cptPriotity = 1;
    bool reste = NO;
    unsigned long len = [txt length];
    unsigned long j;
    unsigned short index [len];
    bool operatorBefore = NO;
    bool interupt = NO;
    int prio = 0;
    int Nprio = 0;
    bool aContainOp = NO;
    
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
         NSLog(@"prio = %d , Nprio = %d, index = %c",prio,Nprio,index[i]);
     }

    if(prio > 0 && Nprio > 0 ) {
         NSLog(@"calcul -> priorité test");
    }else {
        NSLog(@"calcul -> no prio test");
    }
    
    int cpt = 0;
    // reparcours de mon tableau de 2 façon différente en fonction du nb de priorité
    for(i = 0; i < len; i++) {
        if(prio > 0 && Nprio > 0 ) {
            
            if(reste == YES){
                [strA appendFormat:@"%c",index[i]];
               // NSLog(@"strA = %@",strA);
            }
            
            
            if(index[i] == '-' || index[i] == '+' || index[i] == '.' || (index[i] >= '0' && index[i] <= '9')) {
            }else if(nbPriority == cptPriotity){
                cpt = i;
                [operator appendFormat:@"%c",index[i]];
              
                //NSLog(@"index = %c",index[i]);
                cpt--;
                while(cpt > -1 ) {
                    if(index[cpt] != '+' && index[cpt] != '-' && reste == NO ) {
                       [strB appendFormat:@"%c",index[cpt]];
                      // NSLog(@"IF à la case %d  il y a %c strB = %@ strX = %@  l'operateur = %@ ",cpt,index[cpt],strB,strX,operator);
                    }else {
                        [strX appendFormat:@"%c",index[cpt]];
                        //NSLog(@"ELSE à la case %d  il y a %c strB = %@  strX = %@  l'operateur = %@ ",cpt,index[cpt],strB,strX,operator);
                        reste = YES;
                    }
                    cpt--;
                }
                
            }else {
                cptPriotity++;
            }
        }else {
            
            if(operatorBefore == NO && (index[i] == '-')  ) {
                [strA appendFormat:@"%c",index[i]];
                i++;
            }
            
            if((index[i] >= '0' && index[i] <= '9' && nbOperator < 2) || (index[i] == '.' && nbOperator < 2)) {
                [strA appendFormat:@"%c",index[i]];
                operatorBefore = YES;
                
            }else {
                if(nbOperator >= 1 ) {
                    [strX appendFormat:@"%c",index[i]];
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
    


    
    if(prio > 0 && Nprio > 0 && nbPriority >= 2 ) {
        strB = reverse(strB);
        nbOperator = 2;
       NSLog(@"avant -> strX = %@ ",strX);
        strX = reverse(strX);
        NSLog(@"aprés ->  strX = %@ ",strX);
        
    }
    if(interupt == YES) {
        strX = reverse(strX);
        NSLog(@"aprés ->  strX = %@ ",strX);
    }
    
    NSLog(@"1 strX = %@ strB =  %@, operator = %@ strA = %@",strX,strB,operator,strA);
    
    if(prio > 0 && Nprio > 0) {
        len = [strA length];
        [strA getCharacters:index range:NSMakeRange(0, len)];
    
        for(j = 0; j < len ; j++) {
            NSLog(@"index = %c After = %@",index[j],strXAfter);
            if(index[j] == '-' || index[j] == '+' || aContainOp == YES) {
                NSLog(@" je prend index = %c",index[j]);
                [strXAfter appendFormat:@"%c",index[j]];
                aContainOp = YES;
                x++;
            }
        }
        [strA deleteCharactersInRange:NSMakeRange((j-x), (len-1))];
    
        NSLog(@"strA = %@ , strXAfter = %@",strA,strXAfter);
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
    
    NSLog(@"a = %.2f , b = %.2f operator = %@ result = %.2f nbOp = %d",a,b,operator,result,nbOperator);
    again = [NSMutableString stringWithFormat:@"%g", result];
    if(nbOperator == 1 ) {
        NSLog(@"IF again = %@ result = %.2f",again,result);
        return again;
    }else {
        if( prio > 0 && Nprio > 0 && nbOperator >= 1 ) {
            [strX appendString:again];
            NSLog(@" ici ELSE if again = %@ strX = %@ op = %@  ",again,strX,operator);
            [again setString:(priority(strX))];
        } else {
            
            [again appendString:strXAfter];
            [again appendString:strX];
            NSLog(@" ELSE if  again = %@ strX = %@ op = %@  ",again,strX,operator);
            [again setString:(priority(again))];
        }
    }
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
