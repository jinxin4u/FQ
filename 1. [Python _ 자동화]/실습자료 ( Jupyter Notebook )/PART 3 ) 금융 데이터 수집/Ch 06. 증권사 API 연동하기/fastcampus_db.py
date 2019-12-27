# -*- coding: utf-8 -*-
"""
Created on Fri Aug  2 04:04:18 2019

@author: gen2
"""
# -*- coding: utf-8 -*-
"""
Created on Thu Aug  1 07:31:41 2019

@author: gen2
"""

import win32com.client
import pymysql

# 연결 여부 체크
objCpCybos = win32com.client.Dispatch("CpUtil.CpCybos")
bConnect = objCpCybos.IsConnect
if (bConnect == 0):
    print("PLUS가 정상적으로 연결되지 않음. ")
    exit()
 
try:
    con = pymysql.connect(host='127.0.0.1', user='root', password='123', port = 3306, charset='utf8')
    cur = con.cursor()
except Exception as e:
    print (e)
    
try:
    cur.execute("CREATE DATABASE stock")
    con.commit()
    cur.execute("USE stock")    
except:
    cur.execute("USE stock")    


try:
    sql_create = """
    CREATE TABLE `stock_day_table` (
    	`st_id` VARCHAR(30) NOT NULL,
    	`st_day` DATE NOT NULL,
    	`st_start` INT(11) NULL DEFAULT NULL,
    	`st_high` INT(11) NULL DEFAULT NULL,
    	`st_low` INT(11) NULL DEFAULT NULL,
    	`st_close` INT(11) NULL DEFAULT NULL,
    	`st_before` INT(11) NULL DEFAULT NULL,
    	`st_trade` BIGINT(20) NULL DEFAULT NULL,
    	`st_money` BIGINT(20) NULL DEFAULT NULL,
    	PRIMARY KEY (`st_id`, `st_day`)
    )
    COLLATE='utf8_general_ci';
    """
    cur.execute(sql_create)
    con.commit()
except Exception as Error:
    print (Error)



inStockChart = win32com.client.Dispatch("CpSysDib.StockChart")

inStockCode = win32com.client.Dispatch("CpUtil.CpStockCode")

stock_count = inStockCode.GetCount()



sql_insert = "INSERT INTO stock_day_table VALUES('{}','{}','{}','{}','{}','{}','{}','{}','{}')"

for i in range(0, stock_count):
    code = inStockCode.GetData(0,i) 
    inStockChart.SetInputValue(0, code)
    inStockChart.SetInputValue(1, ord('1')) # 1 : 기간, 2 : 개수  조회
    inStockChart.SetInputValue(2, '20190630') # 요청종료일
    inStockChart.SetInputValue(3, '20190601') # 요청시작일
    
    inStockChart.SetInputValue(5, [0, 2, 3, 4, 5, 6, 8, 9])  
    #날짜,시가, 고가, 저가, 종가, 전일대비, 거개량, 거래대금
    
    inStockChart.SetInputValue(6, ord('D')) # '일 (Day)'
    inStockChart.SetInputValue(9, ord('1')) # 보정가격
    inStockChart.BlockRequest() # 데이터요청.Blocking Mode
    #  메소드를 호출하면, 서버로 부터 응답이 완료 될 때 까지
    # 대기상태를 유지한다. 데이터를 정상적으로 수신한 후에야 함수가 리턴된다.
    
    count = inStockChart.GetHeaderValue(3) # 헤더데이터를반환합니다 
    # 3 : 수신개수(long) 
    
    print (count)
    
    # GetDataValue (Type,index)
    # type에해당하는데이터를반환합니다
    # type: 요청한필드의 index - 필드는요청한필드값으로오름차순으로정렬되어있음
    # index: 요청한종목의 index

    for j in range(count):
        day = inStockChart.GetDataValue(0, j)
        start = inStockChart.GetDataValue(1, j)
        high = inStockChart.GetDataValue(2, j)
        low = inStockChart.GetDataValue(3, j)
        close = inStockChart.GetDataValue(4, j)
        state = inStockChart.GetDataValue(5, j)
        trade = inStockChart.GetDataValue(6, j)
        money = inStockChart.GetDataValue(7, j)
        print (code, day, start, high, low, close, state, trade, money)
        try:
            cur.execute(sql_insert.format(code, day, start, high, low, close, state, trade, money))
        except Exception as e:
            print (e)
        
con.commit()
cur.execute('select * from stock_day_table;') 
rt = cur.fetchall() 

import pandas as pd
pd.read_sql_query('select * from stock_day_table;', con=con)







