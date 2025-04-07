// pages/SupplierLogin.js
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

function SupplierLogin() {
  const [companyName, setCompanyName] = useState('');
  const [phone, setPhone] = useState('');
  const [representativeName, setRepresentativeName] = useState('');
  const navigate = useNavigate();

// לדוגמה, בתוך handleLogin ב-SupplierLogin.js:
const handleLogin = async () => {
  // פורמט: אם המשתמש לא הזין גרשיים, נוסיף אותם
  const formattedCompanyName = companyName.trim().startsWith('"')
    ? companyName.trim()
    : `"${companyName.trim()}"`;
  const formattedRepresentativeName = representativeName.trim().startsWith('"')
    ? representativeName.trim()
    : `"${representativeName.trim()}"`;

  try {
    const response = await fetch('https://localhost:5001/api/suppliers/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        companyName: formattedCompanyName,
        phone: phone.trim(),
        representativeName: formattedRepresentativeName
      })
    });
    
    if (response.status === 404) {
      alert('הספק לא קיים, אנא הירשם באמצעות "הרשם כאן".');
      return;
    }
    
    if (!response.ok) {
      throw new Error('Login failed');
    }
    
    const data = await response.json();
    console.log("Logged in supplier:", data);
    // שמירת supplierId
    localStorage.setItem("supplierId", data.supplier.id);
    navigate('/supplier-dashboard');
  } catch (error) {
    console.error(error);
    alert('שגיאה בכניסה');
  }
};


  const handleBack = () => {
    navigate(-1);
  };

  return (
    <div style={{ textAlign: 'right', direction: 'rtl', padding: '20px' }}>
      <h2>כניסת ספק</h2>
      <input
        type="text"
        placeholder="שם חברה"
        value={companyName}
        onChange={(e) => setCompanyName(e.target.value)}
        style={{ marginBottom: '10px', width: '100%' }}
      />
      <br />
      <input
        type="text"
        placeholder="מספר טלפון"
        value={phone}
        onChange={(e) => setPhone(e.target.value)}
        style={{ marginBottom: '10px', width: '100%' }}
      />
      <br />
      <input
        type="text"
        placeholder="שם נציג"
        value={representativeName}
        onChange={(e) => setRepresentativeName(e.target.value)}
        style={{ marginBottom: '10px', width: '100%' }}
      />
      <br />
      <button onClick={handleLogin} style={{ marginRight: '10px' }}>התחבר</button>
      <button onClick={handleBack}>חזרה</button>
      <p>עדיין לא רשום? <a href="/supplier-register">הרשם כאן</a></p>
      
    </div>
  );
}

export default SupplierLogin;
