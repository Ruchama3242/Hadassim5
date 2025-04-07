// src/pages/TestConnection.js
import React, { useEffect, useState } from 'react';

function TestConnection(){
  const [message, setMessage] = useState('');

  useEffect(() => {
    // ודאי שאת משתמשת בכתובת הנכונה – בהתאם להגדרות השרת
    fetch('https://localhost:5001/api/test/ping')
      .then(response => response.text())
      .then(data => {
        setMessage(data);
      })
      .catch(error => {
        console.error("Error connecting to server:", error);
        setMessage("Error connecting to server");
      });
  }, []);

  return (
    <div>
      <h2>בדיקת התחברות לשרת</h2>
      <p>{message}</p>
    </div>
  );
}

export default TestConnection;
