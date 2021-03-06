<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
if(session.getAttribute("none") == null){
	
} else {
	out.println("No reservations found, or none with a valid return on the selected return date. <br></br>");
	session.setAttribute("none", null);
}
	session.setAttribute("disc", null);
	session.setAttribute("orig", null);
	session.setAttribute("dest", null);
	
	session.setAttribute("rt", null);
	session.setAttribute("date1", null);
	session.setAttribute("date2", null);
	session.setAttribute("so", null);
	
	session.setAttribute("mr4", null);
	session.setAttribute("options", null);
	session.setAttribute("none", null);
	
	session.setAttribute("selectedBuilder", null);
	session.setAttribute("validReservations", null);
	session.setAttribute("validReservationBuilders", null);
	session.setAttribute("disc", "0f");
	
	//ArrayList<Station> stations = TrainProject.Stations.getAsList();
	ArrayList<Station> stations = TrainProject.Stations.getAsList();
	
	ArrayList<Object> options = new ArrayList<Object>();
	ArrayList<Object> dispOptions = new ArrayList<Object>();
	//ArrayList<String> cities = new ArrayList<String>();
	//session.setAttribute("cities",cities);
	session.setAttribute("options",options);
	
	for(Station s : stations){
		if(options.contains(s.city)){
			continue;
		}
		options.add(s.city);
		options.add(s);
		
		dispOptions.add(s.city + " - "+s.state);
		dispOptions.add(s);
	}

	Collections.sort(options,
            new Comparator<Object>() {
                public int compare(Object o1, Object o2)
                {
                    return o1.toString().compareTo(o2.toString());
                }
            }
	);
	Collections.sort(dispOptions,
            new Comparator<Object>() {
                public int compare(Object o1, Object o2)
                {
                    return o1.toString().compareTo(o2.toString());
                }
            }
	);

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Schedule Search</title>
</head>
<body>
<h3>Make a reservation</h3>
<form action="MakeReservation2.jsp" method="POST">
	
	
	
	Origin City/Station
	<select name="objectA">
		<% for(int i=0; i<options.size(); i++){ %>
			<option value=<%=i%>><%=dispOptions.get(i)%></option>
		<% } %>
	</select>
	<br></br>
	Destination City/Station
	<select name="objectB">
	
		<% for(int i=0; i<options.size(); i++){ 
		%>
			<option value=<%=i%>><%=dispOptions.get(i)%></option>
		<% } %>
	</select>
	<br></br>
	
	Departure Date:
	<input type="date" name="date1">
	
	
	Trip Type:
	 <input type="radio" name="rt" value="0"/>One-Way 
	 <input type="radio" name="rt" value="1"/>Round-Trip
	

	<br></br>Return Date: 
	<input type="date" name="date2"> (Select if Round-Trip)
	<br></br>
	
	Passenger Discount Type:
	<input type="radio" name="disc" value="0.00f" checked="checked"/>Adult
	<input type="radio" name="disc" value="0.25f"/>Child
	<input type="radio" name="disc" value="0.35f"/>Senior
	<input type="radio" name="disc" value="0.50f"/>Disabled
	<br></br>
	<input type="submit" value="Continue"/>
</form>
<br></br>
<br></br>
<form action="CustomerLanding.jsp">
<input type="submit" value="Cancel"/>
</form>
</body>
</html>