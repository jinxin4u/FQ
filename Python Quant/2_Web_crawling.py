# -*- coding: utf-8 -*-
"""
Created on Tue Dec 10 23:11:47 2019

@author: jinxi
"""
#%% requests 패키지 GET 방식 사용 예제
import requests

r = requests.get('https://api.github.com/events')

payload = { 'key1' : 'value1', 'key2' : 'value2' }
r = requests.get('https://httpbin.org/get', params = payload)
r.status_code
r.url
#%% requests GET방식 예시2

naver_data = dict(
        sm='top_hty',
        fbm=1,
        ie='utf8',
        query='퀀트'
)

r = requests.get('https://search.naver.com/search.naver', params = naver_data)
r.url
#%% header 값을 임의로 수정하여 GET 메소드 호출할 때 함꼐 전달하기

header = {'User-Agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:66.0) Gecko/2010101 Firefox/66.0'}
url = 'http://www.useragentstring.com/'

r = requests.get(url, headers = header)

# requests의 리턴값인 Response 객체의 메소드 알아보기
# r.request : 요청 정보 가진 객체
# r.url : 요청한 url 문자열
# r.cookie : cookie 정보 가진 객체
# r.headers : dict 형식의 응답 헤더
# r.status_code : 응답의 http 상태코드
# r.ok : 상태코드가 정상이면 True, 비정상이면 False
# r.text : 응답 본문값을 문자열로 출력
# r.json() : 응답 본문을 JSON 형식으로 출력하여 dict형식으로 반환
#%% requests POST방식
import requests

payload = { 'key1' : 'value1', 'key2' : 'value2' }

r = requests.post("https://httpbin.org/post", data = payload)
print(r.text)

#%% 세션 개념 : 서버에 상주하도록..

s = requests.Session()
s.headers.update({'User-Agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:66.0) Gecko/2010101 Firefox/66.0'})
# 헤더를 변경해놓고 세선 상주하기
r = s.get('http://naver.com')
r = s.get('http://daum.net')
#%% Session 메소드를 with와 함께 사용하기
with requests.Session() as s:
    s.headers.update({'User-Agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:66.0) Gecko/2010101 Firefox/66.0'})
    
    r = s.get('http://naver.com')
    r = s.get('http://daum.net')
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
#%% title 태그의 정보 출력
soup.title
#%% title 태그의 이름 출력
soup.title.name
#%% title 태그가 가진 내용 출력
soup.title.string
#%% p 태그의 정보 출력
soup.p
#%% p 태그가 가진 class를 출력
soup.p['class']
#%% a 태그의 정보 출력
soup.a
#%% 문서상의 모든 a를 탐색
soup.find_all('a')
#%% id가 link3라는 것만 출력
soup.find(id='link3')
# class속성 검색을 원할 경우 : find(class_ = '클래스이름')  _는 기존의 class와의 충돌 피하기위해..
# find('요소이름', attr={'속성이름':'값'}) 과같이 지정하면 조건 세밀하게 할수도..
# parameter 형식
#   name = None, attrs={}, recursive = True, text = None, **kwargs
#   요소이름을 검색조건으로
#   요소 속성이름과 값을 검색조건으로. 사전형으로 작성
#   false 지정하면 바로 아래 자식 요소만 대상이..
#   text - 요소의 내용(시작태그와 종료태그 사이의 텍스트)를 검색 조건으로 한다

# find_all 메소드의 경우는 limit 인수도 있음
# limit : 지정한 수만큼 요소가 발견되면 검색을 종료한다

# find를 써서 tag 객체를 반환한다
#%% Tag 객체의 리스트를 순회하며 get메서드를 사용하며 해당 키에 맞는 값 출력하기
for link in soup.find_all('a'):
    print (link.get('href'))
    
    
    
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
#%% Selenium 메소드의 기능

# 웹 페이지의 DOM 정보를 바탕으로 선택자를 선택할 수 있
#   find_element_by_id() : id값을 사용하여 위치 찾기
#   find_element_by_css_selector() : css요소의 표기 방법으로 된 위치를 찾
#   find_element_by_xpath() : xml의 특정 요소로 지정된 위치를 찾

# 선택자 함수 사용하면 브라우저에 해당 항목을 선택한 것처럼 됨
# 선택자 함수들의 click(), send_key() 메소드를 가지고 있,
#   get() : 특정 사이트로 이동도..
#   click() : 선택자 함수로 선택된 곳을 실제로 클릭
#   clear() : 선택된 곳에 타이핑 된 내용을 삭제
#   implicitly_wait() : 브라우저에서 웹페이지 요소들이 로딩될 수 있도록 특정시간 기다려주는..
#   send_key() : 선택자 함수로 선택된 곳에 키보드로 타이핑하는 것처럼 데이터 전송
#   page_source : drive가 보고 있는 웹 데이터를 가지고 있는 문자열 변수
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




#%% Pandas 기능 중 read_html 메소드 알아보기
# 웹페이지 상의 table형태 데이터를 읽어 dataframe 형식으로 저장
# 크롬 예) F12누르고 네트워크 탭 선택 , 로그 유지 체크
# html 혹은 document로 되어있는 정보 확인할 수 있
# 확인된 document를 우클릭해서 주소 복사

import pandas as pd

url = "https://finance.naver.com/sise/sise_index_day.nhn?code=KOSPI&page=1"
pd_result = pd.read_html(url)
pd_result[0]

#%% 뽑은 데이터에서 결측치 제거해보자
pd_result[0].dropna()

#%% 파이썬으로 사이트 인증하여 로그인하기
import requests

# 로그인 정보를 dict 형태로 전달합니다
payload = dict(
        user_id='ta6464',
        password='ta6464'
)

header = {
        'Referer' : 'https://www.ppomppu.co.kr/zboard/login.php',
        'User-Agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:66.0) Gecko/2010101 Firefox/66.0'
}

URL = 'https://www.ppomppu.co.kr/zboard/login_check.php?/'

# with 구문으로 context를 실행
# with 구문이 종료가 되면 자동으로 세션도 종료가 됨

with requests.Session() as s:
    rt = s.post(URL, data = payload, headers = header)
    
    r = s.get('http://www.ppomppu.co.kr/zboard/zboard.php?id=market', headers = header)
    
    # 접속 정보 출력
    print(r.text)
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
data2
# dropna해도 데이터 셋에 적용 안됨 그때뿐임 ㅋ
# 그래서 inplace = True하면 실제로 데이터셋에 반영됨
#%% 시가 컬럼 내부의 문자열을 조회하여 콜론을 없애고 정수화 하는 작업
data2['시가'].apply(lambda x : int(x.replace(",","")))
# 하지만 data2 자체가 변한게 없다
#%%
data2['시가'] = data2['시가'].apply(lambda x: int(x.replace(",","")))  # 시가 컬럼내용 콜론없애기
data2.info()

#info로 확인하면 시가의 data type이 int64로 바뀐걸 알수있음

#%% 여러 컬럼의 콜론 없애기
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

#%%
import os
import sys
import urllib.request
client_id = "YOUR_CLIENT_ID"
client_secret = "YOUR_CLIENT_SECRET"
url = "https://openapi.naver.com/v1/datalab/search";
body = "{\"startDate\":\"2017-01-01\",\"endDate\":\"2017-04-30\",\"timeUnit\":\"month\",\"keywordGroups\":[{\"groupName\":\"한글\",\"keywords\":[\"한글\",\"korean\"]},{\"groupName\":\"영어\",\"keywords\":[\"영어\",\"english\"]}],\"device\":\"pc\",\"ages\":[\"1\",\"2\"],\"gender\":\"f\"}";

request = urllib.request.Request(url)
request.add_header("X-Naver-Client-Id",client_id)
request.add_header("X-Naver-Client-Secret",client_secret)
request.add_header("Content-Type","application/json")
response = urllib.request.urlopen(request, data=body.encode("utf-8"))
rescode = response.getcode()
if(rescode==200):
    response_body = response.read()
    print(response_body.decode('utf-8'))
else:
    print("Error Code:" + rescode)





















