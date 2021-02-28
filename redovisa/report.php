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
        <section>
            <?php
            $filename = __DIR__ . "/kmom01.md";
            $text     = file_get_contents($filename);
            $filter   = new \Anax\TextFilter\TextFilter();
            $parsed   = $filter->parse($text, ["shortcode", "markdown"]);
            echo $parsed->text;
            ?>
        </section>
        <section>
            <?php
            $filename = __DIR__ . "/kmom02.md";
            $text     = file_get_contents($filename);
            $filter   = new \Anax\TextFilter\TextFilter();
            $parsed   = $filter->parse($text, ["shortcode", "markdown"]);
            echo $parsed->text;
            ?>
        </section>
        <section>
            <?php
            $filename = __DIR__ . "/kmom03.md";
            $text     = file_get_contents($filename);
            $filter   = new \Anax\TextFilter\TextFilter();
            $parsed   = $filter->parse($text, ["shortcode", "markdown"]);
            echo $parsed->text;
            ?>
        </section>
        <section>
            <?php
            $filename = __DIR__ . "/kmom04.md";
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
