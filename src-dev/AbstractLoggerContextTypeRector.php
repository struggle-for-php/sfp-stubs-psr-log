<?php

declare(strict_types=1);

namespace SfpDev\Stubs\Psr\Log;

use PhpParser\Node;
use PHPStan\PhpDocParser\Ast\PhpDoc\GenericTagValueNode;
use PHPStan\PhpDocParser\Ast\PhpDoc\ParamTagValueNode;
use PHPStan\PhpDocParser\Ast\PhpDoc\PhpDocTagNode;
use PHPStan\PhpDocParser\Ast\Type\IdentifierTypeNode;
use Rector\Core\Rector\AbstractRector;
use Symplify\RuleDocGenerator\ValueObject\CodeSample\CodeSample;
use Symplify\RuleDocGenerator\ValueObject\RuleDefinition;

abstract class AbstractLoggerContextTypeRector extends AbstractRector
{
    public function getRuleDefinition(): RuleDefinition
    {
        return new RuleDefinition("", [new CodeSample('', '')]);
    }

    public function getNodeTypes(): array
    {
        return [
            Node\Stmt\Interface_::class,
            Node\Stmt\Class_::class,
            Node\Stmt\ClassMethod::class,
        ];
    }

    abstract public function getLoggerContextTypeTagValueNode(): GenericTagValueNode;

    public function refactor(Node $node) : Node
    {
        if (! $this->isObjectType($node, new \PHPStan\Type\ObjectType('Psr\Log\LoggerInterface'))) {
            return $node;
        }

        if ($node instanceof Node\Stmt\Interface_) {
            $phpDocInfo = $this->phpDocInfoFactory->createFromNode($node);
            $phpDocInfo->addPhpDocTagNode(
                new PhpDocTagNode('@psalm-type', $this->getLoggerContextTypeTagValueNode())
            );

            return $node;
        }

        if ($node instanceof Node\Stmt\Class_ && $node->name->name === 'AbstractLogger') {
            $phpDocInfo = $this->phpDocInfoFactory->createFromNode($node);
            $phpDocInfo->addPhpDocTagNode(
                new PhpDocTagNode('@psalm-import-type', new GenericTagValueNode('LoggerContextType from LoggerInterface'))
            );

            return $node;
        }


        if ($node instanceof Node\Stmt\ClassMethod) {
            $phpDocInfo = $this->phpDocInfoFactory->createFromNode($node);
            $context = $phpDocInfo->getParamTagValueByName('context');
            assert($context instanceof ParamTagValueNode);
            $context->type = new IdentifierTypeNode('LoggerContextType');

            if ($node->name->name === 'log') {
                $level = $phpDocInfo->getParamTagValueByName('level');
                assert($level instanceof ParamTagValueNode);
                $level->type = new IdentifierTypeNode('LogLevel::*');
            }

            return $node;
        }

        return $node;
    }
}