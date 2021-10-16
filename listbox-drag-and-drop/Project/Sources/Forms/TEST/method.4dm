$event:=FORM Event:C1606

Case of 
	: ($event.code=On Load:K2:1)
		
		$context:=New object:C1471("context";"lb.Table_1")
		
		$col:=ds:C1482.Table_1.all($context).toCollection()
		
		Form:C1466.Table_1:=New object:C1471("all";$col;"col";$col;"sel";Null:C1517;"item";Null:C1517;"pos";Null:C1517;"context";$context;"dragItem";Null:C1517)
		
End case 