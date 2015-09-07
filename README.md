## This is the documentation for 2D ad 3D Fli(a)p view. This documentation describes and explains the usage of this library to add cool effect to your application.


![alt text][JKFlippingViewDemo]


### 2D Effect
You can add 2D flipping view to your application by initializing 2D `JKFlippingView` as follows.

```obj-c
JKFlippingView* flippingView2D = [[JKFlippingView alloc] init2DFlapWithPosition:JKFlapOpening2DPositionTopLeft and2DModeFlapOpeningDirection:JKFlapOpening2DDirectionClockwise andFlipviewSize:CGSizeMake(150.0f, 150.0f)];

```

Where,
`2DFlapWithPosition` is the flap position around which 2D flap will rotate in 2-Dimensional plane. It's possible values are as follow,
* JKFlapOpening2DPositionTopLeft,
* JKFlapOpening2DPositionBottomLeft,
* JKFlapOpening2DPositionBottomRight,
* JKFlapOpening2DPositionTopRight

As name suggests for each position, there are four corner point positions around which 2D view will rotate.

`2DModeFlapOpeningDirection` is the direction in which 2D view will rotate around designated corner point. Possible values are,
* JKFlapOpening2DDirectionClockwise
* JKFlapOpening2DDirectionAnticlockwise

`FlipviewSize` is the size of flip view which you are going to add to current view in the app. It's of type CGSize and user can specify any value to which view will be made to bound in initialization block

### 3D Effect
You can add 3D flipping view to your application by initializing 3D `JKFlippingView` as follows.
```obj-c
JKFlippingView* flippingView3D = [[JKFlippingView alloc] init3DFlapWithOpeningMode:JKFlapOpeningMode3DTop andFlipviewSize:CGSizeMake(150.0f, 150.0f)];
```
Where,
`3DFlapWithOpeningMode` is the edge from where 3D flap will open. There are following possible values for this parameter.
* JKFlapOpeningMode3DTop
* JKFlapOpeningMode3DLeft
* JKFlapOpeningMode3DBottom
* JKFlapOpeningMode3DRight

`FlipviewSize` - As mentioned earlier this is the parameter which specifies the size of 3D flipping overlay being added to the view.

There are other parameters as follows:

* `UIImage* overlayBackgroundImage` - An overlay image that can be added as a background to flip view in the current context
* `JKBlurredImageEffect blurredImageEffectValue` - Blurred background effect to flip view. There are 4 possible values to this parameter as follows:
1. `JKBlurredImageEffectNone` - No background blurred image is added. Rather transparent black colored background is added to the overlay view
2. `JKBlurredImageEffectSpotlight` - Spotlight kind of effect is added to the background
3. `JKBlurredImageEffectBlack` - Black fading effect is added
4. `JKBlurredImageEffectColorful` - Colorful rainbow like pleasant view is added
5. `JKBlurredImageEffectBlue` - Blurred blue color is added as a background color to flip view

* `CGFloat flapOpeningAngle` - Value which decides by what angle flipping view is going to rotate on touch events. (Applicable for both 2D and 3D animations)
* `CGFloat flapOverlayViewAlpha` - Decides alpha value of the flap overlay. Defaults to 0.5
* `CGFloat animationDuration` - Decides the animation of flip view. Whether flap opens or closes back.
* `NSString* overlayLabelTextValue` - Guess what? You can add text to overlay too. Just specify this value. Overlay supports multiline text. Just make sure Flip view is large enough to accommodate lengthy text.
* `AHEasingFunction flipAnimationEasingFunction`  - Variety of easing functions provided by Easing library at https://github.com/warrenm/AHEasing


---

In addition to these properties, there are also delegates that can be used to notify beginning end ending of animation. They are as follows :

`- (void)flipAnimationEnded`- 
Indicates flipping animation has just begun

`- (void)flipAnimationBegan` - 
Indicates flipping animation has just ended


## Workaround while working with Autolayouts
The library is designed the way that it is not mandatory for user to specify view size and position during initialization. If you are using autolayout, make sure you set `translatesAutoresizingMaskIntoConstraints` to `NO` for initialized Flip View just so you can lay it in the view hierarchy using auto layouts. 

It will all be taken care of by auto layout system. However, some parts of this view are constructed using `CALayer` components which does not support Auto layout at all. Thus you can call following method after overriding `viewDidLayoutSubviews` which will take care of laying out position and sizes of subLayers once auto layout mechanism has placed all views in position. You can safely initialize size of the FlipView as `CGSizeZero` in case auto layout is being used

``` 
- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	[flippingView updateSize];
}
```
Method `updateSize` will resize label and underlying `CALayers` to match with final flippingView size.

*Note* - Demo has been added to the library for more clarity. It has demonstrated both 2D and 3D flip views and their usage. Kindly let me know if you are having issues on how to use it or find any bugs/ways to improve it. As always, Suggestion/comment/criticisms are welcome.

[JKFlippingViewDemo]: https://github.com/jayesh15111988/JKFlapView/blob/master/demo/FlipViewDemoVideo.gif "Flipping View in action"
