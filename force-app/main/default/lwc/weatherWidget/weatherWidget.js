import { LightningElement, track, wire } from 'lwc';
import { showToast } from "c/utils";
import generateEndpointURL from '@salesforce/apex/WeatherApiPathGenerator.generateEndpointURL';
import { getRecord } from 'lightning/uiRecordApi';
import USER_CITY_NAME_FIELD from "@salesforce/schema/User.City"
import Id from "@salesforce/user/Id";

const DEFAULT_CITY = 'Lviv';
const ERROR_MSG = 'ERROR';
const CITY_PARAM_NAME = 'city_param';
const options = {
    day : '2-digit',
    month : '2-digit',
    year : 'numeric',
    hour : '2-digit',
    minute : '2-digit'
};

export default class WeatherWidget extends LightningElement {
    currentUser;
    weatherData = [];
    URL;

    @track weatherEntries;

    @wire(generateEndpointURL)
    getURL({data, error}) {
        if(data) {
            this.URL = data;
        } else if(error) {
            showToast(this, ERROR_MSG, error.body.message, 'error');
        }
    } 
    
    
    @wire(getRecord, {recordId: Id, fields: USER_CITY_NAME_FIELD})
    wiredUser({data, error}) {
        if(data) {
            this.currentUser = {
                City : (data.City == undefined) ? DEFAULT_CITY : data.City
            }
        } else if(error) {
            showToast(this, ERROR_MSG, error.body.message, 'error');
        }
    }

     get propertiesWired() {
        return !!this.URL && !!this.currentUser;
    }



    renderedCallback() {
        if(this.URL === undefined || this.currentUser === undefined) {
            return;
        }
        let targertUrl = this.URL.replace(CITY_PARAM_NAME, this.currentUser.City);
        let xhr = new XMLHttpRequest();
        xhr.open('GET', targertUrl, true);
        xhr.send();

        xhr.onload = () => {
            if(xhr.status === 200) {
                const response = JSON.parse(xhr.responseText);
                for(let i = 0; i < response.list.length; i++) {
                    this.weatherData.push({
                        dateTime : new Date(response.list[i].dt_txt).toLocaleString('en-US', options),
                        temperature : Math.round(response.list[i].main.temp)
                    });
                }                
                this.weatherEntries = this.weatherData;
            }
        };
    }

}