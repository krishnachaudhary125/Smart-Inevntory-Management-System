<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <div class="contact-container">

        <h1>Contact Us</h1>
        <p>
            If you have any questions, feedback, or issues regarding the
            Smart Inventory Management System, please contact us using the form below.
        </p>

        <form action="ContactServlet" method="post" class="contact-form">

            <label>Full Name</label>
            <input type="text" name="name" required>

            <label>Email Address</label>
            <input type="email" name="email" required>

            <label>Subject</label>
            <input type="text" name="subject" required>

            <label>Message</label>
            <textarea name="message" rows="5" required></textarea>

            <button type="submit">Send Message</button>

        </form>

        <div class="contact-info">
            <h3>Administrator Contact</h3>
            <p>Email: krishnachaudhary0125@gmail.com</p>
            <p>Location: Kathmandu, Nepal</p>
        </div>

    </div>