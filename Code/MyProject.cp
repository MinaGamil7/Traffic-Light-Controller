#line 1 "D:/Projects Summer Training/Embedded/Code/MyProject.c"
#line 18 "D:/Projects Summer Training/Embedded/Code/MyProject.c"
int i;
char flag = 0;
char counter = 0;
char South_flag = 0;
char West_flag = 0;
char segment[] = {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09
 ,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19
 ,0x20,0x21,0x22,0x23};
void south_yellow(){
  portD.B2  = 0;
  portD.B3  = 1;
  portD.B4  = 0;
  portD.B5  = 1;
  portD.B6  = 0;
  portD.B7  = 0;
}
void south_green(){
  portD.B2  = 0;
  portD.B3  = 0;
  portD.B4  = 1;
  portD.B5  = 1;
  portD.B6  = 0;
  portD.B7  = 0;
}
void west_yellow(){
  portD.B2  = 1;
  portD.B3  = 0;
  portD.B4  = 0;
  portD.B5  = 0;
  portD.B6  = 1;
  portD.B7  = 0;
}
void west_green(){
  portD.B2  = 1;
  portD.B3  = 0;
  portD.B4  = 0;
  portD.B5  = 0;
  portD.B6  = 0;
  portD.B7  = 1;
}
void interrupt(){
 if(INTF_bit){
 INTF_bit = 0;
 INTE_bit = 0;
 while(1){
 if(South_flag){
 counter = 1;
 portB = 0b00111100;
 i = 16;
 West_flag = 0;
 south_green();
 while( portB.B1 ){
 if(INTF_bit == 1){
 INTF_bit = 0;
 flag = 1;
 break;
 }
 }
 if(flag){
 flag = 0;
 break;
 }
 for(i = 3;i >= 0;i--){
 portB = 0b00000000;
 portC = segment[i];
 south_yellow();
 delay_ms(1000);
 }
 South_flag = !(South_flag);
 }
 else{
 counter = 0;
 portB = 0b00111100;
 i = 24;
 West_flag = 1;
 west_green();
 while( portB.B1 ){
 if(INTF_bit == 1){
 INTF_bit = 0;
 flag = 1;
 break;
 }
 }
 if(flag){
 flag = 0;
 break;
 }
 for(i = 3;i >= 0;i--){
 portB = 0b00000000;
 portC = i;
 west_yellow();
 delay_ms(1000);
 }
 South_flag = !(South_flag);
 }
 }
 INTE_bit = 1;
 }
}
void west() {
 South_flag = 0;
 for(i = 23;i >= 0;i--){
 if(!(West_flag) && counter){
 counter = 0;
 break;
 }
 portB = 0b00000000;
 portC = segment[i];
 if(i > 3)west_green();
 else west_yellow();
 delay_ms(1000);
 }
}
void south() {
 South_flag = 1;
 for(i = 15;i >= 0;i--){
 if(West_flag){
 West_flag = 0;
 break;
 }
 portB = 0b00000000;
 portC = segment[i];
 if(i > 3)south_green();
 else south_yellow();
 delay_ms(1000);
 }
}

void main() {
 trisC = 0b00000000;
 trisD = 0b00000000;
 trisB = 0b00000011;
 INTE_bit = 1;
 GIE_bit = 1;
 INTEDG_bit = 0;
 loop:
 west();
 south();
 goto loop;
}
