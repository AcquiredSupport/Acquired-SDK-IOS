# Acquired IOS Library

## Requirements

- IOS 9.0+
- Xcode 10.0+

## HPP Library Installation

### Manual

You can integrate the Acquired iOS Library into your project manually.

- Download the latest release from GitHub:

    https://github.com/AcquiredSupport/Acquired-SDK-IOS/releases

- Drag and drop the folder 'Acquired_SDK_IOS' into Xcode to use the HPP part of the library.

## Documentation  ##
https://developer.acquired.com/integrations/hpp

## Using the HPP Library

### Initiation 

To initiate an instance of the HPPManager do the following:

```
let hppManager = HppManager()
```


### Integrate With Your Server

The HPPManager requires some HPP settings which you can get on Acquired Dashboard (server side).

1) **Company ID**: Utilising one of the Acquired HPP server SDKs; Company ID is necessary to create an instance of HppSetting which is required for HPPManager.

2) **Company MID ID**: Using this value that SDK will choose the default template that has been uploaded through the Acquired Dashboard

3) **Hash Code**: This parameter is used to encode the requests of HPP, a new hash will be generated, server side will check the validity of the hash and decode the response.

```
let hppSetting = HppSetting(companyId:211,  companyMidId:1229,  companyHash:""hashcode")
```

### Present Payment Form

Insert the code to present a payment form as follows:

```
hppManager.loadHppView(viewController: self, hppSetting: hppSetting)
```

Executing this code, HPPManager will process the given parameters(HppSetting), get the request from the server, send the encoded request to HPP and present the form received back.

###  HPP Response 

On the server-side you can set your own return url or callback url, hpp will handle response automatically so that you don't have to do any response handling in your APP. You can also set another return url or call back url when calling HPPManager in your APP:

```
hppSetting.error_url = "xxx"
hppSetting.return_url = "xxx"
hppSetting.merchant_customer_id = "xxx"
```

## FAQ

### Set HPP Properties
HppSetting is used to provide all parameters that server requires:card detail, shipping address, billing address..., etc. 
You can also set whatever HPP properties you need to in the component, for example;

```
hppSetting.is_debug = true
hppSetting.transaction_type = "AUTH_ONLY"
hppSetting.currency_code_iso3 = "GBP"
hppSetting.amount = 100.1
hppSetting.billing_email = "xxx"
hppSetting.customer_company = "xxx"
...
```

These will be sent to the *Request Producer URL*, your server-side code must be setup to take in these values and pass them to the HPP server-side SDK for them to be included in the request.  

### Testing     

Acquired maintains separate endpoints for live and test transactions. Use the code below:

```
hppSetting.is_debug = true
```     

## License

See the LICENSE file.
