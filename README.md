## 만국박람회
``
JSON파일을 decoding하여 만국박람회에 대한 설명과 이미지 등을 화면에 띄우고 오토레이아웃을 통해 정렬해보는 프로젝트
``

---
### 목차
- [팀원](#팀원)
- [타임라인](#타임라인)
- [시각화 구조](#시각화-구조)
- [실행 화면](#실행-화면)
- [트러블 슈팅](#트러블-슈팅)
- [참고 링크](#참고-링크)
- [팀 회고](#팀-회고)

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

### 시각화 구조

#### 클래스 다이어그램
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

#### 1. NSMutableAttributedString
첫 화면의 "방문객", "개최지", "개최 기간"의 폰트 크기가 다른것을 확인. 
Label을 여러개 만들지 않고 일부 폰트를 수정해보고자 함
```
   private func changeFontSize(targetString: String, targetLabel: UILabel) {
        let attributedString = NSMutableAttributedString(string: targetLabel.text ?? "")
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20), range: ((targetLabel.text ?? "") as NSString).range(of: targetString))
        
        targetLabel.attributedText = attributedString
    }
```
[documentation - NSMutableAttributedString](https://developer.apple.com/documentation/foundation/nsmutableattributedstring)

#### 2. setContentOffset / scrollRectToVisible
처음엔 스크롤 이동에 setContentOffset 메서드를 사용했으나 원하는 위치와 약간 다른 지점이 표시된다는 문제가 있어 스크롤 이동에 일반적으로 쓰이는 두 메서드의 차이를 비교해보았다.

- setContentOffset
    스크롤 뷰를 전달받은 CGPoint, 즉 한 점으로 이동하는 메서드라 이해
    [documentatio - setContentOffset(_:animated:)](https://developer.apple.com/documentation/uikit/uiscrollview/1619400-setcontentoffset)

- scrollRectToVisible
    스크롤 뷰를 전달받은 CGRect, 즉 직사각형이 표시되도록 이동하는 메서드라 이해
    [documentation - scrollRectToVisible(_:animated:)
](https://developer.apple.com/documentation/uikit/uiscrollview/1619439-scrollrecttovisible)
특정 포인트를 지정해주기보단 titleLabel을 보여줄것이다 라는 표현이 더 적절하다 생각하여 scrollRectToVisible을 선택.

#### 3. defaultContentConfiguration
일반적인 셀 구성으로 이미지와 텍스트를 넣었을때 이미지 정렬이 일정하지 않았다. 방법을 찾던 도중 [모던 셀 구성 - WWDC](https://developer.apple.com/videos/play/wwdc2020/10027/)을 접하게되어 셀 구성에 해당 기술을 써보고자 했다.
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
위처럼 생성한 셀의 이미지, 텍스트를 설정하고 적용시킬 수 있었다.
reservedLayoutSize - 셀의 프레임(레이아웃)의 크기를 변경시키는 것으로 이해했다. 이미지가 모두 정렬될 수 있도록 설정해줌.


#### 4. IBOutlet Implicitly Unwrapped Optionals에 대한 고찰.
```swift
// DetailViewController의 프로퍼티
@IBOutlet private weak var imageView: UIImageView!
@IBOutlet private weak var explanation: UILabel!

// 만약 DetailViewController에서 이러한 메소드가 존재한다면
func changeValue(text: String) {
    explanation.text = test
}

// 그리고 CulturalAssetListViewController에서 이를 호출한다면
detailViewController.changeValue(text: "TEST")
```
- 이와 같은 경우 viewDidLoad가 아직 호출되지 않아 IBOutlet 값에 nil이 들어있는 상태에 접근을 시도하여 런타임 오류가 발생한다.
- 이러한 경우가 있기에 무작정 자동생성된 코드를 사용하는 것은 좋지 않음.

#### 5. instantiateViewController(identifier:creator:)에서 init()을 통한 데이터 전달.
- 기존에는 이전 화면에서 다운캐스팅을 통해 다음 화면의 프로퍼티에 직접 접근을 하였는데, 이는 객체지향 관점에서 좋지않는 접근 방식이라 아래와 같이 1차 수정하였음.
```swift
func setUp(culturalAsset: CulturalAsset) {
   name = culturalAsset.name
   imageName = culturalAsset.imageName
   detailDescription = culturalAsset.detailDescription
}
```
- 하지만 이러한 방식은 DetailViewController에서 해당 프로퍼티들에게 불필요한 기본값들을 넣어주어야 해서 나온 방안 두 가지
    - 해당 프로퍼티들을 옵셔널 타입으로 선언
    - init()을 통한 값 전달

- 결론은 이 프로퍼티들은 데이터를 전달받고 수정될 일이 없는 프로퍼티라 let을 사용하기 위해 init()을 통해 전달하기로 결정함.
```swift
guard let detailViewController = storyboard?.instantiateViewController(identifier: String(describing: DetailViewController.self), creator: { coder in
   DetailViewController(coder: coder, culturalAsset: self.culturalAssets[indexPath.row])
   }) else {
   return
}
```


#### 6. enum + static / struct
'AssetParser' 메서드는 assetfile명을 받아 디코딩을 하고 지정된 제네릭 타입에 값을 넣어 반환하는 역할을 한다.
처음엔 struct로 구성했으나 사용할때마다 인스턴스화를 진행해야한다는 이유로 중간에 enum + static으로 변경했다.
코드리뷰를 진행하는 과정에서 이 변경에 대한 이유가 적절했는지 다시 생각해보게 되었다.

static으로 선언해주었으므로 처음부터 끝까지 메모리 공간을 차지하게 된다. 여러번 불릴게 아니면 낭비가 아닌가? 실제로 우리 코드에선 이 메서드가 딱 두번 호출된다. 


---
### 팀 회고
<details>
<summary>우리팀이 잘한 점</summary>
최대한 시간을 투자하여 프로젝트를 이해해보고자 했다.
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
