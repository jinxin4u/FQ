# -*- coding: utf-8 -*-
"""
Created on Tue Dec 10 23:11:47 2019

@author: jinxi
"""

#%% 파일 위치
import os
os.getcwd()

#%% bs4사용 예
from bs4 import BeautifulSoup

html_doc = """
<html><head><title>IT IS TITLE</title></head>
<body><p class="title"><b>The...</b></p>
<a href="naver.com">Naver.com</a>
</body></html>
"""
soup = BeautifulSoup(html_doc, 'html.parser')

print(soup.prettify())
#%%
soup.title
#%%
soup.title.name
#%%
soup.title.string
#%%
soup.p
#%%
soup.p['class']
#%%
soup.a
#%%
soup.find_all('a')
#%% request를 이용한 크롤링 예
import requests
import pandas as pd

url = "https://finance.naver.com/item/sise_day.nhn?code=005930&page=6"

result = pd.read_html(url)
result
#%%
result[0]
#%%
stock = result[0].dropna()
stock
#%% selenium : JS가 있는 사이트에서 데이터 가저오기 위함
from selenium import webdriver

driver = webdriver.Chrome('C:/chromedriver/chromedriver.exe')

#%% selenium 예제
from selenium import webdriver
from bs4 import BeautifulSoup
url = "https://fastcampus.co.kr"
driver = webdriver.Chrome('C:/chromedriver/chromedriver.exe')
driver.get(url) # get:특정 사이트로 이동할 수 있도록 드라이버에게 요청

#%%
# XPath는 XML의 특정 요소를 지정할 때 사용
# CSS 선택자는 CSS로 요소를 디자인 할 때 사용하는 표기 방법
# CSS 선택자가 보기 편하고 간편하다

#css선택자
#theme-page > div:nth-child(9) > div > div.theme-content.no-padding > div:nth-child(1) > div > div:nth-child(3) > div:nth-child(1) > div > div > div > figure > a > img
#Xpath
//*[@id="theme-page"]/div[9]/div/div[1]/div[1]/div/div[3]/div[1]/div/div/div/figure/a/img

#%% selenium이 클릭하도록
driver.find_element_by_xpath(//*[@id="theme-page"]/div[9]/div/div[1]/div[1]/div/div[3]/div[1]/div/div/div/figure/a/img).click()
#%% 
driver.page_source # 셀레니엄이 이동한 최종 html 페이지의 코드
#%% 이거 파싱하려면
bs = BeautifulSoup(driver.page_source, "lxml")
#%% 팬텀js 기본
from selenium import webdriver
driver = webdriver.PhantomJS('C:/phantomjs-2.1.1-windows/bin/phantomjs.exe')


#%% Pandas Data Frame

stock_dict = [{'날짜':'2019-05-07',
               '종목':'삼성전자',
               '시가':'45,250',
               '종가':'44,850'},
              {'날짜':'2019-05-07',
               '종목':'LG전자',
               '시가':'75,200',
               '종가':'77,000'},
              {'날짜':'2019-05-07',
               '종목':'SK텔레콤',
               '시가':'254,500'},
              {'날짜':'2019-05-07',
               '종목':'SK하이닉스',
               '시가':'79,200',
               '종가':'79,900'}]
data = pd.DataFrame(stock_dict, columns = ['날짜','종목','시가','종가'])
data
#%%
data.info()
#%% 데이터프레임 결측치 처리
data.dropna() # 결측치 행 제외
#%%
data.fillna(0) # 결측치 대체
#%% 이건 시계열에서 주로 쓰임
data.fillna(method='ffill') #전위 값으로 대체
#%%
data.fillna(method='bfill') #후위 값으로 대체
#%%
# apply 특정함수를 특정 데이터 컬럼에 적용..

data2 = data.copy()
# 카피함수 없이 주면 복사가 아니라 참조가 된다...
# 그러니 하나 더 만드려면 카피함수 써서 '깊은복사'를.

data2.dropna(inplace=True)
# dropna해도 데이터 셋에 적용 안됨 그때뿐임 ㅋ
# 그래서 inplace = True하면 실제로 데이터셋에 반영됨

data2['시가'] = data2['시가'].apply(lambda x: int(x.replace(",","")))  # 시가 컬럼내용 콜론없애기
data2.info()
#info로 확인하면 시가 데이터타입이 바뀐걸 알수있음

#%%
data3 = data.copy()
data3.dropna(inplace=True)
data3[['시가','종가']] = data3[['시가','종가']].applymap(lambda x : int(x.replace(",","")))
data3.info()
# applymap : apply 여러개 적용시키고플떄..

#%% 날짜데이터 변환

# astype() : 형변환
# to_datetime() : 문자열->날짜객체로..

data3['날짜'] = pd.to_datetime( data3['날짜'], format='%Y-%m-%d %H:%M:%S')

data3.info()

#%% 32비트 int로 변경하기
data3['종가'] = data3['종가'].astype('int32')
data3.info()























