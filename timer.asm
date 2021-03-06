ORG 0H
MOV B,#0FFH
MOV P2,A
MOV P3,A
MOV R7,#0
BEGIN:
CONFIRM: JNB P0.1,CONFIRM

JB P0.2,ODD ;EITHER MODE 1 OR MODE 3 LSB bit

EVEN:
JB P0.3,MODE2
SJMP MODE0

ODD:
JB P0.3,MODE3 ;MODE 3 JUMP P2.6 is MSB
SJMP MODE1

MODE0:
JB P0.5,ODD1 ;EITHER MODE 1 OR MODE 3 LSB bit

EVEN1:
JB P0.6,DELAY2MODE0
SJMP DELAY0MODE0

ODD1:
JB P0.6,DELAY3MODE0 ;MODE 3 JUMP P2.6 is MSB
SJMP DELAY1MODE0


MODE1:
JB P0.5,ODD2 ;EITHER MODE 1 OR MODE 3 LSB bit

EVEN2:
JB P0.6,DELAY2MODE1
SJMP DELAY0MODE1

ODD2:
JB P0.6,DELAY3MODE1 ;MODE 3 JUMP P2.6 is MSB
SJMP DELAY1MODE1

MODE2:

JB P0.5,ODD3 ;EITHER MODE 1 OR MODE 3 LSB bit

EVEN3:
JB P0.6,JUMPDELAY2MODE2
SJMP DELAY0MODE2
JUMPDELAY2MODE2: LJMP DELAY2MODE2
ODD3:
JB P0.6,JUMPDELAY3MODE2 ;MODE 3 JUMP P2.6 is MSB
SJMP DELAY1MODE2
JUMPDELAY3MODE2: LJMP DELAY3MODE2

MODE3:
JB P0.5,ODD4 ;EITHER MODE 1 OR MODE 3 LSB bit

EVEN4:
JB P0.6,DELAY2MODE0
SJMP DELAY0MODE0

ODD4:
JB P0.6,DELAY3MODE0 ;MODE 3 JUMP P2.6 is MSB
SJMP DELAY1MODE0

DELAY0MODE0:
MOV R4,#6
REPEAT1:
ACALL DELAY1SEC
ACALL DISPDELAY0MODE0
DJNZ R4,REPEAT1
CLR TR0
CLR TF0
LJMP MUDINCHU


DELAY1MODE0:
MOV R4,#9
REPEAT2:
ACALL DELAY1SEC
ACALL DISPDELAY1MODE0
DJNZ R4,REPEAT2
 LJMP MUDINCHU

DELAY2MODE0:
MOV R4,#12
REPEAT3:
ACALL DELAY1SEC
ACALL DISPDELAY2MODE0
DJNZ R4,REPEAT3
LJMP MUDINCHU

DELAY3MODE0:
MOV R4,#15
REPEAT4:
ACALL DELAY1SEC
ACALL DISPDELAY3MODE0
DJNZ R4,REPEAT4
LJMP MUDINCHU

DELAY0MODE1:
MOV R4,#11
REPEAT5:
ACALL DELAY1SEC
ACALL DISPDELAY0MODE1
DJNZ R4,REPEAT5
LJMP MUDINCHU

DELAY1MODE1:
MOV R4,#19
REPEAT6:
ACALL DELAY1SEC
ACALL DISPDELAY1MODE1
DJNZ R4,REPEAT6
LJMP MUDINCHU

DELAY2MODE1:
MOV R4,#29
REPEAT7:
ACALL DELAY1SEC
ACALL DISPDELAY2MODE1
DJNZ R4,REPEAT7
LJMP MUDINCHU

DELAY3MODE1:
MOV R4,#29
REPEAT8:
ACALL DELAY1SEC
ACALL DISPDELAY3MODE1
DJNZ R4,REPEAT8
LJMP MUDINCHU

DELAY0MODE2:
MOV R4,#3
REPEAT9:
ACALL DELAY1SEC
ACALL DISPDELAY0MODE2
DJNZ R4,REPEAT9
LJMP MUDINCHU

DELAY1MODE2:
MOV R4,#4
REPEAT10:
ACALL DELAY1SEC
ACALL DISPDELAY1MODE2
DJNZ R4,REPEAT10
LJMP MUDINCHU

DELAY2MODE2:
MOV R4,#5
REPEAT11:
ACALL DELAY1SEC
ACALL DISPDELAY2MODE2
DJNZ R4,REPEAT11
LJMP MUDINCHU

DELAY3MODE2:
MOV R4,#6
REPEAT12:
ACALL DELAY1SEC
ACALL DISPDELAY3MODE2
DJNZ R4,REPEAT12
LJMP MUDINCHU


DISPDELAY0MODE0:
CLR PSW.7
MOV A,R7
SUBB A,#6
CPL A
ADD A,#1
MOV P3,A
MOV A,#0
MOV P2,A
RET
DISPDELAY1MODE0:
CLR PSW.7
MOV A,R7
SUBB A,#9
CPL A
ADD A,#1
MOV P3,A
MOV A,#0
MOV P2,A
RET

DISPDELAY2MODE0:
CLR PSW.7
MOV A,R7
SUBB A,#12
CPL A
ADD A,#1
MOV B,A
SUBB A,#10
JNB PSW.7,TENTH
MOV A,B
MOV P3,A
MOV A,#0
MOV P2,A
SJMP RETURN
TENTH:
 MOV P3,A
MOV A,#1
MOV P2,A
RETURN: RET

DISPDELAY3MODE0:
CLR PSW.7
MOV A,R7
SUBB A,#15
CPL A
ADD A,#1
MOV B,A
SUBB A,#10
JNB PSW.7,TENTH1
MOV A,B
MOV P3,A
MOV A,#0
MOV P2,A
SJMP RETURN1
TENTH1:
 MOV P3,A
MOV A,#1
MOV P2,A
RETURN1: RET

DISPDELAY0MODE1:
CLR PSW.7
MOV A,R7
SUBB A,#11
CPL A
ADD A,#1
MOV B,A
SUBB A,#10
JNB PSW.7,TENTH2
MOV A,B
MOV P3,A
MOV A,#0
MOV P2,A
SJMP RETURN2
TENTH2:
 MOV P3,A
MOV A,#1
MOV P2,A
RETURN2: RET

DISPDELAY1MODE1:
CLR PSW.7
MOV A,R7
SUBB A,#19
CPL A
ADD A,#1
MOV B,A
SUBB A,#10
JNB PSW.7,TENTH3
MOV A,B
MOV P3,A
MOV A,#0
MOV P2,A
SJMP RETURN3
TENTH3:
MOV P3,A
MOV A,#1
MOV P2,A
RETURN3: RET

DISPDELAY2MODE1:
CLR PSW.7
MOV A,R7
SUBB A,#29
CPL A
ADD A,#1
MOV B,A
SUBB A,#20
JNB PSW.7,TWENTY1
CLR PSW.7
MOV A,B
SUBB A,#10
JNB PSW.7,TENTH4
MOV A,B
MOV P3,A
MOV A,#0
MOV P2,A
SJMP RETURN4
TENTH4:
MOV P3,A
MOV A,#1
MOV P2,A
SJMP RETURN4
TWENTY1:
MOV P3,A
MOV A,#2
MOV P2,A
RETURN4: RET

DISPDELAY3MODE1:
CLR PSW.7
MOV A,R7
SUBB A,#29
CPL A
ADD A,#1
MOV B,A
SUBB A,#20
JNB PSW.7,TWENTY2
CLR PSW.7
MOV A,B
SUBB A,#10
JNB PSW.7,TENTH5
MOV A,B
MOV P3,A
MOV A,#0
MOV P2,A
SJMP RETURN5
TENTH5:
MOV P3,A
MOV A,#1
MOV P2,A
SJMP RETURN5
TWENTY2:
MOV P3,A
MOV A,#2
MOV P2,A
RETURN5: RET
DISPDELAY0MODE2:
CLR PSW.7
MOV A,R7
SUBB A,#4
CPL A
ADD A,#1
MOV P3,A
MOV A,#0
MOV P2,A
RET
DISPDELAY1MODE2:
CLR PSW.7
MOV A,R7
SUBB A,#5
CPL A
ADD A,#1
MOV P3,A
MOV A,#0
MOV P2,A
RET
DISPDELAY2MODE2:
CLR PSW.7
MOV A,R7
SUBB A,#6
CPL A
ADD A,#1
MOV P3,A
MOV A,#0
MOV P2,A
RET
DISPDELAY3MODE2:
 CLR PSW.7
MOV A,R7
SUBB A,#7
CPL A
ADD A,#1
MOV P3,A
MOV A,#0
MOV P2,A
RET


DELAY1SEC:
MOV R0,#250
MOV R1,#4
HERE: 
MOV R0,#250
AGAIN:

MOV TMOD,#01
MOV TL0,#66H
MOV TH0,#0FCH
SETB TR0
BACK: JNB TF0,BACK
CLR TR0
CLR TF0
DJNZ R0,AGAIN
DJNZ R1,HERE
INC R7
RET

MUDINCHU:
DONE: SJMP DONE

END