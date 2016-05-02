<html __fvdsurfcanyoninserted="1" wcxlastxpos="129" wcxlastypos="160" wcxlasttime="1462063324157" wcxdocid="1462063295745" wcxlastmousedownxpos="909" wcxlastmousedownypos="452" wcxlastmouseupxpos="909"><head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <title>Example: Website Top Nav Using Animation With Submenus Built From Markup (YUI Library)</title>

        <!-- Standard reset, fonts and grids -->

        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/reset-fonts-grids/reset-fonts-grids.css">


        <!-- CSS for Menu -->

        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/menu/assets/skins/sam/menu.css"> 


        <!-- Page-specific styles -->

        <style type="text/css">

            div.yui-b p {

                margin: 0 0 .5em 0;
                color: #999;

            }

            div.yui-b p strong {

                font-weight: bold;
                color: #000;

            }

            div.yui-b p em {

                color: #000;

            }            

            h1 {

                font-weight: bold;
                margin: 0 0 1em 0;
                padding: .25em .5em;
                background-color: #ccc;

            }

            #productsandservices {

                margin: 0 0 10px 0;

            }

        </style>


        <!-- Dependency source files -->

        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/yahoo-dom-event/yahoo-dom-event.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/animation/animation.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/container/container_core.js"></script>


        <!-- Menu source file -->

        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/menu/menu.js"></script>


        <!-- Page-specific script -->

        <script type="text/javascript">

            /*
             Initialize and render the MenuBar when its elements are ready 
             to be scripted.
             */

            YAHOO.util.Event.onContentReady("productsandservices", function () {

                var ua = YAHOO.env.ua,
                        oAnim;  // Animation instance


                /*
                 "beforeshow" event handler for each submenu of the MenuBar
                 instance, used to setup certain style properties before
                 the menu is animated.
                 */

                function onSubmenuBeforeShow(p_sType, p_sArgs) {

                    var oBody,
                            oElement,
                            oShadow,
                            oUL;


                    if (this.parent) {

                        oElement = this.element;

                        /*
                         Get a reference to the Menu's shadow element and 
                         set its "height" property to "0px" to syncronize 
                         it with the height of the Menu instance.
                         */

                        oShadow = oElement.lastChild;
                        oShadow.style.height = "0px";


                        /*
                         Stop the Animation instance if it is currently 
                         animating a Menu.
                         */

                        if (oAnim && oAnim.isAnimated()) {

                            oAnim.stop();
                            oAnim = null;

                        }


                        /*
                         Set the body element's "overflow" property to 
                         "hidden" to clip the display of its negatively 
                         positioned <ul> element.
                         */

                        oBody = this.body;


                        //  Check if the menu is a submenu of a submenu.

                        if (this.parent &&
                                !(this.parent instanceof YAHOO.widget.MenuBarItem)) {


                            /*
                             There is a bug in gecko-based browsers and Opera where 
                             an element whose "position" property is set to 
                             "absolute" and "overflow" property is set to 
                             "hidden" will not render at the correct width when
                             its offsetParent's "position" property is also 
                             set to "absolute."  It is possible to work around 
                             this bug by specifying a value for the width 
                             property in addition to overflow.
                             */

                            if (ua.gecko || ua.opera) {

                                oBody.style.width = oBody.clientWidth + "px";

                            }


                            /*
                             Set a width on the submenu to prevent its 
                             width from growing when the animation 
                             is complete.
                             */

                            if (ua.ie == 7) {

                                oElement.style.width = oElement.clientWidth + "px";

                            }

                        }


                        oBody.style.overflow = "hidden";


                        /*
                         Set the <ul> element's "marginTop" property 
                         to a negative value so that the Menu's height
                         collapses.
                         */

                        oUL = oBody.getElementsByTagName("ul")[0];

                        oUL.style.marginTop = ("-" + oUL.offsetHeight + "px");

                    }

                }


                /*
                 "tween" event handler for the Anim instance, used to 
                 syncronize the size and position of the Menu instance's 
                 shadow and iframe shim (if it exists) with its 
                 changing height.
                 */

                function onTween(p_sType, p_aArgs, p_oShadow) {

                    if (this.cfg.getProperty("iframe")) {

                        this.syncIframe();

                    }

                    if (p_oShadow) {

                        p_oShadow.style.height = this.element.offsetHeight + "px";

                    }

                }


                /*
                 "complete" event handler for the Anim instance, used to 
                 remove style properties that were animated so that the 
                 Menu instance can be displayed at its final height.
                 */

                function onAnimationComplete(p_sType, p_aArgs, p_oShadow) {

                    var oBody = this.body,
                            oUL = oBody.getElementsByTagName("ul")[0];

                    if (p_oShadow) {

                        p_oShadow.style.height = this.element.offsetHeight + "px";

                    }


                    oUL.style.marginTop = "";
                    oBody.style.overflow = "";


                    //  Check if the menu is a submenu of a submenu.

                    if (this.parent &&
                            !(this.parent instanceof YAHOO.widget.MenuBarItem)) {


                        // Clear widths set by the "beforeshow" event handler

                        if (ua.gecko || ua.opera) {

                            oBody.style.width = "";

                        }

                        if (ua.ie == 7) {

                            this.element.style.width = "";

                        }

                    }

                }


                /*
                 "show" event handler for each submenu of the MenuBar 
                 instance - used to kick off the animation of the 
                 <ul> element.
                 */

                function onSubmenuShow(p_sType, p_sArgs) {

                    var oElement,
                            oShadow,
                            oUL;

                    if (this.parent) {

                        oElement = this.element;
                        oShadow = oElement.lastChild;
                        oUL = this.body.getElementsByTagName("ul")[0];


                        /*
                         Animate the <ul> element's "marginTop" style 
                         property to a value of 0.
                         */

                        oAnim = new YAHOO.util.Anim(oUL,
                                {marginTop: {to: 0}},
                        .5, YAHOO.util.Easing.easeOut);


                        oAnim.onStart.subscribe(function () {

                            oShadow.style.height = "100%";

                        });


                        oAnim.animate();


                        /*
                         Subscribe to the Anim instance's "tween" event for 
                         IE to syncronize the size and position of a 
                         submenu's shadow and iframe shim (if it exists)  
                         with its changing height.
                         */

                        if (YAHOO.env.ua.ie) {

                            oShadow.style.height = oElement.offsetHeight + "px";


                            /*
                             Subscribe to the Anim instance's "tween"
                             event, passing a reference Menu's shadow 
                             element and making the scope of the event 
                             listener the Menu instance.
                             */

                            oAnim.onTween.subscribe(onTween, oShadow, this);

                        }


                        /*
                         Subscribe to the Anim instance's "complete" event,
                         passing a reference Menu's shadow element and making 
                         the scope of the event listener the Menu instance.
                         */

                        oAnim.onComplete.subscribe(onAnimationComplete, oShadow, this);

                    }

                }


                /*
                 Instantiate a MenuBar:  The first argument passed to the 
                 constructor is the id of the element in the page 
                 representing the MenuBar; the second is an object literal 
                 of configuration properties.
                 */

                var oMenuBar = new YAHOO.widget.MenuBar("productsandservices", {
                    autosubmenudisplay: true,
                    hidedelay: 750,
                    lazyload: true});


                /*
                 Subscribe to the "beforeShow" and "show" events for 
                 each submenu of the MenuBar instance.
                 */

                oMenuBar.subscribe("beforeShow", onSubmenuBeforeShow);
                oMenuBar.subscribe("show", onSubmenuShow);


                /*
                 Call the "render" method with no arguments since the 
                 markup for this MenuBar already exists in the page.
                 */

                oMenuBar.render();

            });

        </script>

    </head>
    <body class="yui-skin-sam" id="yahoo-com"><iframe id="_yuiResizeMonitor" title="Text Resize Monitor" tabindex="-1" role="presentation" style="position: absolute; visibility: visible; border-width: 0px; width: 2em; height: 2em; left: 0px; top: -27px; background-color: transparent;"></iframe>

        <div id="doc" class="yui-t1">
            <div id="hd">
                <!-- start: your content here -->

                <h1>Welcome to Ram Thoughts Ltd.</h1>

                <!-- end: your content here -->
            </div>
            <div id="bd">

                <!-- start: primary column from outer template -->
                <div id="yui-main">
                    <div class="yui-b">
                        <!-- start: stack grids here -->

                        <div id="productsandservices" class="yuimenubar yuimenubarnav yui-module yui-overlay visible" style="z-index: 0; position: static; display: block; visibility: visible;">
                            <div class="bd">
                                <ul class="first-of-type">
                                    <li class="yuimenubaritem first-of-type yuimenubaritem-hassubmenu" id="yui-gen0" groupindex="0" index="0"><a class="yuimenubaritemlabel yuimenubaritemlabel-hassubmenu" href="/services/aboutus">About us</a>



                                    </li>
                                    <li class="yuimenubaritem yuimenubaritem-hassubmenu" id="yui-gen1" groupindex="0" index="1"><a class="yuimenubaritemlabel yuimenubaritemlabel-hassubmenu" href="/services/services">Services</a>

                                        <div id="shopping" class="yuimenu yui-module yui-overlay yui-overlay-hidden" style="z-index: 1; position: absolute; visibility: hidden;">
                                            <div class="bd">                    
                                                <ul class="first-of-type">
                                                    <li class="yuimenuitem first-of-type" id="yui-gen4" groupindex="0" index="0"><a class="yuimenuitemlabel" href="/services/opt">Page Optimization</a></li>
                                                    <li class="yuimenuitem" id="yui-gen5" groupindex="0" index="1"><a class="yuimenuitemlabel" href="/services/adsense">Adsense Revenue Generation</a></li>
                                                    <li class="yuimenuitem" id="yui-gen6" groupindex="0" index="2"><a class="yuimenuitemlabel" href="/services/blog">Blogging</a></li>
                                                    <li class="yuimenuitem" id="yui-gen7" groupindex="0" index="3"><a class="yuimenuitemlabel" href="/services/html">HTML 5 Design</a></li>
                                                </ul>
                                            </div>
                                            <div class="yui-menu-shadow" style="height: 152px;"></div></div>                    

                                    </li>
                                    <li class="yuimenubaritem yuimenubaritem-hassubmenu" id="yui-gen2" groupindex="0" index="2"><a class="yuimenubaritemlabel yuimenubaritemlabel-hassubmenu" href="/services/tools">Tools</a>

                                        <div id="entertainment" class="yuimenu yui-module yui-overlay yui-overlay-hidden" style="z-index: 1; position: absolute; visibility: hidden;">
                                            <div class="bd">                    
                                                <ul class="first-of-type">
                                                    <li class="yuimenuitem first-of-type" id="yui-gen12" groupindex="0" index="0"><a class="yuimenuitemlabel" href="/services/facebook">Connect Facebook</a></li>
                                                    <li class="yuimenuitem" id="yui-gen13" groupindex="0" index="1"><a class="yuimenuitemlabel" href="/services/blogger">Auto Blogger</a></li>
                                                    <li class="yuimenuitem" id="yui-gen14" groupindex="0" index="2"><a class="yuimenuitemlabel" href="/services/broken">Broken Link Analysis</a></li>
                                                    <li class="yuimenuitem" id="yui-gen15" groupindex="0" index="3"><a class="yuimenuitemlabel" href="/services/dofollow">Do Follow Link Generator</a></li>
                                                    <li class="yuimenuitem" id="yui-gen16" groupindex="0" index="4"><a class="yuimenuitemlabel" href="/services/links">URL Link Analysis</a></li>
                                                    <li class="yuimenuitem" id="yui-gen17" groupindex="0" index="5"><a class="yuimenuitemlabel" href="/services/robotics">Robotics File Generator</a></li>
                                                    <li class="yuimenuitem" id="yui-gen18" groupindex="0" index="6"><a class="yuimenuitemlabel" href="/services/site">Site XML</a></li>
                                                </ul>                    
                                            </div>
                                            <div class="yui-menu-shadow" style="height: 152px;"></div></div>                                        

                                    </li>
                                    <li class="yuimenubaritem yuimenubaritem-hassubmenu" id="yui-gen3" groupindex="0" index="3"><a class="yuimenubaritemlabel yuimenubaritemlabel-hassubmenu" href="/services#information">Blogging</a>

                                        <div id="information" class="yuimenu yui-module yui-overlay yui-overlay-hidden" style="z-index: 1; position: absolute; visibility: hidden;">
                                            <div class="bd">                                        
                                                <ul class="first-of-type">
                                                    <li class="yuimenuitem first-of-type" id="yui-gen20" groupindex="0" index="0"><a class="yuimenuitemlabel" href="/serviceshttp://downloads.yahoo.com">Downloads</a></li>
                                                    <li class="yuimenuitem" id="yui-gen21" groupindex="0" index="1"><a class="yuimenuitemlabel" href="/serviceshttp://finance.yahoo.com">Finance</a></li>
                                                    <li class="yuimenuitem" id="yui-gen22" groupindex="0" index="2"><a class="yuimenuitemlabel" href="/serviceshttp://health.yahoo.com">Health</a></li>
                                                    <li class="yuimenuitem" id="yui-gen23" groupindex="0" index="3"><a class="yuimenuitemlabel" href="/serviceshttp://local.yahoo.com">Local</a></li>
                                                    <li class="yuimenuitem" id="yui-gen24" groupindex="0" index="4"><a class="yuimenuitemlabel" href="/serviceshttp://maps.yahoo.com">Maps &amp; Directions</a></li>
                                                    <li class="yuimenuitem" id="yui-gen25" groupindex="0" index="5"><a class="yuimenuitemlabel" href="/serviceshttp://my.yahoo.com">My Yahoo!</a></li>
                                                    <li class="yuimenuitem" id="yui-gen26" groupindex="0" index="6"><a class="yuimenuitemlabel" href="/serviceshttp://news.yahoo.com">News</a></li>
                                                    <li class="yuimenuitem" id="yui-gen27" groupindex="0" index="7"><a class="yuimenuitemlabel" href="/serviceshttp://search.yahoo.com">Search</a></li>
                                                    <li class="yuimenuitem" id="yui-gen28" groupindex="0" index="8"><a class="yuimenuitemlabel" href="/serviceshttp://smallbusiness.yahoo.com">Small Business</a></li>
                                                    <li class="yuimenuitem" id="yui-gen29" groupindex="0" index="9"><a class="yuimenuitemlabel" href="/serviceshttp://weather.yahoo.com">Weather</a></li>
                                                </ul>                    
                                            </div>
                                            <div class="yui-menu-shadow" style="height: 188px;"></div></div>                                        

                                    </li>
                                    <li class="yuimenubaritem yuimenubaritem-hassubmenu" id="yui-gen4" groupindex="0" index="3"><a class="yuimenubaritemlabel yuimenubaritemlabel-hassubmenu" href="/services#information">Contact US</a>

                                        <div id="information" class="yuimenu yui-module yui-overlay yui-overlay-hidden" style="z-index: 1; position: absolute; visibility: hidden;">
                                            <div class="bd">                                        
                                                <ul class="first-of-type">
                                                    <li class="yuimenuitem first-of-type" id="yui-gen20" groupindex="0" index="0"><a class="yuimenuitemlabel" href="/services/facebook">Facebook</a></li>
                                                    <li class="yuimenuitem" id="yui-gen21" groupindex="0" index="1"><a class="yuimenuitemlabel" href="/services/twitter">Twitter</a></li>
                                                    <li class="yuimenuitem" id="yui-gen22" groupindex="0" index="2"><a class="yuimenuitemlabel" href="/services/form">Contact Form</a></li>
                                                </ul>                    
                                            </div>
                                            <div class="yui-menu-shadow" style="height: 188px;"></div></div>                                        

                                    </li>
                                </ul>            
                            </div>
                        </div>




                        <p>B Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas sit amet metus. Nunc quam elit, posuere nec, auctor in, rhoncus quis, dui. Aliquam erat volutpat. Ut dignissim, massa sit amet dignissim cursus, quam lacus feugiat dolor, id aliquam leo tortor eget odio. Pellentesque orci arcu, eleifend at, iaculis sit amet, posuere eu, lorem. Aliquam erat volutpat. Phasellus vulputate. Vivamus id erat. Nulla facilisi. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Nunc gravida. Ut euismod, tortor eget convallis ullamcorper, arcu odio egestas pede, ut ornare urna elit vitae mauris. Aenean ullamcorper eros a lacus. Curabitur egestas tempus lectus. Donec et lectus et purus dapibus feugiat. Sed sit amet diam. Etiam ipsum leo, facilisis ac, rutrum nec, dignissim quis, tellus. Sed eleifend.</p>
                        <p>C Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas sit amet metus. Nunc quam elit, posuere nec, auctor in, rhoncus quis, dui. Aliquam erat volutpat. Ut dignissim, massa sit amet dignissim cursus, quam lacus feugiat dolor, id aliquam leo tortor eget odio. Pellentesque orci arcu, eleifend at, iaculis sit amet, posuere eu, lorem. Aliquam erat volutpat. Phasellus vulputate. Vivamus id erat. Nulla facilisi. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Nunc gravida. Ut euismod, tortor eget convallis ullamcorper, arcu odio egestas pede, ut ornare urna elit vitae mauris. Aenean ullamcorper eros a lacus. Curabitur egestas tempus lectus. Donec et lectus et purus dapibus feugiat. Sed sit amet diam. Etiam ipsum leo, facilisis ac, rutrum nec, dignissim quis, tellus. Sed eleifend.</p>

                        <!-- end: stack grids here -->
                    </div>
                </div>
                <!-- end: primary column from outer template -->

                <!-- start: secondary column from outer template -->
                <div class="yui-b">

                    <p>A Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas sit amet metus. Nunc quam elit, posuere nec, auctor in, rhoncus quis, dui. Aliquam erat volutpat. Ut dignissim, massa sit amet dignissim cursus, quam lacus feugiat dolor, id aliquam leo tortor eget odio. Pellentesque orci arcu, eleifend at, iaculis sit amet, posuere eu, lorem. Aliquam erat volutpat. Phasellus vulputate. Vivamus id erat. Nulla facilisi. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Nunc gravida. Ut euismod, tortor eget convallis ullamcorper, arcu odio egestas pede, ut ornare urna elit vitae mauris. Aenean ullamcorper eros a lacus. Curabitur egestas tempus lectus. Donec et lectus et purus dapibus feugiat. Sed sit amet diam. Etiam ipsum leo, facilisis ac, rutrum nec, dignissim quis, tellus. Sed eleifend.</p>

                </div>
                <!-- end: secondary column from outer template -->
            </div>
            <div id="ft">

                <p id="note"><strong>&reg;</strong> <em>Ramthoughts Ltd. copyrights reserved.</em></p>
            </div>
        </div>



    </body></html>