using System.Collections.Generic;
using System.Threading.Tasks;
using SuperMarket.DAL;
using SuperMarket.Model;

namespace SuperMarket.BL
{
    public class ProductBL
    {
        private readonly ProductDal productDal;

        public ProductBL(ProductDal productDal)
        {
            this.productDal = productDal;
        }

        // שליפת רשימת מוצרים עבור ספק מסוים
        public async Task<List<Product>> GetProductsForSupplierAsync(int supplierId)
        {
            return await productDal.GetProductsForSupplierAsync(supplierId);
        }

        
        public async Task<Product> GetProductAsync(int productId)
        {
            return await productDal.GetProductAsync(productId);
        }
    }
}
