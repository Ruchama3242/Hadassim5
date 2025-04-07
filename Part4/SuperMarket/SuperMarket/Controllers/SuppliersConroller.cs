using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using SuperMarket.BL;
using SuperMarket.Model;
using SuperMarket.DTOs; // ודאי שה-DTO מיובא

namespace SuperMarket.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SuppliersController : ControllerBase
    {
        private readonly SupplierBL supplierBL;
        private readonly OrderBL orderBL;

        public SuppliersController(SupplierBL supplierBL, OrderBL orderBL)
        {
            this.supplierBL = supplierBL;
            this.orderBL = orderBL;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] Supplier supplier)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var registeredSupplier = await supplierBL.registerSupplierAsync(supplier);
            return CreatedAtAction(nameof(GetSupplier), new { id = registeredSupplier.id }, registeredSupplier);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetSupplier(int id)
        {
            var supplier = await supplierBL.GetSupplierAsync(id);
            if (supplier == null)
            {
                return NotFound();
            }
            return Ok(supplier);
        }

       
        [HttpGet("{supplierId}/orders")]
        public async Task<IActionResult> GetOrdersForSupplier(int supplierId)
        {
            var orders = await orderBL.GetOrdersForSupplierAsync(supplierId);
            if (orders == null || orders.Count == 0)
            {
                return NotFound("אין הזמנות עבור ספק זה.");
            }
            return Ok(orders);
        }


        [HttpPost("orders/{orderId}/approve")]
        public async Task<IActionResult> ApproveOrder(int orderId)
        {
            var order = await orderBL.ApproveOrderAsync(orderId);
            if (order == null)
            {
                return NotFound($"לא נמצאה הזמנה עם מזהה {orderId}.");
            }
            return Ok(order);
        }

        
        [HttpPost("login")]
        
        public async Task<IActionResult> Login([FromBody] SupplierLoginDto loginDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // חיפוש ספק קיים לפי הפרטים
            var supplier = await supplierBL.GetSupplierByCredentialsAsync(
                loginDto.CompanyName,
                loginDto.Phone,
                loginDto.RepresentativeName);

            if (supplier == null)
            {
              
                return NotFound("הספק לא קיים. נא להרשם באמצעות האנדפוינט המתאים.");
            }

           
            var orders = await orderBL.GetOrdersForSupplierAsync(supplier.id);

            return Ok(new { supplier, orders });
        }
    }
}
