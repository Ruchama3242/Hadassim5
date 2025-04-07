// pages/ManagerDashboard.js
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

function ManagerDashboard() {
  const [orders, setOrders] = useState([]);
  const [filterStatus, setFilterStatus] = useState("all"); // "all", "ממתינה לאישור", "בתהליך", "הושלמה"
  const navigate = useNavigate();
  const ownerId = 1; //  מזהה קבוע של בעל המכולת יהיה 1

  useEffect(() => {
    fetch(`https://localhost:5001/api/owner/orders?ownerId=${ownerId}`)
      .then((res) => {
        if (!res.ok) {
          throw new Error('Failed to fetch orders');
        }
        return res.json();
      })
      .then((data) => setOrders(data))
      .catch((err) => console.error(err));
  }, [ownerId]);

  const handleApprove = async (orderId) => {
    try {
      const response = await fetch(`https://localhost:5001/api/owner/orders/${orderId}/complete`, {
        method: 'POST'
      });
      if (!response.ok) throw new Error('Confirm failed');
      alert('ההזמנה אושרה, סטטוס עבר ל"הושלמה"');
      setOrders(orders.map(o => o.id === orderId ? { ...o, status: "הושלמה" } : o));
    } catch (error) {
      console.error(error);
      alert('שגיאה באישור קבלת ההזמנה');
    }
  };

  const handleBack = () => {
    navigate(-1);
  };

  // מסננים את ההזמנות לפי הסטטוס שנבחר, או מציגים את כל ההזמנות אם נבחר "all"
  const filteredOrders = filterStatus === "all"
    ? orders
    : orders.filter(order => order.status === filterStatus);

  return (
    <div style={{ textAlign: 'right', direction: 'rtl', padding: '20px' }}>
      <h2>לוח הזמנות בעל/ת המכולת</h2>
      <button onClick={() => navigate('/manager/create-order')} style={{ marginBottom: '10px' }}>
        יצירת הזמנה חדשה
      </button>
      <button onClick={handleBack} style={{ marginBottom: '10px', marginRight: '10px' }}>
        חזרה
      </button>

      {/* כפתורי סינון */}
      <div style={{ marginBottom: '20px' }}>
        <span style={{ marginRight: '10px' }}>סינון לפי סטטוס:</span>
        <button onClick={() => setFilterStatus("all")} style={{ marginRight: '10px' }}>
          כל ההזמנות
        </button>
        <button onClick={() => setFilterStatus("ממתינה לאישור")} style={{ marginRight: '10px' }}>
          ממתינה לאישור
        </button>
        <button onClick={() => setFilterStatus("בתהליך")} style={{ marginRight: '10px' }}>
          בתהליך
        </button>
        <button onClick={() => setFilterStatus("הושלמה")} style={{ marginRight: '10px' }}>
          הושלמה
        </button>
      </div>

      <ul>
        {filteredOrders.map(order => (
          <li key={order.id} style={{ border: '1px solid #ccc', padding: '10px', marginBottom: '10px' }}>
            <p>מספר הזמנה: {order.id}</p>
            <p>תאריך: {order.date}</p>
            <p>סטטוס: {order.status}</p>
            <button onClick={() => navigate(`/manager/order/${order.id}`)} style={{ marginRight: '10px' }}>
              פרטים
            </button>
            {order.status === "בתהליך" && (
              <button onClick={() => handleApprove(order.id)}>
                אשר קבלת הזמנה
              </button>
            )}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default ManagerDashboard;
