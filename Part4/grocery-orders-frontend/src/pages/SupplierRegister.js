// pages/SupplierRegister.js
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

function SupplierRegister() {
  const [companyName, setCompanyName] = useState('');
  const [phone, setPhone] = useState('');
  const [representativeName, setRepresentativeName] = useState('');
  const [products, setProducts] = useState([{ name: '', price: '', minimumQuantity: '' }]);
  const navigate = useNavigate();

  const handleProductChange = (index, field, value) => {
    const newProducts = [...products];
    newProducts[index][field] = value;
    setProducts(newProducts);
  };

  const addProduct = () => {
    setProducts([...products, { name: '', price: '', minimumQuantity: '' }]);
  };

  const handleRegister = async () => {
    // עיבוד שם החברה ושם הנציג: אם אינם מכילים גרשיים, נוסיף אותם
    const formattedCompanyName = companyName.trim().startsWith('"')
      ? companyName.trim()
      : `"${companyName.trim()}"`;
    const formattedRepresentativeName = representativeName.trim().startsWith('"')
      ? representativeName.trim()
      : `"${representativeName.trim()}"`;

    const supplierData = {
      companyName: formattedCompanyName,
      phone: phone.trim(),
      representativeName: formattedRepresentativeName,
      products
    };

    try {
      const response = await fetch('https://localhost:5001/api/suppliers/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(supplierData)
      });
      if (!response.ok) {
        throw new Error('Registration failed');
      }
      const data = await response.json();
      alert('נרשמת בהצלחה');
      navigate('/supplier-dashboard');
    } catch (error) {
      console.error(error);
      alert('שגיאה בהרשמה');
    }
  };

  const handleBack = () => {
    navigate(-1); // מחזיר לדף הקודם
  };

  return (
    <div style={{ textAlign: 'right', direction: 'rtl', padding: '20px' }}>
      <h2>הרשמת ספק חדש</h2>
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
      <h3>רשימת סחורות</h3>
      {products.map((product, index) => (
        <div key={index} style={{ marginBottom: '10px' }}>
          <input
            type="text"
            placeholder="שם המוצר"
            value={product.name}
            onChange={(e) => handleProductChange(index, 'name', e.target.value)}
            style={{ marginBottom: '5px', width: '100%' }}
          />
          <br />
          <input
            type="number"
            placeholder="מחיר לפריט"
            value={product.price}
            onChange={(e) => handleProductChange(index, 'price', e.target.value)}
            style={{ marginBottom: '5px', width: '100%' }}
          />
          <br />
          <input
            type="number"
            placeholder="כמות מינימלית"
            value={product.minimumQuantity}
            onChange={(e) => handleProductChange(index, 'minimumQuantity', e.target.value)}
            style={{ marginBottom: '5px', width: '100%' }}
          />
        </div>
      ))}
      <button onClick={addProduct} style={{ marginRight: '10px' }}>הוסף מוצר</button>
      <button onClick={handleRegister} style={{ marginRight: '10px' }}>הרשם</button>
      <button onClick={handleBack}>חזרה</button>
    </div>
  );
}

export default SupplierRegister;
