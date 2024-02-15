@isTest
private class DummyClassTest {
    @isTest
    static void testAdd() {
        Integer result = DummyClass.add(2, 3);
        System.assertEquals(5, result, 'Expected result should be 5');
    }
}