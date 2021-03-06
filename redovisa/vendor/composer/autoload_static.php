<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit9b97cb07b8dbb2eb8716ba585eaa284b
{
    public static $files = array (
        '2cffec82183ee1cea088009cef9a6fc3' => __DIR__ . '/..' . '/ezyang/htmlpurifier/library/HTMLPurifier.composer.php',
        'b6ec61354e97f32c0ae683041c78392a' => __DIR__ . '/..' . '/scrivo/highlight.php/HighlightUtilities/functions.php',
    );

    public static $prefixLengthsPsr4 = array (
        'M' => 
        array (
            'Michelf\\' => 8,
        ),
        'A' => 
        array (
            'Anax\\' => 5,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'Michelf\\' => 
        array (
            0 => __DIR__ . '/..' . '/michelf/php-markdown/Michelf',
        ),
        'Anax\\' => 
        array (
            0 => __DIR__ . '/..' . '/anax/textfilter/src',
        ),
    );

    public static $prefixesPsr0 = array (
        'M' => 
        array (
            'Michelf' => 
            array (
                0 => __DIR__ . '/..' . '/michelf/php-smartypants',
            ),
        ),
        'H' => 
        array (
            'Highlight\\' => 
            array (
                0 => __DIR__ . '/..' . '/scrivo/highlight.php',
            ),
            'HighlightUtilities\\' => 
            array (
                0 => __DIR__ . '/..' . '/scrivo/highlight.php',
            ),
            'HTMLPurifier' => 
            array (
                0 => __DIR__ . '/..' . '/ezyang/htmlpurifier/library',
            ),
        ),
    );

    public static $classMap = array (
        'Composer\\InstalledVersions' => __DIR__ . '/..' . '/composer/InstalledVersions.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit9b97cb07b8dbb2eb8716ba585eaa284b::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit9b97cb07b8dbb2eb8716ba585eaa284b::$prefixDirsPsr4;
            $loader->prefixesPsr0 = ComposerStaticInit9b97cb07b8dbb2eb8716ba585eaa284b::$prefixesPsr0;
            $loader->classMap = ComposerStaticInit9b97cb07b8dbb2eb8716ba585eaa284b::$classMap;

        }, null, ClassLoader::class);
    }
}
