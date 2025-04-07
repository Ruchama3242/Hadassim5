using System.Collections.Generic;

namespace SuperMarket.Model
{
    public class Supplier
    {
        public int id { get; set; }
        public string companyName { get; set; }
        public string phone { get; set; }
        public string RepresentativeName { get; set; }
        public ICollection<Product> Products { get; set; }
    }
}