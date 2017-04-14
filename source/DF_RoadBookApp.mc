using Toybox.Application as App;

class DF_RoadBookApp extends App.AppBase
{

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
		var Args = new [2];
		
		Args[0] = getProperty("DF_Title");
		Args[1] = getProperty("WayPoints_List");
		
        return [ new DF_RoadBookView(Args) ];
    }

}