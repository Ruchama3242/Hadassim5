using Microsoft.EntityFrameworkCore;
using SuperMarket.Data;
using SuperMarket.Model;

namespace SuperMarket.DAL
{
    public class SupplierDal
    {
        private readonly SuperMarketManagerContext context;
        public SupplierDal(SuperMarketManagerContext context)
        {
            this.context = context;
        }

        public async Task<Supplier> addSupplierAsync(Supplier supplier)
        {
            context.Suppliers.Add(supplier);
            await context.SaveChangesAsync();
            return supplier;
        }

        public async Task<Supplier> GetSupplierAsync(int id)
        {
            return await context.Suppliers.FirstOrDefaultAsync(s => s.id == id);
        }

       
        public async Task<List<Supplier>> GetAllSuppliersAsync()
        {
            return await context.Suppliers.ToListAsync();
        }

        public async Task<Supplier> GetSupplierByCredentialsAsync(string companyName, string phone, string representativeName)
        {
            return await context.Suppliers
                .FirstOrDefaultAsync(s => s.companyName == companyName
                                        && s.phone == phone
                                        && s.RepresentativeName == representativeName);
        }

    }
}
