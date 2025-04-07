namespace SuperMarket.DTOs
{
    public class OrderCreationDto
    {
        public int SupplierId { get; set; }
        public int OwnerId { get; set; }
        public List<OrderItemDto> OrderItems { get; set; }
    }

    public class OrderItemDto
    {
        public int ProductId { get; set; }
        public int Quantity { get; set; }
        public string ProductName { get; set; }
    }

    public class SupplierLoginDto
    {
        public string CompanyName { get; set; }
        public string Phone { get; set; }
        public string RepresentativeName { get; set; }
    }
}
