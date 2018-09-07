﻿//
// Copyright (c) XSharp B.V.  All Rights Reserved.  
// Licensed under the Apache License, Version 2.0.  
// See License.txt in the project root for license information.
//

#ifdef NOTDEFINED
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION DBClearOrderCondition()  AS LOGIC
	RETURN OrdCondSet("", NIL, .F., NIL, NIL, 0, 0, 0, 0, .F., .F.)
	


/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION DbReindex() AS LOGIC
	RETURN ORDLISTREBUILD()
	


FUNCTION DbSeek(xValue, lSoft, lLast) AS LOGIC CLIPPER
	LOCAL dbsci     IS _DBSCOPEINFO
	LOCAL lRet      AS LOGIC
	
	DEFAULT(@lSoft, SetSoftSeek())
	
	MemClear(@dbsci, _SIZEOF(_DBSCOPEINFO))
	
	IF !IsNil(lLast)
		dbsci.fLast := lLast
	ENDIF
	
	VODBSetScope(@dbsci)
	
	DEFAULT(@xValue, "")
	
	IF !VODBSeek(xValue, lSoft)
		RETURN DoError(#DbSeek)
	ENDIF
	
	lRet := VODBFound()
	
	//  UH 02/16/1999
	MemClear(@dbsci, _SIZEOF(_DBSCOPEINFO))
	VODBSetScope(@dbsci)
	
	RETURN lRet
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION DbSetFound(lFnd AS LOGIC) AS LOGIC 
	RETURN VODBSetFound(lFnd)
	
	
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION DBSETORDERCONDITION(  cFor,       ;
		uCobFor,    ;
		lAll,       ;
		uCobWhile,  ;
		uCobEval,   ;
		nStep,      ;
		nStart,     ;
		nNext,      ;
		nRecno,     ;
		lRest,      ;
		lDescending,;
		lAdditive,  ;
		lCurrent,   ;
		lCustom,    ;
		lNoOptimize     ) AS LOGIC CLIPPER
	
	
	RETURN OrdCondSet( cFor, uCobFor, lAll, uCobWhile, uCobEval, ;
		nStep, nStart, nNext, nRecno, lRest,      ;
		lDescending, lAdditive, lCurrent, lCustom, lNoOptimize)

	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION DbSetIndex(cIndex, uOrder) AS LOGIC CLIPPER
	
	IF IsNil(cIndex)
		RETURN ORDLISTCLEAR()
	ENDIF
	RETURN ORDLISTADD(cIndex, uOrder)
	
	
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION DbSetOrder (uOrder, cBagName) AS LOGIC CLIPPER
	
	LOCAL pszOrder          AS PSZ
	
	DEFAULT(@cBagName, "")
	
	RETURN VODBOrdSetFocus(cBagName, uOrder, @pszOrder)
	

/// <summary>
/// </summary>
/// <returns>
/// </returns>


FUNCTION IndexCount() AS DWORD 
	LOCAL nRet      AS DWORD
	IF Used()
		nRet := DbOrderInfo(DBOI_ORDERCOUNT)
	ENDIF
	
	RETURN nRet
	
	//TEXTBLOCK E:\Program Files\CAVO26\SOURCE\System Library\DBBULK.PRG


/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION INDEXEXT       () AS STRING STRICT
	RETURN VODBOrdBagExt()
	
	
	
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION INDEXKEY(uOrder) AS STRING CLIPPER
	
	LOCAL uRetVal   AS USUAL
	
	IF IsNil(uOrder)
		uOrder := 0
	ENDIF
	
	uRetVal := DbOrderInfo(DBOI_EXPRESSION, "", uOrder)
	
	IF IsNil(uRetVal)
		uRetVal := ""
	ENDIF
	
	RETURN uRetVal
	
	
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION INDEXORD       () AS INT STRICT
	
	LOCAL uRetVal := NIL AS USUAL
	
	uRetVal := DbOrderInfo(DBOI_NUMBER, "", NIL)
	
	DEFAULT(@uRetVal, 0)
	
	RETURN uRetVal
	
	
STATIC FUNCTION OrdScopeNum(nScope)  AS SHORT CLIPPER
	
	IF !IsNumeric( nScope )
		nScope := 0
	ENDIF
	
	nScope := INT(nScope)
	
	IF nScope < 0
		nScope := 0
	ENDIF
	
	IF nScope > 1
		nScope := 1
	ENDIF
	
	RETURN nScope
	
	
	
FUNCTION OrdSetRelation (cAlias, bKey, cKey) AS USUAL CLIPPER
	
	DbSetRelation(cAlias, bKey, cKey)
	
	(cAlias)->(OrdScope(0, bKey))
	
	(cAlias)->(OrdScope(1, bKey))
	
	RETURN NIL
	
	
	
FUNCTION OrdScope       (nScope, xVal) AS USUAL CLIPPER
	LOCAL n     AS DWORD
	
	nScope := OrdScopeNum(nScope)
	
	n := DBOI_SCOPETOP
	
	IF PCount() > 1 .AND. IsNil(xVal)
		n := DBOI_SCOPETOPCLEAR
	ENDIF
	
	RETURN DbOrderInfo(n + nScope,,,xVal)
	
	
	
	
FUNCTION OrdSkipUnique  (nCount) AS USUAL CLIPPER
	RETURN VODBOrderInfo ( DBOI_SKIPUNIQUE, "", NIL,@nCount )
	
	
	
	
FUNCTION OrdIsUnique    (xOrder, cOrderBag) AS USUAL CLIPPER
	
	RETURN DbOrderInfo(DBOI_UNIQUE, cOrderBag, xOrder)
	
	


// DbOrder.prg - Order related functions
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION ORDBAGEXT () AS STRING STRICT
	RETURN VODBOrdBagExt()
	
	
	
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION ORDBAGNAME     (uOrder) AS STRING CLIPPER
	RETURN DbOrderInfo(DBOI_BAGNAME, "", uOrder)
	
	
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION OrdCondSet(   cFor,       ;
		uCobFor,    ;
		lAll,       ;
		uCobWhile,  ;
		uCobEval,   ;
		nStep,      ;
		nStart,     ;
		nNext,      ;
		nRecno,     ;
		lRest,      ;
		lDescending,;
		lAdditive,  ;
		lCurrent,   ;
		lCustom,    ;
		lNoOptimize     ) AS LOGIC CLIPPER
	
	
	LOCAL lRetCode          AS LOGIC
	LOCAL dbOrdCondInfo     AS DbOrderCondInfo
	
	
	IF !IsNil(cFor)
        dbOrdCondInfo:ForExpression := cFor
	ENDIF
	
	
	IF !IsNil(uCobFor)
        dbOrdCondInfo:ForBlock := uCobFor
	ENDIF
	
	IF !IsNil(uCobWhile)
		dbOrdCondInfo:WhileBlock := uCobWhile
	ENDIF
	
	IF !IsNil(uCobEval)
		dbOrdCondInfo:EvalBlock := uCobEval
	ENDIF
	
	IF IsNumeric(nStep)
		dbOrdCondInfo:StepSize := nStep
	ENDIF
	
	IF IsNumeric(nStart)
		dbOrdCondInfo:StartRecNo := nStart
	ENDIF
	
	IF IsNumeric(nNext)
		dbOrdCondInfo:NextCount := nNext
	ENDIF
	
	IF IsNumeric(nRecno)
		dbOrdCondInfo:RecNo := nRecno
	ENDIF
	
	IF IsLogic(lRest)
		dbOrdCondInfo:Rest := lRest
	ENDIF
	
	IF IsLogic(lDescending)
		dbOrdCondInfo:Descending := lDescending
	ENDIF
	
	
	IF IsLogic(lAll)
		dbOrdCondInfo:All := lAll
	ENDIF
	
	
	IF IsLogic(lAdditive)
		dbOrdCondInfo:Additive := lAdditive
	ENDIF
	
	IF IsLogic(lCustom)
		dbOrdCondInfo:Custom := lCustom
	ENDIF
	
	IF IsLogic(lCurrent)
		dbOrdCondInfo:UseCurrent := lCurrent
	ENDIF
	
	
	IF !IsNil(lNoOptimize)
		dbOrdCondInfo:NoOptimize := lNoOptimize
	ENDIF
	
	lRetCode := VODBOrdCondSet( dbOrdCondInfo )
	
	IF !lRetCode
		lRetCode := DoError(#OrdCondSet)
	ENDIF
	
	RETURN lRetCode
	
	
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION OrdCreate(cName, cOrder, cExpr, cobExpr, lUnique) AS LOGIC CLIPPER
	
	LOCAL lRetCode  AS LOGIC
	
	IF IsNil(lUnique)
		lUnique := SetUnique()
	ENDIF
	
	IF IsNil(cName)
		IF IsNil(cOrder)
			ptrErrInfo := _VODBErrInfoPtr()
			ptrErrInfo.dwGenCode  := EG_ARG
			ptrErrInfo.dwSubCode  := EDB_CREATEINDEX
			ptrErrInfo.dwSeverity := ES_ERROR
			ptrErrInfo.pszArg     := AsPsz(cName)
			ptrErrInfo.lCanDefault:= TRUE
			DoError(#OrdCreate)
		ELSE
			cName := ""
		ENDIF
	ENDIF
	
	IF IsNil(cExpr)
		cExpr := ""
		IF IsNil(cobExpr)
			ptrErrInfo := _VODBErrInfoPtr()
			ptrErrInfo.dwGenCode  := EG_ARG
			ptrErrInfo.dwSubCode  := EDB_EXPRESSION
			ptrErrInfo.dwSeverity := ES_ERROR
			ptrErrInfo.lCanDefault:= TRUE
			DoError(#OrdCreate)
		ENDIF
	ELSE
		IF IsNil(cobExpr)
			cobExpr := &( "{||" + cExpr + "}" )
		ENDIF
	ENDIF
	
	lRetCode := VODBOrdCreate (cName, cOrder, cExpr, cobExpr, lUnique, NULL)
	
	IF !lRetCode
		lRetCode := DoError(#OrdCreate)
	ENDIF
	
	RETURN lRetCode
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION OrdDescend     (xOrder, cOrdBag, lDescend) AS LOGIC CLIPPER
	
	IF !IsLogic( lDescend )
		lDescend := NIL
	ENDIF
	
	RETURN DbOrderInfo(DBOI_ISDESC, cOrdBag, xOrder, lDescend)
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION ORDDESTROY     (uOrder, cOrdBag) AS LOGIC CLIPPER
	
	LOCAL lRetCode  AS LOGIC
	
	IF IsNil(cOrdBag)
		cOrdBag := ""
	ENDIF
	
	IF IsString(uOrder)
		lRetCode := VODBOrdDestroy (cOrdBag, uOrder)
	ELSE
		ptrErrInfo := _VODBErrInfoPtr()
		
		ptrErrInfo.pszSubSystem     := String2Psz("DBCMD")
		ptrErrInfo.dwGenCode        := EG_ARG
		ptrErrInfo.dwSeverity       := ES_ERROR
		ptrErrInfo.lCanDefault      := .F.
		ptrErrInfo.lCanRetry        := .T.
		ptrErrInfo.lCanSubstitute   := .F.
		ptrErrInfo.pszArg           := AsPsz(uOrder)
		ptrErrInfo.dwArgType        := UsualType(uOrder)
		lRetCode := .F.
	ENDIF
	
	IF !lRetCode
		lRetCode := DoError(#ORDDESTROY)
	ENDIF
	
	RETURN lRetCode
	
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION ORDFOR         (uOrder, cOrdBag, cFor) AS LOGIC CLIPPER
	
	IF IsNil(cOrdBag)
		cOrdBag := ""
	ENDIF
	
	IF !IsString(cFor)
		cFor := NIL
	ENDIF
	
	RETURN DbOrderInfo(DBOI_CONDITION, cOrdBag, uOrder, cFor)
	
	
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION ORDKEY(uOrder, cOrdBag) AS USUAL CLIPPER
	
	LOCAL xKey      AS USUAL
	
	IF IsNil(cOrdBag)
		cOrdBag := ""
	ENDIF
	
	IF !VODBOrderInfo(DBOI_EXPRESSION, cOrdBag, uOrder, @xKey)
		xKey := ""
	ENDIF
	
	RETURN xKey
FUNCTION OrdKeyAdd(xOrder, cOrdBag, xVal) AS USUAL CLIPPER
	
	RETURN DbOrderInfo(DBOI_KEYADD, cOrdBag, xOrder, xVal)
	

FUNCTION OrdKeyDel(xOrder, cOrdBag, xVal) AS USUAL CLIPPER
	
	RETURN DbOrderInfo( DBOI_KEYDELETE, cOrdBag, xOrder, NIL)
	
	
FUNCTION OrdKeyGoto     (nKeyNo) AS LOGIC CLIPPER
	LOCAL lRetCode  AS LOGIC
	
	IF IsNumeric(nKeyNo)
		DbGotop()
		DBSKIP(nKeyno - 1)
		lRetCode := TRUE
	ENDIF
	
	RETURN lRetCode
	
	
	
FUNCTION OrdKeyCount    (xOrder, cOrdBag) AS USUAL CLIPPER
	RETURN DbOrderInfo(DBOI_KEYCOUNT, cOrdBag, xOrder, NIL)
	
	
FUNCTION ORDKeyNo       (xOrder, cOrdBag) 	AS USUAL CLIPPER
	RETURN DbOrderInfo( DBOI_POSITION, cOrdBag, xOrder, NIL)
	
	
	
FUNCTION ORDKeyVal      () AS USUAL STRICT
	RETURN DbOrderInfo( DBOI_KEYVAL, NIL ,NIL, NIL)
	
	
	
	
	
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION ORDLISTADD     (cOrdBag, uOrder) AS LOGIC CLIPPER
	
	LOCAL lRetCode  AS LOGIC
	
	lRetCode := VODBOrdListAdd(cOrdBag, uOrder)
	
	IF !lRetCode
		lRetCode := DoError(#ORDLISTADD)
	ENDIF
	
	RETURN lRetCode



/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION ORDLISTCLEAR   (cOrdBag, uOrder)  AS LOGIC CLIPPER
	
	LOCAL lRetCode  AS LOGIC
	
	IF IsNil(cOrdBag)
		cOrdBag := ""
	ENDIF
	
	lRetCode := VODBOrdListClear(cOrdBag, uOrder)
	
	IF !lRetCode
		lRetCode := DoError(#ORDLISTCLEAR)
	ENDIF
	
	RETURN lRetCode
	
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION __OrdListClear()  AS LOGIC STRICT
	LOCAL lRet      AS LOGIC
	LOCAL lOpen     AS LOGIC
	LOCAL cDBF      AS STRING
	LOCAL cAlias    AS STRING
	LOCAL lShare    AS LOGIC
	LOCAL aRDD      AS ARRAY
	LOCAL rdds      AS _RDDLIST
	LOCAL i         AS DWORD
	
	IF Used()
		cDBF   := DbInfo(DBI_FULLPATH)
		rdds   := DbInfo(DBI_RDD_LIST)
		
		aRdd := {}
		FOR i := 1 TO rdds.uiRddCount
			AAdd(aRdd, Symbol2String(rdds.atomRddName[i]) )
		NEXT
		
		lShare := DbInfo(DBI_SHARED)
		cAlias := ALIAS()
		lOpen := RDDINFO(_SET_AUTOOPEN)
		RDDINFO(_SET_AUTOOPEN, .F.)
		DBCLOSEAREA()
		lRet := DBUSEAREA(.F., aRdd, cDBF, cAlias, lShare)
		RDDINFO(_SET_AUTOOPEN, lOpen)
	ELSE
		lRet := .F.
	ENDIF
	
	RETURN lRet
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION ORDLISTREBUILD ()  AS LOGIC STRICT
	
	LOCAL lRetCode  AS LOGIC
	
	lRetCode := VODBOrdListRebuild()
	
	IF !lRetCode
		lRetCode := DoError(#ORDLISTREBUILD)
	ENDIF
	
	RETURN lRetCode
	
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION OrdName(uOrder, cOrdBag) AS LOGIC CLIPPER
	
	IF IsNil(cOrdBag)
		cOrdBag := ""
	ENDIF
	
	RETURN DbOrderInfo(DBOI_NAME, cOrdBag, uOrder)
	
	
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION OrdNumber(uOrder, cOrdBag) AS USUAL CLIPPER
	
	IF IsNil(cOrdBag)
		cOrdBag := ""
	ENDIF
	
	RETURN DbOrderInfo(DBOI_NUMBER, cOrdBag, uOrder)
	
	
	
	
/// <summary>
/// </summary>
/// <returns>
/// </returns>
FUNCTION ORDSETFOCUS    (uOrder, cOrdBag) AS USUAL CLIPPER
	LOCAL cOrder    AS   STRING
	
	DEFAULT(@cOrdBag, "")
	VODBOrdSetFocus(cOrdBag, uOrder, REF cOrder)
	RETURN cOrder
	
#endif
