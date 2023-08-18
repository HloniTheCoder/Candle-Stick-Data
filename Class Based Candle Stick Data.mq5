//Get Class Data From The PriceDataClass

#include <IncludeTutorial/PriceDataClass.mqh>


//Access Candlestick Methods Using The HPriceData Class

HPriceData MyPriceData;


//Date Time Index Of The Candle Stick Types

datetime bull_maru_index;

datetime bull_hammer_index;

datetime bull_inv_hammer_index;

datetime bear_maru_index;

datetime bear_hang_man_index;

datetime bear_shoot_star_idex;


int OnInit()
  {
//---
   
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
//---

   //Add Price Data To The Array.
   //This Method Uses The CopyBuffer Function.

   MyPriceData.Add_Price_Data();
   
   
   int candle_index = 1; //Candle we want to use
   
   int avr_range = 7; //Average Candle Range. To Determine Long and Short Candles
   
   
   //Identify Candlestick Pattern Types.
   
   //Bullish Marubozu (Long Body)
   //Bullish Hammer (Long Lower Wick)
   //Bullish Inverted Hammer (Long Upper Wick)
   
   //Bearish Marubozu (Long Body)
   //Bearish Hanging Man (Long Lower Wick)
   //Bearish Shooting Star (Long Upper Wick)
   
   bool is_bull_maru = MyPriceData.Get_Long_Bullish_Marubozu_Type(candle_index, avr_range);
   
   bool is_hammer = MyPriceData.Get_Long_Hammer_Type(candle_index, avr_range);
   
   bool is_inv_hammer = MyPriceData.Get_Long_Inverted_Hammer_Type(candle_index, avr_range);
   
   bool is_bear_maru = MyPriceData.Get_Long_Bearish_Marubozu_Type(candle_index, avr_range);
   
   bool is_hang = MyPriceData.Get_Long_Hanging_Man_Type(candle_index, avr_range);
   
   bool is_star = MyPriceData.Get_Long_Shooting_Star_Type(candle_index, avr_range);
   
   
   //Add Candle Type Index
   
   datetime curr_Time = MyPriceData.Get_DateTime_Value(candle_index);
   
   if(is_bull_maru)
     {
      
      bull_maru_index = curr_Time;
      
     }
   
   if(is_hammer)
     {
      
      bull_hammer_index = curr_Time;
      
     }
   
   if(is_inv_hammer)
     {
      
      bull_inv_hammer_index = curr_Time;
      
     }
   
   if(is_bear_maru)
     {
      
      bear_maru_index = curr_Time;
      
     }
   
   if(is_hang)
     {
      
      bear_hang_man_index = curr_Time;
      
     }
   
   if(is_star)
     {
      
      bear_shoot_star_idex = curr_Time;
      
     }
   
   //Output The Index Of The Candle Pattern Type As A Vertical Line
   
   ObjectCreate(0, "Bullish Marubozu Index", OBJ_VLINE, 0, bull_maru_index, 0,0);
   
   ObjectSetInteger(0, "Bullish Marubozu Index", OBJPROP_COLOR, clrRed);
   
   
   ObjectCreate(0, "Bearish Marubozu Index", OBJ_VLINE, 0, bear_maru_index, 0,0);
   
   ObjectSetInteger(0, "Bearish Marubozu Index", OBJPROP_COLOR, clrYellow);
   
   
   ObjectCreate(0, "Hammer Index", OBJ_VLINE, 0, bull_hammer_index, 0,0);
   
   ObjectSetInteger(0, "Hammer Index", OBJPROP_COLOR, clrBlue);
   
   
   ObjectCreate(0, "Inverted Hammer Index", OBJ_VLINE, 0, bull_inv_hammer_index, 0,0);
   
   ObjectSetInteger(0, "Inverted Hammer Index", OBJPROP_COLOR, clrGreen);
   
   
   ObjectCreate(0, "Hanging Man Index", OBJ_VLINE, 0, bear_hang_man_index, 0,0);
   
   ObjectSetInteger(0, "Hanging Man Index", OBJPROP_COLOR, clrOrange);
   
   
   ObjectCreate(0, "Shooting Star Index", OBJ_VLINE, 0, bear_shoot_star_idex, 0,0);
   
   ObjectSetInteger(0, "Shooting Star Index", OBJPROP_COLOR, clrPurple);
   
   
   Comment("Bullish Marubozu Colour: Red \n",
           "Bullish Hammer Colour: Blue \n",
           "Bullish Inverted Hammer Colour: Green \n",
           "-------------------------------\n",
           "Bearish Marubozu Colour: Yellow \n",
           "Beariish Hanging Man Colour: Orange \n",
           "Bearish Shooting Star Colour: Purple \n");
   
  }
//+------------------------------------------------------------------+
