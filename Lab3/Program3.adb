--Parameshor Bhandari
--COSC 3319 Data Structure
--B Option
--Lab 3
--04/02/2015

WITH Ada.Text_IO; USE Ada.Text_IO;
WITH GenericTopologicalSort;


PROCEDURE Program3 IS

   PACKAGE Iio IS NEW Ada.Text_IO.Integer_IO(Integer); USE Iio;
   NumElements:Integer;

BEGIN
   Put("Elements: ");
   Get(NumElements);

   DECLARE

      PACKAGE Topo IS NEW GenericTopologicalSort(NumElements); USE Topo;
      InputComplete: Boolean := False;
      Resp: Character := 'N';
      J, K: Integer;

   BEGIN
		--Input relations
      WHILE InputComplete = False LOOP
         Put("Enter 1st : "); Get(J);
         Put("Enter 2nd: "); Get(K);
         GetRelation(J,K);
         Put("Done (y/n): "); Get(Resp);
         IF Resp = 'Y' or Resp = 'y' THEN
            InputComplete := True;
         END IF;
      END LOOP;

		--Sort relations
      Put_Line(""); Put_Line(""); Put("Sorted order is: ");
      TopologicalSort;
   END;
END Program3;


