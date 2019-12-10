# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
#%% for 문

for x in range(1, 101):
    if x % 2 == 0 and x % 5 != 0:
        print(x)
#%% 출력문 예제

year = 2019
month = 11
day = 28
today = "목요일"

print("{}년 {}월 {}일 {}입니다".format(year, month, day, today))
#%% 문자열 자르기

str = "abcdefghijklm"
str[2:10:2]

#%% 리스트 생성
tmp = [k for k in range(0,30) if k % 2 == 0]
tmp

#%% 리스트 생성 이중포문
print([x*y for x in range(2,10) for y in range(2,10)])
#%% 이중리스트
sss= [['samsung', '44444'], ['LG', '10000']]
for name, money in sss:
    print(name, money)
#%% 딕셔너리 데이터셋 예
dictionary = {'a' : 1, 'c' : 2, 'b' : 4, 'd' :3 }
sorted(dictionary, key = lambda x : x)  # 람다식 예제
#%% 산술평균
def mean(stock):
    return sum(stock)/len(stock)

#%% 기하평균

from math import *

def geometric(*arg):
    print(arg)
    geo_list = [1 + (x/100) for x in arg]
    print(geo_list)
    
    total = 1
    for i in geo_list:
        total *= i
    
    return pow(total,1/len(geo_list))



print(1000 * geometric(10,20,-15)**3)

print(1080 * geometric(20,5,-7,-15)**4)

#%% 최소값 최대값
stock = [5785,4450,3310,3270,3300,3200,3200,2240,2300,2512]

print(min(stock))
print(max(stock))

#%% 중간값

def median(arg):
    print("리스트 : {}".format(arg))
    
    length = len(arg)
    print("인자갯수 : {}".format(length))

    mid = int(length/2)
    #짝수
    if length % 2 == 0:
        return (arg[mid] + arg[mid-1]) / 2
    #홀수
    else :
        return arg[mid]

stock.sort()

print(median(stock))

#%% 분산

def variance(data):
    var_mean = mean(data)
    diff = 0
    
    for i in data:
        diff += (i - var_mean)**2
        
    return diff/(len(data)-1)#표본분산은 n대신 n-1로 나눈다

variance(stock)

#%% 표준 편차

def stddev(data):
    return variance(data)**0.5
stddev(stock)
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











