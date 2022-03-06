   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.5 - 16 Jun 2021
   3                     ; Generator (Limited) V4.5.3 - 16 Jun 2021
  47                     ; 18 void setup(void){
  49                     	switch	.text
  50  0000               _setup:
  54                     ; 19 CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //Nastavení vstupù a výstupù, rozbìhnutí hodin
  56  0000 4f            	clr	a
  57  0001 cd0000        	call	_CLK_HSIPrescalerConfig
  59                     ; 20 init_milis();
  61  0004 cd0000        	call	_init_milis
  63                     ; 21 GPIO_Init(LCD_RS_PORT, LCD_RS_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
  65  0007 4bc0          	push	#192
  66  0009 4b01          	push	#1
  67  000b ae501e        	ldw	x,#20510
  68  000e cd0000        	call	_GPIO_Init
  70  0011 85            	popw	x
  71                     ; 22 GPIO_Init(LCD_RW_PORT, LCD_RW_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
  73  0012 4bc0          	push	#192
  74  0014 4b04          	push	#4
  75  0016 ae500a        	ldw	x,#20490
  76  0019 cd0000        	call	_GPIO_Init
  78  001c 85            	popw	x
  79                     ; 23 GPIO_Init(LCD_E_PORT,LCD_E_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
  81  001d 4bc0          	push	#192
  82  001f 4b08          	push	#8
  83  0021 ae500a        	ldw	x,#20490
  84  0024 cd0000        	call	_GPIO_Init
  86  0027 85            	popw	x
  87                     ; 25 GPIO_Init(LCD_D4_PORT,LCD_D4_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
  89  0028 4bc0          	push	#192
  90  002a 4b40          	push	#64
  91  002c ae500f        	ldw	x,#20495
  92  002f cd0000        	call	_GPIO_Init
  94  0032 85            	popw	x
  95                     ; 26 GPIO_Init(LCD_D5_PORT,LCD_D5_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
  97  0033 4bc0          	push	#192
  98  0035 4b20          	push	#32
  99  0037 ae500f        	ldw	x,#20495
 100  003a cd0000        	call	_GPIO_Init
 102  003d 85            	popw	x
 103                     ; 27 GPIO_Init(LCD_D6_PORT,LCD_D6_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
 105  003e 4bc0          	push	#192
 106  0040 4b01          	push	#1
 107  0042 ae5014        	ldw	x,#20500
 108  0045 cd0000        	call	_GPIO_Init
 110  0048 85            	popw	x
 111                     ; 28 GPIO_Init(LCD_D7_PORT,LCD_D7_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
 113  0049 4bc0          	push	#192
 114  004b 4b02          	push	#2
 115  004d ae500a        	ldw	x,#20490
 116  0050 cd0000        	call	_GPIO_Init
 118  0053 85            	popw	x
 119                     ; 31 GPIO_Init(NCODER_CLK_PORT,NCODER_CLK_PIN,GPIO_MODE_IN_FL_NO_IT);
 121  0054 4b00          	push	#0
 122  0056 4b01          	push	#1
 123  0058 ae5005        	ldw	x,#20485
 124  005b cd0000        	call	_GPIO_Init
 126  005e 85            	popw	x
 127                     ; 32 GPIO_Init(NCODER_DATA_PORT,NCODER_DATA_PIN,GPIO_MODE_IN_FL_NO_IT);
 129  005f 4b00          	push	#0
 130  0061 4b02          	push	#2
 131  0063 ae5005        	ldw	x,#20485
 132  0066 cd0000        	call	_GPIO_Init
 134  0069 85            	popw	x
 135                     ; 34 GPIO_Init(GPIOB,GPIO_PIN_2,GPIO_MODE_OUT_PP_LOW_SLOW);
 137  006a 4bc0          	push	#192
 138  006c 4b04          	push	#4
 139  006e ae5005        	ldw	x,#20485
 140  0071 cd0000        	call	_GPIO_Init
 142  0074 85            	popw	x
 143                     ; 36 GPIO_Init(GPIOE, GPIO_PIN_4,GPIO_MODE_IN_FL_NO_IT);
 145  0075 4b00          	push	#0
 146  0077 4b10          	push	#16
 147  0079 ae5014        	ldw	x,#20500
 148  007c cd0000        	call	_GPIO_Init
 150  007f 85            	popw	x
 151                     ; 38 }
 154  0080 81            	ret
 157                     	bsct
 158  0000               _hodiny:
 159  0000 0000          	dc.w	0
 160  0002               _minuty:
 161  0002 0000          	dc.w	0
 162  0004               _sekundy:
 163  0004 0000          	dc.w	0
 164  0006               _cisloB:
 165  0006 0000          	dc.w	0
 166  0008               L52_minule:
 167  0008 0000          	dc.w	0
 200                     ; 44 int8_t check_ncoder(void){
 201                     	switch	.text
 202  0081               _check_ncoder:
 206                     ; 46 if (minule == 0 && NCODER_GET_CLK == 1){
 208  0081 be08          	ldw	x,L52_minule
 209  0083 2625          	jrne	L54
 211  0085 4b01          	push	#1
 212  0087 ae5005        	ldw	x,#20485
 213  008a cd0000        	call	_GPIO_ReadInputPin
 215  008d 5b01          	addw	sp,#1
 216  008f 4d            	tnz	a
 217  0090 2718          	jreq	L54
 218                     ; 47 	minule=1;
 220  0092 ae0001        	ldw	x,#1
 221  0095 bf08          	ldw	L52_minule,x
 222                     ; 48 	if (NCODER_GET_DATA == 0){
 224  0097 4b02          	push	#2
 225  0099 ae5005        	ldw	x,#20485
 226  009c cd0000        	call	_GPIO_ReadInputPin
 228  009f 5b01          	addw	sp,#1
 229  00a1 4d            	tnz	a
 230  00a2 2603          	jrne	L74
 231                     ; 49 		return 1;
 233  00a4 a601          	ld	a,#1
 236  00a6 81            	ret
 237  00a7               L74:
 238                     ; 51 		return -1;
 240  00a7 a6ff          	ld	a,#255
 243  00a9 81            	ret
 244  00aa               L54:
 245                     ; 54 else if (minule == 1 && NCODER_GET_CLK == 0){
 247  00aa be08          	ldw	x,L52_minule
 248  00ac a30001        	cpw	x,#1
 249  00af 2623          	jrne	L35
 251  00b1 4b01          	push	#1
 252  00b3 ae5005        	ldw	x,#20485
 253  00b6 cd0000        	call	_GPIO_ReadInputPin
 255  00b9 5b01          	addw	sp,#1
 256  00bb 4d            	tnz	a
 257  00bc 2616          	jrne	L35
 258                     ; 55 	minule =0;
 260  00be 5f            	clrw	x
 261  00bf bf08          	ldw	L52_minule,x
 262                     ; 56 	if (NCODER_GET_DATA == 0){
 264  00c1 4b02          	push	#2
 265  00c3 ae5005        	ldw	x,#20485
 266  00c6 cd0000        	call	_GPIO_ReadInputPin
 268  00c9 5b01          	addw	sp,#1
 269  00cb 4d            	tnz	a
 270  00cc 2603          	jrne	L75
 271                     ; 57 		return -1;
 273  00ce a6ff          	ld	a,#255
 276  00d0 81            	ret
 277  00d1               L75:
 278                     ; 59 		return 1;
 280  00d1 a601          	ld	a,#1
 283  00d3 81            	ret
 284  00d4               L35:
 285                     ; 62 return 0;
 287  00d4 4f            	clr	a
 290  00d5 81            	ret
 388                     .const:	section	.text
 389  0000               L21:
 390  0000 00000065      	dc.l	101
 391  0004               L41:
 392  0004 000003e9      	dc.l	1001
 393                     ; 65 void main(void){
 394                     	switch	.text
 395  00d6               _main:
 397  00d6 5230          	subw	sp,#48
 398       00000030      OFST:	set	48
 401                     ; 67 	uint16_t n = 0;
 403                     ; 68 	uint32_t timeA = 0;
 405  00d8 ae0000        	ldw	x,#0
 406  00db 1f05          	ldw	(OFST-43,sp),x
 407  00dd ae0000        	ldw	x,#0
 408  00e0 1f03          	ldw	(OFST-45,sp),x
 410                     ; 69 	uint32_t timeB = 0;
 412                     ; 70 	volatile hodiny = 0;
 414  00e2 5f            	clrw	x
 415  00e3 1f2d          	ldw	(OFST-3,sp),x
 417                     ; 71 	volatile minuty = 0;
 419  00e5 5f            	clrw	x
 420  00e6 1f2f          	ldw	(OFST-1,sp),x
 422                     ; 72 	volatile sekundy = 0;
 424  00e8 5f            	clrw	x
 425  00e9 1f2b          	ldw	(OFST-5,sp),x
 427                     ; 73 	setup();
 429  00eb cd0000        	call	_setup
 431                     ; 75 	lcd_init();
 433  00ee cd0000        	call	_lcd_init
 435  00f1               L131:
 436                     ; 77 		if ((milis() - timeA) > 100){
 438  00f1 cd0000        	call	_milis
 440  00f4 cd0000        	call	c_uitolx
 442  00f7 96            	ldw	x,sp
 443  00f8 1c0003        	addw	x,#OFST-45
 444  00fb cd0000        	call	c_lsub
 446  00fe ae0000        	ldw	x,#L21
 447  0101 cd0000        	call	c_lcmp
 449  0104 2403          	jruge	L61
 450  0106 cc0196        	jp	L531
 451  0109               L61:
 452                     ; 78 			timeA = milis();
 454  0109 cd0000        	call	_milis
 456  010c cd0000        	call	c_uitolx
 458  010f 96            	ldw	x,sp
 459  0110 1c0003        	addw	x,#OFST-45
 460  0113 cd0000        	call	c_rtol
 463                     ; 79 		if (GPIO_ReadInputPin(NCODER_CLK_PORT,NCODER_CLK_PIN)!=RESET){
 465  0116 4b01          	push	#1
 466  0118 ae5005        	ldw	x,#20485
 467  011b cd0000        	call	_GPIO_ReadInputPin
 469  011e 5b01          	addw	sp,#1
 470  0120 4d            	tnz	a
 471  0121 2726          	jreq	L731
 472                     ; 80 			minuty += 1;
 474  0123 1e2f          	ldw	x,(OFST-1,sp)
 475  0125 1c0001        	addw	x,#1
 476  0128 1f2f          	ldw	(OFST-1,sp),x
 478                     ; 81 			if (minuty > 59){
 480  012a 9c            	rvf
 481  012b 1e2f          	ldw	x,(OFST-1,sp)
 482  012d a3003c        	cpw	x,#60
 483  0130 2f17          	jrslt	L731
 484                     ; 82 				hodiny++;
 486  0132 1e2d          	ldw	x,(OFST-3,sp)
 487  0134 1c0001        	addw	x,#1
 488  0137 1f2d          	ldw	(OFST-3,sp),x
 490                     ; 83 				minuty=0;
 492  0139 5f            	clrw	x
 493  013a 1f2f          	ldw	(OFST-1,sp),x
 495                     ; 84 				if (hodiny > 23){
 497  013c 9c            	rvf
 498  013d 1e2d          	ldw	x,(OFST-3,sp)
 499  013f a30018        	cpw	x,#24
 500  0142 2f05          	jrslt	L731
 501                     ; 85 					hodiny=24;
 503  0144 ae0018        	ldw	x,#24
 504  0147 1f2d          	ldw	(OFST-3,sp),x
 506  0149               L731:
 507                     ; 89 		if (GPIO_ReadInputPin(NCODER_DATA_PORT,NCODER_DATA_PIN)!=RESET){
 509  0149 4b02          	push	#2
 510  014b ae5005        	ldw	x,#20485
 511  014e cd0000        	call	_GPIO_ReadInputPin
 513  0151 5b01          	addw	sp,#1
 514  0153 4d            	tnz	a
 515  0154 271f          	jreq	L541
 516                     ; 90 			if (minuty!=0){
 518  0156 1e2f          	ldw	x,(OFST-1,sp)
 519  0158 2707          	jreq	L741
 520                     ; 91 				minuty+= -1;
 522  015a 1e2f          	ldw	x,(OFST-1,sp)
 523  015c 1cffff        	addw	x,#65535
 524  015f 1f2f          	ldw	(OFST-1,sp),x
 526  0161               L741:
 527                     ; 93 			if (minuty==0 && hodiny!=0){
 529  0161 1e2f          	ldw	x,(OFST-1,sp)
 530  0163 2610          	jrne	L541
 532  0165 1e2d          	ldw	x,(OFST-3,sp)
 533  0167 270c          	jreq	L541
 534                     ; 94 			hodiny+= -1;
 536  0169 1e2d          	ldw	x,(OFST-3,sp)
 537  016b 1cffff        	addw	x,#65535
 538  016e 1f2d          	ldw	(OFST-3,sp),x
 540                     ; 95 			minuty=59;
 542  0170 ae003b        	ldw	x,#59
 543  0173 1f2f          	ldw	(OFST-1,sp),x
 545  0175               L541:
 546                     ; 98 			lcd_gotoxy(0 ,0);
 548  0175 5f            	clrw	x
 549  0176 cd0000        	call	_lcd_gotoxy
 551                     ; 99 			sprintf(text,"cas = %2d:%2d:%2d",hodiny,minuty,sekundy);
 553  0179 1e2b          	ldw	x,(OFST-5,sp)
 554  017b 89            	pushw	x
 555  017c 1e31          	ldw	x,(OFST+1,sp)
 556  017e 89            	pushw	x
 557  017f 1e31          	ldw	x,(OFST+1,sp)
 558  0181 89            	pushw	x
 559  0182 ae0008        	ldw	x,#L351
 560  0185 89            	pushw	x
 561  0186 96            	ldw	x,sp
 562  0187 1c0013        	addw	x,#OFST-29
 563  018a cd0000        	call	_sprintf
 565  018d 5b08          	addw	sp,#8
 566                     ; 100 			lcd_puts(text);	
 568  018f 96            	ldw	x,sp
 569  0190 1c000b        	addw	x,#OFST-37
 570  0193 cd0000        	call	_lcd_puts
 572  0196               L531:
 573                     ; 102 		if ((GPIO_ReadInputPin(GPIOE,GPIO_PIN_4)==RESET)){
 575  0196 4b10          	push	#16
 576  0198 ae5014        	ldw	x,#20500
 577  019b cd0000        	call	_GPIO_ReadInputPin
 579  019e 5b01          	addw	sp,#1
 580  01a0 4d            	tnz	a
 581  01a1 2703          	jreq	L02
 582  01a3 cc00f1        	jp	L131
 583  01a6               L02:
 584                     ; 103 			timeB = milis();
 586  01a6 cd0000        	call	_milis
 588  01a9 cd0000        	call	c_uitolx
 590  01ac 96            	ldw	x,sp
 591  01ad 1c0007        	addw	x,#OFST-41
 592  01b0 cd0000        	call	c_rtol
 595  01b3               L751:
 596                     ; 105 				if (milis() - timeB > 1000){
 598  01b3 cd0000        	call	_milis
 600  01b6 cd0000        	call	c_uitolx
 602  01b9 96            	ldw	x,sp
 603  01ba 1c0007        	addw	x,#OFST-41
 604  01bd cd0000        	call	c_lsub
 606  01c0 ae0004        	ldw	x,#L41
 607  01c3 cd0000        	call	c_lcmp
 609  01c6 255a          	jrult	L361
 610                     ; 106 					if ((sekundy) == 0 && (minuty) == 0 && (hodiny) == 0){
 612  01c8 1e2b          	ldw	x,(OFST-5,sp)
 613  01ca 2619          	jrne	L561
 615  01cc 1e2f          	ldw	x,(OFST-1,sp)
 616  01ce 2615          	jrne	L561
 618  01d0 1e2d          	ldw	x,(OFST-3,sp)
 619  01d2 2611          	jrne	L561
 620  01d4               L761:
 621                     ; 108 								GPIO_WriteReverse(GPIOB,GPIO_PIN_2); // zapíšeme na PC5 log. úroveò High (log.1) - rozsvítí LED
 623  01d4 4b04          	push	#4
 624  01d6 ae5005        	ldw	x,#20485
 625  01d9 cd0000        	call	_GPIO_WriteReverse
 627  01dc 84            	pop	a
 628                     ; 109 								delay_ms(100);
 630  01dd ae0064        	ldw	x,#100
 631  01e0 cd0000        	call	_delay_ms
 634  01e3 20ef          	jra	L761
 635  01e5               L561:
 636                     ; 112 					sekundy+=-1;
 638  01e5 1e2b          	ldw	x,(OFST-5,sp)
 639  01e7 1cffff        	addw	x,#65535
 640  01ea 1f2b          	ldw	(OFST-5,sp),x
 642                     ; 113 					if ((sekundy) < 0){
 644  01ec 9c            	rvf
 645  01ed 1e2b          	ldw	x,(OFST-5,sp)
 646  01ef 2e24          	jrsge	L371
 647                     ; 114 						if ((minuty) == 0){
 649  01f1 1e2f          	ldw	x,(OFST-1,sp)
 650  01f3 2610          	jrne	L571
 651                     ; 115 							if ((hodiny)!=0){
 653  01f5 1e2d          	ldw	x,(OFST-3,sp)
 654  01f7 270c          	jreq	L571
 655                     ; 116 							hodiny+=-1;
 657  01f9 1e2d          	ldw	x,(OFST-3,sp)
 658  01fb 1cffff        	addw	x,#65535
 659  01fe 1f2d          	ldw	(OFST-3,sp),x
 661                     ; 117 							minuty=60;
 663  0200 ae003c        	ldw	x,#60
 664  0203 1f2f          	ldw	(OFST-1,sp),x
 666  0205               L571:
 667                     ; 120 						if ((minuty)!=0){
 669  0205 1e2f          	ldw	x,(OFST-1,sp)
 670  0207 270c          	jreq	L371
 671                     ; 121 							minuty+=-1;
 673  0209 1e2f          	ldw	x,(OFST-1,sp)
 674  020b 1cffff        	addw	x,#65535
 675  020e 1f2f          	ldw	(OFST-1,sp),x
 677                     ; 122 							sekundy=59;
 679  0210 ae003b        	ldw	x,#59
 680  0213 1f2b          	ldw	(OFST-5,sp),x
 682  0215               L371:
 683                     ; 125 					timeB=milis();
 685  0215 cd0000        	call	_milis
 687  0218 cd0000        	call	c_uitolx
 689  021b 96            	ldw	x,sp
 690  021c 1c0007        	addw	x,#OFST-41
 691  021f cd0000        	call	c_rtol
 694  0222               L361:
 695                     ; 127 				lcd_gotoxy(0 ,0);
 697  0222 5f            	clrw	x
 698  0223 cd0000        	call	_lcd_gotoxy
 700                     ; 128 				sprintf(text,"cas = %2d:%2d:%2d",hodiny,minuty,sekundy);
 702  0226 1e2b          	ldw	x,(OFST-5,sp)
 703  0228 89            	pushw	x
 704  0229 1e31          	ldw	x,(OFST+1,sp)
 705  022b 89            	pushw	x
 706  022c 1e31          	ldw	x,(OFST+1,sp)
 707  022e 89            	pushw	x
 708  022f ae0008        	ldw	x,#L351
 709  0232 89            	pushw	x
 710  0233 96            	ldw	x,sp
 711  0234 1c0013        	addw	x,#OFST-29
 712  0237 cd0000        	call	_sprintf
 714  023a 5b08          	addw	sp,#8
 715                     ; 129 				lcd_puts(text);
 717  023c 96            	ldw	x,sp
 718  023d 1c000b        	addw	x,#OFST-37
 719  0240 cd0000        	call	_lcd_puts
 722  0243 acb301b3      	jpf	L751
 757                     ; 150 void assert_failed(u8* file, u32 line)
 757                     ; 151 { 
 758                     	switch	.text
 759  0247               _assert_failed:
 763  0247               L122:
 764  0247 20fe          	jra	L122
 815                     	xdef	_main
 816                     	xdef	_check_ncoder
 817                     	xdef	_cisloB
 818                     	xdef	_sekundy
 819                     	xdef	_minuty
 820                     	xdef	_hodiny
 821                     	xdef	_setup
 822                     	xref	_lcd_puts
 823                     	xref	_lcd_gotoxy
 824                     	xref	_lcd_init
 825                     	xref	_sprintf
 826                     	xref	_init_milis
 827                     	xref	_delay_ms
 828                     	xref	_milis
 829                     	xdef	_assert_failed
 830                     	xref	_GPIO_ReadInputPin
 831                     	xref	_GPIO_WriteReverse
 832                     	xref	_GPIO_Init
 833                     	xref	_CLK_HSIPrescalerConfig
 834                     	switch	.const
 835  0008               L351:
 836  0008 636173203d20  	dc.b	"cas = %2d:%2d:%2d",0
 856                     	xref	c_rtol
 857                     	xref	c_lcmp
 858                     	xref	c_lsub
 859                     	xref	c_uitolx
 860                     	end
