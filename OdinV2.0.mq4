//+------------------------------------------------------------------+
//|                                                     OdinV2.0.mq4 |
//|                                         Black Wombat Innovations |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Black Wombat Innovations"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
double timeFrameMinutes = 30;
double nextTimeFrameMinutes = 60;
double lastTimeFrameMinutes = 240;

//extern double longerSlopeMinn = .00001;
extern double longestSlopeMinn = .00001;
double longerSlopeMinn =longestSlopeMinn;

//extern double longerGapMinn = .00001;
extern double longestGapMinn = .00001;
double longerGapMinn =longestGapMinn;

double lotSize = .01;

double longerSlopeMin = longerSlopeMinn*30;
double longestSlopeMin = longestSlopeMinn*30;
double longerGapMin = longerGapMinn*30;
double longestGapMin = longestGapMinn*30;

extern double movingAverageTakeProfit = 10;
extern double movingAverageStopLoss = 10;

extern double movingAverageFastPeriod = 10;
extern double movingAverageSlowPeriod = 40;



int ThisBarTrade           =  0;
double pips=0;
int OnInit()
  {

  double tickSize =MarketInfo(Symbol(),MODE_TICKSIZE);
   if(tickSize==.00001||tickSize==.001)
    pips= tickSize*10;
   else pips=tickSize;
   printf("Robot Initiated");

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
   
   double timeFrameFastMa = iMA(NULL,timeFrameMinutes,movingAverageFastPeriod,0,1,0,0);
double timeFrameSlowMa = iMA(NULL,timeFrameMinutes,movingAverageSlowPeriod,0,1,0,0);
double timeFrameFastMaPrevious = iMA(NULL,timeFrameMinutes,movingAverageFastPeriod,0,1,0,1);
double timeFrameSlowMaPrevious = iMA(NULL,timeFrameMinutes,movingAverageSlowPeriod,0,1,0,1);
double timeFrameFastSlope = timeFrameFastMa-timeFrameFastMaPrevious;
double timeFrameSlowSlope = timeFrameSlowMa-timeFrameSlowMaPrevious;
//Print(timeFrameSlowSlope+" timeFrameSlowSlope");

double timeFrameGapDevelopment = timeFrameFastSlope-timeFrameSlowSlope;
//Print(timeFrameGapDevelopment+" timeFrameGapDevelopment");
 
double longerTimeFrameFastMa = iMA(NULL,nextTimeFrameMinutes,movingAverageFastPeriod,0,1,0,0);
double longerTimeFrameSlowMa = iMA(NULL,nextTimeFrameMinutes,movingAverageSlowPeriod,0,1,0,0);
double longerTimeFrameFastMaPrevious = iMA(NULL,nextTimeFrameMinutes,movingAverageFastPeriod,0,1,0,1);
double longerTimeFrameSlowMaPrevious = iMA(NULL,nextTimeFrameMinutes,movingAverageSlowPeriod,0,1,0,1);
double longerTimeFrameFastSlope = longerTimeFrameFastMa-longerTimeFrameFastMaPrevious;
double longerTimeFrameSlowSlope = longerTimeFrameSlowMa-longerTimeFrameSlowMaPrevious;
//Print(longerTimeFrameSlowSlope+" longerTimeFrameSlowSlope");

double longerTimeFrameGapDevelopment = longerTimeFrameFastSlope-longerTimeFrameSlowSlope;
 //Print(longerTimeFrameGapDevelopment+" longerTimeFrameGapDevelopment");
 
double longestTimeFrameFastMa = iMA(NULL,lastTimeFrameMinutes,movingAverageFastPeriod,0,1,0,0);
double longestTimeFrameSlowMa = iMA(NULL,lastTimeFrameMinutes,movingAverageSlowPeriod,0,1,0,0);
double longestTimeFrameFastMaPrevious = iMA(NULL,lastTimeFrameMinutes,movingAverageFastPeriod,0,1,0,1);
double longestTimeFrameSlowMaPrevious = iMA(NULL,lastTimeFrameMinutes,movingAverageSlowPeriod,0,1,0,1);
double longestTimeFrameFastSlope = longestTimeFrameFastMa-longestTimeFrameFastMaPrevious;
double longestTimeFrameSlowSlope = longestTimeFrameSlowMa-longestTimeFrameSlowMaPrevious;
//Print(longestTimeFrameSlowSlope+" longestTimeFrameSlowSlope");

double longestTimeFrameGapDevelopment = longestTimeFrameFastSlope-longestTimeFrameSlowSlope;


  if(/*longestTimeFrameSlowSlope>longestSlopeMin&&longestTimeFrameFastSlope>longestSlopeMin&&*/longerTimeFrameFastSlope>longerSlopeMin&&longerTimeFrameSlowSlope>longerSlopeMin/*&&longestTimeFrameGapDevelopment>longestGapMin*/&&longerTimeFrameGapDevelopment>longerGapMin&&timeFrameFastMaPrevious<timeFrameSlowMaPrevious&&timeFrameSlowMa<timeFrameFastMa){
   double buyticket=OrderSend(Symbol(),OP_BUY,lotSize,Ask,3,Ask-(movingAverageStopLoss*pips),Ask+movingAverageTakeProfit*pips,NULL,0,0,Green);}
 if(/*longestTimeFrameSlowSlope<-longestSlopeMin&&longestTimeFrameFastSlope<-longestSlopeMin&&*/longerTimeFrameFastSlope<-longerSlopeMin&&longerTimeFrameSlowSlope<-longerSlopeMin/*&&longestTimeFrameGapDevelopment<-longestGapMin*/&&longerTimeFrameGapDevelopment<-longerGapMin&&timeFrameFastMaPrevious>timeFrameSlowMaPrevious&&timeFrameSlowMa>timeFrameFastMa){
   double sellticket=OrderSend(Symbol(),OP_SELL,lotSize,Bid,3,Bid+(movingAverageStopLoss*pips),Bid-movingAverageTakeProfit*pips,NULL,0,0,Red);}
   
  
   
   
   
   
   
   
   
   }
   }
  
//+------------------------------------------------------------------+
