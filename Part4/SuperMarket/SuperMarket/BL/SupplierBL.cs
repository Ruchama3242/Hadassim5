using SuperMarket.DAL;
using SuperMarket.Model;

namespace SuperMarket.BL
{
    public class SupplierBL
    {
        private readonly SupplierDal _supplierDAL;
        public SupplierBL(SupplierDal supplierDAL)
        {
            _supplierDAL= supplierDAL;

        }

        public async Task<Supplier> registerSupplierAsync(Supplier supplier)
        {
            return await _supplierDAL.addSupplierAsync(supplier);
        }

        public async Task<Supplier> GetSupplierAsync(int id)
        {
            return await _supplierDAL.GetSupplierAsync(id);
        }

        public async Task<List<Supplier>> GetAllSuppliersAsync()
        {
            return await _supplierDAL.GetAllSuppliersAsync();
        }

        public async Task<Supplier> GetSupplierByCredentialsAsync(string companyName, string phone, string representativeName)
        {
            return await _supplierDAL.GetSupplierByCredentialsAsync(companyName, phone, representativeName);
        }
    }
}
