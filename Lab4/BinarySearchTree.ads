--Parameshor Bhandari
--CS3319
--Lab 5
--B Option
--Dr. Burris

GENERIC

   TYPE Key IS PRIVATE;
   TYPE Data IS PRIVATE;

   WITH FUNCTION GetKey(AData: IN Data) RETURN Key;
   WITH PROCEDURE Print(AData: IN Data);
   WITH FUNCTION "<"(AKey: IN Key; AData: IN Data) RETURN Boolean;
   WITH FUNCTION ">"(AKey: IN Key; AData: IN Data) RETURN Boolean;
   WITH FUNCTION "="(AKey: IN Key; AData: IN Data) RETURN Boolean;

   PACKAGE BinarySearchTree IS

      TYPE Pointer IS LIMITED PRIVATE;
      PROCEDURE Insert(AData: IN Data);
      FUNCTION InOrderSuccessor(P: IN Pointer ) RETURN Pointer ;
      FUNCTION InOrderPredecessor(P: IN Pointer ) RETURN Pointer ;
      PROCEDURE Find_I(AKey: IN Key; OutData: OUT Data; Failed: OUT Boolean);
      PROCEDURE Find_R(AKey: IN Key;OutData: OUT Data; Failed: OUT Boolean);
      PROCEDURE Delete(AKey: IN Key);
      FUNCTION Size RETURN Integer;

      PROCEDURE PreOrder_R;
      PROCEDURE PreOrder_I;
      PROCEDURE InOrder_R;
      PROCEDURE InOrder_R(AKey: IN Key);
      PROCEDURE ReverseOrder_R;
      PRIVATE

      TYPE Node;
      TYPE Pointer IS ACCESS Node;
      TYPE Node IS RECORD
         LLink, RLink: pointer ;
         LTag, RTag: Boolean;
         Info: Data;
      END RECORD;

   END BinarySearchTree;


