*** Settings ***
Documentation    Reusable business logic keywords for Stock Watchlist operations.
Library          AppiumLibrary
Resource         locators.resource

*** Variables ***
${REMOTE_URL}         http://127.0.0.1:4723
${PLATFORM_NAME}      Android
${DEVICE_NAME}        emulator-5554
${AUTOMATION_NAME}    UiAutomator2
${APP_PACKAGE}        com.trade.app
${APP_ACTIVITY}       .ui.watchlist.WatchlistActivity

*** Keywords ***
Launch Application
    [Documentation]    Starts Appium session and launches app.
    Open Application    ${REMOTE_URL}
    ...                 platformName=${PLATFORM_NAME}
    ...                 deviceName=${DEVICE_NAME}
    ...                 automationName=${AUTOMATION_NAME}
    ...                 appPackage=${APP_PACKAGE}
    ...                 appActivity=${APP_ACTIVITY}
    Wait Until Element Is Visible    ${WATCHLIST_HEADER}    timeout=10s

Close Application Session
    [Documentation]    Terminates active Appium session.
    Close Application

Search Stock Ticker Symbol
    [Arguments]    ${symbol}
    Input Text     ${SEARCH_BAR_INPUT}    ${symbol}