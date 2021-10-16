$event:=FORM Event:C1606

Case of 
	: ($event.code=On Drop:K2:12)
		
		If (Form:C1466.Table_1.dragItem#Null:C1517)
			
			If (Drop position:C608=-1)
				
/*
				
item was moved down and dropped below the last row with data
				
*/
				
				Form:C1466.Table_1.col.push(Form:C1466.Table_1.dragItem.item)
				Form:C1466.Table_1.col.remove(Form:C1466.Table_1.dragItem.pos-1)
			Else 
				
				If (Drop position:C608>Form:C1466.Table_1.dragItem.pos)
					
/*
					
item was moved down
					
*/
					
					Form:C1466.Table_1.col.remove(Form:C1466.Table_1.dragItem.pos-1)
					Form:C1466.Table_1.col.insert(Drop position:C608-1;Form:C1466.Table_1.dragItem.item)
				Else 
					
/*
					
item was moved up
					
*/
					
					Form:C1466.Table_1.col.insert(Drop position:C608-1;Form:C1466.Table_1.dragItem.item)
					Form:C1466.Table_1.col.remove(Form:C1466.Table_1.dragItem.pos)
				End if 
			End if 
			
		End if 
		
		SET CURSOR:C469
		
	: ($event.code=On Drag Over:K2:13)
		
		$accept:=False:C215
		
		If (Form:C1466.Table_1.dragItem#Null:C1517)
			
			GET MOUSE:C468($MouseX;$MouseY;$MouseB)
			
/*
			
the event fires on headers and footers
we need to know the header height
in order to only accept drop on rows
			
*/
			
			OBJECT GET COORDINATES:C663(*;$event.objectName;$x;$y;$right;$bottom)
			
			$headerHeight:=LISTBOX Get headers height:C1144(*;$event.objectName)
			
			Case of 
				: (Drop position:C608#Form:C1466.Table_1.dragItem.pos)\
					 & (Drop position:C608#-1)
					
/*
					
drop on a line other than the origin
					
*/
					
					$accept:=True:C214
					
				: (Drop position:C608=-1)\
					 & (Form:C1466.Table_1.dragItem.pos#Form:C1466.Table_1.col.length)\
					 & ($mouseY>($y+$headerHeight))
					
/*
					
drop on a line below the fine row with data
					
*/
					
					$accept:=True:C214
					
			End case 
		End if 
		
/*
		
if we manipulate the cursor by code
we must not return $0:=-1
because we need the on drop event to restore it
even if technically we refuse it in the sense that we do not move the line
		
*/
		
		If ($accept)
			SET CURSOR:C469(9016)
			  //$0:=0
		Else 
			SET CURSOR:C469(9019)
			  //$0:=-1
		End if 
		
	: ($event.code=On Begin Drag Over:K2:44)
		
/*
		
normally it is better to store drag and drop context in the pasteboard
however, here we implement drag and drop within the same object
so the context is stored in "Form"
		
*/
		
		Form:C1466.Table_1.dragItem:=New object:C1471("pos";Form:C1466.Table_1.pos;"item";Form:C1466.Table_1.item)
		
/*
		
force single select;
only support drag and drop one item at a time
		
*/
		
		LISTBOX SELECT ROW:C912(*;$event.objectName;Form:C1466.Table_1.pos;lk replace selection:K53:1)
		
End case 