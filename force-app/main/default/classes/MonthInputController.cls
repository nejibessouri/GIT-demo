public with sharing class MonthInputController {
    @AuraEnabled
    public static void saveMonthlyData(List<MonthlyDataWrapper> dataList) {
        if (dataList == null || dataList.isEmpty()) {
            throw new AuraHandledException('La liste des données est vide ou nulle.');
        }
        System.debug('dataList : ' + dataList);
        Decimal totalSum = 0; // Variable pour stocker la somme totale

        for (MonthlyDataWrapper data : dataList) {
            if (data == null || data.day == null || data.value == null) {
                System.debug('data : ' + data);
                throw new AuraHandledException('Une ou plusieurs données sont nulles.');
            }
            
            // Validation : la valeur doit être vide, ou comprise entre 0 et 1
            if (data.value != '' && (Decimal.valueOf(data.value) < 0 || Decimal.valueOf(data.value) > 1)) {
                throw new AuraHandledException('Les valeurs doivent être vides ou comprises entre 0 et 1.');
            }

            // Ajouter la valeur à la somme totale si elle est valide
            if (data.value != '') {
                totalSum += Decimal.valueOf(data.value);
            }
        }

        // Créer un nouvel enregistrement dans Compte_rendu_activit__c
        Compte_rendu_activit__c activityReport = new Compte_rendu_activit__c();
        activityReport.Sum_values__c = totalSum; // Sauvegarder la somme des valeurs
        // Vous pouvez ajouter d'autres champs ici si nécessaire

        try {
            insert activityReport; // Insérer l'enregistrement
        } catch (DmlException e) {
            throw new AuraHandledException('Erreur lors de l\'insertion du Compte_rendu_activit__c : ' + e.getMessage());
        }
    }

    public class MonthlyDataWrapper {
        @AuraEnabled
        public Integer day;
        @AuraEnabled
        public String value;
    }
}