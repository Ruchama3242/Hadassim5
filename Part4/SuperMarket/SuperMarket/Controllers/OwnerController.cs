using Microsoft.AspNetCore.Mvc;
using SuperMarket.BL;
using SuperMarket.DTOs;

namespace SuperMarket.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class OwnerController : ControllerBase
    {
        private readonly OrderBL orderBL;
        private readonly SupplierBL supplierBL; 
        private readonly ProductBL productBL;   // אם יש לך שכבת BL למוצרים

        public OwnerController(OrderBL orderBL, SupplierBL supplierBL, ProductBL productBL)
        {
            this.orderBL = orderBL;
            this.supplierBL = supplierBL;
            this.productBL = productBL;
        }

        [HttpGet("orders")]
        public async Task<IActionResult> GetOrdersForOwner([FromQuery] int ownerId)
        {
            var orders = await orderBL.GetOrdersForOwnerAsync(ownerId);
            if (orders == null || orders.Count == 0)
                return NotFound("אין הזמנות עבור בעל המכולת.");
            return Ok(orders);
        }


        // Endpoint לקבלת רשימת ספקים 
        [HttpGet("suppliers")]
        public async Task<IActionResult> GetAllSuppliers()
        {
            var suppliers = await supplierBL.GetAllSuppliersAsync();
            return Ok(suppliers);
        }

        // Endpoint לקבלת מוצרים עבור ספק מסוים
        [HttpGet("suppliers/{supplierId}/products")]
        public async Task<IActionResult> GetProductsForSupplier(int supplierId)
        {
            var products = await productBL.GetProductsForSupplierAsync(supplierId);
            if (products == null || products.Count == 0)
                return NotFound("לא נמצאו מוצרים עבור ספק זה.");
            return Ok(products);
        }

        // Endpoint ליצירת הזמנה חדשה
        [HttpPost("orders")]
        public async Task<IActionResult> CreateOrder([FromBody] OrderCreationDto orderDto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            try
            {
                var createdOrder = await orderBL.CreateOrderAsync(orderDto);
                return CreatedAtAction(nameof(GetOrder), new { orderId = createdOrder.id }, createdOrder);
            }
            catch (System.ArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        // Endpoint לשליפת הזמנה לפי מזהה (לצורך CreatedAtAction)
        [HttpGet("orders/{orderId}")]
        public async Task<IActionResult> GetOrder(int orderId)
        {
            var order = await orderBL.GetOrderAsync(orderId);
            if (order == null)
                return NotFound();
            return Ok(order);
        }

        // Endpoint לאישור הזמנה – בעל המכולת מאשר שקיבל את ההזמנה, והסטטוס משתנה ל"הושלמה"
        [HttpPost("orders/{orderId}/complete")]
        public async Task<IActionResult> CompleteOrder(int orderId)
        {
            var order = await orderBL.ConfirmOrderAsync(orderId);
            if (order == null)
                return NotFound($"לא נמצאה הזמנה עם מזהה {orderId}.");
            return Ok(order);
        }
    }
}
