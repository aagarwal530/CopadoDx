// StringManipulatorTest.cls
@isTest
private class StringManipulatorTest {
    @isTest
    static void testReverseString() {
        String input = 'hello';
        String expectedResult = 'olleh';
        String actualResult = StringManipulator.reverseString(input);
        System.assertEquals(expectedResult, actualResult, 'Expected result should be the reverse of the input string');
    }
}