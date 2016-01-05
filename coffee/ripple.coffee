#@todo need refactoring
$ ->
  $('
  <div style="height: 0; width: 0; position: absolute; visibility: hidden;" aria-hidden="true">
  <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" focusable="false">
    <symbol id="ripply-scott" viewBox="0 0 100 100">
      <circle id="ripple-shape" cx="1" cy="1" r="1"/>
    </symbol>
    </svg>
  </div>').prependTo 'body'

hoverRipple = new TimelineLite()
$(document).on 'mouseenter focusin', '.btn', (e)->
  hoverRipple.kill().clear()

  w = e.target.offsetWidth
  h = e.target.offsetHeight
  if e.offsetX? and e.offsetY?
    x = e.offsetX
    y = e.offsetY
  else
    x = w / 2
    y = h / 2
  offsetX = Math.abs((w / 2) - x)
  offsetY = Math.abs((h / 2) - y)
  deltaX = (w / 2) + offsetX
  deltaY = (h / 2) + offsetY
  scaleRatio = Math.sqrt(Math.pow(deltaX, 2) + Math.pow(deltaY, 2));

  hoverColor = $(this).css 'background-color'

  $twin = $('<div/>').addClass($(this).attr('class')).css(position: 'absolute', left: '-9000px').appendTo 'body'
  defaultColor = $twin.css 'background-color'
  activeColor = $twin.addClass('active').css 'background-color'
  $twin.remove()

  if $(this).find('.ripple-above').size() == 0
    $(this).wrapInner('<span class="ripple-above"/>')

  $(this).css position: 'relative', overflow: 'hidden'
  if !(e.type is 'focusin' and $(this).is(':hover'))
    $(this).css 'background-color', defaultColor

  $ripple = $(this).find '.ripple-obj'
  if $ripple.size() == 0
    $ripple = $('
      <svg class="ripple-obj">
        <use height="100" width="100" xlink:href="#ripply-scott" class="js-ripple"></use>
      </svg>').prependTo $(this)

  $ripple = $ripple.children()

  animationShift = '+=0'
  hoverRipple.set $ripple, {transformOrigin: '50% 50%', scale: 0, fill: hoverColor}
  if $(this).hasClass 'btn-raised'
    hoverRipple.to this, 0.3, {backgroundColor: activeColor}
    animationShift = '-=0.3'
  else
    hoverRipple
    .fromTo $ripple, 0.2,
      {x: x, y: y},
      {scale: scaleRatio, ease: Linear.easeOut, fill: activeColor}
    .set this, {backgroundColor: activeColor}

  hoverRipple
  .fromTo $ripple, 0.3,
    {x: w / 2 - 1, y: h / 2 - 1, scale: 0, fill: hoverColor, immediateRender: false},
    {scale: w / 2 * 0.85, ease: Linear.easein}, animationShift
  .add TweenMax.to $ripple, 1,
    scale: w / 2 * 0.75,
    ease: Linear.easeInOut,
    repeat: -1,
    yoyo: true,
    repeatDelay: 0.1

.on 'mouseleave focusout', '.btn', (e)->
  hoverRipple.kill()
  if e.type is 'mouseleave'
    $(this).blur()
  $(this).removeAttr('style').find('.ripple-obj').remove()

.on 'click touchstart', '.btn', (e)->
  hoverRipple.kill().clear()
  w = e.target.offsetWidth
  h = e.target.offsetHeight
  if e.offsetX? and e.offsetY? and e.offsetX != 0 and e.offsetY != 0
    x = e.offsetX
    y = e.offsetY
  else
    x = w / 2
    y = h / 2
  offsetX = Math.abs((w / 2) - x)
  offsetY = Math.abs((h / 2) - y)
  deltaX = (w / 2) + offsetX
  deltaY = (h / 2) + offsetY
  scaleRatio = Math.sqrt(Math.pow(deltaX, 2) + Math.pow(deltaY, 2));

  $twin = $('<div/>').addClass($(this).attr('class')).css(position: 'absolute', left: '-9000px').appendTo 'body'
  defaultColor = $twin.css 'background-color'
  hoverColor = $twin.addClass('focus').css 'background-color'
  activeColor = $twin.removeClass('focus').addClass('active').css 'background-color'
  $twin.remove()

  if $(this).find('.ripple-above').size() == 0
    $(this).wrapInner('<span class="ripple-above"/>')
  $(this).css position: 'relative', overflow: 'hidden', 'background-color': activeColor

  $ripple = $(this).find '.ripple-obj'
  if $ripple.size() == 0
    $ripple = $('
      <svg class="ripple-obj">
        <use height="100" width="100" xlink:href="#ripply-scott" class="js-ripple"></use>
      </svg>').prependTo $(this)

  $ripple = $ripple.children()
  if $(this).hasClass 'btn-raised'
    $ripple.css 'fill', '#fff'
  else
    $ripple.css 'fill', hoverColor

  TweenLite.fromTo($ripple, 0.4, {
    x: x,
    y: y,
    transformOrigin: '50% 50%',
    scale: 0,
    opacity: 1,
    ease: Linear.easeIn
  }, {
    scale: scaleRatio,
    opacity: 0
  });
  TweenLite.to($(this), 0.55, {backgroundColor: defaultColor, ease: Linear.easeIn})