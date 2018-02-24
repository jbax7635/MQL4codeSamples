//+------------------------------------------------------------------+
//|                                                        uther.mq4 |
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

extern double stopLine=90;
extern double trendAverage=90;
extern double shortAverage = 200;
extern double longAverage = 1900;
extern double takeProfitt = 60;//
 double takeProfit = takeProfitt*Point*10;
extern double stopLos = 40;//
double stopLoss = stopLos*Point*10;
extern double shift = 25;
extern double traillProf = 11;//
double trailProfit = traillProf*Point*10;
extern double traillLoss = 11;//
double trailLoss = traillLoss*Point*10;
    
   double lotSize = .01;
   
   
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
   ThisBarTrade = Bars; 
   
   double trade = tradeTrades();
   double trailll = trailTrades();
   
   
   }}
   
   double tradeTrades(){

   //double lotSize = NormalizeDouble(((     (AccountFreeMargin()*risk)/(.01*stopLos))    *.01),2); //sizes investment to 5% of account balance
    //if(lotSize<.01){lotSize = .01;} //if account reduces, makes 1 microlot the min investment
  // Print(lotSize+" lotsize");
//---
   
   //SELL
   //if((iMA(NULL,0,5,0,0,0,0)<iMA(NULL,0,longAverage,0,0,0,0))&&(iMA(NULL,0,5,0,0,0,0)<iMA(NULL,0,shortAverage,0,0,0,0)))
     if((iMA(NULL,0,shortAverage,0,0,0,1)>iMA(NULL,0,longAverage,0,0,0,1))&&(iMA(NULL,0,shortAverage,0,0,0,0)<iMA(NULL,0,longAverage,0,0,0,0))&&(Bid<iMA(NULL,0,stopLine,0,0,0,0))){//fast moving average is above 2 slower moving averages
  // if(iStochastic(NULL,0,5,3,3,0,0,0,1)>80&&iStochastic(NULL,0,5,3,3,0,0,0,0)<80){ //stochastic idicator goes through a certain point
    //if(iMACD(NULL,0,12,26,9,0,0,0)<0&&iMACD(NULL,0,12,26,9,0,0,1)>0){
  // if(((iMA(NULL,0,trendAverage,0,0,0,0)-iMA(NULL,0,trendAverage,0,0,0,shift)))<0){//slope of a certain moving average is greater than a certain amount
   
   double sellticket=OrderSend(Symbol(),OP_SELL,lotSize,Bid,3,Bid+(stopLoss),0/*Bid-(takeProfit)*/,NULL,0,0,Red);
   }//}}//}
   
   //BUY
 //  if((iMA(NULL,0,5,0,0,0,0)>iMA(NULL,0,longAverage,0,0,0,0))&&(iMA(NULL,0,5,0,0,0,0)>iMA(NULL,0,shortAverage,0,0,0,0)))
  if((iMA(NULL,0,shortAverage,0,0,0,1)<iMA(NULL,0,longAverage,0,0,0,1))&&(iMA(NULL,0,shortAverage,0,0,0,0)>iMA(NULL,0,longAverage,0,0,0,0))&&(Bid>iMA(NULL,0,stopLine,0,0,0,0))){//fast moving average is above 2 slower moving averages
  // if(iStochastic(NULL,0,5,3,3,0,0,0,1)<20&&iStochastic(NULL,0,5,3,3,0,0,0,0)>20){ //stochastic idicator goes through a certain point
  // if(iMACD(NULL,0,12,26,9,0,0,0)>0&&iMACD(NULL,0,12,26,9,0,0,1)<0){
  // if(((iMA(NULL,0,trendAverage,0,0,0,0)-iMA(NULL,0,trendAverage,0,0,0,shift)))>0){//slope of a certain moving average is greater than a certain amount
   
   double buyticket=OrderSend(Symbol(),OP_BUY,lotSize,Ask,3,Ask-(stopLoss),0/*Ask+(takeProfit)*/,NULL,0,0,Green);
   }//}}//}
   
   return 0;
  }
  
  double trailTrades(){
   {
   
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
              else
               if(Ask<iMA(NULL,0,shortAverage,0,0,0,0)){OrderClose(OrderTicket(),OrderLots(),Bid,3,0);}
           /* else
               if(OrderOpenPrice()<OrderStopLoss()&& stopcal>(stopcrnt+trailProfit))
                 {
                  OrderModify(OrderTicket(),OrderOpenPrice(),stopcal,0/*profitcalc*///,0,Blue);
                  //  if(trades<20){ double buyticket=OrderSend(Symbol(),OP_BUY,lotSize,Ask,3,stopcal/*Ask-(trail)*/,0/*Ask+(takeProfit*.00001)*/,NULL,0,0,Green);}
               //  }*/
                /* else
               if(OrderOpenPrice()>OrderStopLoss()&&stopcal>(stopcrnt+trailLoss)&&trailLoss!=0)
                 {
                  OrderModify(OrderTicket(),OrderOpenPrice(),stopcal,0/*profitcalc*///,0,Blue);
                // if(trades<10){double buyticket=OrderSend(Symbol(),OP_BUY,lotSize,Ask,3,stopcal/*Ask-(trail)*/,0/*Ask+(takeProfit*.00001)*/,NULL,0,0,Green);}
                 //}
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
              else
               if(Ask<iMA(NULL,0,shortAverage,0,0,0,0)){OrderClose(OrderTicket(),OrderLots(),Ask,3,0);}
          /*  else
               if(OrderOpenPrice()>OrderStopLoss()&&stopcal<(stopcrnt-trailProfit))
                 {
                  OrderModify(OrderTicket(),OrderOpenPrice(),stopcal,0/*profitcalc*///,0,Red);
              //  if(trades<20){ double sellticket=OrderSend(Symbol(),OP_SELL,lotSize,Bid,3,stopcal/*Bid+(trail)*/,0/*Bid-(takeProfit*.00001)*/,NULL,0,0,Red);}
                // }*/
               /*  else
               if(OrderOpenPrice()<OrderStopLoss()&&stopcal<(stopcrnt-trailLoss)&&trailLoss!=0)
                 {
                  OrderModify(OrderTicket(),OrderOpenPrice(),stopcal,0/*profitcalc*///,0,Red);
                /// if(trades<10){ double sellticket=OrderSend(Symbol(),OP_SELL,lotSize,Bid,3,stopcal/*Bid+(trail)*/,0/*Bid-(takeProfit*.00001)*/,NULL,0,0,Red);}
                // }
           }
      }
  }//Shrt
  
  return 0;
  }
//+------------------------------------------------------------------+
