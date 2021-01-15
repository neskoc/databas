<?php
require __DIR__ . "/vendor/autoload.php";
include("incl/config.php");
$title = "Redovisningssida | $shortName";
include("incl/header.php");
include("incl/navbar.php");
?>
<main>
    <article class="all-browsers">
        <header>
            <h1>Redovisningssida för Databskursen</h1>
        </header>
        <p>
            Här kommer finnas lösningar för de olika kursmomenten.
        </p>
        <section>
            <?php
            $filename = __DIR__ . "/kmom01.md";
            $text     = file_get_contents($filename);
            $filter   = new \Anax\TextFilter\TextFilter();
            $parsed   = $filter->parse($text, ["shortcode", "markdown"]);
            echo $parsed->text;
            ?>
        </section>
    </article>
</main>

<?php
// include("incl/byline.php");
include("incl/footer.php");
?>
