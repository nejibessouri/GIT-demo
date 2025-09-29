// Classe de tri
public class InsertionSortExample {
    public static List<Integer> insertionSort(List<Integer> numbers) {
        Integer n = numbers.size();
        
        for (Integer i = 1; i < n; i++) {
            Integer key = numbers[i];
            Integer j = i - 1;
            
            // Déplacer les éléments plus grands vers la droite
            while (j >= 0 && numbers[j] > key) {
                numbers[j + 1] = numbers[j];
                j = j - 1;
            }
            numbers[j + 1] = key;
        }
        
        return numbers;
    }
}