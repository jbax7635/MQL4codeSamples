//+------------------------------------------------------------------+
//|                                                    PIDTrader.mq4 |
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
int ThisBarTrade           =  0;
double pips=0;

extern int timeFrame=0;
extern double tradeVolume=0;
string tradeStartTime="22:00:00";
string timeNow = "";
double startingPrice =0;
bool running = false;

//extern double gainGain = 0;
extern double maxLotSize = 0;
extern double targetPips = 0;
extern double proportionID=0;

//P logic variables
double orderGain = 0;

//I logic variables
double volume = 0;
 double iProportionality=proportionID;
 extern double iGain = 0;//increases the power of the integral term so in proportion to slope.


//D logic variables
extern double dAverage =0;//how many periods the slope is taked across
double slope=0;
double  dProportionality=1-proportionID;



int OnInit()
  {
  double tickSize =MarketInfo(Symbol(),MODE_TICKSIZE);
   if(tickSize==.00001||tickSize==.001)
    pips= tickSize*10;
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
   
   
   if(running==false){
   timeNow="";
 timeNow =  TimeToStr(Time[0], TIME_SECONDS);
 Print(timeNow);
 
 
 }
 int timeCompare = StringCompare(timeNow,tradeStartTime,false);   
 Print(timeCompare);
   if(timeCompare==0){
  
    timeCompare = 1;
    
   running = true;
   startingPrice= start();
  
   }
   if((iClose(NULL,timeFrame,0)> (startingPrice+targetPips*pips))||(iClose(NULL,timeFrame,0)< (startingPrice-targetPips*pips)))
   {running = false;}
   if(running==true){
  getOrderGain();
  getVolume();
  getSlope();
  order();
   }
  
   
  }}

double start()
{
double price = iClose(NULL,timeFrame,0);
return price;}

void getOrderGain(){
double move = (startingPrice-iClose(NULL,timeFrame,0))*-1;
orderGain = (move/(targetPips*pips))*maxLotSize;


}
void getVolume(){
volume=volume+ iClose(NULL,timeFrame,0)-startingPrice;

}
void getSlope(){
slope=(iClose(NULL,timeFrame,0)-iClose(NULL,timeFrame,dAverage))/dAverage;

}
void order(){
double order = orderGain*((iGain*volume)+slope);

if(order>0){
double buyticket=OrderSend(Symbol(),OP_BUY,order,Ask,3,Ask-(targetPips*pips),Ask+(targetPips*pips),NULL,0,0,Green);

}
if(order<0){
 double sellticket=OrderSend(Symbol(),OP_SELL,order,Bid,3,Bid+(targetPips*pips),Bid-(targetPips*pips),NULL,0,0,Red);
   
}

}