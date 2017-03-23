# Playground-Work
iOS Features coded using Playgrounds on iPad :iphone:<br><br>

## Playgrounds

### AlertViewButtonTimer

  ###### Shows
   * How to operate an AlertViewController
   * Simple UIButton class to create a fancy button that shows the amount of time a user holds a button in a button animation
   * Use of BezierPath and CAShapeLayer to create a circular progress view
  
  ###### TODO's
   * Add _bounceable_ extension for animation when button is pressed
   * Add simple AlertViewController extension for displaying AlertViewControllers
  
  <br><br>
### Draggable Views

  ###### Shows
   * How to use UIPan and UITap Gestures to move a simple view around with a neat animation upon touch down and touch up
   * Use of Gestures and using translations to move views around based on their frame
   * That you cannot have selectors implemented only in extensions of protocols, as then it is not seen by Obj-C -> Crash
   * Creation of protocols using constratints and the _where_ keyword with _Self_ (not shown in code)
   * How to handle multiple gestures through the use of UIGestureRecognizerDelegate
   * Simple bounce and draggable extension on views to allow features defined by protocols
    
  ###### TODO's
   * Figure out whether _center_ property of view can be used to move view around


  <br><br>
### Async Image Downloading

  ###### Shows
   * How to asynchronously download an image given a URL path to an image
    
  ###### TODO's
   * Insert a UISlider to see the effects of downloading an image synchronously vs asynchronously
