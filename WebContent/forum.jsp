<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%  
	ArrayList<Question> Questions = TrainProject.Questions.getAsList();
	ArrayList<Answer> Answers = TrainProject.Answers.getAsList();
	String x = request.getParameter("keywords");
	ArrayList<Question> temp = new ArrayList<Question>();
	if(x !=null)
	{
		int i =0;
		for(i = 0; i<Questions.size(); i ++)
		{
			if(Questions.get(i).toString().contains(x) || Questions.get(i).descriptionText.contains(x)){
				temp.add(Questions.get(i));
			}
		}
		if(temp.size() == 0){
			response.sendRedirect("forum.jsp");
			session.setAttribute("keywords", null);
			return;
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Q&A Forum</title>
</head>
<body>
<form action="CustomerLanding.jsp" method="GET">
	<input type="Submit" name="filter" value="Back to Home" /> <br></br>
</form> <br></br><br></br>
<% /*
	<div class="topnav">
  	<a class="active" href="http://localhost:8080/TrainProject/CustomerLanding.jsp">Home Page</a>
	</div>*/
	
	%>
	
	Post a new question:
	<form action="PostQuestion.jsp" method = "POST">
	<input type="submit" value="Create New Post"/>
	</form> 
	
	Search by keyword: <form action="forum.jsp" method="POST">
	<input type="text" name="keywords"/> 
	<input type="Submit" value="Search">
	</form><br></br>
	
	
	Previous Question:
	<%
	if(x!=null){ %>
		<%
		for(int i = 0; i < temp.size(); i ++ )
		{%> 
	 		<% out.print("No."+(i+1)+ ""); %>
	 		<h2> <%=temp.get(i).toString()%> </h2>
	    	<p> <%=temp.get(i).descriptionText%> </p>
	    	<div>Posted by: <%=temp.get(i).username%> </div> <br></br> 
	    	
	    	<%
	    	
	  		if(temp.get(i).getAnswers().size() != 0){
	    		for(int j = 0; j <temp.get(i).getAnswers().size(); j++) { %> 
	    			<p>Answers</p>
	    			<p><%=temp.get(i).getAnswers().get(0).toString()%></p> <br></br> <% 
	    		}
	   		 }
	    
		} %> 
	 <%}else{ %>
		<%
			for(int i = 0; i < Questions.size(); i ++ )
			{%> 
				<% out.print("No."+(i+1)+ ""); %>
	 			<h2> <%=Questions.get(i).toString()%> </h2>
	    		<p> <%=Questions.get(i).descriptionText%></p>
	    		<div>Posted by: <%=Questions.get(i).username%> </div> <br></br> 
	    		<%
	  			if(Questions.get(i).getAnswers().size() != 0){
	    			for(int j = 0; j <Questions.get(i).getAnswers().size(); j++) { %> 
	    				<p>Answers</p>
	    				<p><%=Questions.get(i).getAnswers().get(0).toString()%></p> <br></br> <% 
	    			}
	   		 	}
	    	
			} 
		}%>
	
	
</body>
</html>