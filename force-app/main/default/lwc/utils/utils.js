import { ShowToastEvent } from "lightning/platformShowToastEvent";
export { showToast };

const showToast = (context, title, message, variant) => {
    const evt = new ShowToastEvent({
        title: title,
        message: message,
        variant: variant,
    });
    context.dispatchEvent(evt);
};
