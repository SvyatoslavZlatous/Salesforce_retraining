public with sharing class WeatherApiPathGenerator {
   
    private static final String QUESTION_MARK_CHARACTER = '?';
    private static final String AMPERSAND_CHARACTER = '&';
    private static final String CITY_PARAM_NAME = 'q';
    private static final String UNITS_PARAM_NAME = 'units';
    private static final String TOKEN_PARAM_NAME = 'appid';

    private static Dreamhouse_Settings__c customSettings; 
    private static URLBuilder builder;
    
    static{
        customSettings = Dreamhouse_Settings__c.getOrgDefaults();
        builder = new URLBuilder(customSettings.WeatherMapApiURL__c);
    }

    @AuraEnabled(cacheable = true)
    public static String generateEndpointURL() {
        String cityParamValue = 'city_param';
        String unitsParamValue = 'metric';
        String apiToken = customSettings.WeatherMapApiToken__c;
        String weatherApiUrl = builder.appendSeparator(QUESTION_MARK_CHARACTER)
                                .appendParam(CITY_PARAM_NAME, cityParamValue)
                                .appendSeparator(AMPERSAND_CHARACTER)
                                .appendParam(UNITS_PARAM_NAME, unitsParamValue)
                                .appendSeparator(AMPERSAND_CHARACTER)
                                .appendParam(TOKEN_PARAM_NAME, apiToken)
                                .build();
        return weatherApiUrl;
    }
}
