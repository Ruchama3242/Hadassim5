using Microsoft.EntityFrameworkCore;
using SuperMarket.Data;
using SuperMarket.Model;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SuperMarket.DAL
{
    public class OrderDal
    {
        private readonly SuperMarketManagerContext context;
        public OrderDal(SuperMarketManagerContext context)
        {
            this.context = context;
        }

        // שליפת כל ההזמנות עבור ספק מסוים
        public async Task<List<Order>> GetOrdersForSupplierAsync(int supplierId)
        {
            return await context.orders
                .Where(o => o.supplierId == supplierId)
                .Include(o => o.OrderItems)         // טוען את רשימת הפריטים
                .ThenInclude(oi => oi.product)     
                .ToListAsync();
        }


        // שליפת הזמנה לפי מזהה
        public async Task<Order> GetOrderAsync(int orderId)
        {
            return await context.orders
                .Include(o => o.supplier)
                .Include(o => o.OrderItems)
                .ThenInclude(oi => oi.product)
                 .FirstOrDefaultAsync(o => o.id == orderId);

        }



        // עדכון סטטוס ההזמנה
        public async Task<Order> UpdateOrderStatusAsync(int orderId, string newStatus)
        {
            var order = await GetOrderAsync(orderId);
            if (order != null)
            {
                order.status = newStatus;
                await context.SaveChangesAsync();
            }
            return order;
        }

        // שליפת כל ההזמנות עבור בעל המכולת (Owner)
        public async Task<List<Order>> GetOrdersForOwnerAsync(int ownerId)
        {
            return await context.orders
                .Where(o => o.OwnerId == ownerId)
                .ToListAsync();
        }

        // הוספת הזמנה חדשה (יצירת הזמנה)
        public async Task<Order> AddOrderAsync(Order order)
        {
            context.orders.Add(order);
            await context.SaveChangesAsync();
            return order;
        }

        
    }
}
