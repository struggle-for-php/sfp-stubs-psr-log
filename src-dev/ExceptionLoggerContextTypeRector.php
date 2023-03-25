<?php

namespace SfpDev\Stubs\Psr\Log;

use PHPStan\PhpDocParser\Ast\PhpDoc\GenericTagValueNode;

final class ExceptionLoggerContextTypeRector extends AbstractLoggerContextTypeRector
{
    public function getLoggerContextTypeTagValueNode(): GenericTagValueNode
    {
        return new GenericTagValueNode('LoggerContextType = array{exception?: \Exception}');
    }
}