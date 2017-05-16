--Parameshor Bhandari
--COSC 3319 Data Structure
--B Option
--Lab 3
--04/02/2015
WITH Ada.Text_IO; USE Ada.Text_IO;
PACKAGE BODY GenericTopologicalSort IS
   PACKAGE MyInt_IO IS NEW Ada.Text_IO.Integer_IO(Integer); USE MyInt_IO;
   TYPE Node;
   TYPE NodePointer IS ACCESS Node;
   TYPE Node IS TAGGED RECORD
      Suc: Integer;
      Next: NodePointer;
   END RECORD;

   TYPE JobElement IS RECORD
      Count:Integer :=0;
      Top: NodePointer := NULL;
   END RECORD;

   SortStructure: ARRAY(0..NumElements) OF JobElement;
   NumberOfAction: Integer:= NumElements;
   K:Integer:=1;
   P: NodePointer;

  -- Get the relation J < K
   PROCEDURE GetRelation(J: IN Integer; K:IN Integer) IS

   BEGIN
      SortStructure(K).Count := SortStructure(K).Count + 1;
      P:= NEW Node;
      P.Suc:= K;
      P.Next:= SortStructure(J).Top;
      SortStructure(J).Top:= P;
   END GetRelation;

   PROCEDURE TopologicalSort IS
      F,R : Integer :=0;
   BEGIN
      SortStructure(0).Count:= 0;
      FOR K IN 1..NumElements LOOP
         IF SortStructure(K).Count = 0 THEN
            SortStructure(R).Count := K;
            R:= K;
         END IF;
      END LOOP;

      F:= SortStructure(0).Count;SortStructure(0).Count := 0;

      WHILE F /= 0 LOOP
         Put(F,0); Put(" ");
         NumberOfAction := NumberOfAction -1;
         P:= SortStructure(F).Top;SortStructure(F).Top:=NULL;
         WHILE P /= NULL LOOP
            SortStructure(P.Suc).Count := SortStructure(P.Suc).Count - 1;
            IF SortStructure(P.Suc).Count = 0 THEN
               SortStructure(R).Count:= P.Suc;--Add to Output Queue
               R:=P.Suc;
            END IF;
            P:= P.Next;
         END LOOP;
         F:= SortStructure(F).Count;
      END LOOP;

      IF NumberOfAction /= 0 THEN
         Put_Line(" ");
         Put_Line("No Solution.");
         Put("The remaining"); Put(NumberOfAction,0); Put_Line(" element contain at least one loop");

         FOR L IN 1..NumElements LOOP
            P:= SortStructure(L).Top; SortStructure(L).Top:=NULL;

            WHILE P /= NULL LOOP
               IF SortStructure(P.Suc).Count = 0 THEN
                  SortStructure(P.Suc).COUNT := L;
                  P:= P.Next;
               END IF;
            END LOOP;

         END LOOP;

         WHILE SortStructure(K).Count = 0 LOOP
            K:= K + 1;
         END LOOP;

         LOOP
            SortStructure(K).Top:= NEW Node;
            K:=SortStructure(K).Count;
            EXIT WHEN SortStructure(K).Top /=NULL;
         END LOOP;


         Put_Line(" "); Put("Element in the loop: ");
         WHILE SortStructure(K).Top /= NULL LOOP
            Put(K,0); Put("  ");
            SortStructure(K).Top := NULL;
            K:= SortStructure(K).Count;
         END LOOP;

         Put_Line(""); Put(K,0); Put_Line(" is the first element in the loop");

      END IF;

   END TopologicalSort;
END GenericTopologicalSort;



