<%@ page import="com.example.project.model.Vendor" %>
<%@ page import="java.util.List" %>
<div class="vendor-container">
    <nav class="vendor-header">
        <ul>
            <li><button id="add-vendor-btn">Add Vendor</button></li>
            <li>
                <div class="search-vendor">
                    <input type="text" placeholder="Search Vendor">
                    <button>Search</button>
                </div>
            </li>
        </ul>
    </nav>

    <div class="add-vendor-modal" id="add-vendor-modal">
        <div class="add-vendor-container">
            <span class="close">&times;</span>
            <h2>Add Vendor</h2>
            <div class="general-error" id="generalError" style="display:none;"></div>
            <form action="<%= request.getContextPath() %>/addVendor" method="post" id="addVendorForm">
                <input type="hidden" name="action" value="add">
                <div class="add-vendor-field">
                    <input type="text" name="vendorName" id="vendorName" placeholder="Enter vendor name" value="">
                </div>
                <div class="add-vendor-field">
                    <input type="text" name="vendorPhone" id="vendorPhone" placeholder="Enter vendor phone" value="">
                    <small class="error" id="vendorPhoneError"></small>
                </div>
                <div class="add-vendor-field">
                    <input type="text" name="vendorEmail" id="vendorEmail" placeholder="Enter vendor email" value="">
                    <small class="error" id="vendorEmailError"></small>
                </div>
                <div class="add-vendor-field">
                    <input type="text" name="vendorAddress" id="vendorAddress" placeholder="Enter vendor address" value="">
                </div>
                <div class="add-vendor-button">
                    <button type="submit" name="add-vendor-button" id="add-vendor-button">Add Vendor</button>
                </div>
            </form>
        </div>
    </div>

    <div class="vendor-table">
        <table>
            <thead>
                <tr>
                    <th>S.No</th>
                    <th>ID</th>
                    <th>Vendor Name</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th>Address</th>
                    <% String role=(String) session.getAttribute("role"); if("super-admin".equals(role)){ %>
                    <th>Action</th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
                <% Object obj=request.getAttribute("vendors");
                    List<Vendor> vendors = null;
                    if (obj instanceof List) {
                        vendors = (List<Vendor>) obj;
                    }
                    String currentRole = (String) session.getAttribute("role");

                    if (vendors != null && !vendors.isEmpty()) {
                        int counter = 1;
                        for (Vendor v : vendors) {
                %>
                <tr>
                    <td><%= counter++ %></td>
                    <td><%= v.getVendorId() %></td>
                    <td><%= v.getVendorName() %></td>
                    <td><%= v.getVendorPhone() %></td>
                    <td><%= v.getVendorEmail() %></td>
                    <td><%= v.getVendorAddress() %></td>
                    <% if("super-admin".equals(role)){ %>
                    <td></td>
                    <% } %>
                </tr>
                <% } 
                }else{%>
                <tr><td colspan="7">No vendor found.</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>
<script>
    const modal = document.getElementById("add-vendor-modal");
    const closeBtn = document.querySelector(".close");
    const addVendorBtn = document.getElementById("add-vendor-btn");

    addVendorBtn.onclick = () => modal.style.display = "flex";
    closeBtn.onclick = () => modal.style.display = "none";
    window.onclick = (e) => { if(e.target === modal) modal.style.display = "none"; };


    const form = document.getElementById("addVendorForm");

    form.addEventListener('submit', function(e){
        let hasError = false;

        document.getElementById("generalError").innerText = "";
        document.getElementById("vendorPhoneError").innerText = "";
        document.getElementById("vendorEmailError").innerText = "";

        const name = document.getElementById("vendorName").value.replace(/\u00A0|\u202F/g, ' ').trim();
        const phone = document.getElementById("vendorPhone").value.replace(/\u00A0|\u202F/g, ' ').trim();
        const email = document.getElementById("vendorEmail").value.replace(/\u00A0|\u202F/g, ' ').trim();
        const address = document.getElementById("vendorAddress").value.replace(/\u00A0|\u202F/g, ' ').trim();

        if(name === "" || phone === "" || email === "" || address === ""){
            generalError.innerText = "All fields are required.";
            generalError.style.display = "block"; 
            hasError = true;
        } else {
            generalError.innerText = "";
            generalError.style.display = "none"; 
        }

        const phoneRegex = /^\+?[\d\-‑\s]{7,20}$/;
        if(phone !== "" && !phoneRegex.test(phone)) {
            document.getElementById("vendorPhoneError").innerText = "Inavlid phone number.";
            hasError = true;
        }

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/i;
        if(email !== "" && !emailRegex.test(email)) {
            document.getElementById("vendorEmailError").innerText = "Invalid email format";
            hasError = true;
        }

        if(hasError) e.preventDefault();
    });
</script>