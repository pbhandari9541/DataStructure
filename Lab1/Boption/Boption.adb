With Ada.Text_IO; Use Ada.Text_IO;
with Unchecked_Conversion;
with gStack;

procedure Program1 is
   type DataType is (char, int, date, quit);
   type StackOption is (push, pop, quit);

   package DataType_IO is New Ada.Text_IO.Enumeration_IO(DataType); use DataType_IO;
   Package StackOption_IO is New Ada.Text_IO.Enumeration_IO(StackOption);use StackOption_IO;

   package MyInt_IO is New Ada.Text_IO.integer_IO(integer);use MyInt_IO;

   function integerToCharacter is New Unchecked_Conversion(Integer,Character);
   function characterToInteger is New Unchecked_Conversion(Character, Integer);

   stackSize: Integer;
   stackType: DataType;
   stackChoice: StackOption;

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
                                 Exit;
                              End if;
                           End Loop;
                        End If;
                     
                        If stackException = False Then
                           tempChar:= integerToCharacter(charLength);
                           push(tempChar, stackException);
                           If stackException = True Then
                              Put("Stack is Full");
                           End If;
                        End If;
                     When pop =>
                        pop(tempChar, stackException);
                        If stackException = True Then
                           Put("Stack is Empty");
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
      
         WHEN Int=>
         
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
                        Put("Enter integer separated by comma i.e 12,16,20 etc :  ");
                        Put_line("");
                        count :=0;
                        WHILE 1=1 LOOP
                           get(tempInt);
                           IF Count = 0 THEN
                              Put("Pushing..");
                           END IF;
                           Put(tempInt,0);Put(" ");
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
                           IF stackException = true THEN
                              Put_Line("Stack is Full!!");
                              EXIT;
                           END IF;
                           Count := Count + 1;
                        END LOOP;
                        Put_Line("");
                  
                     When pop =>
                        pop(count, stackException);
                        If stackException = True Then
                           Put("Stack is Empty");
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
                  End Case;
               End Loop;
            END;
      
         When quit =>
            Exit;
         When Others =>
            Null;
      End Case;
   END LOOP;
End Program1;