import React, { useState } from 'react';
import Logo from './Logo';
import AddArea from './AddComponents/AddArea';
import AddPlate from './AddComponents/AddPlate';
import AddBeverage from './AddComponents/AddBeverage';
import KitchenScreen from './MenuDisplays/KitchenScreen';
import BarScreen from './MenuDisplays/BarScreen';

function ActionsPage() {
  const [displayComponent, setDisplayComponent] = useState(null);

  const clearArea = () => {
    setDisplayComponent(null);
  };

  const handleAddArea = () => {
    clearArea();
    setDisplayComponent(<AddArea />);
  };

  const handleAddPlate = () => {
    clearArea();
    setDisplayComponent(<AddPlate />);
  };

  const handleAddBeverage = () => {
    clearArea();
    setDisplayComponent(<AddBeverage />);
  };

  const handleKitchenScreen = () => {
    clearArea();
    setDisplayComponent(<KitchenScreen/>);
  };

  const handleBarScreen = () => {
    clearArea();
    setDisplayComponent(<BarScreen/>);
  };

  return (
    <div>
      <Logo />
      <h2>Restaurant Management Actions</h2>
      <div>
        <button onClick={handleTakeOrder}>Take Order</button>
        <button onClick={handleKitchenScreen}>Kitchen Screen</button>
        <button onClick={handleBarScreen}>Bar Screen</button>
        <button onClick={handlePrintOrder}>Print Order</button>
        <button onClick={handleCloseAccount}>Close Account</button>
        <button onClick={handlePrintInvoice}>Print Invoice</button>
        <button onClick={handlePlatesReport}>Plates Report</button>
        <button onClick={handleOrderTimeReport}>Order Time Report</button>
        <button onClick={handleAverageDiningTimeReport}>Average Dining Time Report</button>
        <button onClick={handleComplaintsByPersonReport}>Complaints by Person Report</button>
        <button onClick={handleComplaintsByDishReport}>Complaints by Dish Report</button>
        <button onClick={handleWaiterEfficiencyReport}>Waiter Efficiency Report</button>
        <button onClick={handleAddArea}>Add Area</button>
        <button onClick={handleAddPlate}>Add Plate</button>
        <button onClick={handleAddBeverage}>Add Beverage</button>
      </div>
      {displayComponent}
    </div>
  );
}

// Define placeholder functions for other button actions
function handleTakeOrder() {}
function handlePrintOrder() {}
function handleCloseAccount() {}
function handlePrintInvoice() {}
function handlePlatesReport() {}
function handleOrderTimeReport() {}
function handleAverageDiningTimeReport() {}
function handleComplaintsByPersonReport() {}
function handleComplaintsByDishReport() {}
function handleWaiterEfficiencyReport() {}

export default ActionsPage;
