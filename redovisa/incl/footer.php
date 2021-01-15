<footer id="site-footer">
    <hr>
    Validatorer:
    <a href="http://validator.w3.org/check/referer" target="_blank">HTML5</a>
    <a href="http://jigsaw.w3.org/css-validator/check/referer" target="_blank">CSS</a>
    <a href="http://validator.w3.org/unicorn/check?ucn_uri=referer&amp;ucn_task=conformance" target="_blank">Unicorn</a>
    <br>
    Specifikationer:
    <a href="https://www.w3.org/2009/cheatsheet/" target="_blank">Cheatsheet</a>
    <a href="https://html.spec.whatwg.org/" target="_blank">HTML</a>
    <a href="https://www.w3.org/TR/CSS/" target="_blank">CSS</a>
    <a href="https://www.w3.org/TR/css-color-3/" target="_blank">CSS Color L3</a>
    <br>
    Verktyg:
    <a href="https://caniuse.com/" target="_blank">Can I use</a>
    <a href="https://www.w3schools.com/" target="_blank">W3Schools</a>
    <?php
        $numFiles   = count(get_included_files());
        $memoryUsed = memory_get_peak_usage(true);
        $memoryUsed_mib = $memoryUsed / 1024**2;
        $loadTime   = microtime(true) - $_SERVER['REQUEST_TIME_FLOAT'];
        $loadTime_ms = round($loadTime * 1000, 3);
    ?>
    <p>Time to load page: <?= $loadTime_ms ?>ms. Memory used: <?= $memoryUsed_mib ?>MiB. #files included: <?= $numFiles ?>.</p>
</footer>

</body>
</html>
