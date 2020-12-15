package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Reservation {
	
	public int reservationID;
	public int cancelled;
	public String username;
	
	
	public String forward_transitLineName;
	public int forward_reverseLine;
	public Timestamp forward_scheduleDepartureTime;
	public int forward_trainID;
	public float forward_fare;

	public int roundTrip;
	
	public String return_transitLineName;
	public int return_reverseLine;
	public Timestamp return_scheduleDepartureTime;
	public int return_trainID;
	public float return_fare;
	
	public int origin_stationID;
	public int destination_stationID;
	
	//ArrayList<Reservation> res = TrainProject.Reservations.getAsList();
	
	public Timestamp dateOfCreation;
	public float discount;
	public float totalFare;
	
	public String title;
	public String firstName;
	public String lastName;
	
	public Reservation(
			int reservationID,
			int cancelled,
			String username,
				
			String forward_transitLineName,
			int forward_reverseLine,
			Timestamp forward_scheduleDepartureTime,
			int forward_trainID,
			float forward_fare,

			int roundTrip,
			
			String return_transitLineName,
			int return_reverseLine,
			Timestamp return_scheduleDepartureTime,
			int return_trainID,
			float return_fare,
			
			int origin_stationID,
			int destination_stationID,
			
			Timestamp dateOfCreation,
			float discount,
			float totalFare,
			
			String title,
			String firstName,
			String lastName
			) {
		this.reservationID = reservationID;
		this.cancelled = cancelled;
		this.username = username;
		
		this.forward_transitLineName = forward_transitLineName;
		this.forward_reverseLine = forward_reverseLine;
		this.forward_scheduleDepartureTime = forward_scheduleDepartureTime;
		this.forward_trainID = forward_trainID;
		this.forward_fare = forward_fare;
		
		this.roundTrip = roundTrip;

		this.return_transitLineName = return_transitLineName;
		this.return_reverseLine = return_reverseLine;
		this.return_scheduleDepartureTime = return_scheduleDepartureTime;
		this.return_trainID = return_trainID;
		this.return_fare = return_fare;
		
		this.origin_stationID = origin_stationID;
		this.destination_stationID = destination_stationID;
		this.dateOfCreation = dateOfCreation;
		this.discount = discount;
		this.totalFare = totalFare;	
		
		this.title = title;
		this.firstName = firstName;
		this.lastName = lastName;
		
		/*
		LocalDate.of(0,0,0).isAfter(other);
		LocalDate.of(0,0,31).isAfter(other);
		dateOfCreation.toLocalDateTime().toLocalDate().isAfter(LocalDate.of(0,0,31).isAfter(other))
		*/
	}
	
	public Reservation(ResultSet rs) throws SQLException {
		this(
			rs.getInt("reservationID"),
			rs.getInt("cancelled"),
			rs.getString("username"),
			
			rs.getString("forward_transitLineName"),
			rs.getInt("forward_reverseLine"),
			rs.getTimestamp("forward_scheduleDepartureTime"),
			rs.getInt("forward_trainID"),
			rs.getFloat("forward_fare"),
			
			rs.getInt("roundTrip"),
			
			rs.getString("return_transitLineName"),
			rs.getInt("return_reverseLine"),
			rs.getTimestamp("return_scheduleDepartureTime"),
			rs.getInt("return_trainID"),
			rs.getFloat("return_fare"),
			
			rs.getInt("origin_stationID"),
			rs.getInt("destination_stationID"),
			
			rs.getTimestamp("dateOfCreation"),
			rs.getFloat("discount"),
			rs.getFloat("totalFare"),
			
			rs.getString("title"),
			rs.getString("firstName"),
			rs.getString("lastName")
		);
	}
	public Schedule getForwardSchedule() throws SQLException {
		return TrainProject.Schedules.get(forward_transitLineName, forward_reverseLine, forward_scheduleDepartureTime);
	}
	public Schedule getReturnSchedule() throws SQLException {
		return TrainProject.Schedules.get(return_transitLineName, return_reverseLine, return_scheduleDepartureTime);
	}
	public Station getOriginStation() throws SQLException {
		return TrainProject.Stations.get(origin_stationID);
	}
	public Station getDestinationStation() throws SQLException {
		return TrainProject.Stations.get(destination_stationID);
	}
	public LocalDateTime timeOfForwardDeparture() throws SQLException {
		return getForwardSchedule().dateTimeOfDeparture(getOriginStation());
	}
	public LocalDateTime timeOfForwardArrival() throws SQLException {
		return getForwardSchedule().dateTimeOfArrival(getDestinationStation());
	}
	public LocalDateTime timeOfReturnDeparture() throws SQLException {
		return getReturnSchedule().dateTimeOfDeparture(getDestinationStation());
	}
	public LocalDateTime timeOfReturnArrival() throws SQLException {
		return getReturnSchedule().dateTimeOfArrival(getOriginStation());
	}
	
	private String getString() throws SQLException {
		String l1 = getOriginStation()+" "+Formatting.displayTime(timeOfForwardDeparture())+" --> "+getDestinationStation()+" "+Formatting.displayTime(timeOfForwardArrival());
		
		if(roundTrip == 1) {
			String l2 = getDestinationStation()+" "+Formatting.displayTime(timeOfReturnDeparture())+" --> "+getOriginStation()+" "+Formatting.displayTime(timeOfReturnArrival());
			l1 = "<br></br>";
		}
		l1 = l1 + "<br></br>";
		l1 = "<h3>"+l1+"</h3>";
		
		String bn = "Booked on "+Formatting.displayTime(dateOfCreation.toLocalDateTime().toLocalDate()) + "<br></br>";
		String p1 = "Passenger "+ ((title == null || "".equals(title)) ? "" : title ) + " " + firstName +" "+ lastName;
		p1 = p1 + "<br></br>";
		
		String tf = "Total fare: "+Formatting.getFare(totalFare) + "<br></br>";
		String ad = "Applied discount: "+Formatting.getDiscount(discount) + "<br></br>";
		
		return l1 + p1 + bn + tf + ad;
		
	}
	
	@Override
	public String toString() {
		try {
			System.out.println("CALLING TO STRIGN");
			return getString();
		
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			return "ERROR";
		}
	}
}
