// StringManipulator.cls
public class StringManipulator {
    public static String reverseString(String input) {
        String reversedString = '';
        for(Integer i = input.length() - 1; i >= 0; i--) {
            reversedString += input.substring(i, i + 1);
        }
        return reversedString;
    }
}