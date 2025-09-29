import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; // Importer le service de Toast
import saveSum from '@salesforce/apex/CompteRenduActiviteController.saveSum';

export default class TableauJournee extends LightningElement {
    @track days = [];

    connectedCallback() {
        this.generateDaysOfMonth();
    }

    // Générer la liste des jours du mois courant et marquer les dimanches
    generateDaysOfMonth() {
        const date = new Date();
        const month = date.getMonth(); // Mois actuel (0-11)
        const year = date.getFullYear(); // Année actuelle

        // Nombre de jours dans le mois courant
        const daysInMonth = new Date(year, month + 1, 0).getDate();

        this.days = Array.from({ length: daysInMonth }, (v, k) => {
            const dayDate = new Date(year, month, k + 1); // Date actuelle (k+1)
            const isSunday = dayDate.getDay() === 0; // getDay() retourne 0 pour dimanche
            const className = isSunday ? 'sunday' : 'normal-day'; // Définir la classe en fonction du jour
            return {
                date: k + 1, // Jour du mois
                value: 0,    // Valeur initiale
                isSunday,    // True si c'est un dimanche
                className    // Nom de la classe pour styliser
            };
        });
    }

    // Gérer la saisie dans chaque input et mettre à jour la valeur
    handleInputChange(event) {
        const day = event.target.dataset.id;
        const value = parseFloat(event.target.value);
        
        // Validation des valeurs saisies
        if (value < 0 || value > 1) {
            this.showToast('Erreur', 'La valeur doit être comprise entre 0 et 1', 'error');
            event.target.value = 0; // Réinitialiser la valeur à 0 si non valide
        } else {
            this.days = this.days.map(d => {
                if (d.date == day) {
                    return { ...d, value: isNaN(value) ? 0 : value };
                }
                return d;
            });
        }
    }

    // Calculer la somme des valeurs et sauvegarder
    handleSave() {
        const totalSum = this.days.reduce((sum, day) => sum + (day.value || 0), 0);

        saveSum({ sumValue: totalSum })
            .then(() => {
                // Toast de succès
                this.showToast('Succès', 'Votre compte rendu a été enregistrer.', 'success');
            })
            .catch(error => {
                // Toast d'erreur
                this.showToast('Erreur', 'Erreur lors de la sauvegarde: ' + error.body.message, 'error');
            });
    }

    // Méthode pour afficher un Toast
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(event);
    }
}