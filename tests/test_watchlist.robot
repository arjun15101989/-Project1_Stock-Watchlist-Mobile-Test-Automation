*** Settings ***
Documentation    Project 1: Stock Watchlist Acceptance Criteria Test Suite (FIN-101)
...              Covers all 18 Acceptance Criteria mapped to domain-specific keywords.
Resource         ../resources/watchlist_keywords.resource

Test Setup       Launch Trading Application
Test Teardown    Close Trading Application

*** Test Cases ***
AC-01: Default Watchlist Load Verification
    [Documentation]    Verify default market watchlist loads within 5s displaying standard tickers.
    [Tags]             smoke    sanity    AC-01
    Wait Until Element Is Visible    ${WATCHLIST_HEADER}    timeout=5s
    Page Should Contain Element      ${STOCK_TICKER_ITEM}

AC-02: Search Valid Ticker Symbol
    [Documentation]    Verify searching "AAPL" dynamic filters list and returns matching company name.
    [Tags]             functional    AC-02
    Search Stock Symbol              AAPL
    Page Should Contain Element      ${SEARCH_RESULT_ITEM}

AC-03: Search Invalid Ticker Symbol
    [Documentation]    Verify searching "INVALID123" renders empty-state "No Stocks Found".
    [Tags]             functional    negative    AC-03
    Search Stock Symbol              INVALID123
    Verify Empty Search State        No Stocks Found

AC-04: Special Character Input Handling
    [Documentation]    Verify special characters input handled gracefully without app crash.
    [Tags]             edge_case    negative    AC-04
    ${status}=                       Run Keyword And Return Status    Search Stock Symbol    @#$%^&*
    Should Be True                   ${status}

AC-05: Add Stock to Watchlist
    [Documentation]    Verify tapping "+" adds searched asset to active watchlist.
    [Tags]             functional    AC-05
    Search Stock Symbol              TSLA
    Click Element                    ${ADD_TO_WATCHLIST_BTN}
    Clear Active Search
    Verify Stock Listed In Watchlist  TSLA

AC-06: Remove Stock from Watchlist
    [Documentation]    Verify swiping left or tapping "Delete" removes ticker from list.
    [Tags]             functional    AC-06
    Remove Stock From Watchlist      AAPL
    Verify Stock Not In Watchlist    AAPL

AC-07: Real-Time Bullish Indicator
    [Documentation]    Verify tickers with positive gains render price indicators in Green.
    [Tags]             functional    ui    AC-07
    Verify Price Color Indicator     #008000

AC-08: Real-Time Bearish Indicator
    [Documentation]    Verify tickers with losses render price indicators in Red.
    [Tags]             functional    ui    AC-08
    Verify Price Color Indicator     #FF0000

AC-09: Currency Symbol Formatting
    [Documentation]    Verify ticker price values display valid regional currency prefixes ($).
    [Tags]             functional    ui    AC-09
    Element Should Contain           ${STOCK_PRICE_TEXT}    $

AC-10: Pull-to-Refresh Data Update
    [Documentation]    Verify downward swipe gesture re-queries backend APIs and updates timestamp.
    [Tags]             functional    gestures    AC-10
    Perform Pull To Refresh
    Wait Until Element Is Visible    ${LAST_REFRESHED_TIME}

AC-11: Watchlist Item Drag & Reorder
    [Documentation]    Verify long-pressing and dragging alters ticker ordinal index.
    [Tags]             gestures    advanced    AC-11
    Reorder Watchlist Item           AAPL    MSFT

AC-12: Navigation to Stock Detail Route
    [Documentation]    Verify tapping a ticker routes to detailed interactive chart page.
    [Tags]             functional    navigation    AC-12
    Click Element                    ${STOCK_TICKER_ITEM}
    Wait Until Location Contains     chart_detail

AC-13: Clear Search Persistence
    [Documentation]    Verify tapping "X" clears search query and restores default tickers.
    [Tags]             functional    AC-13
    Search Stock Symbol              NVDA
    Clear Active Search
    Page Should Contain Element      ${STOCK_TICKER_ITEM}

AC-14: Max Capacity Alert Trigger
    [Documentation]    Verify exceeding 50 stocks triggers "Watchlist Limit Reached" alert.
    [Tags]             functional    limits    AC-14
    Add Stocks Until Capacity Limit
    Wait Until Element Is Visible    ${MAX_CAPACITY_ALERT}

AC-15: Network Interruption Handling
    [Documentation]    Verify disabling network displays offline cached data banner.
    [Tags]             network    resilience    AC-15
    Set Network Connection Status    OFFLINE
    Page Should Contain              Network Unavailable – Showing Cached Data
    Set Network Connection Status    ONLINE

AC-16: App Background & Resume State Preservation
    [Documentation]    Verify moving app to background for 10s preserves active state.
    [Tags]             lifecycle    AC-16
    Background App                   10
    Wait Until Element Is Visible    ${WATCHLIST_HEADER}

AC-17: Decimal Precision Verification
    [Documentation]    Verify price values render strictly rounded to 2 decimal places ($182.50).
    [Tags]             validation    AC-17
    Verify Decimal Precision Format   ${STOCK_PRICE_TEXT}

AC-18: Session Reset & Cleanup
    [Documentation]    Verify resetting app returns all watchlist configurations to default state.
    [Tags]             cleanup    reset    AC-18
    Reset Application Session
    Wait Until Element Is Visible    ${WATCHLIST_HEADER}