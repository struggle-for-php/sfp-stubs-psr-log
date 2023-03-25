<?php

namespace SfpDev\Stubs\Psr\Log;

use PHPStan\PhpDocParser\Ast\PhpDoc\GenericTagValueNode;

final class ThrowableLoggerContextTypeRector extends AbstractLoggerContextTypeRector
{
    public function getLoggerContextTypeTagValueNode(): GenericTagValueNode
    {
        return new GenericTagValueNode('LoggerContextType = array{exception?: \Throwable}');
    }
}