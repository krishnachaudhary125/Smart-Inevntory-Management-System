<%@ page import="java.util.List" %>
<%@ page import="com.example.project.model.Product" %>

<div class="product-container">

    <h2>Stock Out</h2>

    <!-- CUSTOMER SECTION -->
    <div class="customer-section">

        <div class="customer-header">

            <label class="customer-label">Customer Type</label>

            <select id="customerType" class="customer-select">
                <option value="guest" selected>Non-Member</option>
                <option value="member">Member</option>
            </select>

            <div id="memberSearch" class="member-search">

                <input
                    type="text"
                    id="memberPhone"
                    class="member-input"
                    placeholder="Enter phone number"
                >

                <span class="member-points">
                    Points: <span id="memberPoints">0</span>
                </span>

            </div>

        </div>

    </div>


    <!-- PRODUCT SEARCH -->
    <div class="product-search-container">

        <input
            type="text"
            id="productSearch"
            class="product-search-input"
            placeholder="Search product..."
            autocomplete="off"
        >

        <div id="productSuggestions" class="product-suggestions"></div>

    </div>


    <!-- CART TABLE -->
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

        <tbody class="cart-body"></tbody>

    </table>


    <!-- TEMPLATE ROW -->
    <table style="display:none">

        <tr id="cartRowTemplate" class="cart-row">

            <td class="product-name"></td>

            <td>
                <select class="batch-select">
                </select>
            </td>

            <td>
                <input type="number" class="qty-input" value="0" min="1">
            </td>

            <td class="price-value">0</td>

            <td class="row-total">0</td>

            <td>
                <button class="remove-btn">Delete</button>
            </td>

        </tr>

    </table>


    <!-- SUMMARY -->
    <div class="cart-summary">

        <p>Subtotal: Rs <span class="subtotal">0</span></p>

        <div id="pointSection" class="point-section">
            Use Points:
            <input type="number" class="use-point" value="0" min="0">
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

document.addEventListener("DOMContentLoaded", function(){

    toggleMemberFields();

    customerType.addEventListener("change", toggleMemberFields);

});

/* MEMBER LOOKUP */

const memberPhone = document.getElementById("memberPhone");
const memberPoints = document.getElementById("memberPoints");

memberPhone.addEventListener("input", function(){

    let phone = this.value;

    if(phone.length < 3){
        memberPoints.innerText = "0";
        return;
    }

    fetch("<%=request.getContextPath()%>/searchMember?phone=" + phone)

    .then(res => res.json())

    .then(data => {

        if(data.points !== undefined){

            memberPoints.innerText = data.points;

        }else{

            memberPoints.innerText = "0";

        }

    });

});



/* PRODUCT SEARCH */

const searchInput = document.getElementById("productSearch");
const suggestionBox = document.getElementById("productSuggestions");

searchInput.addEventListener("input", function(){

    let keyword = this.value;

    if(keyword.length < 2){

        suggestionBox.style.display = "none";
        return;

    }

    fetch("<%=request.getContextPath()%>/searchProduct?keyword=" + keyword)

    .then(res => res.json())

    .then(products => {

        suggestionBox.innerHTML = "";

        products.forEach(product => {

            const div = document.createElement("div");

            div.classList.add("suggestion-item");

            div.textContent = product.name;

            div.onclick = function(){

                addProductToCart(product);

                suggestionBox.style.display = "none";

                searchInput.value = "";

            };

            suggestionBox.appendChild(div);

        });

        suggestionBox.style.display = "block";

    });

});



/* ADD PRODUCT TO CART */
function addProductToCart(product){

    const tbody = document.querySelector(".cart-body");
    const template = document.getElementById("cartRowTemplate");

    const newRow = template.cloneNode(true);

    newRow.removeAttribute("id");
    newRow.style.display = "";

    newRow.querySelector(".product-name").innerText = product.name;

    const batchSelect = newRow.querySelector(".batch-select");

    fetch("<%=request.getContextPath()%>/getBatches?productId=" + product.id)

    .then(res => res.json())

    .then(batches => {

        batchSelect.innerHTML = "";

        let totalStock = 0;

        batches.forEach(b => {

            totalStock += b.qty;

            const option = document.createElement("option");

            option.value = b.batchId;
            option.textContent = b.batch + " (" + b.qty + ")";

            option.dataset.price = b.price;
            option.dataset.qty = b.qty;

            batchSelect.appendChild(option);

        });

        /* set first batch price */
        if(batches.length > 0){

            const first = batches[0];

            const qty = parseInt(newRow.querySelector(".qty-input").value) || 0;

            newRow.querySelector(".price-value").innerText = first.price;

            newRow.querySelector(".row-total").innerText = qty * first.price;

        }
    });

    batchSelect.addEventListener("change", function(){

        const selected = this.options[this.selectedIndex];

        const price = parseFloat(selected.dataset.price);

        const row = this.closest(".cart-row");

        const qty = parseInt(row.querySelector(".qty-input").value) || 0;

        row.querySelector(".price-value").innerText = price;

        row.querySelector(".row-total").innerText = qty * price;

        updateTotal();
    });

    const removeBtn = newRow.querySelector(".remove-btn");

    removeBtn.addEventListener("click", function(){

        newRow.remove();
        updateTotal();

    });

    tbody.appendChild(newRow);

    updateTotal();
}

/* PRICE CALCULATION */
document.addEventListener("input", function(e){

/* POINTS INPUT */
if(e.target.classList.contains("use-point")){
updateTotal();
return;
}

/* QUANTITY INPUT */
if(!e.target.classList.contains("qty-input")) return;

const row = e.target.closest(".cart-row");

const qty = parseInt(e.target.value) || 0;

const batchSelect = row.querySelector(".batch-select");
const selectedBatch = batchSelect.options[batchSelect.selectedIndex];

const price = parseFloat(selectedBatch.dataset.price);
const batchStock = parseInt(selectedBatch.dataset.qty);

const productName = row.querySelector(".product-name").innerText;
const batchId = selectedBatch.value;

/* calculate used stock */
let usedStock = 0;

document.querySelectorAll(".cart-row").forEach(r=>{

if(r === row) return;

const p = r.querySelector(".product-name").innerText;
const b = r.querySelector(".batch-select").value;

if(p === productName && b === batchId){

usedStock += parseInt(r.querySelector(".qty-input").value) || 0;

}

});

const remainingStock = batchStock - usedStock;

if(qty > remainingStock){

alert("Only " + remainingStock + " items available");

e.target.value = remainingStock;

}

const finalQty = parseInt(e.target.value) || 0;

row.querySelector(".row-total").innerText = finalQty * price;

updateTotal();

});

function createBatchRow(productName, batch, qty){

    const tbody = document.querySelector(".cart-body");
    const template = document.getElementById("cartRowTemplate");

    const row = template.cloneNode(true);

    row.removeAttribute("id");
    row.style.display = "";

    row.querySelector(".product-name").innerText = productName;

    row.querySelector(".batch-select").innerHTML =
        `<option>${batch.batch}</option>`;

    row.querySelector(".qty-input").value = qty;

    row.querySelector(".price-value").innerText = batch.price;

    row.querySelector(".row-total").innerText = qty * batch.price;

    row.dataset.batches = JSON.stringify([batch]);

    const removeBtn = row.querySelector(".remove-btn");

    removeBtn.onclick = () => {
        row.remove();
        updateTotal();
    };

    tbody.appendChild(row);
}
/* UPDATE TOTAL */

function updateTotal(){

    let subtotal = 0;

    document.querySelectorAll(".row-total").forEach(el => {

        subtotal += parseFloat(el.innerText) || 0;

    });

    document.querySelector(".subtotal").innerText = subtotal;

    let points = parseFloat(document.querySelector(".use-point").value) || 0;

    let discount = (points / 100) * 50;

    document.querySelector(".discount").innerText = discount;

    document.querySelector(".final-total").innerText = subtotal - discount;

}

/* INITIAL CALCULATION */

updateTotal();

    /* SENDING CART DATA */
    document.querySelector(".complete-sale-btn").addEventListener("click", function(){

        const rows = document.querySelectorAll(".cart-row");

        if(rows.length === 0){
            alert("Cart is empty");
            return;
        }

        const items = [];

       rows.forEach(row => {

           const qty = parseInt(row.querySelector(".qty-input").value) || 0;

           if(qty <= 0) return;

           const batchSelect = row.querySelector(".batch-select");

           const batchId = batchSelect.value;

           const price = parseFloat(row.querySelector(".price-value").innerText) || 0;

           const product = row.querySelector(".product-name").innerText;

           items.push({
               productName: product,
               batchId: batchId,
               quantity: qty,
               price: price
           });

       });

        const finalTotal = parseFloat(document.querySelector(".final-total").innerText) || 0;

        const usedPoints = parseInt(document.querySelector(".use-point").value) || 0;

        const memberPoints = parseInt(document.getElementById("memberPoints").innerText) || 0;

        const customerType = document.getElementById("customerType").value;

        const phone = document.getElementById("memberPhone").value;

        /* SECURITY CHECK */
        if(customerType === "member" && usedPoints > memberPoints){
            alert("You cannot use more points than available.");
            return;
        }

        fetch("<%=request.getContextPath()%>/completeSale",{

            method:"POST",

            headers:{
                "Content-Type":"application/json"
            },

            body:JSON.stringify({
                items:items,
                total:finalTotal,
                usedPoints:usedPoints,
                customerType:customerType,
                phone:phone
            })

        })
        .then(res=>{
            if(!res.ok){
                throw new Error("Server error");
            }
            return res.json();
        })
        .then(data=>{

            alert("Sale completed!");

            location.reload();

        })
        .catch(err=>{
              console.error(err);
              alert("Sale failed");
        });

    });
</script>