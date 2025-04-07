using System;
using System.Collections.Generic;

namespace SuperMarket.Model
{
    public class Order
    {
        public int id { get; set; }
        public DateTime date { get; set; }
        public string status { get; set; }
        public int supplierId { get; set; }
        public int OwnerId { get; set; }

        public ICollection<OrderItem> OrderItems { get; set; }

        public Supplier supplier { get; set; }
    }
}