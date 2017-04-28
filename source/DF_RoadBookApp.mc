using Toybox.Application as App;

class DF_RoadBookApp extends App.AppBase
{
	var WayPoint_Array;
	
    function initialize()
    {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state)
    {
    }

    // onStop() is called when your application is exiting
    function onStop(state)
    {
    }

    //! Return the initial view of your application here
    function getInitialView()
    {
		var Args = new [3];
		
		Args[0] = getProperty("DF_Title");
		Args[1] = getProperty("Set_RoadBook_Starting_Point");
		Args[2] = getProperty("WayPoints_List");
		
        return [ new DF_RoadBookView(Args) ];
    }

    function onSettingsChanged()
    {
		System.println("onSettingsChanged() has been called");
    }

}