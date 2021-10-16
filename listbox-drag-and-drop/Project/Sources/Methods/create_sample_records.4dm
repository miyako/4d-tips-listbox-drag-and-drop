//%attributes = {}
TRUNCATE TABLE:C1051([Table_1:1])
SET DATABASE PARAMETER:C642([Table_1:1];Table sequence number:K37:31;0)

$count:=100
$length:=5
$chars:="ABCDEFGHIJKLMNOPQRSTUVWXYZ"

For ($i;1;$count)
	$eTable_1:=ds:C1482.Table_1.new()
	For ($ii;1;$length)
		$eTable_1.Field_2:=$eTable_1.Field_2+$chars[[((Random:C100%$length)+1)]]
	End for 
	$eTable_1.save()
End for 