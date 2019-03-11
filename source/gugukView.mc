using Toybox.WatchUi;
using Toybox.Attention;
using Toybox.Timer; 


class gugukView extends WatchUi.View {

	var currentHour=-1; 
	
	
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
        var myTimer = new Timer.Timer();
    	myTimer.start(method(:timerCallback), 1000, true);
    }

//12-24 olayı düşünülecek. 
//Çalışmaması istenen saat aralığı setting olarak alınacak. 
//Şiddet sevitesi ayarlardan aldırılabilir. 
	function timerCallback() {
	    
	    var clockTime = System.getClockTime();
        
        //0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23       
        var remainder = clockTime.hour % 6; //0 kısa
        var quotient = (clockTime.hour - remainder) / 4; //uzun 
        
        
        if(currentHour!=clockTime.hour && clockTime.min==0) {
        	currentHour=clockTime.hour;
        	vibrateLong(quotient);
        	vibrateShort(remainder);
        	if(remainder==0 && quotient==0){
        		vibrateLong(4);
        	}
        }
        
        if(clockTime.min==30){
        	vibrateShort(remainder);
        }
	    
	}

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	// Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
    
    function vibrateLong(n) {
    	var vibeData = new [2];
    	if(Attention has :vibrate){
  			vibeData =  [   
  			new Attention.VibeProfile(50, 2500),
  			new Attention.VibeProfile(0, 500)  
  			];
		}
		for(var i=0; i<n; i++){
    			Attention.vibrate(vibeData);
    	}
    }
    
    function vibrateShort(n) {
    	var vibeData = new [2];
    	if(Attention has :vibrate){
  			vibeData =  [   
  			new Attention.VibeProfile(75, 500),
  			new Attention.VibeProfile(0, 500) 
  			];
		}
		for(var i=0; i<n; i++){
    			Attention.vibrate(vibeData);
    	}
	}

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
