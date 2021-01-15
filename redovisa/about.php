<?php
    include("incl/config.php");
    $title = "Om webbsidan | $shortName";
    include("incl/header.php");
    include("incl/navbar.php");
?>

<main>
<article  class="all-browsers">
    <header>
        <h1>Om webbsidan</h1>
    </header>
    <p>
        Detta är en presentation- och redovisningssida för kursen:
        <br>
        <strong><?= $longName ?></strong>
        <br/>
        Kursida på <a href="<?= $dbwebbUrl ?>">dbwebb</a> och <a href="<?= $githubUrl ?>">github</a>
    </p>
</article>
</main>

<?php
    include("incl/byline.php");
    include("incl/footer.php");
?>
