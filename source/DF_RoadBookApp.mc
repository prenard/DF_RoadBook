using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Activity as Act;

class DF_RoadBookApp extends App.AppBase
{
	var WayPoint_Array;
	var WayPoint_Number;
	var Device_Type;
			
    function initialize()
    {
       AppBase.initialize();

	   Device_Type = Ui.loadResource(Rez.Strings.Device);
	   
       if (Device_Type.equals("edge_820"))
       {
			WayPoint_Array = new [50];
	   } else
       if (Device_Type.equals("edge_1000"))
       {
			WayPoint_Array = new [50];
	   }
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

		Generate_Waypoint_Array(Args,0);		

        return [ new DF_RoadBookView() ];
    }

    function onSettingsChanged()
    {
		System.println("onSettingsChanged() has been called");

		var Args = new [3];
		
		Args[0] = getProperty("DF_Title");
		Args[1] = getProperty("Set_RoadBook_Starting_Point");
		Args[2] = getProperty("WayPoints_List");
		
		var elapse_distance;

		if (Args[1])
		{
			System.println("Distance = " + Act.getActivityInfo().elapsedDistance);
		
			elapse_distance = Act.getActivityInfo().elapsedDistance;
		
			if (elapse_distance == null)
			{
				elapse_distance = 0;
			}
		
			elapse_distance = elapse_distance / 1000;
			if (System.getDeviceSettings().distanceUnits == System.UNIT_STATUTE)
			{
				var km_mi_conv = 0.621371;
				elapse_distance = elapse_distance * km_mi_conv;
			}
    	}
    	else
    	{
    		elapse_distance = 0;
    	}

		Generate_Waypoint_Array(Args,elapse_distance);

	}

    function Generate_Waypoint_Array(Args,start_elapse_distance)
    {
		var DF_Title, Set_RoadBook_Starting_Point_Flag, WayPoints_List;

		DF_Title = Args[0];
		Set_RoadBook_Starting_Point_Flag = Args[1];		
		WayPoints_List = Args[2];

		for( var i = 0; i < WayPoint_Array.size(); i += 1 )
		{
    		WayPoint_Array[i] = new [2];
		}

		//System.println("WayPoints List = " + WayPoints_List);

		WayPoint_Number = 0;
		
		while (WayPoints_List.find(";") != null)
		{
			// System.println("WP Number = " + WayPoint_Number);
			// System.println(WayPoints_List);
			// System.println(WayPoints_List.find(";"));
			var WayPoint =  WayPoints_List.substring(0, WayPoints_List.find(";"));
			// System.println("WayPoint = " + WayPoint);
			WayPoint_Array[WayPoint_Number] = [WayPoint.substring(0,WayPoint.find(",")).toNumber() + start_elapse_distance,WayPoint.substring(WayPoint.find(",")+1,WayPoint.length())];
			WayPoint_Number++;
			WayPoints_List = WayPoints_List.substring(WayPoints_List.find(";")+1, WayPoints_List.length());
		}

		//System.println(WayPoint_Number);
		
		
		for (var i = 0; i < WayPoint_Number; ++i)
        {
			System.println(WayPoint_Array[i][0]);
			System.println(WayPoint_Array[i][1]);
		}
		
	}


}