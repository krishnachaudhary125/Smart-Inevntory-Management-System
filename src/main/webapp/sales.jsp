<%@ page import="java.util.List" %>
<%@ page import="com.example.project.model.Sale" %>

<div class="product-container">

<h2>Sales History</h2>

<div class="product-table">

<table>

<thead>
<tr>
<th>S.No</th>
<th>Customer</th>
<th>Products</th>
<th>Total</th>
<th>Used Points</th>
<th>Date</th>
</tr>
</thead>

<tbody>

<%
List<Sale> sales = (List<Sale>) request.getAttribute("sales");

if(sales != null && !sales.isEmpty()){

int counter = 1;

for(Sale s : sales){
%>

<tr>

<td><%= counter++ %></td>

<td>
<%= (s.getMemberPhone()==null || s.getMemberPhone().equals("Guest"))
? "Guest"
: s.getMemberPhone()
%>
</td>

<td>

<%
java.sql.Connection conn =
com.example.project.util.DBConnection.getConnection();

com.example.project.dao.SaleDAO dao =
new com.example.project.dao.SaleDAO(conn);

List<String> products = dao.getProductsBySale(s.getSaleId());

for(String p : products){
%>

<%= p %><br>

<%
}
conn.close();
%>

</td>

<td>Rs <%= s.getTotalAmount() %></td>

<td><%= s.getUsedPoints() %></td>

<td><%= s.getSaleDate() %></td>

</tr>

<%
}
}else{
%>

<tr>
<td colspan="6">No sales found</td>
</tr>

<%
}
%>

</tbody>

</table>

</div>

</div>