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

extern double trailLosss =35;
double trailLoss =trailLosss*Point*10;
extern double buyCutOff = .52; 
extern double sellCutOff = .49;
extern double takeProfitt = 80;
extern double stopLosss = 100;
//extern double risk = .01;
//extern double accountReserve = .2;
//extern double Average = 20;

 double takeProfit = takeProfitt*Point*10;//6.8
 double stopLoss = stopLosss*Point*10;//3.6


double ADirection = 0; //proportion of last 5 1m ticks upward
double A = 0; //proportion of last 10 1m ticks upward
double MacD = 0; //proportion of last 20 1m ticks upward
double BDirection = 0; //Slope of c from 20 mins ago to now
double B = 0; //last 5 1m tick size and direction (average)
double Stoc = 0; //last 10 1m tick size and direction (average)
double CDirection = 0; //20SMA slope 20 periods ago till now
double C = 0; //20SMA slope 20 periods ago till now


double b0 = 0.100484990568514;//0.0999763013501513;//0.0998835492251033; //120minute regression 2015-2017//15minute regression 2015-2017//15minute regression 2017
double b1 = -0.00066595383197919;//-0.0022731660694331;//-0.0023042820575413; 
double b2 = 0.0428674208312725;//0.100473350586248;//0.0965638646239525;
double b3 = 0.10026941075673;//0.0999786211021981;//0.0999690527250419;
double b4 = -0.000737052644227322;//-0.0016427123250452;//-0.00117997690505978;
double b5 =-0.0452948686416168;//-0.0422879427478928;// -0.0387588354143091;
double b6 =0.100313074528222;// 0.0999012224927114;//0.0998219480235081;
double b7 = -0.00091683662989246;//-0.00157035305521744;//-0.00184379884580967;
double b8 = -0.110420005686238;//-0.137323060851885;//-0.102498900152494;
double b9 = 0.0996855487287171;// 0.0999423364995556;//0.0999901623714795;
double b10 = -0.00110231356960479;//-0.00185134189216756;//-0.00109692561030346;
double b11 = -0.00401395842084728;//-0.0168638451246795;//0.000830966392230202;
double b12 = 0.100921965659202;//0.100131541003995;//0.0999063692480248;
double b13 = -0.00077209116917602;//-0.00122236953033615;//-0.0019384949186334;
double b14= 0.133298128696589;//0.155103546030637;//0.175214415227082;
double b15= 0.0998960069813121;//0.0999816265149066;//0.0999772814218886;
double b16= -0.00104583443272743;//-0.00116535270396477;//-0.00257373671510201;
double b17= -0.0108703927872572;//0.0353197402549742;//-0.0293837905842666;
double b18= 0.100186757403801;//0.0998565335792022;//0.100012359102084;
double b19= -0.000942278455154396;//-0.00235871026464803;//-0.00348929256095971;
double b20= -0.0743570710345244;// -0.0929158507069024;//-0.103507220104105;
double b21= 0.09924338123818;//0.0999014705809957;//0.0999900439042032;
double b22= -0.000716833765913933;//-0.00199660515334506;//-0.00268673992390745;
double b23= 0.0510966038951804;// 0.0400847847813721;//0.0338105780929237;
/*
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
   

   
 if(ADirection<0&&BDirection<0&&CDirection<0){
 logit = b14+ b12*A+(b13*Stoc);
 }
 if(ADirection>0&&BDirection<0&&CDirection<0){
 logit = 0;//b23+ b21*A+(b22*Stoc);
 } 
 if(ADirection>0&&BDirection>0&&CDirection<0){
 logit = 0;//b20+ b18*A+(b19*Stoc);
 }
 if(ADirection<0&&BDirection>0&&CDirection<0){
 logit = 0;//b17+ b15*A+(b16*Stoc);
 }
 if(ADirection<0&&BDirection<0&&CDirection>0){
  logit =0;//b2+ b0*A+(b1*Stoc);
 }
 if(ADirection>0&&BDirection<0&&CDirection>0){
 logit = 0;//b11+ b9*A+(b10*Stoc);
 }
 if(ADirection>0&&BDirection>0&&CDirection>0){
  logit = b8+ b6*A+(b7*Stoc);
 } 
 if(ADirection<0&&BDirection>0&&CDirection>0){
 logit = 0;//b5+ b3*A+(b4*Stoc);
 } 
 
  /*    
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

   //double lotSize = NormalizeDouble(((     ((AccountFreeMargin()-AccountFreeMargin()*accountReserve)*risk)/(.01*stopLosss))    *.01),2); //sizes investment to 5% of account balance
 //  if(lotSize<.01){lotSize = .01;} //if account reduces, makes 1 microlot the min investment
 //  Print(lotSize+" lotsize");
  
 

double expL = exp(logit);
double probability = expL/(1+expL);

if(probability>buyCutOff&&AccountBalance()<=AccountEquity())
{
double buyticket=OrderSend(Symbol(),OP_BUY,.01,Ask,3,Ask-(stopLoss),Ask+(takeProfit),NULL,0,0,Green);
//double  close=closeTrades("short");
}
if(probability<sellCutOff&&AccountBalance()<=AccountEquity())
{
 double sellticket=OrderSend(Symbol(),OP_SELL,.01,Bid,3,Bid+(stopLoss),Bid-(takeProfit),NULL,0,0,Red);
// double  close=closeTrades("long");
}
double number = trailTrades();
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
  double closeTrades(string direction) {
  double longTrades = 0;
  int trade;
  int tradeCount=0;
  int trades=OrdersTotal();
  for(trade=0;trade<trades;trade++)
     {
    
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol())
         {
         tradeCount++;
  if(direction=="long")
           {OrderClose(OrderTicket(),OrderLots(),Bid,3,0);}
           if(direction=="short")
           {OrderClose(OrderTicket(),OrderLots(),Ask,3,0);}
  
  
  }}
  
 return 0;
  }
   double trailTrades(){
   {
  //double tradesGood = checkTrades();
//----
   double stopcrnt;
   double stopcal;
   int trade;
   int trades=OrdersTotal();
   double profitcalc;
   for(trade=0;trade<trades;trade++)
     {
    
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol())
         {
         //continue;
         //LONG
         if(OrderType()==OP_BUY)
           {
            stopcrnt=OrderStopLoss();
            stopcal=Bid-(stopLoss);
            //profitcalc=OrderTakeProfit()+(TakeProfit*Point);
            if (stopcrnt==0)
              {
               OrderModify(OrderTicket(),OrderOpenPrice(),stopcal,0/*profitcalc*/,0,Blue);
              }
              
              
              
              
             
           /* else
               if(OrderOpenPrice()<OrderStopLoss()&& stopcal>(stopcrnt+trailProfit)) //moves stop from break even up continually
                 {
                  OrderModify(OrderTicket(),OrderOpenPrice(),stopcal,0/*profitcalc*///,0,Blue);
                  //  if(trades<20){ double buyticket=OrderSend(Symbol(),OP_BUY,lotSize,Ask,3,stopcal/*Ask-(trail)*/,0/*Ask+(takeProfit*.00001)*/,NULL,0,0,Green);}
               //  }*/
                 else
               if(OrderOpenPrice()>OrderStopLoss()&&stopcal>(stopcrnt+trailLoss)&&trailLoss!=0)//moves stop up to open price
                 {
                  OrderModify(OrderTicket(),OrderOpenPrice(),stopcal,OrderTakeProfit(),0,Blue);
             // if(OrderOpenPrice()<OrderStopLoss()){double buyticket= OrderSend(Symbol(),OP_BUY,.01,Ask,3,stopcal,OrderTakeProfit(),NULL,0,0,Green);}
                 }
            }
         }//LONG
         //Shrt
         if(OrderType()==OP_SELL)
           {
            stopcrnt=OrderStopLoss();
            stopcal=Ask+(stopLoss);
           // profitcalc=OrderTakeProfit()-(TakeProfit*Point);
            if (stopcrnt==0)
              {
               OrderModify(OrderTicket(),OrderOpenPrice(),stopcal,0/*profitcalc*/,0,Red);
              }
             
          /*  else
               if(OrderOpenPrice()>OrderStopLoss()&&stopcal<(stopcrnt-trailProfit))
                 {
                  OrderModify(OrderTicket(),OrderOpenPrice(),stopcal,0/*profitcalc*///,0,Red);
              //  if(trades<20){ double sellticket=OrderSend(Symbol(),OP_SELL,lotSize,Bid,3,stopcal/*Bid+(trail)*/,0/*Bid-(takeProfit*.00001)*/,NULL,0,0,Red);}
                // }*/
                 else
               if(OrderOpenPrice()<OrderStopLoss()&&stopcal<(stopcrnt-trailLoss)&&trailLoss!=0)
                 {
                  OrderModify(OrderTicket(),OrderOpenPrice(),stopcal,OrderTakeProfit(),0,Red);
               // if(OrderOpenPrice()>OrderStopLoss()){double buyticket= OrderSend(Symbol(),OP_SELL,.01,Bid,3,stopcal,OrderTakeProfit(),NULL,0,0,Green);}
                 }
           }
      }
  }//Shrt
  
  return 0;
  }
  double checkTrades()
  {
  double good = 0;
  int trade;
  int trades=OrdersTotal();
  for(trade=0;trade<trades;trade++)
     {
    
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol())
         {
  if(OrderType()==OP_BUY)
           {if(OrderOpenPrice()<Ask){good++;}}
  
  
  if(OrderType()==OP_SELL)
           {if(OrderOpenPrice()>Bid){good++;}}
  
  }}
  if(good>=trades-2){return 1;}
  else return 0;

  }
//+------------------------------------------------------------------+