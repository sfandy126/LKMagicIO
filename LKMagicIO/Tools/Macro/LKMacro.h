//
//  LKMacro.h
//  LKMagicIO
//
//  Created by LK on 2019/12/2.
//  Copyright © 2019 LK. All rights reserved.
//

#ifndef LKMacro_h
#define LKMacro_h

#define LKScreenSize ([UIScreen mainScreen].bounds.size)

#define LKFont(size) ([UIFont systemFontOfSize:size])
#define LKBFont(size) ([UIFont boldSystemFontOfSize:size])
#define LKScaleRatio      ([[UIScreen mainScreen] bounds].size.width/375.f)

#define LKSystemVersion ([UIDevice currentDevice].systemVersion.floatValue)

#define iSIPHONE_X (\({BOOL isPhoneX = NO;\
    if (@available(iOS11.0, *)) {\
        isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom >0.0;\
    }\
    (isPhoneX);})\)

#define LKTabBarHeight (iSIPHONE_X ? 83.0 :49.0)
#define LKStatusbarHeight (iSIPHONE_X ?44:20)
#define LKNavigationBarHeight (iSIPHONE_X ?88:64)
#define LKSafeAreaBottom (iSIPHONE_X ?34:0)

#define LKWeakSelf(type)    __weak typeof(type) weak##type = type;
#define LKStrongSelf(type)  __strong typeof(type) type = weak##type;

#define LK_available(size) @available(iOS size, *)


#endif /* LKMacro_h */
