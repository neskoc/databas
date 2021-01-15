
<?php $uriFile = basename($_SERVER["REQUEST_URI"]); ?>

<nav class="navbar">
    <a href="me.php"
        class='<?= $uriFile == "me.php" ? "selected" : "a-navbar" ?>'>Hem</a>
    <a href="report.php"
        class='<?= $uriFile == "report.php" ? "selected" : "a-navbar" ?>'>Redovisning</a>
    <a href="about.php"
        class='<?= $uriFile == "about.php" ? "selected" : "a-navbar" ?>'>Om</a>
</nav>
