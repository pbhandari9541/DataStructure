--Parameshor Bhandari
--COSC 3319 Data Structure
--Lab 2
--A Option
--03/06/2015

WITH Ada.Text_IO; USE Ada.Text_IO;
WITH GenericStack;


PROCEDURE Program2 IS

   PACKAGE Int_io IS NEW Ada.Text_IO.Integer_IO(Integer); USE Int_io;

   LBound:Integer; UBound:Integer;
   Start:Integer; Usesize:Integer;
   StackAmt:Integer;


   TYPE String16 IS ARRAY(1..16) OF Character;


   PROCEDURE Str16_Print(Str: String16) IS
   BEGIN
      Put(String(Str));
   END Str16_Print;


   PROCEDURE FillEmptyGap(Str: IN OUT String16; Len: Integer) IS
   BEGIN
      FOR I IN (Len+1)..16 LOOP
         Str(I) := ' ';
      END LOOP;
   END FillEmptyGap;

   TYPE MonthName IS (January, February, March, April, May, June, July, August,
      September, October, November, December, D);
   TYPE DataType IS (Character, Date, Quit);

   package Data_Io IS NEW Ada.Text_IO.Enumeration_IO(DataType);USE Data_IO;

   PACKAGE Monthio IS NEW Ada.Text_IO.Enumeration_IO(MonthName); USE Monthio;

   StackType:DataType;
   TYPE DateType IS RECORD
      Month: MonthName;
      Day: Integer RANGE 1..31;
      Year: Integer RANGE 1400..2020;
   END RECORD;

   PROCEDURE Date_Print(Date: DateType) IS

   BEGIN
      Put(Date.Month,0);Put(" ");Put(Date.Day,0);Put(", ");Put(Date.Year,0);
   END Date_Print;

BEGIN

   WHILE 1 = 1 LOOP
      Put("Enter the type of data i.e Character , Date or quit:  ");
      Get(StackType);
      Put("Enter the lower bound of the stack space: "); Get(LBound);
      Put("Enter the upper bound of the stack space: "); Get(UBound);
      Put("Enter the starting index of the multistack: "); Get(Start);
      Put("Enter the size of the multistack: "); Get(Usesize);
      Put("Enter the number of stacks : "); Get(StackAmt);
      Put_Line("");
      Put("Creating stack space from ");Put(LBound,0);Put(" to ");Put(UBound,0);Put(". Using an index of ");Put(Start,0);
      Put(" and size of ");Put(Usesize,0);Put(" with ");Put(StackAmt,0);Put(" stacks.");Put_Line("");
      New_Line;

      CASE StackType IS
         WHEN Character =>

            DECLARE
               PACKAGE Multi_Stack1 IS NEW GenericStack(LeftBound=>LBound,RightBound=>UBound,L0=>Start,Size=>Usesize,NumStacks=>StackAmt,Item=>String16,Put=>Str16_Print);
               Stack_Exception:Boolean;
               Cur_Stack:Integer:=0;
               Cur_Data:String16;
               Templen:Integer;

            BEGIN
               Put_Line("Enter stack data: ");
               WHILE Cur_Stack /= -1 LOOP
                  Get(Cur_Stack);
                  IF Cur_Stack = -1 THEN
                     Put_Line("END OF DATA SET");
                     EXIT;
                  END IF;
                  Get_Line(String(Cur_Data),Templen);
                  FillEmptyGap(Cur_Data,Templen);
                  IF Cur_Data = "D               " THEN
                     Put("Attempting to POP stack ");Put(Cur_Stack,0);Put("...");
                     Multi_Stack1.Pop(Cur_Data,Cur_Stack,Stack_Exception);
                     IF NOT Stack_Exception THEN
                        Put("Sucessful!");Put_Line("");
                     ELSE
                        Put("Failed! [UNDERFLOW]");Put_Line("");
                     END IF;
                  ELSE
                     Put("Attempting to PUSH ");Str16_Print(Cur_Data);Put(" to stack ");Put(Cur_Stack,0);Put("...");
                     Multi_Stack1.Push(Cur_Data,Cur_Stack,Stack_Exception);
                     IF NOT Stack_Exception THEN
                        Put("Sucessful!");Put_Line("");
                     ELSE
                        Put("Failed! [OVERFLOW]");Put_Line("");
                     END IF;
                  END IF;
               END LOOP;
            END;
         WHEN Date =>

            DECLARE
               PACKAGE Multi_Stack2 IS NEW GenericStack(LeftBound=>LBound,RightBound=>UBound,L0=>Start,Size=>Usesize,NumStacks=>StackAmt,Item=>DateType,Put=>Date_Print);
               Stack_Exception:Boolean;
               Cur_Stack:Integer:=0;
               Cur_Data:DateType;
               Tempmonth:MonthName;
               Tempday:Integer;
               Tempyear:Integer;

            BEGIN
               Put_Line("Enter stack data: ");
               WHILE Cur_Stack /= -1 LOOP
                  Get(Cur_Stack);
                  IF Cur_Stack = -1 THEN
                     Put_Line("END OF DATA SET");
                     EXIT;
                  END IF;
                  Get(Tempmonth);
                  IF Tempmonth = D THEN
                     Put("Attempting to POP stack ");Put(Cur_Stack,0);Put("...");
                     Multi_Stack2.Pop(Cur_Data,Cur_Stack, Stack_Exception);
                     IF NOT Stack_Exception THEN
                        Put("Sucessful!");Put_Line("");
                     ELSE
                        Put("Failed! [UNDERFLOW]");Put_Line("");
                     END IF;
                  ELSE
                     Get(Tempday);
                     Get(Tempyear);
                     Cur_Data := (Tempmonth,Tempday,Tempyear);
                     Put("Attempting to PUSH ");Date_Print(Cur_Data);Put(" to stack ");Put(Cur_Stack,0);Put("...");
                     Multi_Stack2.Push(Cur_Data,Cur_Stack,Stack_Exception);
                     IF NOT Stack_Exception THEN
                        Put("Sucessful!");Put_Line("");
                     ELSE
                        Put("Failed! [OVERFLOW]");Put_Line("");
                     END IF;--PrintContents;
                  END IF;
               END LOOP;
            END;
         WHEN Quit =>
            EXIT;
         WHEN OTHERS =>
            NULL;
      END CASE;
   END LOOP;
END Program2;



