using Toybox.WatchUi;

class gugukDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new gugukMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}