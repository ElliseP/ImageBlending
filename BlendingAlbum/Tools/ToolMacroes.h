//
//  ToolMacroes.h
//  iOS_Demo
//
//  Created by Ellise on 16/7/5.
//  Copyright © 2016年 ellise. All rights reserved.
//

#ifndef ToolMacroes_h
#define ToolMacroes_h

#define WS(weakobj,obj)  __weak __typeof(&*obj)weakobj = obj
#define kSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT	[UIScreen mainScreen].bounds.size.height
#define kScreenBounds   [UIScreen mainScreen].bounds

#define TheAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define CurrentController [TheAppDelegate currentController]
#define CurrentNavigationController [CurrentController navigationController]

#endif /* ToolMacroes_h */
