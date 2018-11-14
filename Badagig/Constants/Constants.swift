//
//  Constants.swift
//  badagig
//
//  Created by Perfect Aduh on 04/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import Foundation

typealias Callback = (_ SUCCESS: Bool) -> ()
typealias ImageUploadCallback = (_ SUCCESS: Bool, _ getUrl: String?) -> ()

//URL
let BASE_URL = "http://localhost:3001/v1/"
//let BASE_URL = "http://127.0.0.1:3000/v1/"
let URL_REGISTER_ACCOUNT = "\(BASE_URL)account/register"
let URL_LOGIN_ACCOUNT = "\(BASE_URL)account/login"
let URL_CREATE_USER = "\(BASE_URL)user/add"
let URL_UPLOAD_IMAGES = "\(BASE_URL)getsignedurl/"
let URL_GET_ALL_CATEGORIES = "\(BASE_URL)category/"
let URL_ADD_NEW_CATEGORIES = "\(BASE_URL)category/add"
let URL_UPDATE_CATEGORIES = "\(BASE_URL)category/update/"
let URL_DELETE_CATEGORIES = "\(BASE_URL)category/delete/"
let URL_ADD_NEW_SUBCATEGORIES = "\(BASE_URL)subcategory/add"
let URL_GET_ALL_SUBCATEGORIES_BY_CATEGORY = "\(BASE_URL)subcategory/bycategory/"
let URL_GET_ALL_SUBCATEGORIES = "\(BASE_URL)subcategory/"
let URL_GET_ALL_REQUESTS_BY_USER = "\(BASE_URL)request/byUser/"
let URL_GET_ALL_REQUESTS = "\(BASE_URL)request/"
let URL_ADD_NEW_REQUESTS = "\(BASE_URL)request/add/bySubCategoryId/"
let URL_GET_ALL_BADAGIG = "\(BASE_URL)badagig/"
let URL_GET_ALL_BADAGIG_BY_USER = "\(BASE_URL)badagig/byuser/"
let URL_GET_LOGGED_IN_USER = "\(BASE_URL)user/byEmail/"
let URL_ADD_NEW_BADAGIG = "\(BASE_URL)badagig/add/bySubCategoryId/"
let URL_GET_USER_EMAIL = "\(BASE_URL)user/byId/"
let URL_ADD_NEW_ORDER = "\(BASE_URL)order/add/byBadaGiger/"


//Segues
let TO_SIGN_UP_VC = "goToSignUpVC"
let TO_SIGN_IN_VC = "goToSignInVC"
let TO_PASSWORD_RESET_VC = "goTPasswordResetVC"
let TO_MAIN_VC = "goToMainVC"
let TO_VERIFY_PHONE_VC = "goToVerifyPhoneVC"
let TO_PIN_CODE_VC = "goToPinCodeVC"
let TO_CATEGORY_VC = "goToCategoryVC"
let TO_SUB_CATEGORY_VC = "goToSubCategoryVC"
let TO_MORE_VC = "goToMoreVC"
let TO_SEARCH_RESULT_VC = "goToSearchResultVC"
let TO_POST_REQUEST_VC = "goToPostRequestVC"
let TO_MANAGE_REQUEST_VC = "goToManageRequestVC"
let TO_BADAGIG_ORDER_VC = "goToBadaGigOrderVC"


//User defaults keys
let IS_LOGGED_IN = "isLoggedIn"
let IS_REGISTERED = "isRegistered"
let EMAIL = "email"
let IS_AUTHENTICATED = "isAuthenticated"
let TOKEN_KEY = "tokenKey"
let LOGGED_IN_USERID = "loggedInUserId"

//Headers

let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

let HEADER_BEARER = [
    "Authorization": "Bearer \(AuthService.instance.tokenKey)",
    "Content-Type": "application/json; charset=utf-8"
]

let HEADER_IMAGE_UPLOAD = [
    "Content-Type": "image/jpeg"
]

//AWS
let REGION = "us-west-2"
let BUCKET = "badagig"
let IDENTITY_POOL_ID = "**********"

//Nexmo Verify
let APPLICATION_ID = "********"
let SHARED_SECRET = "********"


// Google SDK Configuration
let GOOGLE_CLIENT_ID = "********"

// Storyboard Identifiers for VC
let MAIN_VC = "mainVC"
let GETTING_STARTED_VC = "gettingStartedVC"


// Cell id
let PRODUCT_CELL = "productCell"
let SEARCH_RESULT_CELL = "searchResultCell"
let MANAGE_REQUEST_CELL = "manageRequestCell"
let POST_REQUEST_CELL = "postRequestCell"
let MANAGE_ORDERS_CELL = "manageOrdersCell"






