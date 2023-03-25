<?php declare(strict_types=1);

use Rector\Config\RectorConfig;

return static function (RectorConfig $config): void {
    $services = $config->services();

    $config->phpVersion(\Rector\Core\ValueObject\PhpVersion::PHP_53);
    $services->set(\SfpDev\Stubs\Psr\Log\ExceptionLoggerContextTypeRector::class);

    $config->paths([
        __DIR__ . '/../stubs-for-exception',
    ]);
};