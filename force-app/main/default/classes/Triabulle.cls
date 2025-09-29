public class Triabulle {
    public static List<Integer> bubbleSort(List<Integer> numbers){
        Integer n = numbers.size();
        Boolean swapped;
        do{
            swapped = false;
            for(Integer i =0; i<n -1; i++){
                if(numbers[i] > numbers[i+1]){
                    Integer temp = numbers[i];
                    numbers[i] = numbers[i+1];
                    numbers[i+1] = temp;
                    swapped = true;
                }
            }
        }
        while(swapped);
        return numbers;
    }
}