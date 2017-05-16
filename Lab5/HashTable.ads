--Parameshor Bhandari
--COSC3319
--Lab 5
--A Option
--04/10/2015


GENERIC

  TYPE Item IS PRIVATE;
  Table_Size: Long_Integer;

  --Required for Printing the table
  WITH PROCEDURE Put(X: Item);

  --Required to retrieve the key from the object data.
  WITH PROCEDURE Key(X: Item; Y: OUT String);
  PACKAGE HashTable IS

      PROCEDURE Initialize(Collisiontype: IN Integer; Nullitem: IN Item; Removeditem: IN Item);
      PROCEDURE Insert(Key: IN String; Data: IN Item);
      PROCEDURE Remove(Key: IN String; Data: OUT Item);
      PROCEDURE Get(Key: IN String; Data: OUT Item);
      PROCEDURE GetMinProbes(X: OUT Integer);
      PROCEDURE GetMaxProbes(X: OUT Integer);
      PROCEDURE GetAvgProbes(X: OUT Float);
      PROCEDURE ResetStatistics;
      PROCEDURE PrintTable;
      PROCEDURE ResetTable;
      PROCEDURE SetCollisionHandler(Collisiontype: IN Integer);
   END HashTable;





