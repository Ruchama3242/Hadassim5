namespace SuperMarket.Model
{
    public class Product
    {
        public int id { get; set; }
        public string name { get; set; }
        public int price { get; set; }
        public int minimumQuantity { get; set; }
      public int supplierId { get; set; }

       
    }
}