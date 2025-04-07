// pages/MainPage.js
import React from 'react';
import { Link } from 'react-router-dom';

function MainPage() {
  return (
    <div style={{ textAlign: 'right', direction: 'rtl', padding: '20px' }}>
      <h1>ברוכים הבאים למערכת ניהול ההזמנות</h1>
      <p>
        <Link to="/manager-login">כניסת בעל/ת המכולת (Admin)</Link>
      </p>
      <p>
        <Link to="/supplier-login">כניסת ספק</Link>
      </p>
    </div>
  );
}

export default MainPage;
