Const DO_NOT_ALLOW_1_STARTS_WITH = "10.20"
Const DO_NOT_ALLOW_2_STARTS_WITH  = "10.20"
Dim myIPAddress
Dim objWMIService
Dim colAdapters
Dim objAdapter
Dim blnRebooting
Dim blnSecondLoop 

Do

myIPAddress = ""
Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
Set colAdapters = objWMIService.ExecQuery("Select IPAddress from Win32_NetworkAdapterConfiguration Where IPEnabled = True")

For Each objAdapter In colAdapters
	If Not IsNull(objAdapter.IPAddress) Then
		Dim ipPiece
		Dim ipFirstTwoSections
		myIPAddress = Trim(objAdapter.IPAddress(0))
		arrayIPPieces = Split(myIPAddress, ".")
		If UBound(arrayIPPieces) > 0 Then
			ipFirstTwoSections = arrayIPPieces(0) & "." &  arrayIPPieces(1)
			'Wscript.echo DO_NOT_ALLOW_1_STARTS_WITH
			'Wscript.echo "My IPAddress first two is " & ipFirstTwoSections
			Select Case ipFirstTwoSections
				Case DO_NOT_ALLOW_1_STARTS_WITH, DO_NOT_ALLOW_2_STARTS_WITH 
					strComputer = "." ' Local Computer
					Dim objWMIService2
					SET objWMIService2 = GETOBJECT("winmgmts:{impersonationLevel=impersonate,(Shutdown)}\\" & strComputer & "\root\cimv2")
					SET colOs = objWMIService2.ExecQuery("Select * from Win32_OperatingSystem")
					FOR EACH objOs in colOs
						objOs.Win32Shutdown(1)
					NEXT
					Exit Do
					Wscript.echo "AETV IPAddress Starts With " & ipFirstTwoSections
			End Select
			Exit For
		End If 
	End If
Next

Loop

