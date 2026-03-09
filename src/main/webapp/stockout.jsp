<%@ page import="java.util.List" %>
<%@ page import="com.example.project.model.Product" %>

<div class="product-container">
    <h2>Stock Out</h2>
    <div class="customer-section">
        <div class="customer-header">
            <label class="customer-label">Customer Type</label>
            <select id="customerType" class="customer-select">
                <option value="guest" selected>Non-Member</option>
                <option value="member">Member</option>
            </select>

            <div id="memberSearch" class="member-search">
                <input type="text" id="memberPhone" class="member-input" placeholder="Enter phone number">
                <span class="member-points">
                Points: <span id="memberPoints">0</span>
                </span>
            </div>
        </div>
    </div>

    <div class="search-product">
        <input type="text" id="productSearch" placeholder="Search product name..." autocomplete="off">
    </div>

    <table class="cart-table">
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

        <tbody class="cart-body">
            <%
                List<Product> productList = (List<Product>)request.getAttribute("products");
                if(productList != null){
                    for(Product p : productList){
            %>

            <tr class="cart-row">
                <td class="product-name">
                    <%= p.getProductName() %>
                </td>
                <td>
                    <select class="batch-select">
                        <option>B101</option>
                        <option>B102</option>
                    </select>
                </td>
                <td>
                    <input type="number" class="qty-input" value="1" min="1">
                </td>
                <td>
                    <input type="number" class="price-input" value="100" min="0">
                </td>
                <td class="row-total">100</td>
                <td>
                    <button class="remove-btn" onclick="removeRow(this)">X</button>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </tbody>

    </table>

    <div class="cart-summary">
        <p>Subtotal: Rs <span class="subtotal">0</span></p>

        <div id="pointSection" class="point-section">
            Use Points: <input type="number" class="use-point" value="0" min="0">
        </div>

        <p>Discount: Rs <span class="discount">0</span></p>

        <h3>Final Total: Rs <span class="final-total">0</span></h3>

        <button class="complete-sale-btn">Complete Sale</button>
    </div>
</div>

<script>
    /* CUSTOMER TYPE */
    const customerType = document.getElementById("customerType");
    const memberSearch = document.getElementById("memberSearch");
    const pointsSection = document.getElementById("pointSection");

    function toggleMemberFields(){
        if(customerType.value === "member"){
            memberSearch.style.display = "flex";
            pointsSection.style.display = "block";
        }else{
            memberSearch.style.display = "none";
            pointsSection.style.display = "none";

        }
    }
    customerType.addEventListener("change", toggleMemberFields);
    toggleMemberFields();

    /* PRICE CALCULATION */
    document.addEventListener("input", function(e){
        if(
            e.target.classList.contains("qty-input") ||
            e.target.classList.contains("price-input") ||
            e.target.classList.contains("use-point")
        ){
            let row = e.target.closest(".cart-row");
            if(row){
                let qty = parseFloat(
                    row.querySelector(".qty-input").value
                ) || 0;

                let price = parseFloat(
                    row.querySelector(".price-input").value
                ) || 0;

                let total = qty * price;
                row.querySelector(".row-total").innerText = total;
            }
        updateTotal();
        }
    });

    /* UPDATE TOTAL */
    function updateTotal(){
        let subtotal = 0;
        document.querySelectorAll(".row-total").forEach(el=>{
            subtotal += parseFloat(el.innerText) || 0;
        });

        document.querySelector(".subtotal").innerText = subtotal;

        let points = parseFloat(
            document.querySelector(".use-point").value
        ) || 0;

        let discount = (points / 100) * 50;
        document.querySelector(".discount").innerText = discount;
        document.querySelector(".final-total").innerText = subtotal - discount;
    }

    /* REMOVE PRODUCT */
    function removeRow(btn){
        btn.closest(".cart-row").remove();
        updateTotal();
    }

    /* INITIAL CALCULATION */
    updateTotal();
</script>