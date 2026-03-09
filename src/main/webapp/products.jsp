<%@ page import="com.example.project.model.Category" %>
<%@ page import="com.example.project.model.Vendor" %>
<%@ page import="com.example.project.model.Batch" %>
<%@ page import="com.example.project.model.ProductInventory" %>
<%@ page import="java.util.List" %>

<div class="product-container">
    <nav class="product-header">
        <ul>
            <li><button id="add-product-btn">Add Product</button></li>
            <li>
                <div class="search-product">
                    <input type="text" placeholder="Search Product">
                    <button>Search</button>
                </div>
            </li>
        </ul>
    </nav>

    <%
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    List<Vendor> vendors = (List<Vendor>) request.getAttribute("vendors");
    List<Batch> batches = (List<Batch>) request.getAttribute("batches");
    List<ProductInventory> inventory = (List<ProductInventory>) request.getAttribute("inventory");
    %>

    <div class="add-product-modal" id="add-product-modal">
        <div class="add-product-container">
            <span class="close">&times;</span>
            <h2>Add Product</h2>
            <div class="general-error" id="generalError" style="display:none;"></div>
            <form action="<%= request.getContextPath() %>/addProduct" method="post" id="addProductForm">
                <input type="hidden" name="action" value="add">
                <div class="add-product-field">
                    <input type="text" name="productName" id="productName" placeholder="Enter product name" value="">
                </div>
                <div class="add-product-field">
                    <select name="categoryId">
                    <option value="" selected hidden>Select Category</option>
                    <%
                    if(categories != null){
                        for(Category c : categories){
                    %>

                    <option value="<%= c.getCategoryId() %>">
                        <%= c.getCategoryName() %>
                    </option>

                    <%
                        }
                    }
                    %>
                    </select>
                </div>
                <div class="add-product-field">
                    <select name="vendorId">
                    <option value="" selected hidden>Select Vendor</option>
                    <%
                    if(vendors != null){
                        for(Vendor v : vendors){
                    %>
                    <option value="<%= v.getVendorId() %>">
                        <%= v.getVendorName() %>
                    </option>
                    <%
                        }
                    }
                    %>
                    </select>
                </div>
                <div class="add-product-field">
                    <select name="batchId" id="batch-select">
                    <option value="new">Add New Batch</option>
                    <option value="" selected hidden>Select Batch</option>
                    <%
                    if(batches != null){
                        for(Batch b : batches){
                    %>
                    <option value="<%= b.getBatchDefId() %>">
                        <%= b.getBatchNumber() %>
                    </option>
                    <%
                        }
                    }
                    %>
                    </select>
                    <div id="newBatchDiv" style="display:none;" class="add-product-field">
                        <input type="text" name="newBatchName" id="newBatchName" placeholder="Enter new batch name" />
                    </div>
                </div>
                <div class="add-product-field">
                    <input type="number" name="productQunatity" id="productQuantity" placeholder="Enter product quantity" value="">
                </div>
                <div class="add-product-field">
                    <input type="text" name="productPrice" id="productPrice" placeholder="Enter product price" value="">
                </div>
                <div class="add-product-field">
                    <label for="productExpiry">Expiry Date</label>
                    <input type="date" name="productExpiry" id="productExpiry" placeholder="Enter product expiry date" value="">
                </div>
                <div class="add-product-button">
                    <button type="submit" name="add-product-button" id="add-product-button">Add Product</button>
                </div>
            </form>
        </div>
    </div>

    <div class="product-table">
    <table>

    <thead>
    <tr>
    <th>S.No.</th>
    <th>Product</th>
    <th>Category</th>
    <th>Vendor</th>
    <th>Total Quantity</th>
    <th>Action</th>
    </tr>
    </thead>

    <tbody>

    <%
    if(inventory != null){

    int counter = 1;
    int lastProductId = -1;

    for(ProductInventory p : inventory){

        if(p.getProductId() != lastProductId){
    %>

    <tr>
    <td><%= counter++ %></td>
    <td><%= p.getProductName() %></td>
    <td><%= p.getCategoryName() %></td>
    <td><%= p.getVendorName() %></td>
    <td><%= p.getTotalQuantity() %></td>

    <td>
    <button class="view-batch-btn" onclick="toggleBatch('<%= p.getProductId() %>')">
    View All Batch
    </button>
    </td>

    </tr>

    <%
            lastProductId = p.getProductId();
        }
    %>

    <tr class="batch-row batch-<%= p.getProductId() %>" style="display:none;">
    <td></td>
    <td colspan="5">

    Batch: <%= p.getBatchNumber() %>&emsp;|&emsp;
    Qty: <%= p.getQuantity() %>&emsp;|&emsp;
    Price: <%= p.getPrice() %>&emsp;|&emsp;
    Expiry: <%= p.getExpiryDate() %>

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
<div id="toast" class="toast"></div>
<script>
    const modal = document.getElementById("add-product-modal");
     const closeBtn = document.querySelector(".close");
     const addProductBtn = document.getElementById("add-product-btn");

     addProductBtn.onclick = () => modal.style.display = "flex";
     closeBtn.onclick = () => modal.style.display = "none";
     window.onclick = (e) => { if(e.target === modal) modal.style.display = "none"; };

     const batchSelect = document.getElementById("batch-select");
     const newBatchDiv = document.getElementById("newBatchDiv");

     batchSelect.addEventListener("change", function() {
         if(this.value === "new") {
             newBatchDiv.style.display = "block";
         } else {
             newBatchDiv.style.display = "none";
         }
     });


     /* TOAST SYSTEM */
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
             showToast("Product added successfully!","success");
             modal.style.display="none";
         <% } %>

         <% if("failed".equals(request.getParameter("error"))){ %>
             showToast("Failed to add product!","error");
             modal.style.display="flex";
         <% } %>

     });

     function toggleBatch(productId){

         let rows = document.querySelectorAll(".batch-" + productId);

         rows.forEach(row => {

             if(row.style.display === "none"){
                 row.style.display = "table-row";
             }else{
                 row.style.display = "none";
             }

         });

     }
</script>