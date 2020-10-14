using System;
using Microsoft.AspNetCore.Mvc;

namespace ConvertTestApp.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class ConvertController : ControllerBase
    {
        private readonly ConversionCache _conversionCache;

        public ConvertController(ConversionCache conversionCache)
        {
            _conversionCache = conversionCache;
        }

        [HttpGet]
        public string ConvertMiles([FromQuery] string distanceInMiles)
        {
            double miles;
            var isDouble = double.TryParse(distanceInMiles, out miles);
            if (isDouble)
            {
                return _conversionCache.GetCachedConvertedValue(miles).ToString();
            }
            else
            {
                if (distanceInMiles == "simulateError")
                {
                    throw new Exception("Intentionally throw exception if number fromat is wrong");
                }
                else
                {
                    return "\"WrongInput\"";
                }
            }
        }
    }
}
