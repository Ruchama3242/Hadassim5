// pages/SupplierDashboard.js
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

function SupplierDashboard() {
  const storedSupplierId = localStorage.getItem("supplierId");
  const supplierId = storedSupplierId ? parseInt(storedSupplierId, 10) : null;
  
  const [orders, setOrders] = useState([]);
  const navigate = useNavigate();

  // פונקציה לבדיקה והצגת הודעות עבור הזמנות שהושלמו
  const checkCompletedOrders = (ordersData) => {
    ordersData.forEach(order => {
      if (order.status === "הושלמה") {
        // בדיקה אם הודעת ההזמנה כבר הוצגה
        const messageShown = localStorage.getItem(`order_${order.id}_completed`);
        if (!messageShown) {
          alert(`הזמנה מס' ${order.id} התקבלה בהצלחה`);
          localStorage.setItem(`order_${order.id}_completed`, 'true');
        }
      }
    });
  };

  useEffect(() => {
    if (!supplierId) {
      console.error("Supplier ID is not available.");
      return;
    }
    fetch(`https://localhost:5001/api/suppliers/${supplierId}/orders`)
      .then(res => {
        if (!res.ok) {
          throw new Error('Failed to fetch orders');
        }
        return res.json();
      })
      .then(data => {
        setOrders(data);
        checkCompletedOrders(data);
      })
      .catch(err => console.error(err));
  }, [supplierId]);

  const handleApprove = async (orderId) => {
    try {
      const response = await fetch(`https://localhost:5001/api/suppliers/orders/${orderId}/approve`, {
        method: 'POST'
      });
      if (!response.ok) throw new Error('Approval failed');
      alert('הזמנה אושרה, סטטוס עבר ל"בתהליך"');
      setOrders(orders.map(o => o.id === orderId ? { ...o, status: "בתהליך" } : o));
    } catch (error) {
      console.error(error);
      alert('שגיאה באישור ההזמנה');
    }
  };

  const handleBack = () => {
    navigate(-1);
  };

  return (
    <div style={{ textAlign: 'right', direction: 'rtl', padding: '20px', maxWidth: '800px', margin: '0 auto' }}>
      <div style={{ marginBottom: '20px' }}>
        <button onClick={handleBack} style={{ marginRight: '10px' }}>
          חזרה
        </button>
      </div>
      <h2>לוח הזמנות ספק</h2>
      <ul style={{ listStyle: 'none', padding: 0 }}>
        {orders.map(order => (
          <li key={order.id} style={{ border: '1px solid #ccc', padding: '10px', marginBottom: '10px' }}>
            <p>מספר הזמנה: {order.id}</p>
            <p>תאריך: {order.date}</p>
            <p>סטטוס: {order.status}</p>
            <button onClick={() => navigate(`/supplier/order/${order.id}`)} style={{ marginRight: '10px' }}>
              פרטים
            </button>
            {order.status === "ממתינה לאישור" && (
              <button onClick={() => handleApprove(order.id)}>
                אשר הזמנה
              </button>
            )}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default SupplierDashboard;
