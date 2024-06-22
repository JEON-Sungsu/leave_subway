
## 프로젝트 개요
- 프로젝트 이름 : 내리라 (leave_subway)
- 프로젝트 기간 : 24.05.10 ~~ 24.06.07
- 참여 인원 : 1명 (개인 프로젝트)
- 플랫폼 : iOS & Android
- 출시 : AppStore & Google play store 출시 예정 (~24.06.30)
- 주요 패키지
  - Riverpod
  - Futter_local_notifications
  - Permission_handler
  - Go_router

<br/>

## 프로젝트 설명 
- 지하철 목적지를 선택하면, 목적지에 도착하기 전 일정 지점에서 푸쉬 알림을 보내주는 기능이 메인인 어플리케이션 입니다.
- 지하철을 타고 어디론가 이동할 때, ‘지금 어디쯤이지?’ 라고 생각이 들어 위치를 보고싶지만 현재 어느역 근처에 왔는지 빠르게 확인이 불가능해 답답했던 경험을 떠올려서, ‘내릴때가 되면 자동으로 알려주는 어플리케이션이 있으면 좋겠다.’ 라는 생각에서 출발하여 시작하게 된  프로젝트 입니다.

<br/>

## 주요 구현 내용 
- Riverpod을 활용한 상태관리 & 의존성 주입
- 권한 관리
  - Permission handler 사용 권한 통합 관리
  - iOS & Android background 위치추적 & 푸쉬알림 설정 
- 위치 추적
  - Stream을 활용한 지속적인 위치 추적 기능 구현
  - 목적지 도달시 자동 위치 추적 구독 종료 기능 구현
  - 실행 후 일정 시간 경과시 자동 위치 추적 종료 기능 구현
- Debounce를 활용한 스크롤 이벤트 최적화
- SharedPreferences 로컬 저장소 관리 기능 구현

<br/>

## 프로젝트 화면

|시작 & 필수권한확인|플로우|푸쉬알림|
|:--:|:--:|:--:|
|![first_launch_leave](https://github.com/JEON-Sungsu/leave_subway/assets/63297236/a627a019-9254-4c39-a49a-1559d2b2a6cb)|![flow_leave](https://github.com/JEON-Sungsu/leave_subway/assets/63297236/5d857a1a-c4d6-409d-9390-a2879e30c3bb)|![push_notify](https://github.com/JEON-Sungsu/leave_subway/assets/63297236/aa2e31ec-e7ef-4108-b852-cc415842a176)|

<br/>

## 프로젝트를 진행하며 했던 고민들
###### 어떤 상태관리가 좋을까?
- 이번 프로젝트의 목표중 하나가, Riverpod을 사용해보고 익숙해지는것 이었습니다. 하지만 프로젝트를 진행하면서 ‘굳이 리버팟으로 상태관리르 해야 하는걸까?’ 라는 의문이 들었습니다. ‘내리라’ 에서는 별도의 API 요청이나, 캐싱 처리가 필요한것도 없고 성능상 최적화가 필요할만큼 큰 리소스가 들어가는 작업도 없기에 Riverpod의 여러 장점들이 불필요한 상황이었습니다. 이정도 규모의 프로젝트에서는 단순하지만 좀 더 직관적인 Provider를 쓰는게 더 적절한것 같다고 깨닫게 되었습니다. 이미 리버팟으로 구현해둔것을 Provider로 변경을 하지는 않았지만, 고민을 거듭하면서 다시 한 번 ‘이유있는 코드 작성’에 대해서 고민할 수 있었던 계기가 되었습니다.  
###### 위치 추적중에 디바이스의 권한 상태 변경에 따른 처리
- ‘내리라’는 위치 사용 권한과 알림 허용 권한이 필수인 서비스 입니다. 어플리케이션을 실행중, 권한이 변경이 되면 위치추적 Stream 구독을 취소해주기 위해서 지속적으로 권한상태를 확인을 해야겠다고 생각했습니다. 처음에는 위치 상태를 관리하는 객체를 만들어, Stream을 구현하여 지속적으로 관찰하려고 했지만, 앱이 실행중일때 지속적으로 Stream을 사용하는것은 리소스 낭비와 배터리 소모 이슈가 생길 수 있다고 생각했습니다. 방법을 궁리하던 중 권한이 변경될 수 있는 상황은 어플리케이션이 ‘Background 상태일때 밖에 없다’ 라고 생각되어 권한 관리 객체를 Provider로 만들고 최상위 위젯에서 Provider를 참조하여 AppLifecycleState가 resume이 될 때 마다 권한 체크 메서드를 호출하여 상태를 갱신 하고, View에서 이를 확인하여 추적기능을 종료하고 권한이 변경되었음을 사용자에게 알리도록 처리할 수 있었습니다.
###### 지하철 위치 정보 데이터 (API vs Local JSON)
- 최초에 공공데이터 API를 사용해서, 지하철역 좌표를 받아와서 활용하려고 했지만, 서울지역 데이터만 존재하였습니다. 추후에 부산, 대구, 광주 등 타지역 지하철을 대상으로도 기능을 추가하려고 계획을 했기에 서울 데이터만 API로 받아오고 나머지는 JSON 파일에 저장해서 사용할지, 처음부터 JSON 파일을 프로젝트에 두고 사용할지 고민했지만, 지하철의 위치정보가 자주 변경이되거나, 신규로 추가되는 일이 많지가 않으니 매번 어플리케이션을 실행할 때마다 API 호출을 하는데 리소스를 소모할 필요가 없다고 판단되어 JSON 데이터 파일을 만들어 프로젝트에 저장해두고 사용하게 되었습니다.

<br/>

## TroubleShooting
###### ListWheelScroll
- 선택하는 선택하는 UI 를 바텀시트 내부에 ListWheelScrollView Widget을 이용해서 만들었는데, 바텀시트를 다시 열었을때, 스크롤 상태를 초기화 하기 위해 controller를 사용했습니다. 그런데 ScrollController 객체를 지정하니 onSelectedItemChanged 콜백 메서드가 동작하지 않는 현상이 발견되었습니다. 공식문서를 다시 찾아보니, ListWheelScrollView 경우 controller에 FixedExtentScrollController 외에 일반적인 ScrollController를 사용하면 콜백 메서드가 동작하지 않는다고 하여, FixedExtentScrollController을 사용해 문제를 해결하였습니다.[공식문서 보기](https://api.flutter.dev/flutter/widgets/ListWheelScrollView/controller.html)
###### ListTile
- Drawer 메뉴의 Item을 ListTile Widget으로 구성하였는데, 디자인적으로 예쁘게 보이게 하기 위해서 ListTile의 height 값을 줄이고 싶었지만, 다양한 방법을 시도해도 줄어들지 않아, 공식문서를 찾아보니 Material Spec에서 정의하는 접근성 요구사항에 의해 일정 크기를 유지되어야 한다는것을 찾을 수 있었습니다. 그래서 허용하는 내에서 최대한 줄이기 위해 dense 값을 true로 만들어 한도내에서 크기를 줄일 수 있었습니다. 해당 문제를 해결하면서, 동일한 이유로 커스터마이징이 제한된 Button류 위젯들, AppBar, Checkbox, Radio 등 의 constraints에 대해서도 알 수 있었습니다. [공식문서 보기](https://api.flutter.dev/flutter/material/ListTile-class.html)

<br/>

## 프로젝트 회고 & 성과
- iOS & Android의 권한 처리 과정에 대한 차이점을 알게 되었습니다. iOS에서는 최초에 거부시, PermenantDenied 상태가 되어버리고, Android는 한 번은 denied 두 번 거절시 PermenantDenied 전환으로 되는것, 또한 권한 거부시 어플리케이션을 강제 종료시키는것도 Google과 Apple의 개발자 정책에 위반되는것도 알게 되었습니다.
- Riverpod 상태관리 패키지에 대해서 깊게 공부해볼 수 있었습니다. Provider나 Get_it과 비교해서 어떤 장점들이 있는지, 어떤 방식으로 동작하는지에 대해 알 수 있어서 재밌었던 것 같습니다. 아직까진 완벽하게 익힌건 아니라 계속해서 연구하며 더 좋은 사용법과 케이스들을 알아갈 예정입니다. 
- 이번 프로젝트를 하면서 아직 UI 구현이 부족하다는걸 느꼈습니다. 특히 중복 코드를 줄이고, 재사용성을 높일 수 있는 코드작성에 어려움을 느꼈던 것 같습니다. 우선 공식문서의 Widget들 중에, 자주 사용하는 위젯들을 위주로 정리를 진행하면서 다음 프로젝트로 클론코딩을 해보면서 UI 구현력을 조금 연습해볼 생각입니다.
