--Parameshor Bhandari
--CS3319 Data Structure
--Lab 5
--A Option
--Dr. Burris

WITH Ada.Text_IO; USE Ada.Text_IO;

WITH HashTable;


PROCEDURE Program5 IS


   PACKAGE Iio IS NEW Ada.Text_IO.Integer_IO(Integer); USE Iio;

   PACKAGE Fio IS NEW Ada.Text_IO.Float_IO(Float); USE Fio;

   TYPE String16 IS ARRAY(1..16) OF Character;


   PROCEDURE String16_Put(X: IN String16) IS

   BEGIN

      Ada.Text_IO.Put(String(X));

   END String16_Put;



   PROCEDURE String16_Key(X: IN String16; Y: OUT String) IS

   BEGIN

      Y:=String(X);

   END String16_Key;


   PACKAGE Hashtbl IS NEW HashTable(String16,256,String16_Put,String16_Key); USE Hashtbl;

   Removed_Item: CONSTANT String16:=" &&&            ";

   Null_Item: CONSTANT String16:="                ";


   WordsFile:File_Type;

   Tempkey:String(1..16);

   Tempkeylen:Integer;


   Min:Integer;

   Max:Integer;

   Avg:Float;


BEGIN


   Hashtbl.Initialize(0,Null_Item,Removed_Item);

   --50% of a table size of 256 is 128 items. insertting first 128 items from Words200D16.txt
   Open(WordsFile,In_File,"Words200D16.txt");

   FOR I IN 1..128 LOOP
      IF End_Of_File(WordsFile) THEN
         Put_Line("Words200D16.txt is shorter than expected. It may be corrupt.");
         Exit;
      End If;
      Get_line(WordsFile,tempkey,tempkeylen);
      Skip_Line(WordsFile);
      insert(tempkey,string16(tempkey));
   End Loop;
   Close(WordsFile);

	--Perform a lookup on the first 30 keys inserted into the table.
	--Ada's file input requires me to close the file and reopen it in order to go back to line 1
   Open(WordsFile,In_File,"Words200D16.txt");
   For i In 1..30 Loop
      If End_Of_File(WordsFile) Then
         Put_Line("Words200D16.txt is shorter than expected. It may be corrupt.");
         Exit;
      End If;
      Get_line(WordsFile,tempkey,tempkeylen);
      Skip_Line(WordsFile);
      hashtbl.get(tempkey,string16(tempkey));
   End Loop;
   Close(WordsFile);

   Put_Line("Statistics for Part A (Linear Probe at 50% full)");
   Put_Line("Statistics of first 30 lookups:");
   getMinProbes(min); getMaxProbes(max); getAvgProbes(avg);
   put("Min probes: ");put(min);put_line("");
   put("Max probes: ");put(max);put_line("");
   put("Avg probes: ");put(avg);put_line("");
   put_line("");

	--Perform a lookup on the last 30 keys inserted into the table (128-30=98) (starting at line 98)
   Put_Line("Resetting statistics counters..."); resetStatistics;
   Open(WordsFile,In_File,"Words200D16.txt");
   Set_Line(WordsFile,128);
   For i In 1..30 Loop
      If End_Of_File(WordsFile) Then
         Exit;
      End If;
      Get_line(WordsFile,tempkey,tempkeylen);
      Skip_Line(WordsFile);
      hashtbl.get(tempkey,string16(tempkey));
   End Loop;
   Close(WordsFile);

   Put_Line("Statistics of last 30 lookups:");
   getMinProbes(min); getMaxProbes(max); getAvgProbes(avg);
   put("Min probes: ");put(min);put_line("");
   put("Max probes: ");put(max);put_line("");
   put("Avg probes: ");put(avg);put_line("");
   put_line("");

	--Printing table for part A of grading option C.
   Put_Line("Table for Part A (Linear Probe at 50% full)");
   printTable;
   put_line("");

	--Clearing table for Part B of grading option C.
   hashtbl.initialize(0,null_item,removed_item);

	--85% of a table size of 256 is 217.6 items. insertting first 218 items from Words200D16.txt
   Open(WordsFile,In_File,"Words200D16.txt");
   For i In 1..218 Loop
      If End_Of_File(WordsFile) Then
         Put_Line("Words200D16.txt is shorter than expected. It may be corrupt.");
         Exit;
      End If;
      Get_line(WordsFile,tempkey,tempkeylen);
      Skip_Line(WordsFile);
      insert(tempkey,string16(tempkey));
   End Loop;
   Close(WordsFile);

	--Perform a lookup on the first 30 keys inserted into the table.
	--Ada's file input requires me to close the file and reopen it in order to go back to line 1
   Open(WordsFile,In_File,"Words200D16.txt");
   For i In 1..30 Loop
      If End_Of_File(WordsFile) Then
         Put_Line("Words200D16.txt is shorter than expected. It may be corrupt.");
         Exit;
      End If;
      Get_line(WordsFile,tempkey,tempkeylen);
      Skip_Line(WordsFile);
      hashtbl.get(tempkey,string16(tempkey));
   End Loop;
   Close(WordsFile);

   put_line("Statistics for Part B (Linear Probe at 85% full)");

   Put_Line("Statistics of first 30 lookups:");
   getMinProbes(min); getMaxProbes(max); getAvgProbes(avg);
   put("Min probes: ");put(min);put_line("");
   put("Max probes: ");put(max);put_line("");
   put("Avg probes: ");put(avg);put_line("");
   put_line("");

	--Perform a lookup on the last 30 keys inserted into the table (218-30=188) (starting at line 188)
   Put_Line("Resetting statistics counters..."); resetStatistics;
   Open(WordsFile,In_File,"Words200D16.txt");
   Set_Line(WordsFile,188);
   For i In 1..30 Loop
      If End_Of_File(WordsFile) Then
         Exit;
      End If;
      Get_line(WordsFile,tempkey,tempkeylen);
      Skip_Line(WordsFile);
      hashtbl.get(tempkey,string16(tempkey));
   End Loop;
   Close(WordsFile);

   Put_Line("Statistics of last 30 lookups:");
   getMinProbes(min); getMaxProbes(max); getAvgProbes(avg);
   put("Min probes: ");put(min);put_line("");
   put("Max probes: ");put(max);put_line("");
   put("Avg probes: ");put(avg);put_line("");
   put_line("");

	--Printing table for part B of grading option C.
   Put_Line("Table for Part B (Linear Probe at 85% full)");
   printTable;
   put_line("");

	--Switching to random probe collision handling
   hashtbl.initialize(1,null_item,removed_item);
   Put_Line("Hashing collision handler set for random probe. (Part C)");

	--50% of a table size of 256 is 128 items. insertting first 128 items from Words200D16.txt
   Open(WordsFile,In_File,"Words200D16.txt");
   For i In 1..128 Loop
      If End_Of_File(WordsFile) Then
         Put_Line("Words200D16.txt is shorter than expected. It may be corrupt.");
         Exit;
      End If;
      Get_line(WordsFile,tempkey,tempkeylen);
      Skip_Line(WordsFile);
      insert(tempkey,string16(tempkey));
   End Loop;
   Close(WordsFile);

	--Perform a lookup on the first 30 keys inserted into the table.
	--Ada's file input requires me to close the file and reopen it in order to go back to line 1
   Open(WordsFile,In_File,"Words200D16.txt");
   For i In 1..30 Loop
      If End_Of_File(WordsFile) Then
         Put_Line("Words200D16.txt is shorter than expected. It may be corrupt.");
         Exit;
      End If;
      Get_line(WordsFile,tempkey,tempkeylen);
      Skip_Line(WordsFile);
      hashtbl.get(tempkey,string16(tempkey));
   End Loop;
   Close(WordsFile);

   put_line("Statistics for Part C (Random Probe at 50% full)");

   Put_Line("Statistics of first 30 lookups:");
   getMinProbes(min); getMaxProbes(max); getAvgProbes(avg);
   put("Min probes: ");put(min);put_line("");
   put("Max probes: ");put(max);put_line("");
   put("Avg probes: ");put(avg);put_line("");
   put_line("");

	--Perform a lookup on the last 30 keys inserted into the table (128-30=98) (starting at line 98)
   Put_Line("Resetting statistics counters..."); resetStatistics;
   Open(WordsFile,In_File,"Words200D16.txt");
   Set_Line(WordsFile,98);
   For i In 1..30 Loop
      If End_Of_File(WordsFile) Then
         Exit;
      End If;
      Get_line(WordsFile,tempkey,tempkeylen);
      Skip_Line(WordsFile);
      hashtbl.get(tempkey,string16(tempkey));
   End Loop;
   Close(WordsFile);

   Put_Line("Statistics of last 30 lookups:");
   getMinProbes(min); getMaxProbes(max); getAvgProbes(avg);
   put("Min probes: ");put(min);put_line("");
   put("Max probes: ");put(max);put_line("");
   put("Avg probes: ");put(avg);put_line("");
   put_line("");

	--Printing table for part A of grading option C.
   Put_Line("Table for Part C (Random Probe at 50% full)");
   printTable;
   put_line("");

	--Clearing table for Part B of grading option C.
   hashtbl.initialize(1,null_item,removed_item);

	--85% of a table size of 265 is 217.6 items. insertting first 218 items from Words200D16.txt
   Open(WordsFile,In_File,"Words200D16.txt");
   For i In 1..218 Loop
      If End_Of_File(WordsFile) Then
         Put_Line("Words200D16.txt is shorter than expected. It may be corrupt.");
         Exit;
      End If;
      Get_line(WordsFile,tempkey,tempkeylen);
      Skip_Line(WordsFile);
      insert(tempkey,string16(tempkey));
   End Loop;
   Close(WordsFile);

	--Perform a lookup on the first 30 keys inserted into the table.
	--Ada's file input requires me to close the file and reopen it in order to go back to line 1
   Open(WordsFile,In_File,"Words200D16.txt");
   For i In 1..30 Loop
      If End_Of_File(WordsFile) Then
         Put_Line("Words200D16.txt is shorter than expected. It may be corrupt.");
         Exit;
      End If;
      Get_line(WordsFile,tempkey,tempkeylen);
      Skip_Line(WordsFile);
      hashtbl.get(tempkey,string16(tempkey));
   End Loop;
   Close(WordsFile);

   put_line("Statistics for Part C (Random Probe at 85% full)");

   Put_Line("Statistics of first 30 lookups:");
   getMinProbes(min); getMaxProbes(max); getAvgProbes(avg);
   put("Min probes: ");put(min);put_line("");
   put("Max probes: ");put(max);put_line("");
   put("Avg probes: ");put(avg);put_line("");
   put_line("");

	--Perform a lookup on the last 30 keys inserted into the table (218-30=188) (starting at line 188)
   Put_Line("Resetting statistics counters..."); resetStatistics;
   Open(WordsFile,In_File,"Words200D16.txt");
   Set_Line(WordsFile,188);
   For i In 1..30 Loop
      If End_Of_File(WordsFile) Then
         Exit;
      End If;
      Get_line(WordsFile,tempkey,tempkeylen);
      Skip_Line(WordsFile);
      hashtbl.get(tempkey,string16(tempkey));
   End Loop;
   Close(WordsFile);

   Put_Line("Statistics of last 30 lookups:");
   getMinProbes(min); getMaxProbes(max); getAvgProbes(avg);
   put("Min probes: ");put(min);put_line("");
   put("Max probes: ");put(max);put_line("");
   put("Avg probes: ");put(avg);put_line("");
   put_line("");

	--Printing table for part B of grading option C.
   Put_Line("Table for Part C (Random Probe at 85% full)");
   printTable;
   put_line("");


End Program5;

