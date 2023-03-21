PSR-3 psr/log stubs for static analysis
=======================================

This repository is aimed for used by these.

 - https://github.com/struggle-for-php/sfp-psalm-psr-log-plugin
 - https://github.com/struggle-for-php/sfp-phpstan-psr-log

But, You can use this for individual purpose.

## Features

### Typed context array, in order to force `exception` key is only Throwable object.

#### Example

```php
<?php
/** @var Psr\Log\LoggerInterface $logger */
$logger->error('error happen.', ['exception' => $exception->getMessage()]);
```

Your Static analysis would points like this message.
```
Parameter #2 $context of method Psr\Log\LoggerInterface::error() expects array()|array('exception' => Exception),
```
#### Refs.

> Implementors MUST still verify that the 'exception' key is actually an Exception before using it as such, as it MAY contain anything.

https://www.php-fig.org/psr/psr-3/#13-context

The PSR-3 specification states `Exception` but we have confirmed with PHP-FIG that `Throwable` is allowed for PHP 7 and later.

https://groups.google.com/g/php-fig/c/nnwDWSFmij8

### `level` parameter of `log` method is a constant enum of LogLevels::*.

## Not Support (Not planned)

- Stub `LoggerAwareTrait` with @psalm-require-implements
  - https://psalm.dev/docs/annotating_code/supported_annotations/#psalm-require-implements

