; ----------------------------------------------------------------------------
; Object 9A - Turtloid (turtle badnik) from Sky Chase Zone
; ----------------------------------------------------------------------------
; Sprite_37936:
Obj9A:
	moveq	#0,d0
	move.b	routine(a0),d0
	move.w	Obj9A_Index(pc,d0.w),d1
	jmp	Obj9A_Index(pc,d1.w)
; ===========================================================================
; off_37944:
Obj9A_Index:	offsetTable
		offsetTableEntry.w Obj9A_Init	; 0
		offsetTableEntry.w Obj9A_Main	; 2
; ===========================================================================
; loc_37948:
Obj9A_Init:
	bsr.w	LoadSubObject
	move.w	#-$80,x_vel(a0)
	bsr.w	loc_37A4A
	lea	(Ani_obj9A).l,a1
	move.l	a1,objoff_2E(a0)
	bra.w	loc_37ABE
; ===========================================================================
; loc_37964:
Obj9A_Main:
	moveq	#0,d0
	move.b	routine_secondary(a0),d0
	move.w	off_3797A(pc,d0.w),d1
	jsr	off_3797A(pc,d1.w)
	bsr.w	loc_37982
	bra.w	Obj_DeleteBehindScreen
; ===========================================================================
off_3797A:	offsetTable
		offsetTableEntry.w loc_379A0	; 0
		offsetTableEntry.w loc_379CA	; 2
		offsetTableEntry.w loc_379EA	; 4
		offsetTableEntry.w return_37A04	; 6
; ===========================================================================

loc_37982:
	move.w	x_pos(a0),-(sp)
	jsrto	(ObjectMove).l, JmpTo26_ObjectMove
	bsr.w	loc_36776
	move.w	#$18,d1
	move.w	#8,d2
	move.w	#$E,d3
	move.w	(sp)+,d4
	jmpto	(PlatformObject).l, JmpTo9_PlatformObject
; ===========================================================================

loc_379A0:
	bsr.w	Obj_GetOrientationToPlayer
	tst.w	d0
	bmi.w	return_37A48
	cmpi.w	#$80,d2
	bhs.w	return_37A48
	addq.b	#2,routine_secondary(a0)
	move.w	#0,x_vel(a0)
	move.b	#4,objoff_2A(a0)
	move.b	#1,mapping_frame(a0)
	rts
; ===========================================================================

loc_379CA:
	subq.b	#1,objoff_2A(a0)
	bpl.w	return_37A48
	addq.b	#2,routine_secondary(a0)
	move.b	#8,objoff_2A(a0)
	movea.w	objoff_2C(a0),a1 ; a1=object
	move.b	#3,mapping_frame(a1)
	bra.w	loc_37AF2
; ===========================================================================

loc_379EA:
	subq.b	#1,objoff_2A(a0)
	bpl.s	return_37A02
	addq.b	#2,routine_secondary(a0)
	move.w	#-$80,x_vel(a0)
	clr.b	mapping_frame(a0)
	movea.w	objoff_2C(a0),a1 ; a1=object

return_37A02:
	rts
; ===========================================================================

return_37A04:
	rts
; ===========================================================================