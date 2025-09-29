// Classe de tri
public class SelectionSortExample {
    public static List<Integer> selectionSort(List<Integer> numbers) {
        Integer n = numbers.size();
        
        for (Integer i = 0; i < n - 1; i++) {
            Integer minIndex = i;
            
            // Trouver l'index du plus petit élément dans la partie non triée
            for (Integer j = i + 1; j < n; j++) {
                if (numbers[j] < numbers[minIndex]) {
                    minIndex = j;
                }
            }
            
            // Échanger l'élément minimum avec le premier élément non trié
            if (minIndex != i) {
                Integer temp = numbers[i];
                numbers[i] = numbers[minIndex];
                numbers[minIndex] = temp;
            }
        }
        
        return numbers;
    }
}