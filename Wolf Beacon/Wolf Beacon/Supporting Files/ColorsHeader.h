//
//  ColorsHeader.h
//  Digital Dhobi
//
//  Created by Avikant Saini on 12/8/16.
//  Copyright © 2016 darkarmy. All rights reserved.
//

#ifndef ColorsHeader_h
#define ColorsHeader_h

#define UIColorFromRGBWithAlpha(rgbValue, a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define COLOR_PRIMARY_BLUE	UIColorFromRGBWithAlpha(0x3399ff, 1.f)
#define COLOR_LIGHT_BLUE	UIColorFromRGBWithAlpha(0x84ffff, 1.f)
#define COLOR_DARK_BLUE		UIColorFromRGBWithAlpha(0x0d4173, 1.f)
#define COLOR_GRAY_1		UIColorFromRGBWithAlpha(0x93a6b8, 1.f)
#define COLOR_GRAY_2		UIColorFromRGBWithAlpha(0x8cd2db, 1.f)
#define COLOR_TEXT_COLOR_1	UIColorFromRGBWithAlpha(0x212121, 1.f)
#define COLOR_TEXT_COLOR_2	UIColorFromRGBWithAlpha(0x546e7a, 1.f)
#define COLOR_GREEN			UIColorFromRGBWithAlpha(0xdce775, 1.f)
#define COLOR_YELLOW		UIColorFromRGBWithAlpha(0xffee58, 1.f)
#define COLOR_SUCCESS		UIColorFromRGBWithAlpha(0x00a650, 1.f)
#define COLOR_FAILURE		UIColorFromRGBWithAlpha(0xe65100, 1.f)

#define GLOBAL_BACK_COLOR UIColorFromRGBWithAlpha(0xececec, 1.f)
#define GLOBAL_TINT_COLOR UIColorFromRGBWithAlpha(0x2d660d, 1.f)


#endif /* ColorsHeader_h */
