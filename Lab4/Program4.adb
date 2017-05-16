--Parameshor Bhandari
--COSC3319
--Lab 4
--B Option
--Dr. Burris

WITH Ada.Text_IO; USE Ada.Text_IO;
WITH BinarySearchTree;

PROCEDURE Program4 IS

   TYPE String13 IS ARRAY(1..13) OF Character;
   TYPE Customer IS RECORD
         Name: String13;
         PhoneNumber: String13;
      END RECORD;

   FUNCTION CustomerKey(Cust: IN Customer) RETURN String13 IS
   BEGIN
      RETURN Cust.Name;
   END CustomerKey;

   PROCEDURE CustomerPrint(Cust: IN Customer) IS
   BEGIN
      Put(String(Cust.Name));Put(" ");Put(String(Cust.PhoneNumber));

   END CustomerPrint;


   FUNCTION "<"(Name: IN String13; Cust: IN Customer) RETURN Boolean IS
   BEGIN
      IF Name < Cust.Name THEN
         RETURN True;
      ELSE
         RETURN False;
      END IF;
   END "<";

   FUNCTION ">"(Name: IN String13; Cust: IN Customer) RETURN Boolean IS
   BEGIN
      IF Name > Cust.Name THEN
         RETURN True;
      ELSE
         RETURN False;
      END IF;
   END ">";

   FUNCTION "="(Name: IN String13; Cust: IN Customer) RETURN Boolean IS
   BEGIN
      IF Name = Cust.Name THEN
         RETURN True;
      ELSE
         RETURN False;
      END IF;
   END "=";

   PACKAGE BinaryThreadTree IS NEW
   BinarySearchTree(String13,Customer,CustomerKey,CustomerPrint,"<",">","="); USE BinaryThreadTree;

BEGIN
   DECLARE
      CurCust: Customer;
      Failed: Boolean := False;
   BEGIN
      --OPTION C
      CurCust := ("Plattenberger","295-1492     "); Insert(CurCust);put("insertion of ");put(string(curcust.name));put_Line("...successfull");
      CurCust := ("Melkus       ","291-1864     "); Insert(CurCust);put("insertion of ");put(string(curcust.name));put_Line("...successfull");
      CurCust := ("Qamruddin    ","295-1601     "); Insert(CurCust);put("insertion of ");put(string(curcust.name));put_Line("...successfull");
      CurCust := ("Casper       ","293-6122     "); Insert(CurCust);put("insertion of ");put(string(curcust.name));put_Line("...successfull");
      CurCust := ("Aguirre      ","295-1882     "); Insert(CurCust);put("insertion of ");put(string(curcust.name));put_Line("...successfull");
      CurCust := ("Cook         ","291-7890     "); Insert(CurCust);put("insertion of ");put(string(curcust.name));put_Line("...successfull");
      CurCust := ("Vandort      ","294-8075     "); Insert(CurCust);put("insertion of ");put(string(curcust.name));put_Line("...successfull");
      CurCust := ("Keo          ","584-3622     "); Insert(CurCust);put("insertion of ");put(string(curcust.name));put_Line("...successfull");

      Find_I("Casper       ", CurCust, Failed);
      IF Failed /= True THEN
         CustomerPrint(CurCust); Put_Line("..is found");

      END IF;

      Find_R("Casper       ", CurCust, Failed);
      IF Failed /= True THEN
         CustomerPrint(CurCust); Put_Line(" ..is found");
      END IF;

      Find_I("Newton       ", CurCust, Failed);
      IF Failed /= True THEN
         CustomerPrint(CurCust); Put_Line("..is found");

      END IF;

      Find_R("Newton       ", CurCust, Failed);
      IF Failed /= True THEN
         CustomerPrint(CurCust); Put_Line("..is found");
      END IF;
      Put_Line("Inorder sequence starting from Cook(recursive):");
      InOrder_R("Cook         "); Put_Line("");

      CurCust := ("Vickers      ","294-1568     "); Insert(CurCust);put("insertion of ");put(string(curcust.name));put_Line("...successfull");
      CurCust := ("Gunn         ","294-1882     "); Insert(CurCust);put("insertion of ");put(string(curcust.name));put_Line("...successfull");
      CurCust := ("Zulfiqar     ","295-6622     "); Insert(CurCust);put("insertion of ");put(string(curcust.name));put_Line("...successfull");

      Put_Line("Inorder sequence starting from root(recursive):");
      InOrder_R; Put_Line(""); Put_Line("");
      Put_Line("Here");
      --OPTION B
      CurCust := ("Plattenberger","294-1568     "); Delete(CurCust.Name);put("Deletion of ");put(string(curcust.name));put_Line("...successfull");
      CurCust := ("Cook         ","294-1882     "); Delete(CurCust.Name);put("Deletion of ");put(string(curcust.name));put_Line("...successfull");
      CurCust := ("Aquirra      ","295-6622     "); Delete(CurCust.Name);put("Deletion of ");put(string(curcust.name));put_Line("...successfull");
      CurCust := ("Novac        ","294-1666     "); Insert(CurCust)Casper        293-6122     ;put("insertion of ");put(string(curcust.name));put_Line("...successfull");
      CurCust := ("Ellington    ","295-1882     "); Insert(CurCust);put("insertion of ");put(string(curcust.name));put_Line("...successfull");

      Put_Line("Inorder sequence starting from root(recursive):");
      InOrder_R; Put_Line(""); Put_Line("");

      Put_Line("Reverse Inorder sequence starting from root(recursive):");
      ReverseOrder_R; Put_Line(""); Put_Line("");

      Put_Line("Preorder sequence starting from root(iterative):");
      PreOrder_I; Put_Line(""); Put_Line("");


   END;

END Program4;

