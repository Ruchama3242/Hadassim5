// App.js
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import MainPage from './pages/MainPage';
import TestConnection from './pages/TestConnection';
import ManagerLogin from './pages/ManagerLogin';
import ManagerDashboard from './pages/ManagerDashboard';
import CreateOrder from './pages/CreateOrder';
import OrderDetails from './pages/OrderDetails'; 
import SupplierLogin from './pages/SupplierLogin';
import SupplierRegister from './pages/SupplierRegister';
import SupplierDashboard from './pages/SupplierDashboard';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<MainPage />} />
        <Route path="/test-connection" element={<TestConnection />} />
        <Route path="/manager-login" element={<ManagerLogin />} />
        <Route path="/manager-dashboard" element={<ManagerDashboard />} />
        <Route path="/manager/order/:orderId" element={<OrderDetails />} />
        <Route path="/manager/create-order" element={<CreateOrder />} />
        <Route path="/supplier-login" element={<SupplierLogin />} />
        <Route path="/supplier-register" element={<SupplierRegister />} />
        <Route path="/supplier-dashboard" element={<SupplierDashboard />} />
        <Route path="/supplier/order/:orderId" element={<OrderDetails />} />
       
      </Routes>
    </Router>
  );
}

export default App;