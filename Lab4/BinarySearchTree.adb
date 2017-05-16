--Parameshor Bhandari
--CS3319
--Lab 4
--B Option
--Dr. Burris


WITH Ada.Text_IO; USE Ada.Text_IO;
WITH Ada.Unchecked_Deallocation;
WITH Ada.Numerics.Generic_Elementary_Functions;


PACKAGE BODY BinarySearchTree IS
   Count: Integer := 0;
   Root: Pointer;

   PROCEDURE Free IS NEW Ada.Unchecked_Deallocation(Node, Pointer);
   PROCEDURE Insert(AData: IN Data) IS
      FindPoint, Q: Pointer;
   BEGIN
      Q := NEW Node;
      Q.Info := AData;
      IF Root.LLink = Root THEN
         Q.LTag := True;
         Q.RTag := True;
         Q.LLink := Q;
         Q.RLink := Root;
         Root.LLink := Q;
         Root.LTag := False;
         Count := Count + 1;
         RETURN;
      END IF;

      FindPoint := Root.LLink;

      LOOP
         IF GetKey(AData) < FindPoint.Info THEN
            IF FindPoint.LTag = True THEN
               Q.LLink := FindPoint.LLink;
               Q.LTag := FindPoint.LTag;
               FindPoint.LLink := Q;
               FindPoint.LTag := False;
               Q.RTag := True;
               Q.RLink := FindPoint;
               IF Q.LTag = False THEN
                  InOrderPredecessor(Q).RLink := Q;
               END IF;
               Count := Count + 1;
               EXIT;
            ELSE
               FindPoint := FindPoint.LLink;
            END IF;
         ELSE
            IF FindPoint.RTag = True THEN
               Q.RLink := FindPoint.RLink;
               Q.RTag := FindPoint.RTag;
               FindPoint.RLink := Q;
               FindPoint.RTag := False;
               Q.LTag := True;
               Q.LLink := FindPoint;
               IF Q.RTag = False THEN
                  InOrderSuccessor(Q).LLink := Q;
               END IF;
               Count := Count + 1;
               EXIT;
            ELSE
               FindPoint := FindPoint.RLink;
            END IF;
         END IF;
      END LOOP;
   END Insert;


   FUNCTION InOrderSuccessor(P: IN Pointer) RETURN Pointer IS
      Q: Pointer;
   BEGIN
      Q := P.RLink;
      IF P.RTag = False THEN
         WHILE Q.LTag = False LOOP
            Q := Q.LLink;
         END LOOP;
      END IF;
      RETURN Q;
   END InOrderSuccessor;

   FUNCTION InOrderPredecessor(P: IN Pointer) RETURN Pointer IS
      Q: Pointer;
   BEGIN
      Q := P.LLink;
      IF P.LTag = False THEN
         WHILE Q.RTag = False LOOP
            Q := Q.RLink;
         END LOOP;
      END IF;
      RETURN Q;
   END InOrderPredecessor;

   PROCEDURE Find_I(AKey: IN Key; OutData: OUT Data; Failed: OUT Boolean) IS
      FindPoint: Pointer;
   BEGIN
      Failed := False;
      FindPoint := Root.LLink;
      LOOP
         IF FindPoint.LLink = Root THEN
            Put_Line("Tree is empty or item does not exist.");
            EXIT;
         END IF;
         IF AKey < FindPoint.Info THEN
            IF FindPoint.LTag = True THEN
               Failed := True;
               Put_Line("Using iterative method, Item does not exist.");
               EXIT;
            ELSE
               FindPoint := FindPoint.LLink;
            END IF;
         ELSIF AKey > FindPoint.Info THEN
            IF FindPoint.RTag = True THEN
               Failed := True;
               Put_Line("Using iterative method, Item does not exist.");
               EXIT;
            ELSE
               FindPoint := FindPoint.RLink;
            END IF;
         ELSE
            OutData := FindPoint.Info;
            EXIT;
         END IF;
      END LOOP;
   END Find_I;

   FUNCTION Find_I(AKey: IN Key) RETURN Pointer IS
      FindPoint: Pointer;
   BEGIN
      FindPoint := Root.LLink;
      LOOP
         IF FindPoint.LLink = Root THEN
            Put_Line("Tree is empty.");
            RETURN NULL;
         END IF;
         IF AKey < FindPoint.Info THEN
            IF FindPoint.LTag = True THEN
               RETURN NULL;
            ELSE
               FindPoint := FindPoint.LLink;
            END IF;
         ELSIF AKey > FindPoint.Info THEN
            IF FindPoint.RTag = True THEN
               RETURN NULL;
            ELSE
               FindPoint := FindPoint.RLink;
            END IF;
         ELSE
            RETURN FindPoint;
         END IF;
      END LOOP;
   END Find_I;

   PROCEDURE Find_R(AKey: IN Key; OutData: OUT Data; Failed: OUT Boolean) IS
      PROCEDURE FindNode_R(FindPoint: IN Pointer; AKey: IN Key; OutData: OUT Data) IS
      BEGIN
         IF FindPoint /= Root THEN
            IF AKey < FindPoint.Info THEN
               FindNode_R(FindPoint.LLink, AKey, OutData);
            ELSIF AKey > FindPoint.Info THEN
               FindNode_R(FindPoint.RLink, AKey, OutData);
            ELSE
               OutData := FindPoint.Info;
            END IF;
         ELSE
            Failed := True;
            Put_Line("Using recursive method, Item does not exist.");
         END IF;
      END FindNode_R;

   BEGIN
      Failed := False;
      IF Root.LLink = Root THEN
         Put_Line("Tree is empty.");
      ELSE
         FindNode_R(Root.LLink, AKey, OutData);
      END IF;
   END Find_R;

   PROCEDURE Delete(AKey: IN Key) IS
      Q, T, R, S: Pointer;
   BEGIN
      Q := Find_I(AKey);
      T := Q;
      IF T.RTag = True THEN
         Q := T.LLink;
         Free(T);
      ELSE
         IF T.LTag = True THEN
            Q := T.RLink;
            Free(T);
         END IF;
         R := T.RLink;
         IF R.LTag = True THEN
            R. LLink := T.LLink;
            Q := R;
            Free(T);
         ELSE
            S := R.LLink;
            WHILE S.LTag = True LOOP
               R := S;
               S := R.LLink;
            END LOOP;
            S.LLink := T.Llink;  R.LLink := S.RLink;
            S.RLink := T.RLink;  Q := S;
            Free(T);
         END IF;
      END IF;
      IF T = Root THEN
         Root := Q;
      ELSE
         IF T /= NULL THEN
            T.LLink := Q;
         ELSE
            T.RLink := Q;
         END IF;
      END IF;
   END Delete;

   FUNCTION Size RETURN Integer IS
   BEGIN
      RETURN Count;
   END Size;

   PROCEDURE PreOrder_R IS
      PROCEDURE PreOrderNode_R(Point: IN Pointer) IS
      BEGIN
         IF Point /= Root THEN
            Print(Point.Info);Put(", ");
            IF Point.LTag = False THEN
               PreOrderNode_R(Point.LLink);
            END IF;
            IF Point.RTag = False THEN
               PreOrderNode_R(Point.RLink);
            END IF;
         END IF;
      END PreOrderNode_R;
   BEGIN
      IF Root = Root.LLink THEN
         Put_Line("Tree is empty.");
      ELSE
         PreOrderNode_R(Root.LLink);
      END IF;
   END PreOrder_R;

   PROCEDURE PreOrder_I IS
      Point: Pointer := Root.LLink;
   BEGIN
      IF Root = Root.LLink THEN
         Put_Line("Tree is empty.");
      ELSE
         LOOP
            IF Point = Root THEN
               EXIT;
            END IF;
            Print(Point.Info); Put(", ");
            IF Point.LTag = False THEN
               Point := Point.LLink;
            ELSE
               IF Point.RTag = False THEN
                  Point := Point.RLink;
               ELSE
                  Point := Point.RLink.RLink;
               END IF;
            END IF;
         END LOOP;
      END IF;
   END PreOrder_I;

   PROCEDURE InOrder_R IS
      PROCEDURE InOrderNode_R(Point: IN Pointer) IS
      BEGIN
         IF Point /= Root THEN
            IF Point.LTag = False THEN
               InOrderNode_R(Point.LLink);
            END IF;
            Print(Point.Info);Put(", ");
            IF Point.RTag = False THEN
               InOrderNode_R(Point.RLink);
            END IF;
         END IF;
      END InOrderNode_R;

   BEGIN
      IF Root = Root.LLink THEN
         Put_Line("Tree is empty.");
      ELSE
         InOrderNode_R(Root.LLink);
      END IF;
   END InOrder_R;

   PROCEDURE InOrder_R(AKey: IN Key) IS
      PROCEDURE InOrderNode_R(Point: IN Pointer) IS
      BEGIN
         IF Point /= Root THEN
            IF Point.LTag = False THEN
               InOrderNode_R(Point.LLink);
            END IF;
            Print(Point.Info);Put(", ");
            IF Point.RTag = False THEN
               InOrderNode_R(Point.RLink);
            END IF;
         END IF;
      END InOrderNode_R;

      StartPoint: Pointer;

   BEGIN
      IF Root = Root.LLink THEN
         Put_Line("Tree is empty.");
      ELSE
         StartPoint := Find_I(AKey);
         IF StartPoint /= NULL THEN
            InOrderNode_R(StartPoint);
         ELSE
            Put_Line("Item could not be found. Aborting traversal.");
         END IF;
      END IF;
   END InOrder_R;

   PROCEDURE ReverseOrder_R IS
      PROCEDURE ReverseOrderNode_R(Point: IN Pointer) IS
      BEGIN
         IF Point /= Root THEN
            IF Point.RTag = False THEN
               ReverseOrderNode_R(Point.RLink);
            END IF;
            Print(Point.Info);Put(", ");
            IF Point.LTag = False THEN
               ReverseOrderNode_R(Point.LLink);
            END IF;
         END IF;
      END ReverseOrderNode_R;

   BEGIN
      IF Root = Root.LLink THEN
         Put_Line("Tree is empty.");
      ELSE
         ReverseOrderNode_R(Root.LLink);
      END IF;
   END ReverseOrder_R;


BEGIN
   Root := NEW Node;
   Root.LTag := False;
   Root.RTag := True;
   Root.LLink := Root;
   Root.RLink := Root.LLink;

END BinarySearchTree;



