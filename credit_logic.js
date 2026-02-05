let accountBalance = 0;
let creditLimit = 500000;
let creditUsed = 15000;

const formatter = new Intl.NumberFormat('es-CL', {
    style: 'currency',
    currency: 'CLP'
});

function attemptTransaction(amount) {
    if (accountBalance >= amount) {
        accountBalance -= amount;
        console.log("Pago realizado con saldo de cuenta.");
        return true;
    } else {
        let remainingAmount = amount - accountBalance;
        let creditAvailable = creditLimit - creditUsed;

        if (creditAvailable >= remainingAmount) {
            if (accountBalance > 0) {
                console.log(`Usando $${accountBalance} de la cuenta principal.`);
                accountBalance = 0;
            }
            
            creditUsed += remainingAmount;
            console.log(`Se utilizaron $${remainingAmount} de la Línea de Crédito.`);
            
            updateUI();
            return true;
        } else {
            alert("Fondos insuficientes (incluso con Línea de Crédito).");
            return false;
        }
    }
}

function updateUI() {
    const available = creditLimit - creditUsed;
    
    if(document.getElementById('credit-used-display'))
        document.getElementById('credit-used-display').innerText = formatter.format(creditUsed);
    
    if(document.getElementById('credit-limit-display'))
        document.getElementById('credit-limit-display').innerText = formatter.format(creditLimit);
        
    if(document.getElementById('credit-available-display'))
        document.getElementById('credit-available-display').innerText = formatter.format(available);

    if(document.getElementById('modal-pay-amount'))
        document.getElementById('modal-pay-amount').innerText = formatter.format(creditUsed);
}

function openPayModal() {
    if (creditUsed <= 0) {
        alert("No tienes deuda pendiente en tu línea de crédito.");
        return;
    }
    updateUI();
    document.getElementById('payModal').style.display = 'block';
}

function closePayModal() {
    document.getElementById('payModal').style.display = 'none';
}

function processCreditPayment() {
    const amountPaid = creditUsed;
    if (amountPaid > 0) {
        const newTransaction = {
            id: Date.now(),
            type: 'credit_payment',
            amount: amountPaid,
            date: new Date().toISOString().split('T')[0],
            desc: 'Pago Línea de Crédito'
        };
        
        let transactions = JSON.parse(localStorage.getItem('walletTransactions')) || [];
        transactions.unshift(newTransaction);
        localStorage.setItem('walletTransactions', JSON.stringify(transactions));
    }

    alert("¡Pago de línea de crédito realizado con éxito!");
    creditUsed = 0;
    closePayModal();
    updateUI();
}

document.addEventListener('DOMContentLoaded', () => {
    updateUI();
});