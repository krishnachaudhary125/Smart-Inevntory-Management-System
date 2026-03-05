<%@ page import="java.util.List" %>
<%@ page import="com.example.project.model.Member" %>

<div class="category-container">

<nav class="category-header">

<ul>

<li>
<button id="add-member-btn">Add Member</button>
</li>

<li>

<div class="search-category">

<input type="text" placeholder="Search phone">

<button>Search</button>

</div>

</li>

</ul>

</nav>


<div class="add-category-modal" id="add-member-modal">

<div class="add-category-container">

<span class="close">&times;</span>

<h2>Add Member</h2>

<form action="<%=request.getContextPath()%>/addMember" method="post">

<div class="add-category-field">

<input type="text" name="memberName" placeholder="Member Name">

</div>

<div class="add-category-field">

<input type="text" name="phone" placeholder="Phone Number">

</div>

<div class="add-category-button">

<button>Add Member</button>

</div>

</form>

</div>

</div>


<div class="vendor-table">

<table>

<thead>

<tr>

<th>ID</th>
<th>Name</th>
<th>Phone</th>
<th>Points</th>

</tr>

</thead>

<tbody>

<%

List<Member> members =
(List<Member>)request.getAttribute("members");

if(members != null){

for(Member m : members){

%>

<tr>

<td><%=m.getMemberId()%></td>
<td><%=m.getMemberName()%></td>
<td><%=m.getPhone()%></td>
<td><%=m.getPoints()%></td>

</tr>

<%
}
}
%>

</tbody>

</table>

</div>

</div>
<div id="toast" class="toast"></div>

<script>
const modal = document.getElementById("add-member-modal");
const closeBtn = document.querySelector(".close");
const addBtn = document.getElementById("add-member-btn");

addBtn.onclick = () => modal.style.display = "flex";
closeBtn.onclick = () => modal.style.display = "none";

window.onclick = (e)=>{
if(e.target === modal)
modal.style.display="none";
};

const toast = document.getElementById("toast");

function showToast(msg,type){

toast.innerText = msg;

toast.className = "toast show " + type;

setTimeout(()=>{
toast.classList.remove("show");
},3000);

}

document.addEventListener("DOMContentLoaded",()=>{

<% if("added".equals(request.getParameter("success"))){ %>
showToast("Member added successfully!","success");
<% } %>

<% if("failed".equals(request.getParameter("error"))){ %>
showToast("Failed to add member!","error");
<% } %>

<% if("phoneExists".equals(request.getParameter("error"))){ %>
showToast("Phone number already registered!","error");
<% } %>

});
</script>