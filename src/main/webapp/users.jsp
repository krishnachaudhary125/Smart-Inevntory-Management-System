<div class="user-container">
    <nav class="user-header">
        <ul>
        <%
                    String role = (String) session.getAttribute("role");
                    if ("super-admin".equals(role) || "admin".equals(role)) {
                %>
            <li><button id="add-staff-btn">Add Staff</button></li>
            <%
                        }
                    %>
            <li><button>Add Admin</button></li>
            <li><button>Role Filter</button></li>
            <li>
        <div class="search">
            <input type="text" placeholder="Search User">
            <button>Search</button>
        </div>
            </li>
        </ul>
    </nav>

    <div class="add-staff" id="add-staff">
        <div class="add-staff-popup">
        <h2>Add Staff</h2>
        <span class="close" id="closeModal">&times;</span>
        <form>
        </form>
        </div>
    </div>
    <div class="user-table">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>Krishna Chaudhary</td>
                    <td>krishna@example.com</td>
                    <td>Admin</td>
                    <td>
                        <button class="edit">Edit</button>
                        <button class="delete">Delete</button>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Ram Sharma</td>
                    <td>ram@example.com</td>
                    <td>Staff</td>
                    <td>
                        <button class="edit">Edit</button>
                        <button class="delete">Delete</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

</div>