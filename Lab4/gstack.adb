--Parameshor Bhandari
--COSC 3319
--2/21/2015

Package Body gstack is
   Stack: Array(1..max) of MyType;
   top:integer Range 0..max;
   procedure push(x: in MyType; y: out Boolean) is
   Begin
        If(top <max)Then
            top:= top+1;
            Stack(top):=x;
            y:= False ;
        Else
            y:= True;
        End If;
   End push;

   Procedure pop(x:out MyType; y: out Boolean) is
   Begin
        If(top = 0)Then
            y:= True;
        Else
            x:= Stack(top);
            top:= top-1;
            y:= False;
        End If;
   End pop;
   Begin
         top:= 0; --initialize top if stack to empty
 End gstack;
          