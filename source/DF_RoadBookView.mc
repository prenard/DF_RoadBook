using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class DF_RoadBookView extends Ui.DataField
{
	var app;
		
	var Max_Display_Line_Number = 0;
	var Font_Type;
	var X_Distance;
	var X_Comment;

    var Field_1_Description = null;
    var Field_1_Label_Field = null;
    var Field_1_Unit_Field = null;
    var Field_1_Unit = null;
    var Field_1_Value_Field = null;
    var Field_1_Value = 0;

    var Field_2_Description = null;
    var Field_2_Label_Field = null;
    var Field_2_Unit_Field = null;
    var Field_2_Unit = null;
    var Field_2_Value_Field = null;
    var Field_2_Value = 0;

    var Field_3_Description = null;
    var Field_3_Label_Field = null;
    var Field_3_Unit_Field = null;
    var Field_3_Unit = null;
    var Field_3_Value_Field = null;
    var Field_3_Value = 0;

    var Field_4_Description = null;
    var Field_4_Label_Field = null;
    var Field_4_Unit_Field = null;
    var Field_4_Unit = null;
    var Field_4_Value_Field = null;
    var Field_4_Value = 0;

    var Field_5_Description = null;
    var Field_5_Label_Field = null;
    var Field_5_Unit_Field = null;
    var Field_5_Unit = null;
    var Field_5_Value_Field = null;
    var Field_5_Value = 0;

	var WayPoint_Distance_Label_Field = null;
	var WayPoint_Distance_Unit_Field = null;
	var WayPoint_Distance_Unit = null;
	var WayPoint_Comment_Label_Field = null;

    var Time_Value = 0;
    var Timer_Value = 0;
    var Distance_Value = 0;
    var TimeOfDay_Value = "";
    var TimeOfDay_Meridiem_Value = "";
    var Power_AVG_Duration = 0;
    var Power_AVG_Value = 0;
	var Power_History;
	var Power_Sum_Of_Samples;
	var Power_Next_Sample_Idx;
	var Power_Number_Of_Samples;

    var HeartRate_Value = 0;
    var Cadence_Value = 0;

	var First_Line_Y = 0;
	var Line_Height = 0;
	var Line_Separator_Y = 0;

    function initialize()
    {
    	DataField.initialize();

    	app = App.getApp();
       
		if (app.deviceFamily.equals("rectangle-200x265"))
       // edge_820    
       	{
       		Line_Separator_Y = 81;
			First_Line_Y = 95;

       		Max_Display_Line_Number = 5;
			Font_Type = Gfx.FONT_LARGE;
			Line_Height = 30;
			X_Distance = 45;
			X_Comment = 50;
	   	}
		else
		if (app.deviceFamily.equals("rectangle-246x322"))
		// edge_530
		// edge_830
		// edge_840
       	{
       		Line_Separator_Y = 93;
			First_Line_Y = 100;

       		Max_Display_Line_Number = 7;
			Font_Type = Gfx.FONT_LARGE;
			Line_Height = 30;
			X_Distance = 55;
			X_Comment = 60;
	   	}
		else
		if (app.deviceFamily.equals("rectangle-240x400"))
       	// edge_1000
       	{
       		Line_Separator_Y = 93;
			First_Line_Y = 105;
	
	       	Max_Display_Line_Number = 9;
			Font_Type = Gfx.FONT_LARGE;
			Line_Height = 30;
			X_Distance = 45;
			X_Comment = 50;
	   	}
	   	else
		if (app.deviceFamily.equals("rectangle-282x470"))
       	// edge_1030
       	{
       		Line_Separator_Y = 105;
			First_Line_Y = 115;

       		Max_Display_Line_Number = 9;
			Font_Type = Gfx.FONT_LARGE;
			Line_Height = 35;
			X_Distance = 60;
			X_Comment = 65;
	   }

		//app.Generate_Waypoint_Array(Args);
	    
	    Power_AVG_Duration = 3;

		Power_Next_Sample_Idx = 0;
		Power_Sum_Of_Samples = 0;
		Power_Number_Of_Samples = 1;

        Power_History = new[Power_AVG_Duration];
		for (var i = 0; i < Power_History.size(); ++i)
        	{
				Power_History [i] = 0;
			}
	    
    	Field_1_Description = "Distance";
    	Field_2_Description = "Time";
    	Field_3_Description = "Power Average";
    	Field_4_Description = "Heart Rate";
    	Field_5_Description = "Cadence";

    }


    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc)
    {

    	View.setLayout(Rez.Layouts.MainLayout(dc));

   	    var Label;

   		WayPoint_Distance_Unit_Field = View.findDrawableById("WayPoint_Distance_Unit");
  		Label = "Dist:";
		if (System.getDeviceSettings().distanceUnits == System.UNIT_METRIC)
		{
			WayPoint_Distance_Unit = "km";
		}
		else
		{
			WayPoint_Distance_Unit = "mi";
		}
		WayPoint_Distance_Unit_Field.setText(WayPoint_Distance_Unit);
		WayPoint_Comment_Label_Field = View.findDrawableById("WayPoint_Comment_Label");
		Label = "Comment";
		WayPoint_Comment_Label_Field.setText(Label);

    	Field_1_Label_Field = View.findDrawableById("Field_1_Label");
    	Field_1_Unit_Field = View.findDrawableById("Field_1_Unit");
    	Field_1_Value_Field = View.findDrawableById("Field_1_Value");

		if (Field_1_Description.equals("Distance"))
		{
	  	    Label = "Dist:";
   		    Field_1_Label_Field.setText(Label);

			if (System.getDeviceSettings().distanceUnits == System.UNIT_METRIC)
			{
				Field_1_Unit = "km";
			}
			else
			{
				Field_1_Unit = "mi";
			}

			Field_1_Unit_Field.setText(Field_1_Unit);
		}   	    

    	Field_2_Label_Field = View.findDrawableById("Field_2_Label");
    	Field_2_Unit_Field = View.findDrawableById("Field_2_Unit");
    	Field_2_Value_Field = View.findDrawableById("Field_2_Value");

		if (Field_2_Description.equals("Time"))
		{
	  	    Label = "Time:";
   		    Field_2_Label_Field.setText(Label);
        	Field_2_Unit = "";
			Field_2_Unit_Field.setText(Field_2_Unit);
		}   	    

    	Field_3_Label_Field = View.findDrawableById("Field_3_Label");
    	Field_3_Unit_Field = View.findDrawableById("Field_3_Unit");
    	Field_3_Value_Field = View.findDrawableById("Field_3_Value");
 
		if (Field_3_Description.equals("Power Average"))
		{
	  	    Label = "PWR AVG " + Power_AVG_Duration +"s:";
   		    Field_3_Label_Field.setText(Label);
        	Field_3_Unit = "W";
			Field_3_Unit_Field.setText(Field_3_Unit);
		}   	    

    	Field_4_Label_Field = View.findDrawableById("Field_4_Label");
    	Field_4_Unit_Field = View.findDrawableById("Field_4_Unit");
    	Field_4_Value_Field = View.findDrawableById("Field_4_Value");
 
		if (Field_4_Description.equals("Heart Rate"))
		{
	  	    Label = "HR:";
   		    Field_4_Label_Field.setText(Label);
        	Field_4_Unit = "bpm";
			Field_4_Unit_Field.setText(Field_4_Unit);
		}   	    

    	Field_5_Label_Field = View.findDrawableById("Field_5_Label");
    	Field_5_Unit_Field = View.findDrawableById("Field_5_Unit");
    	Field_5_Value_Field = View.findDrawableById("Field_5_Value");

		if (Field_5_Description.equals("Cadence"))
		{
	  	    Label = "Cadence:";
   		    Field_5_Label_Field.setText(Label);
        	Field_5_Unit = "rpm";
			Field_5_Unit_Field.setText(Field_5_Unit);
		}   	    

        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_BLUE );
		dc.drawText(1, 50, Gfx.FONT_MEDIUM, "Test", Gfx.TEXT_JUSTIFY_LEFT);

        return true;
    }

    // The given info object contains all the current workout
    // information. Calculate a value and save it locally in this method.
    function compute(info)
    {
        if( (info.elapsedDistance != null))
        {
			Distance_Value = info.elapsedDistance / 1000;
			if (System.getDeviceSettings().distanceUnits == System.UNIT_STATUTE)
			 {
				var km_mi_conv = 0.621371;
				Distance_Value = Distance_Value * km_mi_conv;
			 }
        }

		if( info.elapsedTime != null )
            {
                Time_Value = TimeFormat(info.elapsedTime);
            }

		if( info.currentPower != null )
            {

				// subtract the oldest sample from our moving sum
				Power_Sum_Of_Samples -= Power_History [Power_Next_Sample_Idx];

				Power_History [Power_Next_Sample_Idx] = info.currentPower;

				// add the newest sample to our moving sum
				Power_Sum_Of_Samples += Power_History [Power_Next_Sample_Idx];

				// keep track of how many samples we've accrued
				if (Power_Number_Of_Samples < Power_History.size())
					{
						++Power_Number_Of_Samples;
					}
					else
					{
						Power_AVG_Value = Power_Sum_Of_Samples / Power_AVG_Duration;
					}

				// advance to the next sample, and wrap around to the beginning
				Power_Next_Sample_Idx = (Power_Next_Sample_Idx + 1) % Power_History.size();

            }

		if( info.currentHeartRate != null )
            {
                HeartRate_Value = info.currentHeartRate;
            }

		if( info.currentCadence != null )
            {
                Cadence_Value = info.currentCadence;
            }

    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc)
    {

        // Set the background color
        View.findDrawableById("Background").setColor(getBackgroundColor());

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);

        // Set the foreground color and value

        if (getBackgroundColor() == Gfx.COLOR_BLACK)
        {
            Field_1_Label_Field.setColor(Gfx.COLOR_WHITE);
            Field_1_Unit_Field.setColor(Gfx.COLOR_WHITE);
            Field_1_Value_Field.setColor(Gfx.COLOR_WHITE);

            Field_2_Label_Field.setColor(Gfx.COLOR_WHITE);
            Field_2_Unit_Field.setColor(Gfx.COLOR_WHITE);
            Field_2_Value_Field.setColor(Gfx.COLOR_WHITE);

            Field_3_Label_Field.setColor(Gfx.COLOR_WHITE);
            Field_3_Unit_Field.setColor(Gfx.COLOR_WHITE);
            Field_3_Value_Field.setColor(Gfx.COLOR_WHITE);

            Field_4_Label_Field.setColor(Gfx.COLOR_WHITE);
            Field_4_Unit_Field.setColor(Gfx.COLOR_WHITE);
            Field_4_Value_Field.setColor(Gfx.COLOR_WHITE);

            Field_5_Label_Field.setColor(Gfx.COLOR_WHITE);
            Field_5_Unit_Field.setColor(Gfx.COLOR_WHITE);
            Field_5_Value_Field.setColor(Gfx.COLOR_WHITE);
        }
        else
        {
            Field_1_Label_Field.setColor(Gfx.COLOR_BLACK);
            Field_1_Unit_Field.setColor(Gfx.COLOR_BLACK);
            Field_1_Value_Field.setColor(Gfx.COLOR_BLACK);

            Field_2_Label_Field.setColor(Gfx.COLOR_BLACK);
            Field_2_Unit_Field.setColor(Gfx.COLOR_BLACK);
            Field_2_Value_Field.setColor(Gfx.COLOR_BLACK);

            Field_3_Label_Field.setColor(Gfx.COLOR_BLACK);
            Field_3_Unit_Field.setColor(Gfx.COLOR_BLACK);
            Field_3_Value_Field.setColor(Gfx.COLOR_BLACK);

            Field_4_Label_Field.setColor(Gfx.COLOR_BLACK);
            Field_4_Unit_Field.setColor(Gfx.COLOR_BLACK);
            Field_4_Value_Field.setColor(Gfx.COLOR_BLACK);

            Field_5_Label_Field.setColor(Gfx.COLOR_BLACK);
            Field_5_Unit_Field.setColor(Gfx.COLOR_BLACK);
            Field_5_Value_Field.setColor(Gfx.COLOR_BLACK);
        }

		//Distance_Value = 999.9;
		//Distance_Value = 0;
		//Power_AVG_Value = 1999;
		//HeartRate_Value = 199;
		//Cadence_Value = 199;
				
		if (Field_1_Description.equals("Distance"))
		{
			Field_1_Value_Field.setText(Distance_Value.format("%.1f").toString());
		}
	
		if (Field_2_Description.equals("Time"))
		{
			Field_2_Value_Field.setText(Time_Value);
		}

		if (Field_3_Description.equals("Power Average"))
		{
			Field_3_Value_Field.setText(Power_AVG_Value.toString());
		}

		if (Field_4_Description.equals("Heart Rate"))
		{
			Field_4_Value_Field.setText(HeartRate_Value.toString());
		}

		if (Field_5_Description.equals("Cadence"))
		{
			Field_5_Value_Field.setText(Cadence_Value.toString());
		}

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);

        if (getBackgroundColor() == Gfx.COLOR_BLACK)
        {
        	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        }
		else
        {
        	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        }

        //dc.setColor( Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT );
        dc.drawLine(0, Line_Separator_Y, System.getDeviceSettings().screenWidth, Line_Separator_Y);

		//System.println("Before Display");
			
		var WayPoint_Array_Idx = 0;
		var Display_Line_Idx = 0;
		while ( (Display_Line_Idx < Max_Display_Line_Number) and (WayPoint_Array_Idx < app.WayPoint_Number) )
		{
			//System.println("Display_Line_Idx = " + Display_Line_Idx);
			//System.println("WayPoint_Array_Idx = " + WayPoint_Array_Idx);
			if (app.WayPoint_Array[WayPoint_Array_Idx][0] >= Distance_Value - 2)
			{
				dc.drawText(X_Distance, First_Line_Y + Display_Line_Idx * Line_Height, Font_Type, app.WayPoint_Array[WayPoint_Array_Idx][0].format("%.0f").toString(), Gfx.TEXT_JUSTIFY_RIGHT);
				dc.drawText(X_Comment, First_Line_Y + Display_Line_Idx * Line_Height, Font_Type, app.WayPoint_Array[WayPoint_Array_Idx][1], Gfx.TEXT_JUSTIFY_LEFT);
				Display_Line_Idx++;
			}
			WayPoint_Array_Idx++;
		}

    }

    function TimeFormat(milliseconds)
    {
      //elapsedTime is in ms.
      var Seconds = milliseconds / 1000;
      var Rest;
               
      var Hour   = (Seconds - Seconds % 3600) / 3600; 
      Rest = Seconds - Hour * 3600;
      var Minute = (Rest - Rest % 60) / 60;
      var Second = Rest - Minute * 60; 

      var Return_Value = Hour.format("%d") + ":" + Minute.format("%02d") + ":" + Second.format("%02d");
      return Return_Value;
    }
}
