// pages/ManagerLogin.js
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

function ManagerLogin() {
  const [password, setPassword] = useState('');
  const navigate = useNavigate();

  const handleLogin = () => {
    if (password.trim() === '1234') {
      navigate('/manager-dashboard');
    } else {
      alert('סיסמה שגויה, אנא נסה שוב.');
    }
  };

  const handleBack = () => {
    navigate(-1);
  };

  return (
    <div style={{ textAlign: 'right', direction: 'rtl', padding: '20px' }}>
      <h2>כניסת בעל/ת המכולת (Admin)- הסיסמא היא 1234</h2>
      <input 
        type="password"
        placeholder="הכנס סיסמה"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        style={{ marginBottom: '10px', width: '100%' }}
      />
      <br />
      <button onClick={handleLogin} style={{ marginRight: '10px' }}>התחבר</button>
      <button onClick={handleBack}>חזרה</button>
    </div>
  );
}

export default ManagerLogin;
