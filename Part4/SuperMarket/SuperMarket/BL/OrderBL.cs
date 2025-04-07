using SuperMarket.DAL;
using SuperMarket.DTOs;
using SuperMarket.Model;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SuperMarket.BL
{
    public class OrderBL
    {
        private readonly OrderDal orderDal;
        private readonly ProductDal productDal;
        public OrderBL(OrderDal orderDal,ProductDal productDal)
        {
            this.orderDal = orderDal;
            this.productDal = productDal;
        }

        // קריאה ל-DAL לשליפת כל ההזמנות עבור ספק
        public async Task<List<Order>> GetOrdersForSupplierAsync(int supplierId)
        {
            return await orderDal.GetOrdersForSupplierAsync(supplierId);
        }

        // אישור הזמנה – שינוי סטטוס ל״בתהליך״
        public async Task<Order> ApproveOrderAsync(int orderId)
        {
            
            return await orderDal.UpdateOrderStatusAsync(orderId, "בתהליך");
        }
        //קבלת רשימת מוצרים ויצירת הזמנה
        public async Task<Order> CreateOrderAsync(OrderCreationDto orderDto)
        {
            var orderItems = new List<OrderItem>();

            foreach (var item in orderDto.OrderItems)
            {
                // שליפת מוצר מהמסד
                var product = await productDal.GetProductAsync(item.ProductId);
                if (product == null)
                    throw new ArgumentException($"המוצר עם מזהה {item.ProductId} לא נמצא.");

                if (item.Quantity < product.minimumQuantity)
                    throw new ArgumentException($"הכמות עבור {product.name} צריכה להיות לפחות {product.minimumQuantity}.");

                orderItems.Add(new OrderItem
                {
                    productId = product.id,
                    quantity = item.Quantity
                });
            }

            // יצירת ההזמנה – סטטוס ראשוני הוא "ממתינה לאישור"
            var order = new Order
            {
                supplierId = orderDto.SupplierId,
                OwnerId = orderDto.OwnerId,
                date = DateTime.Now,
                status = "ממתינה לאישור",
                OrderItems = orderItems
            };

            return await orderDal.AddOrderAsync(order);
        }

        //שינוי סטטוס ההזמנה ל"הושלמה"
        public async Task<Order> ConfirmOrderAsync(int orderId)
        {
            return await orderDal.UpdateOrderStatusAsync(orderId, "הושלמה");
        }

        public async Task<Order> GetOrderAsync(int orderId)
        {
            return await orderDal.GetOrderAsync(orderId);
        }

        public async Task<List<Order>> GetOrdersForOwnerAsync(int ownerId)
        {
            return await orderDal.GetOrdersForOwnerAsync(ownerId);
        }



    }
}