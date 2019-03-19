### 인스타그램 봇 직접 만들어 보기

https://docs.google.com/presentation/d/1jy394LovN_AqtAn2ywvIcyYc0CToeowPPd2hKZ4HQKQ/edit?usp=sharing



```python
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from time import sleep, strftime
from random import randint

like_count = 0
comment_count = 0

# 좋아요 기능


def like(driver):
    try:
        like = driver.find_element_by_xpath(
            '/html/body/div[2]/div[2]/div/article/div[2]/section[1]/span[1]/button')
        like.click()
        return True
    except Exception as ex:
        print("Failure Like", ex)

# 댓글 기능


def comment(driver, comment):
    try:
        driver.find_element_by_xpath(
            '/html/body/div[2]/div[2]/div/article/div[2]/section[1]/span[2]/button').click()
        comment = driver.find_element_by_xpath(
            '/html/body/div[2]/div[2]/div/article/div[2]/section[3]/div/form/textarea')
        comment.send_keys(comment)
        comment.send_keys(Keys.ENTER)
        return True
    except Exception as ex:
        print("Failure Comment", ex)


try:
    # 웹 드라이버가 저장된 위치
    # 윈도우에서 사용할 경우 ''앞에 r 사용 
    # ex) r'크롬드라이버 위치'
    path = '크롬드라이버 위치'
    # 셀레니움 실행
    driver = webdriver.Chrome(path)
    # 웹 페이지가 전부 뜰때까지 3초간 기다림
    driver.implicitly_wait(3)
    # 주소로 이동
    driver.get("https://www.instagram.com/accounts/login/?source=auth_switcher")
    # 3초간 동작을 멈춤
    sleep(3)

    # 아이디 입력 input 태그의 고유한 값인 username을 찾음
    username = driver.find_element_by_name('username')
    # id입력창에 아이디 입력
    username.send_keys('아이디 입력')

    # 비밀번호 입력 input 태그의 고유한 값인 password를 찾음
    password = driver.find_element_by_name('password')
    # password 입력창에 비밀번호 입력
    password.send_keys("비밀번호 입력")

    sleep(2)

    # 로그인 버튼을 찾음
    button_login = driver.find_element_by_xpath(
        '//*[@id="react-root"]/section/main/div/article/div/div[1]/div/form/div[3]/button')
    # 로그인 버튼 클릭
    button_login.click()

    sleep(3)

    # 알림 설정 해제
    notnow = driver.find_element_by_xpath(
        '/html/body/div[2]/div/div/div[3]/button[2]')
    notnow.click()

    sleep(4)

    # 태그 검색
    hashtag_list = ['고양이']

    for tag in hashtag_list:
        driver.get('https://www.instagram.com/explore/tags/' + tag + '/')

        sleep(3)

        p = driver.find_elements_by_xpath(
            '//*[@id="react-root"]/section/main/article/div[2]/div/div/div/a')
        for i in range(len(p)):
            p[i].find_element_by_tag_name('div').click()
            # 좋아요 기능
            if(like(driver)):
                like_count += 1

            # 디스크립션
            # driver.find_element_by_xpath(
            #     '/html/body/div[2]/div[2]/div/article/div[2]/div[1]/ul/li/div/div/div/span').text

            # 댓글 달기
            txt = "안녕하세요!"
            if(comment(driver, txt)):
                comment_count += 1

            sleep(randint(5, 10))

            # 닫기
            close = driver.find_element_by_xpath(
                '/html/body/div[2]/button[1]')
            close.click()
            sleep(5)
finally:
    driver.quit()

```

