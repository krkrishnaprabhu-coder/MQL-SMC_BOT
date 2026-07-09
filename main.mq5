//+------------------------------------------------------------------+
//|                     SMC GOLD BOT                                 |
//|                     Main Expert Advisor                          |
//+------------------------------------------------------------------+
#property strict

#include <Trade/Trade.mqh>

//==============================
// Include Files
//==============================
#include <Trade/Trade.mqh>

#include "Utils.mqh"
#include "MarketStructure.mqh"
#include "Liquidity.mqh"
#include "CHOCH.mqh"
#include "BOS.mqh"
#include "OrderBlock.mqh"
#include "FVG.mqh"
#include "Sessions.mqh"
#include "Confirmation.mqh"
#include "RiskManager.mqh"
#include "TradeManager.mqh"
#include "Logger.mqh"
#include "Telegram.mqh"  

//==============================
// Trade Object
//==============================
CTrade trade;

//==============================
// Inputs
//==============================
input double LotSize = 0.01;
input ulong MagicNumber = 123456;

//==============================
// Global Variables
//==============================
bool BuySignal  = false;
bool SellSignal = false;

//+------------------------------------------------------------------+
//| Expert Initialization                                            |
//+------------------------------------------------------------------+
int OnInit()
{
   trade.SetExpertMagicNumber(MagicNumber);

   Print("==================================");
   Print("      SMC GOLD BOT STARTED");
   Print("==================================");

   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert Deinitialization                                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   Print("SMC GOLD BOT Stopped");
}

//+------------------------------------------------------------------+
//| Expert Tick                                                      |
//+------------------------------------------------------------------+
void OnTick()
{

//====================================
// STEP 1
// SESSION FILTER
//====================================

DetectSessions();

if(!CanTradeSession())
   return;


//====================================
// STEP 2
// MARKET STRUCTURE
//====================================

DetectMarketStructure();


//====================================
// STEP 3
// LIQUIDITY
//====================================

DetectLiquidity();


//====================================
// STEP 4
// CHOCH
//====================================

DetectCHOCH();


//====================================
// STEP 5
// BOS
//====================================

DetectBOS();


//====================================
// STEP 6
// ORDER BLOCK
//====================================

DetectOrderBlock();


//====================================
// STEP 7
// FAIR VALUE GAP
//====================================

DetectFVG();


//====================================
// STEP 8
// CONFIRMATION
//====================================

DetectConfirmation();


//====================================
// STEP 9
// RISK MANAGEMENT
//====================================

if(BuyConfirmation)
{
   PrepareBuyTrade();
}

if(SellConfirmation)
{
   PrepareSellTrade();
}


//====================================
// STEP 10
// TRADE EXECUTION
//====================================

ExecuteTrade();


//====================================
// STEP 11
// DEBUG
//====================================

Print("==============================");
Print("London Session : ",LondonSession);
Print("NewYork Session: ",NewYorkSession);

Print("Bullish Sweep : ",BuySideSweep);
Print("Bearish Sweep : ",SellSideSweep);

Print("Bullish CHOCH : ",BullishCHOCH);
Print("Bearish CHOCH : ",BearishCHOCH);

Print("Bullish BOS : ",BullishBOS);
Print("Bearish BOS : ",BearishBOS);

Print("Bullish OB : ",BullishOB);
Print("Bearish OB : ",BearishOB);

Print("Bullish FVG : ",BullishFVG);
Print("Bearish FVG : ",BearishFVG);

Print("Buy Confirmation : ",BuyConfirmation);
Print("Sell Confirmation : ",SellConfirmation);

Print("Entry : ",EntryPrice);
Print("SL : ",StopLoss);
Print("TP : ",TakeProfit);
Print("Lot : ",LotSize);

}
void OnDeinit(const int reason)
{
   Print("SMC BOT STOPPED");
}