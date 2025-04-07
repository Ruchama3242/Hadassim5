// pages/CreateOrder.js
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

function CreateOrder() {
  const [suppliers, setSuppliers] = useState([]);
  const [selectedSupplier, setSelectedSupplier] = useState(null);
  const [products, setProducts] = useState([]);
  const [orderItems, setOrderItems] = useState([]);
  const navigate = useNavigate();
  const ownerId = 1; // מזהה קבוע של בעל המכולת

  // שליפת רשימת הספקים מהשרת
  useEffect(() => {
    fetch('https://localhost:5001/api/owner/suppliers')
      .then((res) => {
        if (!res.ok) throw new Error('Failed to fetch suppliers');
        return res.json();
      })
      .then((data) => {
        console.log("Suppliers fetched:", data);
        setSuppliers(data);
      })
      .catch((err) => console.error("Error fetching suppliers:", err));
  }, []);

  // בעת בחירת ספק, טוענים את המוצרים שלו
  const handleSupplierSelect = (supplier) => {
    console.log("Selected supplier:", supplier);
    setSelectedSupplier(supplier);
    fetch(`https://localhost:5001/api/owner/suppliers/${supplier.id}/products`)
      .then((res) => {
        if (!res.ok) throw new Error('Failed to fetch products');
        return res.json();
      })
      .then((data) => {
        console.log("Products fetched:", data);
        setProducts(data);
        // אתחול orderItems – עבור כל מוצר, אתחול הכמות ל-0
        setOrderItems(data.map(product => ({ productId: product.id, quantity: 0 })));
      })
      .catch((err) => console.error("Error fetching products:", err));
  };

  // עדכון כמות עבור מוצר מסוים
  const handleQuantityChange = (productId, value) => {
    setOrderItems(orderItems.map(item =>
      item.productId === productId ? { ...item, quantity: Number(value) } : item
    ));
  };

  // שליחת הזמנה
  const handleCreateOrder = async () => {
    // סינון פריטים עם כמות > 0
    const itemsToOrder = orderItems.filter(item => item.quantity > 0);
    console.log('בדיקה', itemsToOrder);
    if (!selectedSupplier || itemsToOrder.length === 0) {
      alert('בחר ספק והזן כמות עבור לפחות מוצר אחד.');
      return;
    }
    
    // הוספת שם המוצר לכל פריט על ידי חיפוש במערך המוצרים
    const enrichedItems = itemsToOrder.map(item => {
      const product = products.find(p => p.id === item.productId);
      console.log('בדיקה עבור item', item, 'מוצר:', product);
      if (!product) {
        console.error(`המוצר עם מזהה ${item.productId} לא נמצא במערך products`);
      }
      return {
        productId: item.productId,
        quantity: item.quantity,
        productName: product ? product.name : "לא נמצא מוצר"
      };
    });
    
    const orderData = {
      OwnerId: ownerId,
      SupplierId: selectedSupplier.id,
      OrderItems: enrichedItems
    };

    try {
      console.log("Order data being sent:", orderData);
      const response = await fetch('https://localhost:5001/api/owner/orders', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(orderData)
      });
      if (!response.ok) throw new Error('Order creation failed');
      alert('הזמנה נוצרה בהצלחה');
      navigate('/manager-dashboard');
    } catch (error) {
      console.error("Error creating order:", error);
      alert(`שגיאה ביצירת ההזמנה: ${error}`);
    }
    
  };

  const handleBack = () => {
    navigate(-1);
  };

  return (
    <div style={{ textAlign: 'right', direction: 'rtl', padding: '20px', maxWidth: '600px', margin: '0 auto' }}>
      <h2 style={{ marginBottom: '20px' }}>יצירת הזמנה חדשה</h2>
      <div style={{ marginBottom: '20px' }}>
        <button onClick={handleBack} style={{ marginRight: '10px' }}>חזרה</button>
      </div>
      
      {!selectedSupplier ? (
        <div>
          <h3 style={{ marginBottom: '10px' }}>בחר ספק</h3>
          {suppliers.length === 0 ? (
            <p>לא נמצאו ספקים. בדקי את השרת.</p>
          ) : (
            <ul style={{ listStyle: 'none', padding: 0 }}>
              {suppliers.map(supplier => (
                <li key={supplier.id} style={{ marginBottom: '10px', borderBottom: '1px solid #ccc', paddingBottom: '10px' }}>
                  <span>
                    שם ספק: {supplier.companyName}      טלפון: {supplier.phone}         נציג: {supplier.representativeName}
                  </span>
                  <button 
                    onClick={() => handleSupplierSelect(supplier)} 
                    style={{ marginLeft: '10px' }}
                  >
                    בחר ספק
                  </button>
                </li>
              ))}
            </ul>
          )}
        </div>
      ) : (
        <div>
          <h3 style={{ marginBottom: '10px' }}>מוצרים עבור {selectedSupplier.companyName}</h3>
          {products.length === 0 ? (
            <p>לא נמצאו מוצרים עבור ספק זה.</p>
          ) : (
            <ul style={{ listStyle: 'none', padding: 0 }}>
              {products.map(product => (
                <li key={product.id} style={{ marginBottom: '10px', borderBottom: '1px solid #ccc', paddingBottom: '10px' }}>
                  <span>
                    {product.name} - מחיר: {product.price} - מינימום: {product.minimumQuantity}
                  </span>
                  <input
                    type="number"
                    placeholder="כמות"
                    onChange={(e) => handleQuantityChange(product.id, e.target.value)}
                    style={{ marginLeft: '10px', width: '80px' }}
                  />
                </li>
              ))}
            </ul>
          )}
          <button onClick={handleCreateOrder} style={{ marginTop: '20px' }}>
            אשר הזמנה
          </button>
        </div>
      )}
    </div>
  );
}

export default CreateOrder;
