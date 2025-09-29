import { LightningElement, track } from 'lwc';
import saveMonthlyData from '@salesforce/apex/MonthInputController.saveMonthlyData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class MonthInputTable extends LightningElement {
    @track dayInputs = [];

    connectedCallback() {
        this.generateDaysOfMonth();
    }

    generateDaysOfMonth() {
        const today = new Date();
        const year = today.getFullYear();
        const month = today.getMonth();
        const daysInMonth = new Date(year, month + 1, 0).getDate();

        for (let i = 1; i <= daysInMonth; i++) {
            this.dayInputs.push({
                day: i,
                value: ''
            });
        }
    }

    handleInputChange(event) {
        const day = event.target.dataset.day;
        const value = event.target.value;

        this.dayInputs = this.dayInputs.map(input => {
            if (input.day == day) {
                return { ...input, value };
            }
            return input;
        });
    }

    handleSave() {
        // Appel Apex pour sauvegarder les données
        saveMonthlyData({ dataList: this.dayInputs })
            .then(() => {
                this.showToast('Succès', 'Les données ont été enregistrées avec succès.', 'success');
            })
            .catch(error => {
                this.showToast('Erreur', 'Une erreur s\'est produite lors de l\'enregistrement des données.', 'error');
                console.error('Erreur lors de l\'enregistrement', error);
            });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant,
        });
        this.dispatchEvent(event);
    }
}