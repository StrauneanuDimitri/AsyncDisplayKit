//
//  Utilities.m
//  Sample
//
//  Copyright (c) 2014-present, Facebook, Inc.  All rights reserved.
//  This source code is licensed under the BSD-style license found in the
//  LICENSE file in the root directory of this source tree. An additional grant
//  of patent rights can be found in the PATENTS file in the same directory.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//  FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
//  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "Utilities.h"
#import <UIKit/UIKit.h>

#define StrokeRoundedImages 0

@implementation UIColor (Additions)

+ (UIColor *)darkBlueColor
{
  return [UIColor colorWithRed:18.0/255.0 green:86.0/255.0 blue:136.0/255.0 alpha:1.0];
}

+ (UIColor *)lightBlueColor
{
  return [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
}

+ (UIColor *)duskColor
{
  return [UIColor colorWithRed:255/255.0 green:181/255.0 blue:68/255.0 alpha:1];
}

+ (UIColor *)customOrangeColor
{
  return [UIColor colorWithRed:40/255.0 green:43/255.0 blue:53/255.0 alpha:1.0];
}


@end

@implementation UIImage (Additions)

- (UIImage *)makeCircularImageWithSize:(CGSize)size withBorderWidth:(CGFloat)width
{
  // make a CGRect with the image's size
  CGRect circleRect = (CGRect) {CGPointZero, size};
  
  // begin the image context since we're not in a drawRect:
  UIGraphicsBeginImageContextWithOptions(circleRect.size, NO, 0);
  
  // create a UIBezierPath circle
  UIBezierPath *circle = [UIBezierPath bezierPathWithRoundedRect:circleRect cornerRadius:circleRect.size.width/2];
  
  // clip to the circle
  [circle addClip];
  
  [[UIColor whiteColor] set];
  [circle fill];
  
  // draw the image in the circleRect *AFTER* the context is clipped
  [self drawInRect:circleRect];
  
  // create a border (for white background pictures)
  if (width > 0) {
    circle.lineWidth = width;
    [[UIColor whiteColor] set];
    [circle stroke];
  }
  
  // get an image from the image context
  UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
  
  // end the image context since we're not in a drawRect:
  UIGraphicsEndImageContext();
  
  return roundedImage;
}

@end

@implementation NSAttributedString (Additions)

+ (NSAttributedString *)attributedStringWithString:(NSString *)string fontSize:(CGFloat)size
                                             color:(nullable UIColor *)color firstWordColor:(nullable UIColor *)firstWordColor
{
  NSDictionary *attributes                    = @{NSForegroundColorAttributeName: color ? : [UIColor blackColor],
                                                  NSFontAttributeName: [UIFont boldSystemFontOfSize:size]};
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
  [attributedString addAttributes:attributes range:NSMakeRange(0, string.length)];
  
  if (firstWordColor) {
    NSRange firstSpaceRange = [string rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    NSRange firstWordRange  = NSMakeRange(0, firstSpaceRange.location);
    [attributedString addAttribute:NSForegroundColorAttributeName value:firstWordColor range:firstWordRange];
  }
  
  return attributedString;
}

@end