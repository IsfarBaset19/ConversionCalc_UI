# ConversionCalc_UI

Homework #4 – Making ConversionCalc Pretty
CIS 357 – Fall 2020
Learning Objectives
● Practice with Auto Layout.
● Become familiar with the UIAppearance protocol.
● Become familiar with subclassing stock iOS user interface controls for styling
purposes.
Please work in pairs to complete this assignment.
Part A – Working With iOS Auto Layout
You are to add Auto Layout constraints to both of the scenes in your iOS version of the
ConversionCalc app. Use your final deliverable from HW #3 as the basis for this
assignment. If you did not complete HW #3 you can use the instructor’s solution . The
layouts are shown in Figure 1 below. Here are some specifics:
Calculator Screen:
● Make sure the text within the label is centered, and the from/to labels left aligned.
● Place the from text field and its associated units label in a horizontally oriented.
UIStackView. Set alignment to “fill” and distribution to “fill equally” and
spacing set to standard value.
● Place the to text field and its associated units label in a horizontally oriented.
UIStackView. Set alignment to “fill” and distribution to “fill equally” and
spacing set to standard value.
● Add the title label, to label, from label and two UIStackViews into a vertically
oriented UIStackView. Set alignment to “fill” and distribution to “fill equally”
and spacing set to standard value.
● Pin the outer UIStackView standard distance from the leading, trailing and top
edges. (you can assume standard distance is 8).
● Set the width of the calculate button so that it is a 1/4 the width of the container
view. Pin it standard distance from the leading edge of the scene, and its top edge
standard distance from the bottom of the UIStackView above it.
● Set the width of the mode button so that it is a 1/4 the width of the container view.
Pin it standard distance from the trailing edge of the scene, and its top edge
standard distance from the bottom of the UIStackView above it.
● Set the width of the clear button so that it is a 1/4 the width of the container view.
Center it horizontally and pin and its top edge standard distance from the bottom
of the UIStackView above it.
● Set the width of the settings button so that it is a 1/4 the width of the container
view. Pin it standard distance from the bottom edge of the scene and center it
horizontally.
Settings Screen:
● Place the two pairs of to/from labels into horizontal UIStackViews. Set alignment
to fill, and distribution to “fill equally” and spacing set to standard value.
● Nest the two horizontal UIStackViews into a vertical UIStackView with
alignment set to “fill” and distribution to “fill equally” and spacing set to standard
value.
● Pin the outer UIStackView standard distance from the leading, trailing and top
edges (assume standard distance = 8.
● Pin the height of the UIPickerView to an adequate size (100 should suffice), and
then pin it to the leading, trailing and bottom edges of the screen.
Run your app and double check your layout looks ok in both landscape and portrait
orientations. Then run it on a different size screen from what you did your layout, and
confirm everything still looks great. See Figure 2 below for how things should look
while running.
Figure 1. The screen layouts.
Figure 2. Run the app in different orientations and on different screen sizes and make sure your
layout constraints work.
Part B – Working With the UIAppearance / Customizing UIKit Classes
Before beginning this part of the assignment, select a dark background and light
foreground color of your choice, e.g. use the colors of your favorite sports team. At the
top of your AppDelegate.swift file define the colors in the form of two constants like this:
let BACKGROUND_COLOR = UIColor . init (red:0.000, green:0.369, blue:0.420,
alpha:1.00) // Blueish
let FOREGROUND_COLOR = UIColor . init (red: 0.937, green: 0.820,
blue: 0.576, alpha: 1.0) // Tannish
You can google around a find color picker tools that generate either Swift or Objective-C
code (which will be easy for you to convert into Swift of the form above). You will
reference these constants throughout the rest of the assignment below.
Using UIAppearance Protocol
As was demonstrated in lecture, use the UIAppearance protocol to change all
UINavigationBars in your app to use your chosen background and foreground color.
There is only one UINavigationBar in your app at the moment (e.g. Settings screen) but if
we add more in the future the new nav bars will automatically adopt the color scheme
you have chosen.
Styling via Subclassing
For the calculator screen only, make the following customizations.
Introduce a custom UITextField named ConversionCalcTextField by subclassing
DecimalMinusTextField. This class will be used on the calculator view, and will tweak
the following styling characterics of UITextField:
● Set the foreground to FOREGROUND_COLOR.
● Set the background color so its transparent – e.g. the color of the view it is placed
upon will bleed through.
● Set the color of any placeholder text to FOREGROUND_COLOR.
● Set a 1 point border with rounded corners that is also set to
FOREGROUND_COLOR.
● Set the color of any entered text to FOREGROUND_COLOR.
Introduce a custom UILabel named ConversionCalcLabel by subclassing UILabel. The
class will be used on the main calculator view only, and will tweak the following styling
characteristic of UILabel.
● Set the foreground color of the label to FOREGROUND_COLOR.
Introduce a custom UIButton named ConversionCalcButton by subclassing UIButton.
The class will be used on the main calculator view only, and will tweak the following
styling characteristics of UIButton.
● Set the background color of the button to FOREGROUND_COLOR.
● Set the foreground color of the button to BACKGROUND_COLOR.
● Round the corners of the button.
You are to use these stylized UI controls only on the calculator main screen. All controls
(other than the nav bar) on the settings screen should use default styling.
Finally, set the background of the main calculator view to BACKGROUND_COLOR.
Since it is the only controller that will have that color you can set this directly in the view
controller’s viewDidLoad() or in Interface Builder. If you did everything correctly your
new stylized calculator should look like that shown in Figure 3.
Figure 3. The final stylized screens.
Deliverables
To receive credit for your homework, you must:
● Push your solution to a github repository and post the URL to Canvas. If you
repo is private, be sure to grant the instructor read access (instructor’s github id:
jengelsma).
