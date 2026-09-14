*** Settings ***

Documentation    Centralized UI locators for Project 1 Stock Watchlist.

*** Variables ***
${WATCHLIST_HEADER}          xpath=//android.widget.TextView[@text="Watchlist"]
${STOCK_TICKER_ITEM}         xpath=//android.widget.TextView[@resource-id="com.trade.app:id/ticker_symbol"]
${SEARCH_BAR_INPUT}          accessibility_id=Search Stock Ticker
${SEARCH_RESULT_ITEM}        xpath=//android.widget.TextView[@resource-id="com.trade.app:id/search_result_name"]
${EMPTY_STATE_MSG}           id=com.trade.app:id/txt_empty_state