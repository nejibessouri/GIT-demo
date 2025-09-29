public with sharing class CompteRenduActiviteController {
    @AuraEnabled
    public static void saveSum(Decimal sumValue) {
        // Charger l'enregistrement du Compte_rendu_activit__c lié
        //Compte_rendu_activit__c compteRendu = [SELECT Id, Sum_values__c FROM Compte_rendu_activit__c LIMIT 1]; 
        Compte_rendu_activit__c compteRendu = new Compte_rendu_activit__c();
        compteRendu.Sum_values__c = sumValue;
        
        // Sauvegarder les modifications
        insert compteRendu;
    }
}