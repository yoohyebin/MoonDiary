# 🌕 달을 통해 하루를 기록하는 다이어리 MoonDiary
<p align="center">
    <img width="500" alt="image" src="https://github.com/user-attachments/assets/8f62769b-090c-473c-96f9-b46a736666eb">
</p>

<a href='https://apps.apple.com/kr/app/moondiary/id6464289799?l=en-GB'><img alt='Available on the App Store' src='https://user-images.githubusercontent.com/67373938/227817078-7aab7bea-3af0-4930-b341-1a166a39501d.svg' height='60px'/></a> 

>**개발기간: 2023.08 ~ 2023.09**

## 📖 프로젝트 소개
- MoonDiary는 달을 통해 그날의 기분을 기록하는 다이어리 앱입니다.
- 사용자는 달을 드래그하여 그날의 기분을 기록할 수 있으며, 한 달간의 기록을 동영상처럼 연속해서 볼 수 있습니다.

## ☺️ 멤버 소개
|🌻Helia (CTO) |🗽NewYork (PM)|
|:---:|:---:|
|<img alt="" src="https://github.com/yoohyebin.png" width="150">|<img alt="" src="https://github.com/NewYorkKim.png" width="150">|
|개발, 기획|기획|

---

## 🔧 Stacks 

### Environment
![Xcode](https://img.shields.io/badge/Xcode-147EFB?style=for-the-badge&logo=Xcode&logoColor=white)
![Github](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=GitHub&logoColor=white)               

### Development
![Swift](https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=Swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-0086c8?style=for-the-badge&logo=Swift&logoColor=white)
![Realm](https://img.shields.io/badge/Realm-39477F?style=for-the-badge&logo=Realm&logoColor=white)

### Communication
![Notion](https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=Notion&logoColor=white)

---
## ⭐ Main Feature
### 감정 기록
- 사용자는 달을 드래그 하여 채우고, 비우면서 그날의 감정을 기록할 수 있습니다.
- 기록은 캘린더에서 확인할 수 있습니다.

### 기록 모아보기
- 사용자는 play 버튼을 눌러 한달 동안의 기록을 영상 처럼 연속적으로 확인할 수 있습니다.
---

## 📂 Project Structure
```
├─ .DS_Store
├─ Assets.xcassets
├─ Model
│  ├─ DragState.swift
│  ├─ Images.swift
│  ├─ MoonData.swift
│  └─ Texts.swift
├─ MoonDiaryApp.swift
├─ Resource
│  ├─ Color+.swift
│  └─ Date+.swift
└─ View
   ├─ Calendar
   │  ├─ CalendarView.swift
   │  └─ CustomCalendar
   │     ├─ CalendarDateButtonView.swift
   │     ├─ CustomCalendarHeader.swift
   │     ├─ CustomCalendarView.swift
   │     └─ YearMonthPicker.swift
   ├─ ContentView.swift
   ├─ DisplayView.swift
   ├─ Moon
   │  ├─ LunarPhaseView.swift
   │  ├─ MoonActivityIndicatorView.swift
   │  ├─ MoonDragView.swift
   │  └─ MoonView.swift
   └─ Tracker
      └─ TrackerView.swift
```
---

## 👩🏻‍💻 Role
- UI 및 인터랙션 구현
- 데이터 구조 설계 및 DB 구축 
---

## 개인정보처리방침
[Privacy Policy](PrivacyPolicy.md)
