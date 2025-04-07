using Microsoft.EntityFrameworkCore;
using SuperMarket.Data;
using SuperMarket.BL;
using SuperMarket.DAL;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();


builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddDbContext<SuperMarketManagerContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));


builder.Services.AddScoped<SupplierDal>();
builder.Services.AddScoped<SupplierBL>();


builder.Services.AddScoped<OrderDal>();
builder.Services.AddScoped<OrderBL>();


builder.Services.AddScoped<ProductBL>();
builder.Services.AddScoped<ProductDal>();
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowReactApp",
        builder =>
        {
            builder.WithOrigins("http://localhost:3000") // כתובת ה-React שלך
                   .AllowAnyHeader()
                   .AllowAnyMethod();
        });
});

var app = builder.Build();

app.UseCors("AllowReactApp");


if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();


app.MapControllers();


app.Run();
