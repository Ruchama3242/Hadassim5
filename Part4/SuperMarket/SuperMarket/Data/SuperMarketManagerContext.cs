using Microsoft.EntityFrameworkCore;
using SuperMarket.Model;

namespace SuperMarket.Data
{
    public class SuperMarketManagerContext : DbContext
    {
        // בנאי שמקבל את האופציות
        public SuperMarketManagerContext(DbContextOptions<SuperMarketManagerContext> options) : base(options)
        {
        }

        // הגדרת DbSet לכל טבלה/ישות
        public DbSet<Supplier> Suppliers { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Order> orders { get; set; }
        public DbSet<OrderItem> orderItems { get; set; }
    }
}