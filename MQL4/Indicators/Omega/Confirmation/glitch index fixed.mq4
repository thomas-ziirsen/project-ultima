//+------------------------------------------------------------------+
//|                                           glitch index fixed.mq4 |
//|                                             nielsindicatorcoding |
//|                                   nielsindicatorcoding@gmail.com |
//+------------------------------------------------------------------+
#property copyright "nielsindicatorcoding"
#property link      "mailto:nielsindicatorcoding@gmail.com"
#property version   "1.00"
#property description "Glitch index fixed"
#property description "Fixed original glitch index by mladen which didn't"
#property description "show correct values for for example btc and gold"

#property indicator_separate_window
#property indicator_buffers    7
#property indicator_color1     clrLimeGreen
#property indicator_color2     clrGreen
#property indicator_color3     clrFireBrick
#property indicator_color4     clrRed
#property indicator_color5     clrDimGray
#property indicator_color6     clrDimGray
#property indicator_width1     2
#property indicator_width2     2
#property indicator_width3     2
#property indicator_width4     2
#property indicator_width5     1
#property indicator_levelcolor clrDimGray
#property strict

//
//
//
//
//

enum enPrices
  {
   pr_close,      // Close
   pr_open,       // Open
   pr_high,       // High
   pr_low,        // Low
   pr_median,     // Median
   pr_typical,    // Typical
   pr_weighted,   // Weighted
   pr_average,    // Average (high+low+open+close)/4
   pr_medianb,    // Average median body (open+close)/2
   pr_tbiased,    // Trend biased price
   pr_tbiased2,   // Trend biased (extreme) price
   pr_haclose,    // Heiken ashi close
   pr_haopen,     // Heiken ashi open
   pr_hahigh,     // Heiken ashi high
   pr_halow,      // Heiken ashi low
   pr_hamedian,   // Heiken ashi median
   pr_hatypical,  // Heiken ashi typical
   pr_haweighted, // Heiken ashi weighted
   pr_haaverage,  // Heiken ashi average
   pr_hamedianb,  // Heiken ashi median body
   pr_hatbiased,  // Heiken ashi trend biased price
   pr_hatbiased2, // Heiken ashi trend biased (extreme) price
   pr_habclose,   // Heiken ashi (better formula) close
   pr_habopen,    // Heiken ashi (better formula) open
   pr_habhigh,    // Heiken ashi (better formula) high
   pr_hablow,     // Heiken ashi (better formula) low
   pr_habmedian,  // Heiken ashi (better formula) median
   pr_habtypical, // Heiken ashi (better formula) typical
   pr_habweighted,// Heiken ashi (better formula) weighted
   pr_habaverage, // Heiken ashi (better formula) average
   pr_habmedianb, // Heiken ashi (better formula) median body
   pr_habtbiased, // Heiken ashi (better formula) trend biased price
   pr_habtbiased2 // Heiken ashi (better formula) trend biased (extreme) price
  };
enum enMaTypes
  {
   ma_sma,     // Simple moving average
   ma_ema,     // Exponential moving average
   ma_smma,    // Smoothed MA
   ma_lwma,    // Linear weighted MA
   ma_slwma,   // Smoothed LWMA
   ma_dsema,   // Double Smoothed Exponential average
   ma_tema,    // Triple exponential moving average - TEMA
   ma_lsma,    // Linear regression value (lsma)
   ma_nlma     // Non Lag moving average - NLMA
  };

input int       MaPeriod  = 30;         // Glitch ma period
input enMaTypes MaMethod  = ma_sma;     // Glitch moving average method
input enPrices  Price     = pr_median;  // Price to use
input double    level1    = 1.0;        // Glitch inner level
input double    level2    = 1.0;        // Glitch outer level

double gliUa[],gliUb[],gliDa[],gliDb[],gliNe[],gli[],state[];

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   IndicatorDigits(2);
   IndicatorBuffers(7);
   SetIndexBuffer(0,gliUa);
   SetIndexStyle(0,DRAW_HISTOGRAM);
   SetIndexBuffer(1,gliUb);
   SetIndexStyle(1,DRAW_HISTOGRAM);
   SetIndexBuffer(2,gliDb);
   SetIndexStyle(2,DRAW_HISTOGRAM);
   SetIndexBuffer(3,gliDa);
   SetIndexStyle(3,DRAW_HISTOGRAM);
   SetIndexBuffer(4,gliNe);
   //SetIndexStyle(4,DRAW_HISTOGRAM);
   SetIndexBuffer(5,gli);
   SetIndexStyle(5,DRAW_LINE);
   SetIndexBuffer(6,state);
   SetLevelValue(0,0);
   SetLevelValue(1, level1);
   SetLevelValue(2, level2);
   SetLevelValue(3,-level1);
   SetLevelValue(4,-level2);

   IndicatorShortName(getAverageName(MaMethod)+" Glitch Index Fixed");
   return(INIT_SUCCEEDED);
  }
void OnDeinit(const int reason) {  }

//+------------------------------------------------------------------+
//| Awesome Oscillator                                               |
//+------------------------------------------------------------------+
//
//

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnCalculate(const int       rates_total,
                const int       prev_calculated,
                const datetime& time[],
                const double&   open[],
                const double&   high[],
                const double&   low[],
                const double&   close[],
                const long&     tick_volume[],
                const long&     volume[],
                const int&      spread[])

  {
   int i,counted_bars=prev_calculated;
   if(counted_bars<0)
      return(-1);
   if(counted_bars>0)
      counted_bars--;
   int limit = fmin(rates_total-counted_bars,rates_total-1);
//
//
//
//
//

   for(i=Bars-50; i>=0; i--)
     {
      double price = getPrice(Price,open,close,high,low,i,rates_total);
      double ma = iCustomMa(MaMethod,price,MaPeriod,i,rates_total);

      gli[i]   = (close[i]-ma)/iATR(_Symbol,0,50,i);
      gliUa[i] = EMPTY_VALUE;
      gliUb[i] = EMPTY_VALUE;
      gliDb[i] = EMPTY_VALUE;
      gliDa[i] = EMPTY_VALUE;
      gliNe[i] = EMPTY_VALUE;
      //if (i<(rates_total-1)) state[i] = state[i+1];

      if(gli[i]>level2)
        {
         gliUa[i] = gli[i];
         state[i] =  2;

        }
      else
         if(gli[i]>level1)
           {
            gliUb[i] = gli[i];
            state[i] =  1;

           }
         else
            if(gli[i]<-level2)
              {
               gliDa[i] = gli[i];
               state[i] = -2;
              }
            else
               if(gli[i]<-level1)
                 {
                  gliDb[i] = gli[i];
                  state[i] = -1;
                 }
               else
                 {
                  gliNe[i] = gli[i];
                  state[i] =  0;
                 }
     }
   return(rates_total);
  }

//------------------------------------------------------------------
//
//------------------------------------------------------------------
//
//
//
//
//

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string getAverageName(int method)
  {
   switch(method)
     {
      case ma_dsema:
         return("DSEMA");
      case ma_ema:
         return("EMA");
      case ma_lsma:
         return("LSMA");
      case ma_lwma:
         return("LWMA");
      case ma_slwma:
         return("SLWMA");
      case ma_nlma:
         return("NLMA");
      case ma_tema:
         return("TEMA");
      case ma_sma:
         return("SMA");
      case ma_smma:
         return("SMMA");
     }
   return("");
  }

//------------------------------------------------------------------
//
//------------------------------------------------------------------
//
//
//
//
//

#define _maInstances 1
#define _maWorkBufferx1 1*_maInstances
#define _maWorkBufferx2 2*_maInstances
#define _maWorkBufferx3 3*_maInstances

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double iCustomMa(int mode, double price, double length, int r, int bars, int instanceNo=0)
  {
   r = bars-r-1;
   switch(mode)
     {
      case ma_sma   :
         return(iSma(price,(int)ceil(length),r,bars,instanceNo));
      case ma_ema   :
         return(iEma(price,length,r,bars,instanceNo));
      case ma_smma  :
         return(iSmma(price,(int)ceil(length),r,bars,instanceNo));
      case ma_lwma  :
         return(iLwma(price,(int)ceil(length),r,bars,instanceNo));
      case ma_slwma :
         return(iSlwma(price,(int)ceil(length),r,bars,instanceNo));
      case ma_dsema :
         return(iDsema(price,length,r,bars,instanceNo));
      case ma_tema  :
         return(iTema(price,(int)ceil(length),r,bars,instanceNo));
      case ma_lsma  :
         return(iLinr(price,(int)ceil(length),r,bars,instanceNo));
      case ma_nlma  :
         return(iNonLagMa(price,length,r,bars,instanceNo));
      default       :
         return(price);
     }
  }

//
//
//
//
//

double workSma[][_maWorkBufferx1];
double iSma(double price, int period, int r, int _bars, int instanceNo=0)
  {
   if(ArrayRange(workSma,0)!= _bars)
      ArrayResize(workSma,_bars);

   workSma[r][instanceNo+0] = price;
   double avg = price;
   int k=1;
   for(; k<period && (r-k)>=0; k++)
      avg += workSma[r-k][instanceNo+0];
   return(avg/(double)k);
  }

//
//
//
//
//

double workEma[][_maWorkBufferx1];
double iEma(double price, double period, int r, int _bars, int instanceNo=0)
  {
   if(ArrayRange(workEma,0)!= _bars)
      ArrayResize(workEma,_bars);

   workEma[r][instanceNo] = price;
   if(r>0 && period>1)
      workEma[r][instanceNo] = workEma[r-1][instanceNo]+(2.0/(1.0+period))*(price-workEma[r-1][instanceNo]);
   return(workEma[r][instanceNo]);
  }

//
//
//
//
//

double workSmma[][_maWorkBufferx1];
double iSmma(double price, double period, int r, int _bars, int instanceNo=0)
  {
   if(ArrayRange(workSmma,0)!= _bars)
      ArrayResize(workSmma,_bars);

   workSmma[r][instanceNo] = price;
   if(r>1 && period>1)
      workSmma[r][instanceNo] = workSmma[r-1][instanceNo]+(price-workSmma[r-1][instanceNo])/period;
   return(workSmma[r][instanceNo]);
  }

//
//
//
//
//

double workLwma[][_maWorkBufferx1];
double iLwma(double price, double period, int r, int _bars, int instanceNo=0)
  {
   if(ArrayRange(workLwma,0)!= _bars)
      ArrayResize(workLwma,_bars);

   workLwma[r][instanceNo] = price;
   if(period<=1)
      return(price);
   double sumw = period;
   double sum  = period*price;

   for(int k=1; k<period && (r-k)>=0; k++)
     {
      double weight = period-k;
      sumw  += weight;
      sum   += weight*workLwma[r-k][instanceNo];
     }
   return(sum/sumw);
  }

//
//
//
//
//


double workSlwma[][_maWorkBufferx2];
double iSlwma(double price, double period, int r, int _bars, int instanceNo=0)
  {
   if(ArrayRange(workSlwma,0)!= _bars)
      ArrayResize(workSlwma,_bars);

//
//
//
//
//

   int SqrtPeriod = (int)MathFloor(MathSqrt(period));
   instanceNo *= 2;
   workSlwma[r][instanceNo] = price;

//
//
//
//
//

   double sumw = period;
   double sum  = period*price;

   for(int k=1; k<period && (r-k)>=0; k++)
     {
      double weight = period-k;
      sumw  += weight;
      sum   += weight*workSlwma[r-k][instanceNo];
     }
   workSlwma[r][instanceNo+1] = (sum/sumw);

//
//
//
//
//

   sumw = SqrtPeriod;
   sum  = SqrtPeriod*workSlwma[r][instanceNo+1];
   for(int k=1; k<SqrtPeriod && (r-k)>=0; k++)
     {
      double weight = SqrtPeriod-k;
      sumw += weight;
      sum  += weight*workSlwma[r-k][instanceNo+1];
     }
   return(sum/sumw);
  }

//
//
//
//
//

double workDsema[][_maWorkBufferx2];
#define _ema1 0
#define _ema2 1

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double iDsema(double price, double period, int r, int _bars, int instanceNo=0)
  {
   if(ArrayRange(workDsema,0)!= _bars)
      ArrayResize(workDsema,_bars);
   instanceNo*=2;

//
//
//
//
//

   workDsema[r][_ema1+instanceNo] = price;
   workDsema[r][_ema2+instanceNo] = price;
   if(r>0 && period>1)
     {
      double alpha = 2.0 /(1.0+MathSqrt(period));
      workDsema[r][_ema1+instanceNo] = workDsema[r-1][_ema1+instanceNo]+alpha*(price                         -workDsema[r-1][_ema1+instanceNo]);
      workDsema[r][_ema2+instanceNo] = workDsema[r-1][_ema2+instanceNo]+alpha*(workDsema[r][_ema1+instanceNo]-workDsema[r-1][_ema2+instanceNo]);
     }
   return(workDsema[r][_ema2+instanceNo]);
  }

//
//
//
//
//

double workTema[][_maWorkBufferx3];
#define _tema1 0
#define _tema2 1
#define _tema3 2

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double iTema(double price, double period, int r, int bars, int instanceNo=0)
  {
   if(ArrayRange(workTema,0)!= bars)
      ArrayResize(workTema,bars);
   instanceNo*=3;

//
//
//
//
//

   workTema[r][_tema1+instanceNo] = price;
   workTema[r][_tema2+instanceNo] = price;
   workTema[r][_tema3+instanceNo] = price;
   if(r>0 && period>1)
     {
      double alpha = 2.0 / (1.0+period);
      workTema[r][_tema1+instanceNo] = workTema[r-1][_tema1+instanceNo]+alpha*(price                         -workTema[r-1][_tema1+instanceNo]);
      workTema[r][_tema2+instanceNo] = workTema[r-1][_tema2+instanceNo]+alpha*(workTema[r][_tema1+instanceNo]-workTema[r-1][_tema2+instanceNo]);
      workTema[r][_tema3+instanceNo] = workTema[r-1][_tema3+instanceNo]+alpha*(workTema[r][_tema2+instanceNo]-workTema[r-1][_tema3+instanceNo]);
     }
   return(workTema[r][_tema3+instanceNo]+3.0*(workTema[r][_tema1+instanceNo]-workTema[r][_tema2+instanceNo]));
  }

//
//
//
//
//

double workLinr[][_maWorkBufferx1];
double iLinr(double price, int period, int r, int bars, int instanceNo=0)
  {
   if(ArrayRange(workLinr,0)!= bars)
      ArrayResize(workLinr,bars);

//
//
//
//
//

   period = MathMax(period,1);
   workLinr[r][instanceNo] = price;
   if(r<period)
      return(price);
   double lwmw = period;
   double lwma = lwmw*price;
   double sma  = price;
   for(int k=1; k<period && (r-k)>=0; k++)
     {
      double weight = period-k;
      lwmw  += weight;
      lwma  += weight*workLinr[r-k][instanceNo];
      sma   +=        workLinr[r-k][instanceNo];
     }

   return(3.0*lwma/lwmw-2.0*sma/period);
  }

//
//
//
//
//

#define _length  0
#define _len     1
#define _weight  2

double  nlmvalues[ ][3];
double  nlmprices[ ][_maWorkBufferx1];
double  nlmalphas[ ][_maWorkBufferx1];

//
//
//
//
//

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double iNonLagMa(double price, double length, int r, int bars, int instanceNo=0)
  {
   if(ArrayRange(nlmprices,0) != bars)
      ArrayResize(nlmprices,bars);
   if(ArrayRange(nlmvalues,0) <  instanceNo+1)
      ArrayResize(nlmvalues,instanceNo+1);
   nlmprices[r][instanceNo]=price;
   if(length<5 || r<3)
      return(nlmprices[r][instanceNo]);

//
//
//
//
//

   if(nlmvalues[instanceNo][_length] != length)
     {
      double Cycle = 4.0;
      double Coeff = 3.0*M_PI;
      int    Phase = (int)(length-1);

      nlmvalues[instanceNo][_length] =       length;
      nlmvalues[instanceNo][_len   ] = (int)(length*4) + Phase;
      nlmvalues[instanceNo][_weight] = 0;

      if(ArrayRange(nlmalphas,0) < (int)nlmvalues[instanceNo][_len])
         ArrayResize(nlmalphas,(int)nlmvalues[instanceNo][_len]);
      for(int k=0; k<(int)nlmvalues[instanceNo][_len]; k++)
        {
         double t;
         if(k<=Phase-1)
            t = 1.0 * k/(Phase-1);
         else
            t = 1.0 + (k-Phase+1)*(2.0*Cycle-1.0)/(Cycle*length-1.0);
         double beta = MathCos(M_PI*t);
         double g = 1.0/(Coeff*t+1);
         if(t <= 0.5)
            g = 1;

         nlmalphas[k][instanceNo]        = g * beta;
         nlmvalues[instanceNo][_weight] += nlmalphas[k][instanceNo];
        }
     }

//
//
//
//
//

   if(nlmvalues[instanceNo][_weight]>0)
     {
      double sum = 0;
      for(int k=0; k < (int)nlmvalues[instanceNo][_len] && (r-k)>=0; k++)
         sum += nlmalphas[k][instanceNo]*nlmprices[r-k][instanceNo];
      return(sum / nlmvalues[instanceNo][_weight]);
     }
   else
      return(0);
  }

//------------------------------------------------------------------
//
//------------------------------------------------------------------
//
//
//
//
//

#define _prHABF(_prtype) (_prtype>=pr_habclose && _prtype<=pr_habtbiased2)
#define _priceInstances     1
#define _priceInstancesSize 4
double workHa[][_priceInstances*_priceInstancesSize];
double getPrice(int tprice, const double& open[], const double& close[], const double& high[], const double& low[], int i, int bars, int instanceNo=0)
  {
   if(tprice>=pr_haclose)
     {
      if(ArrayRange(workHa,0)!= Bars)
         ArrayResize(workHa,Bars);
      instanceNo*=_priceInstancesSize;
      int r = bars-i-1;

      //
      //
      //
      //
      //

      double haOpen  = (r>0) ? (workHa[r-1][instanceNo+2] + workHa[r-1][instanceNo+3])/2.0 : (open[i]+close[i])/2;;
      double haClose = (open[i]+high[i]+low[i]+close[i]) / 4.0;
      if(_prHABF(tprice))
         if(high[i]!=low[i])
            haClose = (open[i]+close[i])/2.0+(((close[i]-open[i])/(high[i]-low[i]))*MathAbs((close[i]-open[i])/2.0));
         else
            haClose = (open[i]+close[i])/2.0;
      double haHigh  = fmax(high[i], fmax(haOpen,haClose));
      double haLow   = fmin(low[i], fmin(haOpen,haClose));

      //
      //
      //
      //
      //

      if(haOpen<haClose)
        {
         workHa[r][instanceNo+0] = haLow;
         workHa[r][instanceNo+1] = haHigh;
        }
      else
        {
         workHa[r][instanceNo+0] = haHigh;
         workHa[r][instanceNo+1] = haLow;
        }
      workHa[r][instanceNo+2] = haOpen;
      workHa[r][instanceNo+3] = haClose;
      //
      //
      //
      //
      //

      switch(tprice)
        {
         case pr_haclose:
         case pr_habclose:
            return(haClose);
         case pr_haopen:
         case pr_habopen:
            return(haOpen);
         case pr_hahigh:
         case pr_habhigh:
            return(haHigh);
         case pr_halow:
         case pr_hablow:
            return(haLow);
         case pr_hamedian:
         case pr_habmedian:
            return((haHigh+haLow)/2.0);
         case pr_hamedianb:
         case pr_habmedianb:
            return((haOpen+haClose)/2.0);
         case pr_hatypical:
         case pr_habtypical:
            return((haHigh+haLow+haClose)/3.0);
         case pr_haweighted:
         case pr_habweighted:
            return((haHigh+haLow+haClose+haClose)/4.0);
         case pr_haaverage:
         case pr_habaverage:
            return((haHigh+haLow+haClose+haOpen)/4.0);
         case pr_hatbiased:
         case pr_habtbiased:
            if(haClose>haOpen)
               return((haHigh+haClose)/2.0);
            else
               return((haLow+haClose)/2.0);
         case pr_hatbiased2:
         case pr_habtbiased2:
            if(haClose>haOpen)
               return(haHigh);
            if(haClose<haOpen)
               return(haLow);
            return(haClose);
        }
     }

//
//
//
//
//

   switch(tprice)
     {
      case pr_close:
         return(close[i]);
      case pr_open:
         return(open[i]);
      case pr_high:
         return(high[i]);
      case pr_low:
         return(low[i]);
      case pr_median:
         return((high[i]+low[i])/2.0);
      case pr_medianb:
         return((open[i]+close[i])/2.0);
      case pr_typical:
         return((high[i]+low[i]+close[i])/3.0);
      case pr_weighted:
         return((high[i]+low[i]+close[i]+close[i])/4.0);
      case pr_average:
         return((high[i]+low[i]+close[i]+open[i])/4.0);
      case pr_tbiased:
         if(close[i]>open[i])
            return((high[i]+close[i])/2.0);
         else
            return((low[i]+close[i])/2.0);
      case pr_tbiased2:
         if(close[i]>open[i])
            return(high[i]);
         if(close[i]<open[i])
            return(low[i]);
         return(close[i]);
     }
   return(0);
  }


//+------------------------------------------------------------------+
