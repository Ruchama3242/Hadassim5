using Microsoft.EntityFrameworkCore.Migrations;

using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SuperMarket.Migrations
{
    /// <inheritdoc />
    public partial class B : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "OwnerId",
                table: "orders",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "OwnerId",
                table: "orders");
        }
    }
}
