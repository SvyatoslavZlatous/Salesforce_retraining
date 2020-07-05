public with sharing class URLBuilder {
    private static final String ERR_MSG_NULL_URL = 'The input URL could not be null';
    private static final String ASSIGNMENT_SYMBOL = '=';
    private String url;
    

    public URLBuilder(String inputURL) {
        if(inputURL == null){
            throw new IllegalArgumentException(ERR_MSG_NULL_URL);
        }
        this.url = inputURL;
    }

    public URLBuilder appendParam(String paramName, String paramValue) {
        url += paramName + ASSIGNMENT_SYMBOL + paramValue;
        return this;
    }

    public URLBuilder appendSeparator(String separator) {
        url += separator;
        return this;
    }

    public String build() {
        return url;
    }
}
