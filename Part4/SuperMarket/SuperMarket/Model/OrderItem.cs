namespace SuperMarket.Model
{
    public class OrderItem
    {
        public int id { get; set; }
        public int productId { get; set; }
        public Product product { get; set; }
        public int quantity { get; set; }
    }
}