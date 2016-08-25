//
//  TMBGraphics.m
//  xcar
//
//  Created by 黄盼青 on 15/12/29.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import "TMBGraphics.h"


void CGContextAddRoundCornerToPath(CGContextRef context, CGRect rect, CGFloat cornerRadius)
{
    CGContextSaveGState(context);
    
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat midY = CGRectGetMidY(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    CGContextMoveToPoint(context, minX, midY);
    CGContextAddArcToPoint(context, minX, minY, midX, minY, cornerRadius);
    CGContextAddArcToPoint(context, maxX, minY, maxX, midY, cornerRadius);
    CGContextAddArcToPoint(context, maxX, maxY, midX, maxY, cornerRadius);
    CGContextAddArcToPoint(context, minX, maxY, minX, midY, cornerRadius);
    CGContextClosePath(context);
    
    CGContextRestoreGState(context);
}

void CGContextAddCircleRectToPath(CGContextRef context, CGRect rect)
{
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextSetShouldAntialias(context, true);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextAddEllipseInRect(context, rect);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

CGRect CGRectFromSize( CGSize size )
{
    return CGRectMake( 0, 0, size.width, size.height );
};

CGPoint CGRectGetCenter( CGRect rect )
{
    return CGPointMake( CGRectGetMidX( rect ), CGRectGetMidY( rect ) );
};

@implementation TMBGraphics

@end
