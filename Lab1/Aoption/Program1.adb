--Parameshor Bhandari
--CS3319 Data Structure
--Lab 1
--02/27/2015
--A Option code

With Ada.Text_IO; Use Ada.Text_IO;
with Unchecked_Conversion;
with gStack;

procedure Program1 is
   type DataType is (char, int, date, quit);
   type StackOption IS (Push, Pop, Quit);
   type MonthName IS (January, February, March, April, May, June, July, August,
                 September, October, November, December, Done);
   TYPE DateType is RECORD
         Month:MonthName;
         Day: Integer RANGE 1..31;
         Year:Integer;
      End record;

   package MonthName_IO is New Ada.Text_IO.Enumeration_IO(MonthName); use MonthName_IO;
   Package StackOption_IO is New Ada.Text_IO.Enumeration_IO(StackOption);use StackOption_IO;
   package Data_IO is new Ada.Text_IO.Enumeration_IO(DataType); Use Data_IO;
   package MyInt_IO is New Ada.Text_IO.integer_IO(integer);use MyInt_IO;

   function integerToCharacter is New Unchecked_Conversion(Integer,Character);
   function characterToInteger is New Unchecked_Conversion(Character, Integer);

   StackSize:Integer;
   stackType: DataType;
   StackChoice: StackOption;



Begin
   Put("Enter the size of the stack: ");
   Get(stackSize);
   Put_Line(" ");

   While 1 = 1 Loop
      Put("Enter the data type for stack i.e char, int, date or quit: ");
      Get(stackType);
      New_Line;
   
      case stackType is
         when char=>
         
            Declare
               inputChar: String(1..255);
               charLength: Integer:=0;
               tempChar: Character;
               stackException: Boolean:= False;
            
               Package Character_Stack is New gStack(Character, stackSize); Use Character_Stack;
            Begin
               While 1= 1 Loop
                  Put("Enter the type of the operation i.e push, pop or quit: ");
                  Get(stackChoice);
                  Case stackChoice is
                     WHEN Push =>
                        Put("");
                        Put("Enter Characters to push : ");
                        Skip_Line;
                        Get_Line(inputChar, charLength);    -- Recives character and character length
                        Put(inputChar(1..charLength));
                        Put("==>> Pushed") ;
                        Put_Line("");
                     
                        If charLength > 0 Then
                           For i in 1..charLength Loop
                              push(inputChar(i),stackException);
                              If stackException = True Then
                                 Put(" Stack is Full");
                                 Put_Line("");
                                 Exit;
                              End if;
                           End Loop;
                        End If;
                     
                        If stackException = False Then
                           tempChar:= integerToCharacter(charLength);
                           push(tempChar, stackException);
                           If stackException = True Then
                              Put("Stack is Full");
                              put_Line("");
                           End If;
                        End If;
                     When pop =>
                        pop(tempChar, stackException);
                        If stackException = True Then
                           Put("Stack is Empty");
                           Put_Line(" ");
                        Else
                           charLength:= CharacterToInteger(TempChar);
                           put(charLength);
                           For i in 1..charLength loop
                              pop(tempChar, stackException);
                              If stackException = True Then
                                 Put("Stack is Empty");
                              
                                 Exit;
                              
                              Else
                                 Put(tempChar);
                              End If;
                           END LOOP;
                           Put_Line("");
                        End If;
                     When quit=>
                        Exit;
                     When Others =>
                        Null;
                  End Case;
               End Loop;
            END;
      
         WHEN int=>
         
            Declare
               count: Integer:=0;
               tempInt: integer:=-1;
               stackException: Boolean:= False;
            
               Package integer_Stack is New gStack(integer, stackSize); Use integer_Stack;
            Begin
               While 1= 1 Loop
                  Put("Enter the type of the operation i.e push, pop or quit: ");
                  Get(stackChoice);
                  Case stackChoice is
                     WHEN Push =>
                        Put("Enter integer separated by space or 0 to terminate :  ");
                        count :=0;
                        WHILE 1=1 LOOP
                           get(tempInt);
                           IF Count = 0 THEN
                              Put("Pushing..");
                           END IF;
                           Put(TempInt,0);Put(" ");
                           IF tempInt = 0 THEN
                              IF Count /=0 THEN
                                 Push(Count, stackException);
                                 IF stackException = true THEN
                                    Put_Line("Stack is full");
                                 END IF;
                                 Exit;
                              End if;
                           END IF;
                           Push(TempInt, stackException);
                           IF StackException = True THEN
                              put_Line("");
                              Put_Line("Stack is Full!!");
                              EXIT;
                           END IF;
                           Count := Count + 1;
                        END LOOP;
                        Put_Line(" ");
                  
                     When pop =>
                        pop(count, stackException);
                        If stackException = True Then
                           Put("Stack is Empty");
                           Put_Line(" ");
                        ELSE
                           Put(Count); Put(", ");
                           FOR i in 1..Count LOOP
                              Pop(tempInt,stackException);
                              IF stackException = True THEN
                                 Put_Line("Stack is Empty");
                                 EXIT;
                              ELSE
                                 Put(tempInt,0); Put(",  ");
                              END IF;
                           END LOOP;
                           Put_Line("");
                        End If;
                     When quit=>
                        Exit;
                     When Others =>
                        Null;
                  END CASE;
               END LOOP;
            END;
      
         When date=>
            DECLARE
               TempMonth: MonthName;
               TempDay: Integer;
               TempYear:Integer;
               TempDate:DateType;
               Count:integer:=0;
               StackException:Boolean;
            
               PACKAGE Count_Stack IS NEW GStack(Integer, stackSize);
               PACKAGE Date_Stack IS NEW GStack(DateType, stackSize);
            BEGIN
               WHILE 1=1 LOOP
                  Put("Date: push, pop, or quit: ");
                  Get(StackChoice);
                  CASE StackChoice IS
                     WHEN Push=>
                        Put_Line("Enter date (Format: Month day year) or 'Done' for termination: ");
                        count:=0;
                     
                        WHILE 1=1 LOOP
                           Get(TempMonth);
                           if TempMonth = Done then
                              Count_Stack.Push(Count,StackException);
                              IF StackException = True THEN
                                 Put_Line("stack is full");
                                 put_Line("");
                              End if;
                              Exit;
                           END IF;
                           Get(TempDay);
                           get(TempYear);
                           TempDate:=(TempMonth,TempDay,TempYear);
                           Date_Stack.push(TempDate,stackException);
                           IF StackException = True THEN
                              Put_Line("stack is full");
                              Exit;
                           End if;
                           count := count + 1;
                        END LOOP;
                  
                     WHEN Pop =>
                        Count_Stack.pop(count,stackException);
                        if stackException = true then
                           Put_Line("stack is Empty");
                           put_Line(" ");
                        ELSE
                           Put(count); Put(": ");
                           for i in 1..count loop
                              Date_Stack.pop(TempDate,stackException);
                              if stackException = True then
                                 Put_Line("stack is empty");
                                 Exit;
                              END IF;
                              Put(TempDate.Month);
                              put(" ");
                              Put(TempDate.Day,0);
                              put(" ");
                              Put(TempDate.Year,0);
                              put(", ");
                           End Loop;
                           Put_Line(" ");
                        End if;
                     WHEN quit=>
                        Exit;
                     WHEN others =>
                        Null;
                  End case;
               End Loop;
            END;
      
         WHEN Quit =>
         
            Exit;
         When Others =>
            Null;
      End Case;
   END LOOP;
End Program1;
