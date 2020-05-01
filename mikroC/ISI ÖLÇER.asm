
_basamaklar:

;ISI ÖLÇER.c,18 :: 		void basamaklar()
;ISI ÖLÇER.c,20 :: 		bin=(derece/1000)+48;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _derece+0, 0 
	MOVWF       R0 
	MOVF        _derece+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _bin+0 
;ISI ÖLÇER.c,21 :: 		yuz=((derece/100)%10)+48;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _derece+0, 0 
	MOVWF       R0 
	MOVF        _derece+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _yuz+0 
;ISI ÖLÇER.c,22 :: 		on=((derece/10)&10)+48;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _derece+0, 0 
	MOVWF       R0 
	MOVF        _derece+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       10
	ANDWF       R0, 0 
	MOVWF       _on+0 
	MOVLW       48
	ADDWF       _on+0, 1 
;ISI ÖLÇER.c,23 :: 		bir=(derece%10)+48;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _derece+0, 0 
	MOVWF       R0 
	MOVF        _derece+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _bir+0 
;ISI ÖLÇER.c,24 :: 		}
L_end_basamaklar:
	RETURN      0
; end of _basamaklar

_main:

;ISI ÖLÇER.c,26 :: 		void main()
;ISI ÖLÇER.c,28 :: 		TRISB.f0=0x00;
	BCF         TRISB+0, 0 
;ISI ÖLÇER.c,29 :: 		PORTB.f0=0x00;
	BCF         PORTB+0, 0 
;ISI ÖLÇER.c,30 :: 		TRISE.F0=0;
	BCF         TRISE+0, 0 
;ISI ÖLÇER.c,31 :: 		PORTE.F0=0;
	BCF         PORTE+0, 0 
;ISI ÖLÇER.c,32 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;ISI ÖLÇER.c,33 :: 		Lcd_Cmd(_Lcd_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;ISI ÖLÇER.c,34 :: 		Lcd_Cmd(_Lcd_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;ISI ÖLÇER.c,35 :: 		CMCON=0x07;
	MOVLW       7
	MOVWF       CMCON+0 
;ISI ÖLÇER.c,36 :: 		while(1)
L_main0:
;ISI ÖLÇER.c,38 :: 		okunan=ADC_Read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _okunan+0 
	MOVF        R1, 0 
	MOVWF       _okunan+1 
;ISI ÖLÇER.c,39 :: 		derece=okunan*4.887585552746823069403714565;
	CALL        _Int2Double+0, 0
	MOVLW       26
	MOVWF       R4 
	MOVLW       103
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _derece+0 
	MOVF        R1, 0 
	MOVWF       _derece+1 
;ISI ÖLÇER.c,40 :: 		basamaklar();
	CALL        _basamaklar+0, 0
;ISI ÖLÇER.c,41 :: 		Lcd_Chr(1,1,bin);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _bin+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;ISI ÖLÇER.c,42 :: 		Lcd_Chr_CP(yuz);
	MOVF        _yuz+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ISI ÖLÇER.c,43 :: 		Lcd_Chr_CP(on);
	MOVF        _on+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ISI ÖLÇER.c,44 :: 		Lcd_Chr_CP('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ISI ÖLÇER.c,45 :: 		Lcd_Chr_CP(bir);
	MOVF        _bir+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ISI ÖLÇER.c,46 :: 		Lcd_Out(1,7,"C");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_ISI_32ÖLÇER+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_ISI_32ÖLÇER+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ISI ÖLÇER.c,47 :: 		Lcd_Chr_CP(0b11011111);
	MOVLW       223
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ISI ÖLÇER.c,48 :: 		delay_ms(100);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       23
	MOVWF       R12, 0
	MOVLW       106
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;ISI ÖLÇER.c,49 :: 		if(derece>=400)
	MOVLW       128
	XORWF       _derece+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main7
	MOVLW       144
	SUBWF       _derece+0, 0 
L__main7:
	BTFSS       STATUS+0, 0 
	GOTO        L_main3
;ISI ÖLÇER.c,51 :: 		portb.f0=0x00;
	BCF         PORTB+0, 0 
;ISI ÖLÇER.c,52 :: 		Lcd_Out(2,1,"SOGUYOR");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_ISI_32ÖLÇER+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_ISI_32ÖLÇER+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ISI ÖLÇER.c,53 :: 		PORTE.F0=0x00;
	BCF         PORTE+0, 0 
;ISI ÖLÇER.c,54 :: 		}
L_main3:
;ISI ÖLÇER.c,55 :: 		if(derece<395)
	MOVLW       128
	XORWF       _derece+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main8
	MOVLW       139
	SUBWF       _derece+0, 0 
L__main8:
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
;ISI ÖLÇER.c,57 :: 		portb.f0=0x01;
	BSF         PORTB+0, 0 
;ISI ÖLÇER.c,58 :: 		PORTE.F0=0x01;
	BSF         PORTE+0, 0 
;ISI ÖLÇER.c,59 :: 		Lcd_Out(2,1,"ISINIYOR");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_ISI_32ÖLÇER+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_ISI_32ÖLÇER+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ISI ÖLÇER.c,60 :: 		}
L_main4:
;ISI ÖLÇER.c,61 :: 		}
	GOTO        L_main0
;ISI ÖLÇER.c,62 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
