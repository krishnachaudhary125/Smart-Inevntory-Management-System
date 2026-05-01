<%@ page import="java.util.*" %>

<div class="product-container">

<h2>Stock Forecast Dashboard</h2>

<div class="product-table">

<table>

<thead>
<tr>
<th>S.No</th>
<th>Product</th>
<th>Current Stock</th>
<th>Forecast Demand</th>
<th>Complementary Product</th>
<th>Restock Recommendation</th>
</tr>
</thead>

<tbody>

<%

List<Map<String,Object>> list =
(List<Map<String,Object>>)request.getAttribute("forecastList");

if(list != null){

int counter = 1;

for(Map<String,Object> row : list){

%>

<tr>

<td><%=counter++%></td>

<td><%=row.get("product")%></td>

<td><%=row.get("stock")%></td>

<td><%=row.get("forecast")%></td>

<td>
<%= row.get("complement") != null ?
row.get("complement") : "-" %>
</td>

<td>

<%

int restock = (int)row.get("restock");

if(restock > 0){

%>

<span style="color:red;font-weight:bold;">
Order <%=restock%> units
</span>

<%

}else{

%>

<span style="color:green;">Stock OK</span>

<%

}

%>

</td>

</tr>

<%
}
}
%>

</tbody>

</table>

</div>

</div>