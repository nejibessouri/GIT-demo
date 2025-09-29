import { LightningElement, track } from 'lwc';

export default class AdditionComponent extends LightningElement {
    @track firstNumber = 0;
    @track secondNumber = 0;
    @track result = 0;

    handleInputChange(event) {
        const field = event.target.dataset.id;
        if (field === 'first') {
            this.firstNumber = Number(event.target.value);
        } else if (field === 'second') {
            this.secondNumber = Number(event.target.value);
        }
    }

    addNumbers() {
        this.result = this.firstNumber + this.secondNumber;
    }
}