using Microsoft.AspNetCore.Mvc;

namespace Test_AppSettings.Controllers;

[ApiController]
[Route("[controller]")]
public class ValueController : ControllerBase
{
    IConfiguration iconfig;
    public ValueController(IConfiguration _iconfig)
    {
        iconfig = _iconfig;
    }

    public string Get()
    {
        return iconfig.GetValue<string>("TestRoot:Test.Value");
    }
}