namespace ConsoleApp.Tests;

using ConsoleApp.MyNamespace;

public class UnitTest1
{
    [Fact]
    public void Test1()
    {
        Assert.Equal(84, MyClass.TimesTwo(42));
    }
}
