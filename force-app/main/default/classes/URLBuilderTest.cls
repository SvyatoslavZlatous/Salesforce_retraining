@isTest
public class URLBuilderTest {

    @isTest
    static void testURLBuilder() {
        String inputUrl = 'https://testtest.com';
        String expectedURL = 'https://testtest.com?testParam=test';
        String queryStringStartSymbol = '?';
        String testParamName = 'testParam';
        String testParamValue = 'test';
        URLBuilder builder = new URLBuilder(inputUrl);

        builder.appendSeparator(queryStringStartSymbol)
                .appendParam(testParamName, testParamValue);

        System.assertEquals(expectedURL, builder.build(), 'The generated URLs are not equal');
        
    }

    @isTest
    static void testURLBuilderShoudThrowIllegalArgumentException() {
        String expectedErrorMsg = 'The input URL could not be null';
        try {
            URLBuilder builder = new URLBuilder(null);
        } catch(IllegalArgumentException ex) {
            System.assertEquals(expectedErrorMsg, ex.getMessage(), 
                                'The URLBuilder cannot be constructed with nullable input URL');
        }
    }
}
