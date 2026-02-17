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
            <form action="#" method="post">
                <div class="add-vendor-field">
                    <input type="text" name="vendorName" id="vendorName" placeholder="Enter vendor name" value="">
                </div>
                <div class="add-vendor-field">
                    <input type="text" name="vendorPhone" id="vendorPhone" placeholder="Enter vendor phone" value="">
                </div>
                <div class="add-vendor-field">
                    <input type="text" name="vendorEmail" id="vendorEmail" placeholder="Enter vendor email" value="">
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
</div>
<script>
    const modal = document.getElementById("add-vendor-modal");
    const closeBtn = document.querySelector(".close");
    const addVendorBtn = document.getElementById("add-vendor-btn");

    addVendorBtn.onclick = () => modal.style.display = "flex";
    closeBtn.onclick = () => modal.style.display = "none";
    window.onclick = (e) => { if(e.target === modal) modal.style.display = "none"; };
</script>