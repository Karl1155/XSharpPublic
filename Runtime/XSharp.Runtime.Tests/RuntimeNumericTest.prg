﻿USING System
USING System.Collections.Generic
USING System.Linq
USING System.Text
using XUnit
using XSharp.Runtime


BEGIN NAMESPACE XSharp.Runtime.Tests

	CLASS RuntimeNumericTests

		[Fact];
		METHOD CHRTest() as void
			Assert.Equal(" ",CHR((DWORD)32))
		RETURN

		[Fact];
		METHOD CONTIMETest() as void
			Assert.Equal("13:34:54",CONTIME((dword)13,(dword)34,(dword)54))
		RETURN

		[Fact];
		METHOD FracTest() as void
			Assert.Equal((__VOFloat)120,Fact((dword)5))
		RETURN

		[Fact];
		METHOD DW2BINTest() as void
			Assert.Equal("    ",DW2Bin((dword) 32*256*256*256+32*256*256+32*256+32))
		RETURN

		[Fact];
		METHOD NToCDoWTest() as void
		//	Assert.Equal("Freitag",NToCDoW(DOW(CTOD("27/05/2016"))))
		RETURN

		[Fact];
		METHOD NToCMonthTest() as void
		//	Assert.Equal("Juni",NToCMonth((dword)6))
		RETURN		 
	END CLASS
END NAMESPACE // XSharp.Runtime.Tests