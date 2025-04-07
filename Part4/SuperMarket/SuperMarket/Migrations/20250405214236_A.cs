using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SuperMarket.Migrations
{
    /// <inheritdoc />
    public partial class A : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Suppliers_supplierId",
                table: "Products");

            migrationBuilder.RenameColumn(
                name: "supplierId",
                table: "Products",
                newName: "Supplierid");

            migrationBuilder.RenameIndex(
                name: "IX_Products_supplierId",
                table: "Products",
                newName: "IX_Products_Supplierid");

            migrationBuilder.AlterColumn<int>(
                name: "Supplierid",
                table: "Products",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<int>(
                name: "supplierId",
                table: "orders",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Suppliers_Supplierid",
                table: "Products",
                column: "Supplierid",
                principalTable: "Suppliers",
                principalColumn: "id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Suppliers_Supplierid",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "supplierId",
                table: "orders");

            migrationBuilder.RenameColumn(
                name: "Supplierid",
                table: "Products",
                newName: "supplierId");

            migrationBuilder.RenameIndex(
                name: "IX_Products_Supplierid",
                table: "Products",
                newName: "IX_Products_supplierId");

            migrationBuilder.AlterColumn<int>(
                name: "supplierId",
                table: "Products",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Suppliers_supplierId",
                table: "Products",
                column: "supplierId",
                principalTable: "Suppliers",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
