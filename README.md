# Acquired IOS Library

## Requirements

- IOS 9.0+
- Xcode 7.1.1+

## HPP Library Installation


### Manual

If you prefer not to use a dependency manager, you can integrate the Acquired iOS Library into your project manually.

- Download the the latest release from GitHub:

    https://github.com/AcquiredSupport/Acquired-SDK-IOS/releases

- Drag and drop the folder 'Acquired_SDK_IOS' into Xcode to use the HPP part of the library.

## Using the HPP Library

### Initiation 

To initiate an instance of the HPP manager do the following:

```
let hppManager = HppManager()
```


### Integrate With Your Server

The HPP Manager requires some Hpp settings which you can get it on acquired dashboard(server side).

1) **Company ID**: utilizing one of the Acquired HPP server SDKs; Company Id is necessary to create an instance of HppSetting which is required for HPPManager.

2) **Company MID ID**: Using this value that SDK will choose the default template that has been uploaded through the Acquired Dashboard

3) **Hash Code**: This parameter is used to encode the requests of HPP, a new hash will be generated , server side will check the validity of the hash and decode the response.

```
let hppSetting = HppSetting(companyId:211,  companyMidId:1229,  companyHash:""hashcode")
```

### Present Payment Form

Insert the code  to present a payment form as follows:

```
hppManager.loadHppView(viewController: self, hppSetting: hppSetting)
```

Executing this code, HPP Manager will process the given parameters(HppSetting), get the request from the server, send the encoded request to HPP and present the form received back.

###  HPP Response 

On the server-side you can set your own return url or call back url, hpp will handle response automatically that you don't have to do any response handling on your app. You can also set another return url or call back url when calling HPPManager in your app:

```
hppSetting.error_url = "xxx"
hppSetting.return_url = "xxx"
hppSetting.merchant_customer_id = "xxx"
```

## FAQ

### Set HPP Properties
HppSetting is used to provide all pamarters that server requires:card detail, shipping address, billing adress...etc 
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

Acquired maintain separate endpoints for live and test transactions. Use the code below:

```
hppSetting.is_debug = true
```     

## License

See the LICENSE file.
