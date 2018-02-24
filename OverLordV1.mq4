//+------------------------------------------------------------------+
//|                                                     OverLord.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int ThisBarTrade =  0;//variable used to ensure only one trade per bar is performed
double pips=0;//variable used to ensure only one trade per bar is performed



extern double buyCutOff = .5;
extern double sellCutOff = .5;
extern double takeProfit = 5;
extern double stopLoss = 5;




double ADirection = 0; //proportion of last 5 1m ticks upward
double A = 0; //proportion of last 10 1m ticks upward
double MacD = 0; //proportion of last 20 1m ticks upward
double BDirection = 0; //Slope of c from 20 mins ago to now
double B = 0; //last 5 1m tick size and direction (average)
double Stoc = 0; //last 10 1m tick size and direction (average)
double CDirection = 0; //20SMA slope 20 periods ago till now
double C = 0; //20SMA slope 20 periods ago till now


double b01 = 0.00463569576961111; //intercept
/*double b02 = -3.9261065357111; //intercept
double b03 = -3.9261065357111; //intercept
double b04 = -3.9261065357111; //intercept
double b05 = -3.9261065357111; //intercept
double b06 = -3.9261065357111; //intercept
double b07 = -3.9261065357111; //intercept
double b08 = -3.9261065357111; //intercept*/
double b1 = -205.32670294845; 
double b2 = -0.00266354368206214;
double b3 = 0.315932630668033;
/*double b4 = 273.836255458535;
double b5 = -6736.20277635117;
double b6 = -7267.06322147547;
double b7 = 1094.17572965062;
double b8 = 1094.17572965062;
double b9 = 1094.17572965062;
double b10 = 1094.17572965062;
double b11 = 1094.17572965062;
double b12 = 1094.17572965062;
double b13 = 1094.17572965062;
double b14= 1094.17572965062;
double b15= 1094.17572965062;
double b16= 1094.17572965062;
double b17= 1094.17572965062;
double b18= 1094.17572965062;
double b19= 1094.17572965062;
double b20= 1094.17572965062;
double b21= 1094.17572965062;
double b22= 1094.17572965062;
double b23= 1094.17572965062;
double b24= 1094.17572965062;
double b25= 1094.17572965062;
double b26= 1094.17572965062;
double b27= 1094.17572965062;
double b28= 1094.17572965062;
double b29= 1094.17572965062;
double b30= 1094.17572965062;*/




int OnInit()
{
 double tickSize =MarketInfo(Symbol(),MODE_TICKSIZE);
   if(tickSize==.00001||tickSize==.001)
    pips= tickSize*100;
   else pips=tickSize;
 
   return(INIT_SUCCEEDED);
   }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
if (Bars != ThisBarTrade ) {
   ThisBarTrade = Bars;  // ensure only one trade opportunity per bar
   // Trade logic goes here
    /*/ /To Be Removed
    double fileHandle = FileOpen("testing.csv",FILE_CSV|FILE_READ | FILE_WRITE);
   if(fileHandle!=INVALID_HANDLE){
   
      FileSeek(fileHandle, 0, SEEK_END); // Write at the end of the file.
      string data = iTime(NULL,0,0)+"," + iClose(NULL,0,0)+","+ ADirection+","+ A+","+ BDirection+","+ B+","+ CDirection+","+ C+","+ MacD+","+ Stoc;
      FileWrite(fileHandle,data);
      FileClose(fileHandle);
     }
     else
      Print("Failed");*/
   
   ADirection=getADirection();
   A=getA();
   MacD=getMacD();
   BDirection=getBDirection();
   B=getB();
   Stoc=getStoc();
   CDirection=getCDirection();
   C=getC();
   double logit=0;
   
 /*if(ADirection<0&&BDirection<0&&CDirection<0){
 logit = b05+ b24*(b25*A+B+C*b23)+b21*(b22*Stoc+MacD) //21 22 23 24 25
 }
 if(ADirection>0&&BDirection<0&&CDirection<0){
 logit = b08+ b36*(b37*A+B+C*b38)+b39*(b40*Stoc+MacD) //36 37 38 39 40
 } 
 if(ADirection>0&&BDirection>0&&CDirection<0){
 logit = b07+ b31*(b32*A+B+C*b33)+b34*(b36*Stoc+MacD) //31 32 33 34 35
 }
 if(ADirection<0&&BDirection>0&&CDirection<0){
 logit = b06+ b26*(b27*A+B+C*b28)+b29*(b30*Stoc+MacD) //26 27 28 29 30
 }
 if(ADirection<0&&BDirection<0&&CDirection>0){
 logit = b01+ b2*(b1*A+B+C*b17)+b9*(b10*Stoc+MacD)  // 1 2 9 10 17
 }
 if(ADirection>0&&BDirection<0&&CDirection>0){
 logit = b04+ b8*(b7*A+B+C*b20)+b16*(b15*Stoc+MacD)  //7 8 15 16 20
 }
 if(ADirection>0&&BDirection>0&&CDirection>0){
 logit = b03+ b6*(b5*A+B+C*b19)+b13*(b14*Stoc+MacD) //5 6 13 14 19
 } 
 if(ADirection<0&&BDirection>0&&CDirection>0){
 logit = b02+ b4*(b3*A+B+C*b18)+b12*(b11*Stoc+MacD)  //3 4 11 12 18
 } 
 
       
if(logit!=0){      
double probability= (exp(logit))/(1+(exp(logit)));  
int ticketNumber;
if(probability>buyCutOff)
{ticketNumber= OrderSend(Symbol(), OP_BUY, 5, Close[0], 0, 0, 0, "BO exp:900", 1, 0, clrGreen);
if(ticketNumber <0){Print("Not Working BUY");}}
if(probability<sellCutOff)
{ticketNumber=OrderSend(Symbol(), OP_SELL, 5, Close[0], 0, 0, 0, "BO exp:900", 1, 0, clrGreen);
if(ticketNumber <0){Print("Not Working SELL");}}}*/

//logit = b01+ b3*(b1*B+A)+b2*(Stoc) ;
double expL = exp(logit);
double probability = expL/(1+expL);
Print(stopLoss*pips);
if(probability>buyCutOff)
{
double buyticket=OrderSend(Symbol(),OP_BUY,.1,Ask,3,Ask-(stopLoss*pips),Ask+(takeProfit*pips),NULL,0,0,Green);
}
if(probability<sellCutOff)
{
 double sellticket=OrderSend(Symbol(),OP_SELL,.1,Bid,3,Bid+(stopLoss*pips),Bid-(takeProfit*pips),NULL,0,0,Red);
}

}}
   
  
  ////--------------------------------------------------
  double getProbability( double logit){//keep.0155
 // double logit = 
  //double logit = b0+b1*.475+b2*0.3+b3*.2+b4*-.0275+b5*-.00012+b6*-.00008+b7*.00000675;
  double expL = exp(logit);

  return  ((expL/(1+expL)));
  }
  //----------------------------------------------------
  double getADirection(){
   double didg;
  didg= (iMA(NULL,0,5,0,0,0,0)-iMA(NULL,0,20,0,0,0,0));

  if(didg >0){return 1;}
  if(didg == 0){return 0;}
  if(didg<0){return-1;}
    return 0;
  }
  
  //---------------------------------------------------
  double getA(){
   double didg;
  didg= (iMA(NULL,0,5,0,0,0,0)-iMA(NULL,0,20,0,0,0,0));//51.73 
// didg= (iMA("XAUUSD",0,5,0,0,0,0)-iMA("XAUUSD",0,20,0,0,0,0));  not tried
  
  return didg;
  }
 
  
  //-----------------------------------------------------
  double getMacD(){
   double didg;
   didg= (iMACD(NULL,0,12,26,9,0,0,0));

  
  return didg;
  }
  //------------------------------------------------------
  double getBDirection(){
   double didg;
   didg= (iMA(NULL,0,20,0,0,0,0)-iMA(NULL,0,200,0,0,0,0));

  if(didg >0){return 1;}
  if(didg == 0){return 0;}
  if(didg<0){return-1;}

  
  return 0;
  }
  //--------------------------------------------------
  double getB(){
   double didg;
   didg= (iMA(NULL,0,20,0,0,0,0)-iMA(NULL,0,200,0,0,0,0));//51.67 
 //didg= (iMA("XAUUSD",0,20,0,0,0,0)-iMA("XAUUSD",0,200,0,0,0,0)); not tried
  
  return didg;
  }
  //-------------------------------------------
  double getStoc(){
   double didg;
   didg= (iStochastic(NULL,0,5,3,3,0,0,0,0)-50);
 //didg= (iMA(NULL,0,20,0,0,0,0)-iMA(NULL,0,80,0,0,0,0));//51.42
  
  return didg;
  }
  //--------------------------------------
  double getCDirection(){
   double didg;
   didg= (iMA(NULL,0,20,0,0,0,0)-iMA(NULL,0,2000,0,0,0,0));

  if(didg >0){return 1;}
  if(didg == 0){return 0;}
  if(didg<0){return-1;}

  
  return 0;
  }
  
//+------------------------------------------------------------------+
 double getC(){
   double didg;
didg= (iMA(NULL,0,20,0,0,0,0)-iMA(NULL,0,2000,0,0,0,0));
 
  
  return didg;
  }
  
//+------------------------------------------------------------------+