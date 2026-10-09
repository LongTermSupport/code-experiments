<?php

declare(strict_types=1);

namespace Example\Tests;

use Example\Hello;
use PHPUnit\Framework\Attributes\CoversClass;
use PHPUnit\Framework\TestCase;

/**
 * @internal
 */
#[CoversClass(Hello::class)]
final class HelloTest extends TestCase
{
    public function testGreet(): void
    {
        self::assertSame('Hello, world!', new Hello()->greet('world'));
    }
}
