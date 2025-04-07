using Microsoft.EntityFrameworkCore;
using SuperMarket.Data;
using SuperMarket.Model;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SuperMarket.DAL
{
    public class ProductDal
    {
        private readonly SuperMarketManagerContext context;
        public ProductDal(SuperMarketManagerContext context)
        {
            this.context = context;
        }

        public async Task<List<Product>> GetProductsForSupplierAsync(int supplierId)
        {
            return await context.Products
                .Where(p => p.supplierId == supplierId)
                .ToListAsync();
        }

        public async Task<Product> GetProductAsync(int productId)
        {
            return await context.Products.FirstOrDefaultAsync(p => p.id == productId);
        }
    }
}
