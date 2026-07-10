//+------------------------------------------------------------------+
//| TradeManager.mqh                                                 |
//+------------------------------------------------------------------+
#ifndef __TRADEMANAGER__
#define __TRADEMANAGER__

#include <Trade/Trade.mqh>

extern CTrade trade;

extern bool BuyConfirmation;
extern bool SellConfirmation;

extern double LotSize;
extern double EntryPrice;
extern double StopLoss;
extern double TakeProfit;

void ExecuteTrade()
{
   if(PositionSelect(_Symbol))
      return;

   if(BuyConfirmation)
   {
      trade.Buy(LotSize, _Symbol, 0.0, StopLoss, TakeProfit, "NEW BOT BUY");
   }

   if(SellConfirmation)
   {
      trade.Sell(LotSize, _Symbol, 0.0, StopLoss, TakeProfit, "NEW BOT SELL");
   }
}

#endif