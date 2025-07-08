<%-- 
    Document   : about
    Created on : 08-Jul-2025, 3:22:53 PM
    Author     : balwant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | AudioZila</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
     <link rel="stylesheet" href="mp3.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
        }

        header {
            padding: 20px 40px;
            text-align: center;
        }

        header h1 {
            font-size: 2.5rem;
            margin: 0;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        h2 {
            font-size: 1.8rem;
            margin-bottom: 10px;
        }

        p {
            line-height: 1.7;
            margin-bottom: 20px;
        }

        ul {
            padding-left: 20px;
        }

        ul li {
            margin-bottom: 10px;
        }

        .section {
            margin-bottom: 50px;
        }

        footer {
            background: #1a1a1a;
            text-align: center;
            padding: 20px;
            color: #888;
        }

        @media (max-width: 600px) {
            header h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>

    <header>
        <h1>About AudioZila</h1>
    </header>

    <div class="container">

        <div class="section">
            <h2>Welcome to AudioZila — Your Ultimate Music Destination!</h2>
            <p>At AudioZila, we believe music is more than sound — it’s emotion, culture, and connection. Whether you're a passionate listener, an aspiring artist, or a music producer, AudioZila is your go-to hub for everything audio.</p>
        </div>

        <div class="section">
            <h2>🎧 What We Offer</h2>
            <ul>
                <li>Latest Music Drops – Stay updated with new tracks across all genres.</li>
                <li>Curated Playlists – Discover music that suits every mood and moment.</li>
                <li>Artist Spotlights – Learn about trending and emerging artists.</li>
                <li>User Uploads & Sharing – Share your sound and grow your audience.</li>
                <li>Hi-Quality Audio Experience – Because great music deserves great sound.</li>
            </ul>
        </div>

        <div class="section">
            <h2>🎤 Our Mission</h2>
            <p>To connect the world through the power of music by creating a space where both creators and listeners thrive. We aim to break barriers, amplify voices, and deliver sonic experiences that move hearts.</p>
        </div>

        <div class="section">
            <h2>🌍 Why Choose AudioZila?</h2>
            <ul>
                <li>Easy and fast music streaming</li>
                <li>Smooth UI/UX across devices</li>
                <li>Regular content updates</li>
                <li>A platform that supports independent artists</li>
                <li>100% community-driven</li>
            </ul>
        </div>

        <div class="section">
            <h2>📍 Join Our Community</h2>
            <p>Whether you’re jamming solo, building beats, or promoting your latest single — AudioZila is for you. Dive in, explore sounds, and let your musical journey begin.</p>
        </div>

        <div class="section">
            <h2 style="text-align:center;">🎶 AudioZila – Feel the Music. Live the Beat.</h2>
        </div>
    </div>
    <%@include  file="footer.jsp" %>

</body>
</html>
