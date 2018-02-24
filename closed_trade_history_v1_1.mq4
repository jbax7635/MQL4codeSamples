//+------------------------------------------------------------------+
//|                                    Closed_Trade_History_v1_1.mq4 |
//|                                          Copyright © 2009, Wolfe |
//|                                              xxxxwolfe@gmail.com |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2009, Wolfe"
#property link      "xxxxwolfe@gmail.com"

extern string Pair_A = "USDCHF";
extern string Pair_B = "GBPJPY";
extern string Pair_C = "EURUSD";
extern string Pair_D = "USDJPY";
extern string Pair_E = "AUDUSD";
extern string Pair_F = "USDCAD";
extern string Pair_G = "EURGBP";
extern string Pair_H = "EURCHF";
extern string Pair_I = "EURJPY";
extern string Pair_J = "GBPJPY";
extern color  EA_Name_Color = Blue;
extern color  Label_Color  = Red;
extern color  Number_Color = White;
extern color  Pairs_Color  = Lime;
extern color  Totals_Color = DeepPink;

//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
  
   ObjectsDeleteAll(0);
   
   Comment("\nCLOSED TRADE HISTORY Initialized,",
           "\n",
           "\nWaiting For Next Tick...");
  
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
  
   ObjectsDeleteAll(0);

   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
  
  Comment("\n");
  
  int Closed_Order_Total = OrdersHistoryTotal();
 
  int Pos=0;
  
  double OT_Pair_A=0;
  double OT_Pair_B=0;
  double OT_Pair_C=0;
  double OT_Pair_D=0;
  double OT_Pair_E=0;
  double OT_Pair_F=0;
  double OT_Pair_G=0;
  double OT_Pair_H=0;
  double OT_Pair_I=0;
  double OT_Pair_J=0;
  
  double OP_Pair_A=0;
  double OP_Pair_B=0;
  double OP_Pair_C=0;
  double OP_Pair_D=0;
  double OP_Pair_E=0;
  double OP_Pair_F=0;
  double OP_Pair_G=0;
  double OP_Pair_H=0;
  double OP_Pair_I=0;
  double OP_Pair_J=0;
  
  double OW_Pair_A=0;
  double OW_Pair_B=0;
  double OW_Pair_C=0;
  double OW_Pair_D=0;
  double OW_Pair_E=0;
  double OW_Pair_F=0;
  double OW_Pair_G=0;
  double OW_Pair_H=0;
  double OW_Pair_I=0;
  double OW_Pair_J=0;
  
  double WT_Pair_A=0;
  double WT_Pair_B=0;
  double WT_Pair_C=0;
  double WT_Pair_D=0;
  double WT_Pair_E=0;
  double WT_Pair_F=0;
  double WT_Pair_G=0;
  double WT_Pair_H=0;
  double WT_Pair_I=0;
  double WT_Pair_J=0;
  
  double OL_Pair_A=0;
  double OL_Pair_B=0;
  double OL_Pair_C=0;
  double OL_Pair_D=0;
  double OL_Pair_E=0;
  double OL_Pair_F=0;
  double OL_Pair_G=0;
  double OL_Pair_H=0;
  double OL_Pair_I=0;
  double OL_Pair_J=0;
  
  double LT_Pair_A=0;
  double LT_Pair_B=0;
  double LT_Pair_C=0;
  double LT_Pair_D=0;
  double LT_Pair_E=0;
  double LT_Pair_F=0;
  double LT_Pair_G=0;
  double LT_Pair_H=0;
  double LT_Pair_I=0;
  double LT_Pair_J=0;
  
  double Total_Closed=0;
  double Total_Profit=0;
  double Total_Wins=0;
  double Total_Win_Profit=0;
  double Total_Losses=0;
  double Total_Loss_Profit=0;
  
  while (Closed_Order_Total > Pos)
   {
    if (OrderSelect(Pos,SELECT_BY_POS,MODE_HISTORY))
     {
      string OS = OrderSymbol();
      double OP = OrderProfit();
      if(OP >= 0)
       
      
      Print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ",GetLastError());
      
      if (OS == Pair_A) {OT_Pair_A++; OP_Pair_A = OP_Pair_A+OP; if(OP>=0){OW_Pair_A++; WT_Pair_A = WT_Pair_A+OP;} if(OP<0){OL_Pair_A++; LT_Pair_A = LT_Pair_A+OP;}}
      if (OS == Pair_B) {OT_Pair_B++; OP_Pair_B = OP_Pair_B+OP; if(OP>=0){OW_Pair_B++; WT_Pair_B = WT_Pair_B+OP;} if(OP<0){OL_Pair_B++; LT_Pair_B = LT_Pair_B+OP;}}
      if (OS == Pair_C) {OT_Pair_C++; OP_Pair_C = OP_Pair_C+OP; if(OP>=0){OW_Pair_C++; WT_Pair_C = WT_Pair_C+OP;} if(OP<0){OL_Pair_C++; LT_Pair_C = LT_Pair_C+OP;}}
      if (OS == Pair_D) {OT_Pair_D++; OP_Pair_D = OP_Pair_D+OP; if(OP>=0){OW_Pair_D++; WT_Pair_D = WT_Pair_D+OP;} if(OP<0){OL_Pair_D++; LT_Pair_D = LT_Pair_D+OP;}}
      if (OS == Pair_E) {OT_Pair_E++; OP_Pair_E = OP_Pair_E+OP; if(OP>=0){OW_Pair_E++; WT_Pair_E = WT_Pair_E+OP;} if(OP<0){OL_Pair_E++; LT_Pair_E = LT_Pair_E+OP;}}
      if (OS == Pair_F) {OT_Pair_F++; OP_Pair_F = OP_Pair_F+OP; if(OP>=0){OW_Pair_F++; WT_Pair_F = WT_Pair_F+OP;} if(OP<0){OL_Pair_F++; LT_Pair_F = LT_Pair_F+OP;}}
      if (OS == Pair_G) {OT_Pair_G++; OP_Pair_G = OP_Pair_G+OP; if(OP>=0){OW_Pair_G++; WT_Pair_G = WT_Pair_G+OP;} if(OP<0){OL_Pair_G++; LT_Pair_G = LT_Pair_G+OP;}}
      if (OS == Pair_H) {OT_Pair_H++; OP_Pair_H = OP_Pair_H+OP; if(OP>=0){OW_Pair_H++; WT_Pair_H = WT_Pair_H+OP;} if(OP<0){OL_Pair_H++; LT_Pair_H = LT_Pair_H+OP;}}
      if (OS == Pair_I) {OT_Pair_I++; OP_Pair_I = OP_Pair_I+OP; if(OP>=0){OW_Pair_I++; WT_Pair_I = WT_Pair_I+OP;} if(OP<0){OL_Pair_I++; LT_Pair_I = LT_Pair_I+OP;}}
      if (OS == Pair_J) {OT_Pair_J++; OP_Pair_J = OP_Pair_J+OP; if(OP>=0){OW_Pair_J++; WT_Pair_J = WT_Pair_J+OP;} if(OP<0){OL_Pair_J++; LT_Pair_J = LT_Pair_J+OP;}}
      
      
     }
    Pos++;
    
    string sOT_Pair_A = DoubleToStr(OT_Pair_A,0);
    string sOT_Pair_B = DoubleToStr(OT_Pair_B,0);
    string sOT_Pair_C = DoubleToStr(OT_Pair_C,0);
    string sOT_Pair_D = DoubleToStr(OT_Pair_D,0);
    string sOT_Pair_E = DoubleToStr(OT_Pair_E,0);
    string sOT_Pair_F = DoubleToStr(OT_Pair_F,0);
    string sOT_Pair_G = DoubleToStr(OT_Pair_G,0);
    string sOT_Pair_H = DoubleToStr(OT_Pair_H,0);
    string sOT_Pair_I = DoubleToStr(OT_Pair_I,0);
    string sOT_Pair_J = DoubleToStr(OT_Pair_J,0);
    
    string sOP_Pair_A = DoubleToStr(OP_Pair_A,2);
    string sOP_Pair_B = DoubleToStr(OP_Pair_B,2);
    string sOP_Pair_C = DoubleToStr(OP_Pair_C,2);
    string sOP_Pair_D = DoubleToStr(OP_Pair_D,2);
    string sOP_Pair_E = DoubleToStr(OP_Pair_E,2);
    string sOP_Pair_F = DoubleToStr(OP_Pair_F,2);
    string sOP_Pair_G = DoubleToStr(OP_Pair_G,2);
    string sOP_Pair_H = DoubleToStr(OP_Pair_H,2);
    string sOP_Pair_I = DoubleToStr(OP_Pair_I,2);
    string sOP_Pair_J = DoubleToStr(OP_Pair_J,2);
    
    string sOW_Pair_A = DoubleToStr(OW_Pair_A,0);
    string sOW_Pair_B = DoubleToStr(OW_Pair_B,0);
    string sOW_Pair_C = DoubleToStr(OW_Pair_C,0);
    string sOW_Pair_D = DoubleToStr(OW_Pair_D,0);
    string sOW_Pair_E = DoubleToStr(OW_Pair_E,0);
    string sOW_Pair_F = DoubleToStr(OW_Pair_F,0);
    string sOW_Pair_G = DoubleToStr(OW_Pair_G,0);
    string sOW_Pair_H = DoubleToStr(OW_Pair_H,0);
    string sOW_Pair_I = DoubleToStr(OW_Pair_I,0);
    string sOW_Pair_J = DoubleToStr(OW_Pair_J,0);
    
    string sWT_Pair_A = DoubleToStr(WT_Pair_A,2);
    string sWT_Pair_B = DoubleToStr(WT_Pair_B,2);
    string sWT_Pair_C = DoubleToStr(WT_Pair_C,2);
    string sWT_Pair_D = DoubleToStr(WT_Pair_D,2);
    string sWT_Pair_E = DoubleToStr(WT_Pair_E,2);
    string sWT_Pair_F = DoubleToStr(WT_Pair_F,2);
    string sWT_Pair_G = DoubleToStr(WT_Pair_G,2);
    string sWT_Pair_H = DoubleToStr(WT_Pair_H,2);
    string sWT_Pair_I = DoubleToStr(WT_Pair_I,2);
    string sWT_Pair_J = DoubleToStr(WT_Pair_J,2);
    
    string sOL_Pair_A = DoubleToStr(OL_Pair_A,0);
    string sOL_Pair_B = DoubleToStr(OL_Pair_B,0);
    string sOL_Pair_C = DoubleToStr(OL_Pair_C,0);
    string sOL_Pair_D = DoubleToStr(OL_Pair_D,0);
    string sOL_Pair_E = DoubleToStr(OL_Pair_E,0);
    string sOL_Pair_F = DoubleToStr(OL_Pair_F,0);
    string sOL_Pair_G = DoubleToStr(OL_Pair_G,0);
    string sOL_Pair_H = DoubleToStr(OL_Pair_H,0);
    string sOL_Pair_I = DoubleToStr(OL_Pair_I,0);
    string sOL_Pair_J = DoubleToStr(OL_Pair_J,0);
    
    string sLT_Pair_A = DoubleToStr(LT_Pair_A,2);
    string sLT_Pair_B = DoubleToStr(LT_Pair_B,2);
    string sLT_Pair_C = DoubleToStr(LT_Pair_C,2);
    string sLT_Pair_D = DoubleToStr(LT_Pair_D,2);
    string sLT_Pair_E = DoubleToStr(LT_Pair_E,2);
    string sLT_Pair_F = DoubleToStr(LT_Pair_F,2);
    string sLT_Pair_G = DoubleToStr(LT_Pair_G,2);
    string sLT_Pair_H = DoubleToStr(LT_Pair_H,2);
    string sLT_Pair_I = DoubleToStr(LT_Pair_I,2);
    string sLT_Pair_J = DoubleToStr(LT_Pair_J,2);
    
   }
   
   string sTotal_Closed = DoubleToStr((OT_Pair_A+OT_Pair_B+OT_Pair_C+OT_Pair_D+OT_Pair_E+
                                       OT_Pair_F+OT_Pair_G+OT_Pair_H+OT_Pair_I+OT_Pair_J),0);
   
   string sTotal_Profit = DoubleToStr((OP_Pair_A+OP_Pair_B+OP_Pair_C+OP_Pair_D+OP_Pair_E+
                                       OP_Pair_F+OP_Pair_G+OP_Pair_H+OP_Pair_I+OP_Pair_J),2);
   
   string sTotal_Wins = DoubleToStr((OW_Pair_A+OW_Pair_B+OW_Pair_C+OW_Pair_D+OW_Pair_E+
                                     OW_Pair_F+OW_Pair_G+OW_Pair_H+OW_Pair_I+OW_Pair_J),0);
   
   string sTotal_Win_Profit = DoubleToStr((WT_Pair_A+WT_Pair_B+WT_Pair_C+WT_Pair_D+WT_Pair_E+
                                           WT_Pair_F+WT_Pair_G+WT_Pair_H+WT_Pair_I+WT_Pair_J),2);
   
   string sTotal_Losses = DoubleToStr((OL_Pair_A+OL_Pair_B+OL_Pair_C+OL_Pair_D+OL_Pair_E+
                                       OL_Pair_F+OL_Pair_G+OL_Pair_H+OL_Pair_I+OL_Pair_J),0);
   
   string sTotal_Loss_Profit = DoubleToStr((LT_Pair_A+LT_Pair_B+LT_Pair_C+LT_Pair_D+LT_Pair_E+
                                            LT_Pair_F+LT_Pair_G+LT_Pair_H+LT_Pair_I+LT_Pair_J),2);
   
   SetLabel("1","Closed Trade History",10,20,"Courier",15,EA_Name_Color);
   
   SetLabel("2","SYMBOL",10,50,"Courier",12,Red); 
   SetLabel("3",Pair_A,10,80,"Courier",10,Lime);
   SetLabel("4",Pair_B,10,110,"Courier",10,Lime);
   SetLabel("5",Pair_C,10,140,"Courier",10,Lime);
   SetLabel("6",Pair_D,10,170,"Courier",10,Lime);
   SetLabel("7",Pair_E,10,200,"Courier",10,Lime);
   SetLabel("8",Pair_F,10,230,"Courier",10,Lime);
   SetLabel("9",Pair_G,10,260,"Courier",10,Lime);
   SetLabel("10",Pair_H,10,290,"Courier",10,Lime);
   SetLabel("11",Pair_I,10,320,"Courier",10,Lime);
   SetLabel("12",Pair_J,10,350,"Courier",10,Lime); 
   
   SetLabel("13","CLOSED",100,50,"Courier",12,Label_Color);
   SetLabel("14",sOT_Pair_A,100,80,"Courier",10,Number_Color);
   SetLabel("15",sOT_Pair_B,100,110,"Courier",10,Number_Color);
   SetLabel("16",sOT_Pair_C,100,140,"Courier",10,Number_Color);
   SetLabel("17",sOT_Pair_D,100,170,"Courier",10,Number_Color);
   SetLabel("18",sOT_Pair_E,100,200,"Courier",10,Number_Color);
   SetLabel("19",sOT_Pair_F,100,230,"Courier",10,Number_Color);
   SetLabel("20",sOT_Pair_G,100,260,"Courier",10,Number_Color);
   SetLabel("21",sOT_Pair_H,100,290,"Courier",10,Number_Color);
   SetLabel("22",sOT_Pair_I,100,320,"Courier",10,Number_Color);
   SetLabel("23",sOT_Pair_J,100,350,"Courier",10,Number_Color);
   
   SetLabel("24","PROFIT",200,50,"Courier",12,Label_Color);
   SetLabel("25",sOP_Pair_A,200,80,"Courier",10,Number_Color);
   SetLabel("26",sOP_Pair_B,200,110,"Courier",10,Number_Color);
   SetLabel("27",sOP_Pair_C,200,140,"Courier",10,Number_Color);
   SetLabel("28",sOP_Pair_D,200,170,"Courier",10,Number_Color);
   SetLabel("29",sOP_Pair_E,200,200,"Courier",10,Number_Color);
   SetLabel("30",sOP_Pair_F,200,230,"Courier",10,Number_Color);
   SetLabel("31",sOP_Pair_G,200,260,"Courier",10,Number_Color);
   SetLabel("32",sOP_Pair_H,200,290,"Courier",10,Number_Color);
   SetLabel("33",sOP_Pair_I,200,320,"Courier",10,Number_Color);
   SetLabel("34",sOP_Pair_J,200,350,"Courier",10,Number_Color);
   
   SetLabel("35","WINS",310,50,"Courier",12,Label_Color);
   SetLabel("36",sOW_Pair_A,310,80,"Courier",10,Number_Color);
   SetLabel("37",sOW_Pair_B,310,110,"Courier",10,Number_Color);
   SetLabel("38",sOW_Pair_C,310,140,"Courier",10,Number_Color);
   SetLabel("39",sOW_Pair_D,310,170,"Courier",10,Number_Color);
   SetLabel("40",sOW_Pair_E,310,200,"Courier",10,Number_Color);
   SetLabel("41",sOW_Pair_F,310,230,"Courier",10,Number_Color);
   SetLabel("42",sOW_Pair_G,310,260,"Courier",10,Number_Color);
   SetLabel("43",sOW_Pair_H,310,290,"Courier",10,Number_Color);
   SetLabel("44",sOW_Pair_I,310,320,"Courier",10,Number_Color);
   SetLabel("45",sOW_Pair_J,310,350,"Courier",10,Number_Color);
   
   SetLabel("46","WIN PROFIT",400,50,"Courier",12,Label_Color);
   SetLabel("47",sWT_Pair_A,400,80,"Courier",10,Number_Color);
   SetLabel("48",sWT_Pair_B,400,110,"Courier",10,Number_Color);
   SetLabel("49",sWT_Pair_C,400,140,"Courier",10,Number_Color);
   SetLabel("50",sWT_Pair_D,400,170,"Courier",10,Number_Color);
   SetLabel("51",sWT_Pair_E,400,200,"Courier",10,Number_Color);
   SetLabel("52",sWT_Pair_F,400,230,"Courier",10,Number_Color);
   SetLabel("53",sWT_Pair_G,400,260,"Courier",10,Number_Color);
   SetLabel("54",sWT_Pair_H,400,290,"Courier",10,Number_Color);
   SetLabel("55",sWT_Pair_I,400,320,"Courier",10,Number_Color);
   SetLabel("56",sWT_Pair_J,400,350,"Courier",10,Number_Color);
   
   SetLabel("57","LOSSES",540,50,"Courier",12,Label_Color);
   SetLabel("58",sOL_Pair_A,540,80,"Courier",10,Number_Color);
   SetLabel("59",sOL_Pair_B,540,110,"Courier",10,Number_Color);
   SetLabel("60",sOL_Pair_C,540,140,"Courier",10,Number_Color);
   SetLabel("61",sOL_Pair_D,540,170,"Courier",10,Number_Color);
   SetLabel("62",sOL_Pair_E,540,200,"Courier",10,Number_Color);
   SetLabel("63",sOL_Pair_F,540,230,"Courier",10,Number_Color);
   SetLabel("64",sOL_Pair_G,540,260,"Courier",10,Number_Color);
   SetLabel("65",sOL_Pair_H,540,290,"Courier",10,Number_Color);
   SetLabel("66",sOL_Pair_I,540,320,"Courier",10,Number_Color);
   SetLabel("67",sOL_Pair_J,540,350,"Courier",10,Number_Color);

   SetLabel("68","LOSS PROFIT",650,50,"Courier",12,Label_Color);
   SetLabel("69",sLT_Pair_A,650,80,"Courier",10,Number_Color);
   SetLabel("70",sLT_Pair_B,650,110,"Courier",10,Number_Color);
   SetLabel("71",sLT_Pair_C,650,140,"Courier",10,Number_Color);
   SetLabel("72",sLT_Pair_D,650,170,"Courier",10,Number_Color);
   SetLabel("73",sLT_Pair_E,650,200,"Courier",10,Number_Color);
   SetLabel("74",sLT_Pair_F,650,230,"Courier",10,Number_Color);
   SetLabel("75",sLT_Pair_G,650,260,"Courier",10,Number_Color);
   SetLabel("76",sLT_Pair_H,650,290,"Courier",10,Number_Color);
   SetLabel("77",sLT_Pair_I,650,320,"Courier",10,Number_Color);
   SetLabel("78",sLT_Pair_J,650,350,"Courier",10,Number_Color);
   
   SetLabel("79","TOTAL",10,380,"Courier",12,Totals_Color);
   SetLabel("80",sTotal_Closed,100,380,"Courier",10,Totals_Color);
   SetLabel("81",sTotal_Profit,200,380,"Courier",10,Totals_Color);
   SetLabel("82",sTotal_Wins,310,380,"Courier",10,Totals_Color);
   SetLabel("83",sTotal_Win_Profit,400,380,"Courier",10,Totals_Color);
   SetLabel("84",sTotal_Losses,540,380,"Courier",10,Totals_Color);
   SetLabel("85",sTotal_Loss_Profit,650,380,"Courier",10,Totals_Color);
      
   return(0);
  }
//+------------------------------------------------------------------+



void SetLabel(string Name, string Text, int x, int y, string Font, int Size, color Color)
  {
   if(ObjectFind(Name) == -1)
   ObjectCreate  (Name, OBJ_LABEL, 0, 0, 0);
   ObjectSet     (Name, OBJPROP_XDISTANCE, x);
   ObjectSet     (Name, OBJPROP_YDISTANCE, y);
   ObjectSetText (Name, Text, Size, Font, Color);
  } 