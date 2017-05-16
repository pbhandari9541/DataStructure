--Parameshor Bhandari
--CS3319 Data Structure
--Lab 2
GENERIC

   LeftBound: Integer;
   RightBound: Integer;
   L0: Integer;
   Size: Integer;
   NumStacks: Positive;
   TYPE Item IS PRIVATE;
   WITH PROCEDURE Put(X: Item);  -- required for printing

   PACKAGE GenericStack IS

      PROCEDURE Push(X: IN Item; Stk: IN Positive; Exception_Result: OUT Boolean);
      PROCEDURE Pop(X: OUT Item; Stk: IN Positive; Exception_Result: OUT Boolean);
      PROCEDURE Repack(CurStack: IN Positive; Exception_Repack: OUT Boolean);
      PROCEDURE SetMinSpace(Min: IN Positive);
      PROCEDURE PrintContents;
      PROCEDURE PrintTopsAndBottoms;
   END GenericStack;



