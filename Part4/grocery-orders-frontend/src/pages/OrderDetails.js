// pages/OrderDetails.js
import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';

function OrderDetails() {
  const { orderId } = useParams();
  const [order, setOrder] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
    fetch(`https://localhost:5001/api/owner/orders/${orderId}`)
      .then((res) => {
        if (!res.ok) {
          throw new Error('Failed to fetch order details');
        }
        return res.json();
      })
      .then((data) => {
        console.log("Order details:", data);
        setOrder(data);
      })
      .catch((err) => console.error(err));
  }, [orderId]);

  return (
    <div style={{ textAlign: 'right', direction: 'rtl', padding: '20px' }}>
      {order ? (
        <>
          <h2>פרטי הזמנה מס׳ {order.id}</h2>
          <p><strong>תאריך:</strong> {order.date}</p>
          <p><strong>סטטוס:</strong> {order.status}</p>

          {/* הצגת פרטי הספק */}
          {order.supplierId ? (
            <>
              <h3>פרטי הספק</h3>
              <p><strong>מזהה ספק:</strong> {order.supplier.id}</p>
              <p><strong>שם החברה:</strong> {order.supplier.companyName}</p>
              <p><strong>טלפון:</strong> {order.supplier.phone}</p>
              <p><strong>שם נציג:</strong> {order.supplier.representativeName}</p>
            </>
          ) : (
            <p>פרטי הספק לא זמינים.</p>
          )}

          {/* הצגת רשימת המוצרים בהזמנה */}
          {order.orderItems && order.orderItems.length > 0 ? (
            <>
              <h3>מוצרים בהזמנה</h3>
              <ul>
                {order.orderItems.map((item, index) => (
                  <li key={index} style={{ marginBottom: '10px' }}>
                    <p>
                      <strong>מוצר:</strong> {item.productName ? item.productName : (item.product && item.product.name)}
                    </p>
                    <p><strong>כמות:</strong> {item.quantity}</p>
                  </li>
                ))}
              </ul>
            </>
          ) : (
            <p>אין מוצרים בהזמנה זו.</p>
          )}
          
          <button onClick={() => navigate(-1)} style={{ marginTop: '10px' }}>
            חזרה
          </button>
        </>
      ) : (
        <p>טוען פרטי הזמנה...</p>
      )}
    </div>
  );
}

export default OrderDetails;
