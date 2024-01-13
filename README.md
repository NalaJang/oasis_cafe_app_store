# Oasis Cafe

This is an application for the admin of the Oasis cafe to process customers order.  
This app is designed to streamline and enhance the management of orders, providing an efficient solution for businesses in the hospitality industry.

<br></br>


## Table of content
* [General info](#general-info)
* [Tech stack](#tech-stack)
* [How to use](#how-to-use)
* [Menu tree](#menu-tree)
* [Screen shots](#screen-shots)
* [Folder Structure](#folder-structure)
* [Preview](#preview)

<br></br>

## General info
1. 개발 기간 : 2023.10 ~ 2024.01
2. 주문 확인 : Firebase Database를 활용하여 주문 상태를 모니터하고 업데이트할 수 있습니다.
3. 직관적 사용자 인터페이스 : Flutter의 위젯 라이브러리를 이용하여 직관적이인 주문 관리 인터페이스를 구현했습니다.
4. 인증 및 권한 부여 : Firebase Authentication을 활용하여 권한이 부여된 관리자 및 직원이 안전하게 액세스할 수 있도록 하였습니다.

<br></br>

## Tech stack
<img src="https://img.shields.io/badge/androidstudio-34A853?style=for-the-badge&logo=androidstudio&logoColor=white">
<img src="https://img.shields.io/badge/firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=white">
<img src="https://img.shields.io/badge/flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white">
<img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">
<img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white">

<br></br>

## How to use
### step 1:
Clone this project.

    git clone https://github.com/NalaJang/oasis_cafe_app_store.git


### step 2:
Open the project folder with VS Code/Android Studio and execute the following command to install all dependencies packages.

    flutter pub get


### step 3:
Go to your [Firebase](https://console.firebase.google.com/) console. Create a new Firebase project.
Register your app. Complete the rest of the step require.

### step 4:
Try launch the app.

<br></br>

## Menu tree

* Store app
<img width="781" alt="oasis_cafe_store_menu_tree" src="https://github.com/NalaJang/oasis_cafe_app_store/assets/73895803/ada99bf2-c0c1-4885-9f43-2ad77b15a2e4">

<br></br>

## Screen shots
<img width="849" alt="image" src="https://github.com/NalaJang/oasis_cafe_app_store/assets/73895803/c458723a-e599-4785-a560-28e116d111f4">

<br></br>

## Folder Structure

    lib/
    |- config/ - contains configuration for widget views.
    |- model/ - contains all the plain data models.
    |- provider/ - contains all Provider models for each of the widget views.
    |- screens/ - the main folder that contains all UI.
    |- main.dart - the main.dart file for dev environment.

<br></br>

## Preview
|주문 접수|
|-------|
|![oasis_cafe_store_app](https://github.com/NalaJang/oasis_cafe_app_store/assets/73895803/fb87b446-099b-479f-a63d-75278b2f0516)|

