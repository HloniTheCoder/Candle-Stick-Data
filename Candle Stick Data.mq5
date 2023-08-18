
//Determine Whether The Candlestick Data Is Long Or Short

//Candle Data Is Long If It Is Greater Than 1.5 Times The Input

//The inp_val Will Typically Be The Average Value

bool Calculate_Is_Long(double curr_val, double inp_val){
   
   bool is_long = (curr_val >= (inp_val * 1.5));
   
   return(is_long);
   
}


//Calculate The Percentage Value

//Will Be Used To Calculate The Percentage Value Of
//The Body Size, Upper Wick, and Lower Wick Relative To
//The Total Candlestick Size

double Calculate_Percentage_Value(double curr_val, double total_val){
   
   double div_value = curr_val / total_val;
   
   double perc_value = div_value * 100;
   
   return(NormalizeDouble(perc_value, 5));
   
}


//Determine If Candle Data Is Significant

//If The Body, Upper Wick, or Lower Wick Size Is Significant
//It Means It Occupies Most Of The Candle

bool Calculate_Is_Significant(double perc_value){
   
   bool is_sig = (perc_value > 70);
   
   return(is_sig);
   
}


//Determine If The Candle Is Of A Type

//If The Body, Upper Wick, or Lower Wick Is Both
//Long And Significant It Is A Type

bool Return_Is_Candle_Type(bool is_long, bool is_sig){
   
   bool is_type = is_long && is_sig;
   
   return(is_type);
   
}


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
   
   
   
   
   
   //Get Price Data
   
   //Array To Store Price Data
   MqlRates price_data_array[];
   
   //Set The Most Recent Item To Index 0
   ArraySetAsSeries(price_data_array, true);
   
   //Copy Price Data To The Array
   //Starting From 0 To 100 Price Data Items
   CopyRates(_Symbol, _Period, 0, 100, price_data_array);
   
   
   //Calculating Average Body, Upper, and Lower Size
   
   double avg_body_sum_value = 0;
   
   double avg_upper_sum_value = 0;
   
   double avg_lower_sum_value = 0;
   
   int candle_index = 1; //Candle Index You Want To Use
   
   int avg_range = 5; //Length Of Average
   
   for(int i=candle_index;i<=avg_range;i++)
     {
      
      int val_index = i + 1;
      
      double open_value = price_data_array[val_index].open;
      
      double high_value = price_data_array[val_index].high;
      
      double low_value = price_data_array[val_index].low;
      
      double close_value = price_data_array[val_index].close;
      
      double body_size = MathAbs(open_value - close_value);
      
      double upper_size = 0;
      
      double lower_size = 0;
      
      //If The Currently Indexed Candle Is Bullish Or Bearish
      
      if(close_value > open_value)
        {
         
         upper_size = MathAbs(high_value - close_value);
         
         lower_size = MathAbs(open_value - low_value);
         
        }
      
      else
        {
         
         upper_size = MathAbs(high_value - open_value);
         
         lower_size = MathAbs(close_value - low_value);
         
        }
      
      avg_body_sum_value += body_size;
      
      avg_upper_sum_value += upper_size;
      
      avg_lower_sum_value += lower_size;
      
     }
   

   //Average Body, Upper, and Lower Wick Size Values
   
   double avg_body_size = avg_body_sum_value / avg_range;
   
   double avg_upper_size = avg_upper_sum_value / avg_range;
   
   double avg_lower_size = avg_lower_sum_value / avg_range;
   
   
   //Calculating Data For The Current Candle
   
   //Indexed Using The candle_index Value
   
   double curr_close_value = price_data_array[candle_index].close;
   
   double curr_open_value = price_data_array[candle_index].open;
   
   double curr_low_value = price_data_array[candle_index].low;
   
   double curr_high_value = price_data_array[candle_index].high;
   
   
   double curr_body_size = MathAbs(curr_open_value - curr_close_value);
   
   double curr_upper_size = 0;
   
   double curr_lower_size = 0;
   
   

   //Determine Whether The Current Candle Is Bullish Or Bearish
   
   bool curr_candle_is_bullish = curr_close_value > curr_open_value;
   
   bool curr_candle_is_bearish = curr_open_value > curr_close_value;
   
   
   if(curr_candle_is_bullish)
     {
      
      curr_upper_size = MathAbs(curr_high_value - curr_close_value);
      
      curr_lower_size = MathAbs(curr_open_value - curr_low_value);
      
     }
   
   else
     {
      
      curr_upper_size = MathAbs(curr_high_value - curr_open_value);
      
      curr_lower_size = MathAbs(curr_close_value - curr_low_value);
      
     }
   
   

   //Determine If The Body, Upper, Lower Wick Are Long
   
   //A Value Is Long If It Is Greater Than The Average Value Times 1.5
   
   bool body_is_long = Calculate_Is_Long(curr_body_size, avg_body_size);
   
   bool upper_is_long = Calculate_Is_Long(curr_upper_size, avg_upper_size);
   
   bool lower_is_long = Calculate_Is_Long(curr_lower_size, avg_lower_size);
   
   
   double curr_candle_size = MathAbs(curr_high_value - curr_low_value);
   
   
   //Calculating The Body, Upper, Lower Wick Percentage Values
   
   //Determining The Percentage Value Of Candle Data Compared To The Candle Size
   
   double curr_body_perc_value = Calculate_Percentage_Value(curr_body_size, curr_candle_size);
   
   double curr_upper_perc_value = Calculate_Percentage_Value(curr_upper_size, curr_candle_size);
   
   double curr_lower_perc_value = Calculate_Percentage_Value(curr_lower_size, curr_candle_size);
   
   
   //Determine If Candle Data Is Significant
   
   //Body, Upper, Lower Wick Values Are Significant If
   //They Occupy Most Of The Candle Size
   
   bool curr_body_is_significant = Calculate_Is_Significant(curr_body_perc_value);
   
   bool curr_upper_is_significant = Calculate_Is_Significant(curr_upper_perc_value);
   
   bool curr_lower_is_significant = Calculate_Is_Significant(curr_lower_perc_value);
   
   
   //Determine Whether The Body, Upper, Or Lower Wick Are Long Types
   
   //A Long Type Is Both Significant And Long(Greater Than The Average Value)
   
   bool body_is_long_type = Return_Is_Candle_Type(body_is_long, curr_body_is_significant);
   
   bool upper_is_long_type = Return_Is_Candle_Type(upper_is_long, curr_upper_is_significant);
   
   bool lower_is_long_type = Return_Is_Candle_Type(lower_is_long, curr_lower_is_significant);
   
   
   //Determine Marubozu Type Candles
   
   //Is Bullish Marubozu If The Candle Is Bullish And The Body Is A Long Type
   bool is_bull_maru = (curr_candle_is_bullish && body_is_long_type);
   
   //Is Bearish Marubozu If The Candle Is Bearish And The Body Is A Long Type
   bool is_bear_maru = (curr_candle_is_bearish && body_is_long_type);
   
   
   //Determine Hammer And Inverted Hammer Type Candles
   
   //Is Bullish Hammer If The Candle Is Bullish And The Lower Is A Long Type
   bool is_bull_hammer = (curr_candle_is_bullish && lower_is_long_type);
   
   //Is Bullish Inverted Hammer If The Candle Is Bullish And The Upper Is A Long Type
   bool is_bull_inv_hammer = (curr_candle_is_bullish && upper_is_long_type);
   
   
   //Determine Hanging Man And Shooting Star Type Candles
   
   //Is Bearish Hanging Man If The Candle Is Bearish And The Lower Is A Long Type
   bool is_bear_hang_man = (curr_candle_is_bearish && lower_is_long_type);
   
   //Is Bearish Shooting Star If The Candle Is Bearish And The Upper Is A Long Type
   bool is_bear_star = (curr_candle_is_bearish && upper_is_long_type);
   
   
   //Add Candle Type Indexes For Output
   
   if(is_bull_maru)
     {
      
      bull_maru_index = price_data_array[candle_index].time;
      
     }
   
   if(is_bull_hammer)
     {
      
      bull_hammer_index = price_data_array[candle_index].time;
      
     }
   
   if(is_bull_inv_hammer)
     {
      
      bull_inv_hammer_index = price_data_array[candle_index].time;
      
     }
   
   if(is_bear_maru)
     {
      
      bear_maru_index = price_data_array[candle_index].time;
      
     }
   
   if(is_bear_hang_man)
     {
      
      bear_hang_man_index = price_data_array[candle_index].time;
      
     }
   
   if(is_bear_star)
     {
      
      bear_shoot_star_idex = price_data_array[candle_index].time;
      
     }


   //Output Candle Type Data As A Vertical Line
   
   //The Most Recent Candle Of Each Type Will Be Output
   
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
