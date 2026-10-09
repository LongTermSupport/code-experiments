<?php

declare(strict_types=1);

namespace Example;

final class Hello
{
    public function greet(string $name): string
    {
        return 'Hello, ' . $name . '!';
    }
}
