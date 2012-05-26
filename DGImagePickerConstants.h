//
//  DGImagePickerConstants.h
//  minube
//
//  Created by Daniel García on 26/05/12.
//  Copyright (c) 2012 minube.com. All rights reserved.
//

#ifndef minube_DGImagePickerConstants_h
#define minube_DGImagePickerConstants_h


#endif


#if DEBUG
    #define DebugLog(s,...)     NSLog(@"[%04d-%@", __LINE__ , [NSString stringWithFormat:@"%@] %@", NSStringFromClass([self class]), [NSString stringWithFormat:s, ##__VA_ARGS__]])
    #define LogMethod()         DebugLog(@"%@", NSStringFromSelector(_cmd))
    #define LogFrame(f)         DebugLog(@"Frame origin-x: %f origin-y: %f size-width: %f size-height:%f", f.origin.x, f.origin.y, f.size.width, f.size.height)
    #define LogSize(s)          DebugLog(@"Size width: %f height: %f", s.width, s.height)
    #define LogObject(o)        DebugLog(@"%@",o);
#else
    #define DebugLog(s,...)    // do nothing.
    #define LogMethod()
    #define LogFrame(f)
    #define LogSize(s)     
    #define LogObject(o)
#endif