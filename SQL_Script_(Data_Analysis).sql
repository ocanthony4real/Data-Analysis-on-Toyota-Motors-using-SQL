USE toyotamotors;

SELECT * FROM cashflow;
DESC cashflow; -- check for anomality in table
ALTER TABLE cashflow ADD PRIMARY KEY (Date); -- change Date column to primary key
ALTER TABLE cashflow MODIFY Date date; -- change the type of Date column from datetime to date

SELECT * FROM balance_sheet;
DESC balance_sheet; -- check for anomality in table
ALTER TABLE balance_sheet ADD PRIMARY KEY (Date); -- change Date column to primary key
ALTER TABLE balance_sheet MODIFY Date date;  -- change the type of Date column from datetime to date

SELECT * FROM financials;
DESC financials; -- check for anomality in table
ALTER TABLE financials ADD PRIMARY KEY (Date); -- change Date column to primary key
ALTER TABLE financials MODIFY Date date;  -- change the type of Date column from datetime to date

SELECT 
    c.Date,
    ABS(FORMAT(c.Capital_Expenditures / f.Total_Revenue,
                2)) AS CAPEX_Ratio
FROM
    cashflow c
        INNER JOIN
    financials f ON c.Date = f.Date;
/* evaluates the CAPEX to revenue ratio of the company. From the result, 
there's been a decline in the ratio over the years. However, the ratios 
are pretty fair for an automobile company.*/

SELECT 
    Date,
    FORMAT(Net_Income / Total_Revenue, 2) AS Net_Profit_Margin
FROM
    financials;
/*evaluates the Net Profit Margin over the years. There's a steady increase in the
 Net Profit Margin which could mean a reduction in the operating cost of the company or an 
 improvement in the pricing structure of the company's product.*/

SELECT 
    Date,
    FORMAT(Total_Operating_Expenses / Total_Revenue,
        2) Operating_Expense_Ratio
FROM
    financials;
/*evaluates the Operating Expense Ratio (OER) over the past four years. For three years, 
the OER was constant at 0.92 before dropping to 0.9. This means that the company is reducing it's operating
expenses, which is a good move.*/

SELECT 
    Date,
    FORMAT(Total_Current_Assets - Total_Current_Liabilities,
        2) as Working_Capital_Ratio
FROM
    balance_sheet;
/* evaluates the Working Capital Ratio (WCR). The WCR has been positive over the years and has been 
on a steady increase. This means that the company is doing its best in maintaining enough liquid assets to keep 
the company running in the short term.*/

SELECT 
    Date,
    FORMAT(Total_Liab / Total_Stockholder_Equity,
        2) AS Debt_to_Equity
FROM
    balance_sheet;
/*evaluates the Debt-to-Equity (D/E) ratio. From the data queried, the D/E ratio is a bit high. This means that the 
company is heavily financing its operations aggressively on debts. However, this is a good move if the company is 
taking a calculated risk at increasing its profit massively by taking on debt. Also, the company will have
to devise other means to attract more investors as a high D/E is already a discouragement to potential investors.*/

SELECT 
    c.Date,
    FORMAT(c.Net_Income / (SELECT 
                Total_Assets - Total_Liab
            FROM
                balance_sheet AS b
            WHERE
                c.Date = b.Date),
        2) AS Return_on_Equity
FROM
    cashflow AS c;
/*evaluates the Return on Equity (ROE) over the years in view. In corroboration with the D/E calculated above, the company 
has been experiencing a low ROE, which is not appealing to potential investors. The company needs more equity from 
investors in order to increase it's ROE.*/
