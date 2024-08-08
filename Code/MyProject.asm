
_south_yellow:

;MyProject.c,26 :: 		void south_yellow(){
;MyProject.c,27 :: 		Red_South = 0;
	BCF        PORTD+0, 2
;MyProject.c,28 :: 		Yellow_South = 1;
	BSF        PORTD+0, 3
;MyProject.c,29 :: 		Green_South = 0;
	BCF        PORTD+0, 4
;MyProject.c,30 :: 		Red_West = 1;
	BSF        PORTD+0, 5
;MyProject.c,31 :: 		Yellow_West = 0;
	BCF        PORTD+0, 6
;MyProject.c,32 :: 		Green_West = 0;
	BCF        PORTD+0, 7
;MyProject.c,33 :: 		}
L_end_south_yellow:
	RETURN
; end of _south_yellow

_south_green:

;MyProject.c,34 :: 		void south_green(){
;MyProject.c,35 :: 		Red_South = 0;
	BCF        PORTD+0, 2
;MyProject.c,36 :: 		Yellow_South = 0;
	BCF        PORTD+0, 3
;MyProject.c,37 :: 		Green_South = 1;
	BSF        PORTD+0, 4
;MyProject.c,38 :: 		Red_West = 1;
	BSF        PORTD+0, 5
;MyProject.c,39 :: 		Yellow_West = 0;
	BCF        PORTD+0, 6
;MyProject.c,40 :: 		Green_West = 0;
	BCF        PORTD+0, 7
;MyProject.c,41 :: 		}
L_end_south_green:
	RETURN
; end of _south_green

_west_yellow:

;MyProject.c,42 :: 		void west_yellow(){
;MyProject.c,43 :: 		Red_South = 1;
	BSF        PORTD+0, 2
;MyProject.c,44 :: 		Yellow_South = 0;
	BCF        PORTD+0, 3
;MyProject.c,45 :: 		Green_South = 0;
	BCF        PORTD+0, 4
;MyProject.c,46 :: 		Red_West = 0;
	BCF        PORTD+0, 5
;MyProject.c,47 :: 		Yellow_West = 1;
	BSF        PORTD+0, 6
;MyProject.c,48 :: 		Green_West = 0;
	BCF        PORTD+0, 7
;MyProject.c,49 :: 		}
L_end_west_yellow:
	RETURN
; end of _west_yellow

_west_green:

;MyProject.c,50 :: 		void west_green(){
;MyProject.c,51 :: 		Red_South = 1;
	BSF        PORTD+0, 2
;MyProject.c,52 :: 		Yellow_South = 0;
	BCF        PORTD+0, 3
;MyProject.c,53 :: 		Green_South = 0;
	BCF        PORTD+0, 4
;MyProject.c,54 :: 		Red_West = 0;
	BCF        PORTD+0, 5
;MyProject.c,55 :: 		Yellow_West = 0;
	BCF        PORTD+0, 6
;MyProject.c,56 :: 		Green_West = 1;
	BSF        PORTD+0, 7
;MyProject.c,57 :: 		}
L_end_west_green:
	RETURN
; end of _west_green

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,58 :: 		void interrupt(){
;MyProject.c,59 :: 		if(INTF_bit){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;MyProject.c,60 :: 		INTF_bit = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;MyProject.c,61 :: 		INTE_bit = 0;
	BCF        INTE_bit+0, BitPos(INTE_bit+0)
;MyProject.c,62 :: 		while(1){
L_interrupt1:
;MyProject.c,63 :: 		if(South_flag){
	MOVF       _South_flag+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt3
;MyProject.c,64 :: 		counter = 1;
	MOVLW      1
	MOVWF      _counter+0
;MyProject.c,65 :: 		portB = 0b00111100;
	MOVLW      60
	MOVWF      PORTB+0
;MyProject.c,66 :: 		i = 16;
	MOVLW      16
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
;MyProject.c,67 :: 		West_flag = 0;
	CLRF       _West_flag+0
;MyProject.c,68 :: 		south_green();
	CALL       _south_green+0
;MyProject.c,69 :: 		while(Switch){
L_interrupt4:
	BTFSS      PORTB+0, 1
	GOTO       L_interrupt5
;MyProject.c,70 :: 		if(INTF_bit == 1){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt6
;MyProject.c,71 :: 		INTF_bit = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;MyProject.c,72 :: 		flag = 1;
	MOVLW      1
	MOVWF      _flag+0
;MyProject.c,73 :: 		break;
	GOTO       L_interrupt5
;MyProject.c,74 :: 		}
L_interrupt6:
;MyProject.c,75 :: 		}
	GOTO       L_interrupt4
L_interrupt5:
;MyProject.c,76 :: 		if(flag){
	MOVF       _flag+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt7
;MyProject.c,77 :: 		flag = 0;
	CLRF       _flag+0
;MyProject.c,78 :: 		break;
	GOTO       L_interrupt2
;MyProject.c,79 :: 		}
L_interrupt7:
;MyProject.c,80 :: 		for(i = 3;i >= 0;i--){
	MOVLW      3
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_interrupt8:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt44
	MOVLW      0
	SUBWF      _i+0, 0
L__interrupt44:
	BTFSS      STATUS+0, 0
	GOTO       L_interrupt9
;MyProject.c,81 :: 		portB = 0b00000000;
	CLRF       PORTB+0
;MyProject.c,82 :: 		portC = segment[i];
	MOVF       _i+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject.c,83 :: 		south_yellow();
	CALL       _south_yellow+0
;MyProject.c,84 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_interrupt11:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt11
	DECFSZ     R12+0, 1
	GOTO       L_interrupt11
	DECFSZ     R11+0, 1
	GOTO       L_interrupt11
	NOP
	NOP
;MyProject.c,80 :: 		for(i = 3;i >= 0;i--){
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;MyProject.c,85 :: 		}
	GOTO       L_interrupt8
L_interrupt9:
;MyProject.c,86 :: 		South_flag = !(South_flag);
	MOVF       _South_flag+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      _South_flag+0
;MyProject.c,87 :: 		}
	GOTO       L_interrupt12
L_interrupt3:
;MyProject.c,89 :: 		counter = 0;
	CLRF       _counter+0
;MyProject.c,90 :: 		portB = 0b00111100;
	MOVLW      60
	MOVWF      PORTB+0
;MyProject.c,91 :: 		i = 24;
	MOVLW      24
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
;MyProject.c,92 :: 		West_flag = 1;
	MOVLW      1
	MOVWF      _West_flag+0
;MyProject.c,93 :: 		west_green();
	CALL       _west_green+0
;MyProject.c,94 :: 		while(Switch){
L_interrupt13:
	BTFSS      PORTB+0, 1
	GOTO       L_interrupt14
;MyProject.c,95 :: 		if(INTF_bit == 1){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt15
;MyProject.c,96 :: 		INTF_bit = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;MyProject.c,97 :: 		flag = 1;
	MOVLW      1
	MOVWF      _flag+0
;MyProject.c,98 :: 		break;
	GOTO       L_interrupt14
;MyProject.c,99 :: 		}
L_interrupt15:
;MyProject.c,100 :: 		}
	GOTO       L_interrupt13
L_interrupt14:
;MyProject.c,101 :: 		if(flag){
	MOVF       _flag+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt16
;MyProject.c,102 :: 		flag = 0;
	CLRF       _flag+0
;MyProject.c,103 :: 		break;
	GOTO       L_interrupt2
;MyProject.c,104 :: 		}
L_interrupt16:
;MyProject.c,105 :: 		for(i = 3;i >= 0;i--){
	MOVLW      3
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_interrupt17:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt45
	MOVLW      0
	SUBWF      _i+0, 0
L__interrupt45:
	BTFSS      STATUS+0, 0
	GOTO       L_interrupt18
;MyProject.c,106 :: 		portB = 0b00000000;
	CLRF       PORTB+0
;MyProject.c,107 :: 		portC = i;
	MOVF       _i+0, 0
	MOVWF      PORTC+0
;MyProject.c,108 :: 		west_yellow();
	CALL       _west_yellow+0
;MyProject.c,109 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_interrupt20:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt20
	DECFSZ     R12+0, 1
	GOTO       L_interrupt20
	DECFSZ     R11+0, 1
	GOTO       L_interrupt20
	NOP
	NOP
;MyProject.c,105 :: 		for(i = 3;i >= 0;i--){
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;MyProject.c,110 :: 		}
	GOTO       L_interrupt17
L_interrupt18:
;MyProject.c,111 :: 		South_flag = !(South_flag);
	MOVF       _South_flag+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      _South_flag+0
;MyProject.c,112 :: 		}
L_interrupt12:
;MyProject.c,113 :: 		}
	GOTO       L_interrupt1
L_interrupt2:
;MyProject.c,114 :: 		INTE_bit = 1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;MyProject.c,115 :: 		}
L_interrupt0:
;MyProject.c,116 :: 		}
L_end_interrupt:
L__interrupt43:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_west:

;MyProject.c,117 :: 		void west() {
;MyProject.c,118 :: 		South_flag = 0;
	CLRF       _South_flag+0
;MyProject.c,119 :: 		for(i = 23;i >= 0;i--){
	MOVLW      23
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_west21:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__west47
	MOVLW      0
	SUBWF      _i+0, 0
L__west47:
	BTFSS      STATUS+0, 0
	GOTO       L_west22
;MyProject.c,120 :: 		if(!(West_flag) && counter){
	MOVF       _West_flag+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_west26
	MOVF       _counter+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_west26
L__west37:
;MyProject.c,121 :: 		counter = 0;
	CLRF       _counter+0
;MyProject.c,122 :: 		break;
	GOTO       L_west22
;MyProject.c,123 :: 		}
L_west26:
;MyProject.c,124 :: 		portB = 0b00000000;
	CLRF       PORTB+0
;MyProject.c,125 :: 		portC = segment[i];
	MOVF       _i+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject.c,126 :: 		if(i > 3)west_green();
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__west48
	MOVF       _i+0, 0
	SUBLW      3
L__west48:
	BTFSC      STATUS+0, 0
	GOTO       L_west27
	CALL       _west_green+0
	GOTO       L_west28
L_west27:
;MyProject.c,127 :: 		else west_yellow();
	CALL       _west_yellow+0
L_west28:
;MyProject.c,128 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_west29:
	DECFSZ     R13+0, 1
	GOTO       L_west29
	DECFSZ     R12+0, 1
	GOTO       L_west29
	DECFSZ     R11+0, 1
	GOTO       L_west29
	NOP
	NOP
;MyProject.c,119 :: 		for(i = 23;i >= 0;i--){
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;MyProject.c,129 :: 		}
	GOTO       L_west21
L_west22:
;MyProject.c,130 :: 		}
L_end_west:
	RETURN
; end of _west

_south:

;MyProject.c,131 :: 		void south() {
;MyProject.c,132 :: 		South_flag = 1;
	MOVLW      1
	MOVWF      _South_flag+0
;MyProject.c,133 :: 		for(i = 15;i >= 0;i--){
	MOVLW      15
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_south30:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__south50
	MOVLW      0
	SUBWF      _i+0, 0
L__south50:
	BTFSS      STATUS+0, 0
	GOTO       L_south31
;MyProject.c,134 :: 		if(West_flag){
	MOVF       _West_flag+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_south33
;MyProject.c,135 :: 		West_flag = 0;
	CLRF       _West_flag+0
;MyProject.c,136 :: 		break;
	GOTO       L_south31
;MyProject.c,137 :: 		}
L_south33:
;MyProject.c,138 :: 		portB = 0b00000000;
	CLRF       PORTB+0
;MyProject.c,139 :: 		portC = segment[i];
	MOVF       _i+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject.c,140 :: 		if(i > 3)south_green();
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__south51
	MOVF       _i+0, 0
	SUBLW      3
L__south51:
	BTFSC      STATUS+0, 0
	GOTO       L_south34
	CALL       _south_green+0
	GOTO       L_south35
L_south34:
;MyProject.c,141 :: 		else south_yellow();
	CALL       _south_yellow+0
L_south35:
;MyProject.c,142 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_south36:
	DECFSZ     R13+0, 1
	GOTO       L_south36
	DECFSZ     R12+0, 1
	GOTO       L_south36
	DECFSZ     R11+0, 1
	GOTO       L_south36
	NOP
	NOP
;MyProject.c,133 :: 		for(i = 15;i >= 0;i--){
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;MyProject.c,143 :: 		}
	GOTO       L_south30
L_south31:
;MyProject.c,144 :: 		}
L_end_south:
	RETURN
; end of _south

_main:

;MyProject.c,146 :: 		void main() {
;MyProject.c,147 :: 		trisC = 0b00000000;
	CLRF       TRISC+0
;MyProject.c,148 :: 		trisD = 0b00000000;
	CLRF       TRISD+0
;MyProject.c,149 :: 		trisB = 0b00000011;
	MOVLW      3
	MOVWF      TRISB+0
;MyProject.c,150 :: 		INTE_bit = 1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;MyProject.c,151 :: 		GIE_bit = 1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;MyProject.c,152 :: 		INTEDG_bit = 0;
	BCF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;MyProject.c,153 :: 		loop:
___main_loop:
;MyProject.c,154 :: 		west();
	CALL       _west+0
;MyProject.c,155 :: 		south();
	CALL       _south+0
;MyProject.c,156 :: 		goto loop;
	GOTO       ___main_loop
;MyProject.c,157 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
