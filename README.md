## 만국박람회
``
만국박람회의 포스터와 설명을 볼 수 있고, 출품작을 품목별로 정리하여 상세한 설명을 볼 수 있는 앱입니다.
``

---
### 목차
- [팀원](#팀원)
- [타임라인](#타임라인)
- [클래스 다이어그램](#클래스-다이어그램)
- [실행 화면](#실행-화면)
- [트러블 슈팅](#트러블-슈팅)
- [팀 회고](#팀-회고)
- [참고 링크](#참고-링크)

---
### 팀원
|Hisop|Charles|
|---|---|
|[GitHub](https://github.com/Hi-sop)|[GitHub](https://github.com/Charl-es)|

### 타임라인

|날짜|내용|
|------|---|
|23.10.31|JSON 기반으로 Exposition 구조체 생성|
|23.11.01|Asset파일 import, CodingKeys 열거형 추가, Exposition에 대한 유닛테스트 추가 및 테스트 함수 수정|
|23.11.02|CulturalAsset 테스트 메서드 수정, 데이터 디코딩 메서드 생성, 첫 번째 화면과 두 번째 화면을 구성 및 간단한 오토레이아웃 설정, 디코딩한 데이터 셀에 할당, 셀 클릭시 화면 전환 구현, 세 번째 화면에 전달받은 데이터를 화면에 출력하는 코드 추가|
|23.11.03|첫 번째 화면 타이틀 개행을 위한 연산 프로퍼티 구현, 방문객, 위치, 기간을 출력하기 위한 연산프로퍼티 구현, 문자열의 폰트 크기를 변경하는 메서드 구현, 첫 번째 화면 네비게이션 컨트롤러 숨김|
|23.11.05|각 컨트롤러 접근제어 수준 변경, 뒤로가기 버튼 구현 방식 변경|
|23.11.06|JSON데이터 디코딩 중 에러 발생 시 얼럿을 띄워주는 방식 구현, 여러 메서드 리팩토링|
|23.11.07|세 번째 화면에 데이터 전달을 init()을 통한 방법으로 구현, 첫 번째 화면에서 디코딩 실패했을 때 앱이 종료되는 코드 삭제|
|23.11.08|에러 출력 문구 수정, 에러 처리 방법 Result 방식으로 변경|
|23.11.09|첫 번째 화면의 회전을 세로로 제한하도록 구현|

### 클래스 다이어그램
![Expo1900](https://github.com/Hi-sop/ios-exposition-universelle/assets/69287436/8ce3c510-9ca8-4309-b5e6-06ca5bb73521)
   

### 실행 화면
|첫 번째 화면|두 번째 화면|
|------|---|
|<img width="320" height="700" src="https://github.com/Hi-sop/ios-exposition-universelle/assets/124643367/208ff8d3-98a5-40ce-ae91-aa74c60d3d1b">|<img width="320" height="700" src="https://github.com/Hi-sop/ios-exposition-universelle/assets/124643367/90f8cac3-230e-46ea-8369-359aee1017fe">|


|화면 회전|
|----|
|<img width="700" height="320" src="https://github.com/Hi-sop/ios-exposition-universelle/assets/124643367/eac3c6c4-b0c7-4b62-9170-133f4be5cedc">|
<img width="700" height="320" src="https://github.com/Hi-sop/ios-exposition-universelle/assets/124643367/e7243dd6-00a0-4f37-99eb-8d677d06ca79">|


|큰 글씨1|큰 글씨2|
|---|--|
|<img width="320" height="700" src="https://github.com/Hi-sop/ios-exposition-universelle/assets/124643367/1f4eb96f-9d0c-44b1-92ce-c8f7fe51c9cd">|<img width="320" height="700" src="https://github.com/Hi-sop/ios-exposition-universelle/assets/124643367/5507b855-e542-4683-b141-ad3a97ad6005">|
   
### 트러블 슈팅

#### 1. 하나의 Label에 다른 폰트크기의 적용
첫 화면의 "방문객", "개최지", "개최 기간"의 폰트 크기가 다른것을 확인했다. 
가장 첫번째로 생각난 해결방법은 Label을 여러개 만들어 극복하는 것이었다. 할당이 여러번 필요하며 받아온 정보를 잘라낼 근거또한 모자랐다.
따라서 하나의 Label만을 사용해 일부 폰트를 수정해보고자 했다.
```
   private func changeFontSize(targetString: String, targetLabel: UILabel) {
        let attributedString = NSMutableAttributedString(string: targetLabel.text ?? "")
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20), range: ((targetLabel.text ?? "") as NSString).range(of: targetString))
        
        targetLabel.attributedText = attributedString
    }
```
[documentation - NSMutableAttributedString](https://developer.apple.com/documentation/foundation/nsmutableattributedstring)
NSMutableAttributedString을 통해 일부 폰트에 다른 크기를 적용하는 것으로 해결하게 되었다.

#### 2. 원하는 지점으로 정확하게 스크롤 이동시키기
처음엔 스크롤 이동에 setContentOffset 메서드를 사용했으나 원하는 위치와 약간 다른 지점이 표시된다는 문제가 있었다.
setContentOffset은 특정 포인트를 지정해주는 메서드라 정확한 포인트를 지정해주지 못하고 있다고 느꼈다.
따라서 scrollRectToVisible을 이용해 titleLabel을 보여줄것이다 라고 설정하여 원하는 지점까지 정확히 스크롤 될 수 있도록 변경했다.

**두 메서드의 차이**
- setContentOffset
    스크롤 뷰를 전달받은 CGPoint, 즉 한 점으로 이동하는 메서드라 이해
    [documentatio - setContentOffset(_:animated:)](https://developer.apple.com/documentation/uikit/uiscrollview/1619400-setcontentoffset)

- scrollRectToVisible
    스크롤 뷰를 전달받은 CGRect, 즉 직사각형이 표시되도록 이동하는 메서드라 이해
    [documentation - scrollRectToVisible(_:animated:)
](https://developer.apple.com/documentation/uikit/uiscrollview/1619439-scrollrecttovisible)

#### 3. 셀 내의 이미지와 텍스트의 정렬

일반적인 셀 구성으로 이미지와 텍스트를 넣었을때 이미지 정렬이 일정하지 않았다. 
이미지의 크기에 따라 셀의 상하는 물론 좌우도 정렬되지 않은 상태로 출력되었다

maximumSize 셀의 이미지, 텍스트를 설정하고 적용시켜 일정한 크기를 가질 수 있게 했다.
reservedLayoutSize을 통해 셀의 프레임(레이아웃 혹은 배경)의 크기를 변경시켜 이미지가 정렬될 수 있도록 설정해주었다.

[모던 셀 구성 - WWDC](https://developer.apple.com/videos/play/wwdc2020/10027/)
https://developer.apple.com/documentation/uikit/uitableviewcell/3601058-defaultcontentconfiguration
```swift
let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        let tableWidth = tableView.frame.width
        
        content.image = UIImage(named: culturalAssets[indexPath.row].imageName)
        content.imageProperties.maximumSize = CGSize(width: tableWidth * 0.2, height: tableWidth * 0.2)
        content.imageProperties.reservedLayoutSize = CGSize(width: tableWidth * 0.2, height: 0)
        
        content.text = culturalAssets[indexPath.row].name
        content.secondaryText = culturalAssets[indexPath.row].shortDescription
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
```

---
### 팀 회고
<details>
<summary>우리팀이 잘한 점</summary>
최대한 시간을 투자하여 프로젝트를 이해해보고자 했으며 스토리보드를 통해 오토레이아웃 기능들의 이해도를 높혀 코드로도 충분히 작성할 수 있도록 하고자 했다.
테이블뷰의 구현에 대해 깊게 고민하며 더 나은 화면구성을 만들고자 했다.
</details>

<details>
<summary>우리팀이 개선할 점</summary>
생각보다 시간을 많이 투자해서 개인적인 공부를 소홀히 한 느낌이 든다. 다음엔 밸런스를 잘 잡아야겠다.
</details>


### 참고 링크
- [CodingKeys](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types#2904058)
- [Using JSON with Custom Types
](https://developer.apple.com/documentation/foundation/archives_and_serialization/using_json_with_custom_types)
- [Result](https://developer.apple.com/documentation/swift/result)
- [defaultContentConfiguration](https://developer.apple.com/documentation/uikit/uitableviewcell/3601058-defaultcontentconfiguration)
- [NSCoding](https://developer.apple.com/documentation/foundation/nscoding)
- [reservedLayoutSize](https://developer.apple.com/documentation/uikit/uilistcontentconfiguration/imageproperties/3601000-reservedlayoutsize)
- [NSMutableAttributedString](https://developer.apple.com/documentation/foundation/nsmutableattributedstring)
- [모던 셀 구성 - WWDC](https://developer.apple.com/videos/play/wwdc2020/10027/)
- [instantiateViewController(identifier:creator:)
](https://developer.apple.com/documentation/uikit/uistoryboard/3213989-instantiateviewcontroller)
