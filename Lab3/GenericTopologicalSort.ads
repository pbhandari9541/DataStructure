--Parameshor Bhandari
--COSC 3319 Data Structure
--B Option
--Lab 3
--04/02/2015
GENERIC

   NumElements: Integer;

PACKAGE GenericTopologicalSort IS

   PROCEDURE GetRelation(J: IN Integer; K: IN Integer);
   PROCEDURE TopologicalSort;

END GenericTopologicalSort; 