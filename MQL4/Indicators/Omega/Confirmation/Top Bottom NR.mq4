//+------------------------------------------------------------------+
//|                                                Top Bottom NR.mq4 |
//|                                             nielsindicatorcoding |
//|                                   nielsindicatorcoding@gmail.com |
//+------------------------------------------------------------------+
#property copyright "nielsindicatorcoding"
#property link      "mailto:nielsindicatorcoding@gmail.com"
#property version   "1.00"
#property description "Top Bottom NR"
#property description "Based on the tradingview top bottom indicator"

#property strict
#property indicator_separate_window
#property indicator_buffers 2
#property indicator_type1 DRAW_LINE
#property indicator_color1 Aqua
#property indicator_style1 STYLE_SOLID
#property indicator_width1 5
#property indicator_type2 DRAW_LINE
#property indicator_color2 Magenta
#property indicator_style2 STYLE_SOLID
#property indicator_width2 5

input int per = 14; // Bottom Period


double long_signal[];
double short_signal[];
int init()
  {
   IndicatorBuffers(2);
   SetIndexBuffer(0, long_signal);
   SetIndexBuffer(1, short_signal);
   return INIT_SUCCEEDED;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {

   ArrayInitialize(long_signal,0);
   ArrayInitialize(short_signal,0);
   int i;

   for(i=Bars-2-per; i>=0; i--)
     {
      if(low[i] < low[iLowest(NULL,0,MODE_LOW,per,i+1)])
        {
         long_signal[i] = 0;
        }
      else
        {
         long_signal[i] = long_signal[i+1]+1;
        }
      if(high[i] > high[iHighest(NULL,0,MODE_HIGH,per,i+1)])
        {
         short_signal[i] = 0;
        }
      else
        {
         short_signal[i] = short_signal[i+1]+1;
        }
     }
     return rates_total;
  }
