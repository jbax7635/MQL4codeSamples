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


extern double trendAverage=50;
extern double shortAverage = 50;
extern double longAverage = 50;
//extern double takeProfit = 0;
extern double stopLos = 5;
double stopLoss = stopLos*Point*10;
extern double slope = 0;
extern double shift = 5;
 double trail = stopLoss;
    
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
   double traill = trailTrades();
   
   
   }}
   
   double tradeTrades(){
   Print(iMA(NULL,0,trendAverage,0,0,0,0)-iMA(NULL,0,trendAverage,0,0,0,shift)/shift);
   //double lotSize = NormalizeDouble((((AccountBalance()*.05)/(.01*stopLoss))*.01),2); //sizes investment to 5% of account balance
   // if(lotSize<.01){lotSize = .01;} if account reduces, makes 1 microlot the min investment
   
//---
   
   //SELL
   if((iMA(NULL,0,5,0,0,0,0)<iMA(NULL,0,longAverage,0,0,0,0))&&(iMA(NULL,0,5,0,0,0,0)<iMA(NULL,0,shortAverage,0,0,0,0))){//fast moving average is above 2 slower moving averages
   if(iStochastic(NULL,0,5,3,3,0,0,0,1)>80&&iStochastic(NULL,0,5,3,3,0,0,0,0)<80){ //stochastic idicator goes through a certain point
   if(((iMA(NULL,0,trendAverage,0,0,0,0)-iMA(NULL,0,trendAverage,0,0,0,shift)))<0){//slope of a certain moving average is greater than a certain amount
   
   double sellticket=OrderSend(Symbol(),OP_SELL,lotSize,Bid,3,Bid+(stopLoss),0/*Bid-(takeProfit*.00001)*/,NULL,0,0,Red);
   }}}
   
   //BUY
   if((iMA(NULL,0,5,0,0,0,0)>iMA(NULL,0,longAverage,0,0,0,0))&&(iMA(NULL,0,5,0,0,0,0)>iMA(NULL,0,shortAverage,0,0,0,0))){//fast moving average is above 2 slower moving averages
   if(iStochastic(NULL,0,5,3,3,0,0,0,1)<20&&iStochastic(NULL,0,5,3,3,0,0,0,0)>20){ //stochastic idicator goes through a certain point
   if(((iMA(NULL,0,trendAverage,0,0,0,0)-iMA(NULL,0,trendAverage,0,0,0,shift)))>0){//slope of a certain moving average is greater than a certain amount
   
   double buyticket=OrderSend(Symbol(),OP_BUY,lotSize,Ask,3,Ask-(stopLoss),0/*Ask+(takeProfit*.00001)*/,NULL,0,0,Green);
   }}}
   
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
            stopcal=Bid-(trail);
            //profitcalc=OrderTakeProfit()+(TakeProfit*Point);
            if (stopcrnt==0)
              {
               OrderModify(OrderTicket(),OrderOpenPrice(),stopcal,0/*profitcalc*/,0,Blue);
              }
            else
               if(stopcal>(stopcrnt+trail))
                 {
                  OrderModify(OrderTicket(),OrderOpenPrice(),stopcal,0/*profitcalc*/,0,Blue);
                    double buyticket=OrderSend(Symbol(),OP_BUY,lotSize,Ask,3,Ask-(trail),0/*Ask+(takeProfit*.00001)*/,NULL,0,0,Green);
                 }
            }
         }//LONG
         //Shrt
         if(OrderType()==OP_SELL)
           {
            stopcrnt=OrderStopLoss();
            stopcal=Ask+(trail);
           // profitcalc=OrderTakeProfit()-(TakeProfit*Point);
            if (stopcrnt==0)
              {
               OrderModify(OrderTicket(),OrderOpenPrice(),stopcal,0/*profitcalc*/,0,Red);
              }
            else
               if(stopcal<(stopcrnt-trail))
                 {
                  OrderModify(OrderTicket(),OrderOpenPrice(),stopcal,0/*profitcalc*/,0,Red);
                  double sellticket=OrderSend(Symbol(),OP_SELL,lotSize,Bid,3,Bid+(trail),0/*Bid-(takeProfit*.00001)*/,NULL,0,0,Red);
                 }
           }
      }
  }//Shrt
  
  return 0;
  }
//+------------------------------------------------------------------+
