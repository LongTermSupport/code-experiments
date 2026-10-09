Console.WriteLine(new Greeter().Greeting());

internal sealed class Greeter
{
    public string Greeting()
    {
        return "Hello, world";
    }
}
