--Parameshor Bhandari
--COSC 3319
--2/21/2015

generic
   type MyType is private;
   max: positive;

package gStack is
   procedure push(x: in MyType; y : out Boolean);
   procedure pop(x: out MyType; y : out Boolean);
end gStack;
   