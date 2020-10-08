# swift-w5-storeapp
스프린트 5-6주차 모바일 프로젝트 - 주문앱



## 회원가입 요구사항



앱을 시작하면 로그인 화면이 나오고, 다음 조건이 만족하면 상품 목록 화면으로 넘어간다.

- 로그인 화면은 앱을 시작할 때만 나오고, 한 번 가입한 이후에는 표시하지 않는다.
- 아이디와 비밀번호, 이름은 UserDefault에 저장한다.



|                          iPhone 11                           |                          iPhone 8+                           |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| <img width="200" alt="스크린샷 2020-10-05 오후 9 13 14" src="https://user-images.githubusercontent.com/46335714/95078120-96dfeb00-074f-11eb-849e-8fbfea3aa81d.png"> | <img width="200" alt="스크린샷 2020-10-05 오후 9 15 43" src="https://user-images.githubusercontent.com/46335714/95078337-f0481a00-074f-11eb-8f4c-0af59c61ab95.png"> |


|                          light mode                          |                          dark mode                           |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| <img width="200" alt="스크린샷 2020-10-05 오후 9 19 09" src="https://user-images.githubusercontent.com/46335714/95078640-6b113500-0750-11eb-9fa5-43c3f97e49d9.png"> | <img width="200" alt="스크린샷 2020-10-05 오후 9 20 02" src="https://user-images.githubusercontent.com/46335714/95078721-8a0fc700-0750-11eb-95b4-9dbb6ee49214.png"> |



기기별 동작, 라이트모드 다크모드별 동작



### 1.5초 후 로직 진행





![login](https://user-images.githubusercontent.com/46335714/95407793-02e16f80-0959-11eb-8ab2-0d4288f344ef.gif)





![pass](https://user-images.githubusercontent.com/46335714/95407797-04129c80-0959-11eb-9e6a-105e10e54926.gif)




## 상품 화면 요구사항



- 스토리보드 ViewController에 CollectionView를 추가하고 Safe 영역에 가득 채우도록 frame을 설정한다.
  - 반드시 TableView를 사용하지 않고, 세로 형태로 보이는 CollectionView로 표시한다.

|                             메인                             |                            국찌개                            |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| <img width="300" alt="스크린샷 2020-10-07 오후 8 32 32" src="https://user-images.githubusercontent.com/46335714/95325494-3cc06080-08dc-11eb-9be8-36debb3c88c0.png"> | <img width="300" alt="스크린샷 2020-10-07 오후 8 34 02" src="https://user-images.githubusercontent.com/46335714/95325628-72654980-08dc-11eb-9666-29a44cbf1ad7.png"> |