<%@ page import="java.util.List" %>
<%@ page import="com.example.project.model.Product" %>

<div class="product-container">
    <h2>Stock Out</h2>
    <div class="customer-section">
        <div class="customer-header">
            <label>Customer Type</label>
            <select id="customerType">
                <option value="guest" selected>Non-Member</option>
                <option value="member">Member</option>
            </select>
        </div>

        <div id="memberSearch" class="member-search">
            <input type="text"
            id="memberPhone"
            placeholder="Enter member phone number">
            <p>Available Points: <span id="memberPoints">0</span></p>
        </div>
    </div>

    <div class="search-product">
        <input type="text" id="productSearch" placeholder="Search product name..." autocomplete="off">
    </div>

    <table id="cartTable">
        <thead>
            <tr>
                <th>Product</th>
                <th>Batch</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
                <th>Remove</th>
            </tr>
        </thead>
        <tbody id="cartBody">
        </tbody>
    </table>

    <div class="cart-summary">
        <p>Subtotal: Rs <span id="subtotal">0</span></p>
        <div id="pointSection" style="display:none">
            Use Points: <input type="number" id="usePoint">
        </div>
        <p>Discount: Rs <span id="discount">0</span></p>
        <h3>Final Total: Rs <span id="finalTotal">0</span></h3>
        <button id="completeSale">Complete Sale</button>
    </div>
</div>

<script>
    // Customer Type
    const customerType = document.getElementById("customerType");
    const memberSearch = document.getElementById("memberSearch");
    const pointsSection = document.getElementById("pointSection");

    customerType.addEventListener("change", function(){

        if(this.value === "member"){
            memberSearch.style.display="flex";
            pointsSection.style.display="block";
        }else{
            memberSearch.style.display="none";
            pointsSection.style.display="none";
        }
    });

    // Product List
    const products = [
        <%
        List<Product> products=(List<Product>)request.getAttribute("products");
        if(products!=null){
            for(Product p:products){
        %>
            {
                id:<%=p.getProductId()%>,
                name:"<%=p.getProductName()%>",
                price:100
            },
        <%
            }
        }
        %>
    ];

    // Add Product to Cart
    document.getElementById("productSearch").addEventListener("change",function(){
        let name=this.value;
        let product=products.find(p=>p.name===name);
        if(product){
            addRow(product);
        }
    });

    // Cart row
    function addRow(product){
        let row = `
        <tr>
            <td>${product.name}</td>
            <td>
                <select class="batch">
                    <option>B101</option>
                    <option>B102</option>
                </select>
            </td>
            <td>
                <input type="number" class="qty" value="1">
            </td>
            <td>
                <input type="number" class="price" value="${product.price}">
            </td>
            <td class="rowTotal">${product.price}</td>
            <td>
                <button onclick="removeRow(this)">X</button>
            </td>
        </tr>
        `;

        document.getElementById("cartBody")
        .insertAdjacentHTML("beforeend",row);

        updateTotal();
    }

    // Price Calculation
    document.addEventListener("input",function(e){
        if(e.target.classList.contains("qty") || e.target.classList.contains("price")){
            let row=e.target.closest("tr");
            let qty=row.querySelector(".qty").value;
            let price=row.querySelector(".price").value;
            let total=qty*price;

            row.querySelector(".rowTotal").innerText=total;
            updateTotal();
        }
    });

    // Update total
    function updateTotal(){
        let subtotal=0;
        document.querySelectorAll(".rowTotal").forEach(el=>{
        subtotal += parseFloat(el.innerText);
    });

    document.getElementById("subtotal").innerText=subtotal;

    let points = document.getElementById("usePoints").value || 0;
    let discount=(points/100)*50;

    document.getElementById("discount").innerText=discount;
    document.getElementById("finalTotal")
        .innerText=subtotal-discount;
    }

    // remove product
    function removeRow(btn){
        btn.closest("tr").remove();
        updateTotal();
    }
</script>