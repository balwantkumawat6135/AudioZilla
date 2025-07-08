<%-- 
    Document   : contect_us
    Created on : 08-Jul-2025, 3:31:07 PM
    Author     : balwant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Contact Us | AudioZila</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="mp3.css">
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background-color: #f7f9fc;
      color: #222;
      margin: 0;
      padding: 0;
    }

    header {
      background-color: #ffffff;
      border-bottom: 1px solid #e0e0e0;
      padding: 20px 40px;
      text-align: center;
    }

    header h1 {
      font-size: 2.5rem;
      color: #2c3e50;
      margin: 0;
    }

    .container {
      max-width: 600px;
      margin: 0 auto;
      padding: 40px 20px;
    }

    h2 {
      color: #2c3e50;
      font-size: 1.8rem;
      margin-bottom: 10px;
    }

    p {
      line-height: 1.6;
      margin-bottom: 20px;
      color: #555;
    }

    form {
      background: #ffffff;
      padding: 30px;
      border-radius: 10px;
      border: 1px solid #ddd;
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    input, textarea {
      width: 100%;
      padding: 12px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 1rem;
      background-color: #fff;
      color: #333;
    }

    input:focus, textarea:focus {
      outline: none;
      border-color: #0077ff;
      box-shadow: 0 0 5px rgba(0,119,255,0.2);
    }

    button {
      background-color: #0077ff;
      color: #fff;
      border: none;
      padding: 12px 24px;
      border-radius: 6px;
      font-size: 1rem;
      cursor: pointer;
      margin-top: 10px;
      transition: background 0.3s;
    }

    button:hover {
      background-color: #005fd4;
    }

    footer {
      background: #f2f2f2;
      text-align: center;
      padding: 20px;
      color: #777;
      font-size: 0.9rem;
    }
  </style>
</head>
<body>

  <header>
    <h1>Contact AudioZila</h1>
  </header>

  <div class="container">
    <h2>We’d love to hear from you!</h2>
    <p>Have a question, suggestion, or feedback? Fill out the form below and our team will get back to you shortly.</p>

    <form action="mailto:your-email@audiozila.com" method="post" enctype="text/plain">
      <input type="text" name="name" placeholder="Your Name" required>
      <input type="email" name="email" placeholder="Your Email" required>
      <input type="text" name="subject" placeholder="Subject">
      <textarea name="message" rows="6" placeholder="Your Message" required></textarea>
      <button type="submit">Send Message</button>
    </form>
  </div>
    <%@include  file="footer.jsp" %>
</body>
</html>

