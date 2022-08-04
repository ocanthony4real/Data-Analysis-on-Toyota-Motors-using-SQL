USE toyotamotors;
SELECT * FROM cashflow;
    
DESC cashflow;

ALTER TABLE cashflow ADD PRIMARY KEY (Date);
# changes Date column to primary key
 
ALTER TABLE cashflow MODIFY Date date;
# change the type of Date column from datetime to date

SELECT * FROM balance_sheet;
DESC balance_sheet;

ALTER TABLE balance_sheet ADD PRIMARY KEY (Date);
ALTER TABLE balance_sheet MODIFY Date date;

SELECT * FROM financials;
DESC financials;

ALTER TABLE financials ADD PRIMARY KEY (Date);
ALTER TABLE financials MODIFY Date date;

SELECT c.Date, abs(FORMAT(c.Capital_Expenditures / f.Total_Revenue, 2)) FROM cashflow c INNER JOIN financials f on c.Date = f.Date
# evaluates the CAPEX to revenue ratio of the company. From the result, there's been a decline in the ratio over the years. However, the ratios are pretty fair for an automobile company. 
