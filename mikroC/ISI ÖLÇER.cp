#line 1 "C:/Users/Emre/Desktop/Yeni klasör/mikroC/ISI ÖLÇER/mikroC/ISI ÖLÇER.c"
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

int okunan=0,derece;
char bin,yuz,on,bir;

void basamaklar()
{
bin=(derece/1000)+48;
yuz=((derece/100)%10)+48;
on=((derece/10)&10)+48;
bir=(derece%10)+48;
}

void main()
{
TRISB.f0=0x00;
PORTB.f0=0x00;
TRISE.F0=0;
PORTE.F0=0;
Lcd_Init();
Lcd_Cmd(_Lcd_CURSOR_OFF);
Lcd_Cmd(_Lcd_CLEAR);
CMCON=0x07;
while(1)
 {
 okunan=ADC_Read(1);
 derece=okunan*4.887585552746823069403714565;
 basamaklar();
 Lcd_Chr(1,1,bin);
 Lcd_Chr_CP(yuz);
 Lcd_Chr_CP(on);
 Lcd_Chr_CP('.');
 Lcd_Chr_CP(bir);
 Lcd_Out(1,7,"C");
 Lcd_Chr_CP(0b11011111);
 delay_ms(100);
 if(derece>=400)
 {
 portb.f0=0x00;
 Lcd_Out(2,1,"SOGUYOR");
 PORTE.F0=0x00;
 }
 if(derece<395)
 {
 portb.f0=0x01;
 PORTE.F0=0x01;
 Lcd_Out(2,1,"ISINIYOR");
 }
 }
}
