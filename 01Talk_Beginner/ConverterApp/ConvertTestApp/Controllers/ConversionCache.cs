using System;
using System.Threading;
using Microsoft.Extensions.Caching.Memory;

namespace ConvertTestApp.Controllers
{
    public class ConversionCache
    {
        private readonly IMemoryCache _cache;

        public ConversionCache(IMemoryCache memoryCache)
        {
            _cache = memoryCache;
        }

        public double GetCachedConvertedValue(double distanceInMiles)
        {
            double cacheEntry;

            if (!_cache.TryGetValue(distanceInMiles, out cacheEntry))
            {
                Thread.Sleep(1000);

                cacheEntry = Converter.ConvertFromMilesToKm(distanceInMiles);

                var cacheEntryOptions = new MemoryCacheEntryOptions()
                    .SetSlidingExpiration(TimeSpan.FromSeconds(30));

                _cache.Set(distanceInMiles, cacheEntry, cacheEntryOptions);
            }

            return cacheEntry;
        }
    }
}
