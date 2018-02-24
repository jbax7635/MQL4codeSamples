//+------------------------------------------------------------------+
//|                                              TrendFollowerEA.mq4 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

//DISCRIPTION
//uses the slope Moving average to trigger buy/sell/stop

//stopMa
extern int stopMa = 16;
 int stopMaShift=0;
 int stopMaMeathod=0;
 int stopMaAppliedTo=0;

//fastMa
extern int fastMa = 16;
 int fastMaShift=0;
 int fastMaMeathod=0;
 int fastMaAppliedTo=0;

extern double EmergencyStopLoss = 50;
extern double takeProfit=5;
 double pips=0;

 int magicNumber = 1000;

extern double LongTrigger = 1;
extern double LongStop = 1;

extern double ShortTrigger = -20;
extern double ShortStop = -20;


extern int slopeSensitivity = 2;
extern int stopSlopeSensitivity = 2;

double previousSlope=0;
int ThisBarTrade           =  0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
  double tickSize =MarketInfo(Symbol(),MODE_TICKSIZE);
   if(tickSize==.00001||tickSize==.001)
    pips= tickSize*10;
   else pips=tickSize;
   printf("Robot Initiated");
//---
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
//---                            reffer to menu in appled (simple, on the close)(1 is candle which is just closed)
if (Bars != ThisBarTrade ) {
   ThisBarTrade = Bars;  // ensure only one trade opportunity per bar
   // Trade logic goes here

 double lotSize = 1;

  double currentFast = iMA(NULL,0,fastMa,fastMaShift,fastMaMeathod,fastMaAppliedTo,1);
  double previousFast= iMA(NULL,0,fastMa,fastMaShift,fastMaMeathod,fastMaAppliedTo,1+slopeSensitivity);
    double currentStop = iMA(NULL,0,stopMa,stopMaShift,stopMaMeathod,stopMaAppliedTo,1);
  double previousStop= iMA(NULL,0,stopMa,stopMaShift,stopMaMeathod,stopMaAppliedTo,1+stopSlopeSensitivity);
  
  double slope = (currentFast-previousFast)/slopeSensitivity;
   double stopSlope = (currentStop-previousStop)/stopSlopeSensitivity;
   Print(previousSlope,ShortTrigger,LongTrigger);
  double LTrigger=LongTrigger/100000.0;
   double LStop=LongStop/100000.0;
  double STrigger=ShortTrigger/100000.0;
   double SStop=ShortStop/100000.0;
   
  if(previousSlope!=0){
  
       if(previousSlope<LTrigger&& slope>LTrigger/*&&stopSlope>LStop*/)
  { 
  double buyticket=OrderSend(Symbol(),OP_BUY,lotSize,Ask,3,Ask-(EmergencyStopLoss*pips),Ask+takeProfit*pips,NULL,magicNumber+1,0,Green);
 
    }
    
    
      
      if(previousSlope>STrigger&& slope<STrigger/*&&stopSlope<SStop*/)
   { double sellticket=OrderSend(Symbol(),OP_SELL,lotSize,Bid,3,Bid+(EmergencyStopLoss*pips),Bid-takeProfit*pips,NULL,magicNumber-1,0,Red);
   
      }
  }
      previousSlope=slope;
   Print(previousSlope,STrigger,LTrigger);
   
 /*
  
for (int i = 0; i < OrdersTotal(); i++)
{
if(OrderSelect(i,SELECT_BY_POS)==true)
{


//Short Stop Check
if(OrderMagicNumber()==magicNumber-1&&stopSlope>=SStop)
{
OrderClose(OrderTicket(),OrderLots() , Ask,3, Red);
}

//Long Trailing Stop Adjustment
if(OrderMagicNumber()==magicNumber+1&&stopSlope<=LStop)
{
OrderClose(OrderTicket(),OrderLots() , Bid,3, Red);
}


}      
}
  
  */
  
  
  
  }}
