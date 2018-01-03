From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v2 2/9] dt-bindings: net: bluetooth: add support for Realtek
 Bluetooth chips
Date: Wed, 3 Jan 2018 13:07:28 -0600
Message-ID: <CAL_JsqLRkicv0p8ur==mq3bCp6Sn7b41M+CoFYx_qrhcdsY9Qg@mail.gmail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
 <20180101204217.26165-3-martin.blumenstingl@googlemail.com>
 <2A1D60F1-F86F-4A2B-A43A-F3419506DE99@holtmann.org> <CAFBinCBNro18Ak3h1fHFpAioDzimh5KcUeOE8PjQr_CCkAs7PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFBinCBNro18Ak3h1fHFpAioDzimh5KcUeOE8PjQr_CCkAs7PA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry Finger <Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org>, Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 2, 2018 at 3:10 PM, Martin Blumenstingl
<martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> Hi Marcel,
>
> On Tue, Jan 2, 2018 at 12:16 PM, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org> wrote:
>> Hi Martin,
>>
>>> This adds the documentation for Bluetooth functionality of the Realtek
>>> RTL8723BS and RTL8723DS.
>>> Both are SDIO wifi chips with an additional Bluetooth module which is
>>> connected via UART to the host.
>>>
>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>> ---
>>> .../devicetree/bindings/net/realtek-bluetooth.txt  | 41 ++++++++++++++++++++++
>>> 1 file changed, 41 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
>>> new file mode 100644
>>> index 000000000000..1491329c4cd1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
>>> @@ -0,0 +1,41 @@
>>> +Realtek Bluetooth Chips
>>> +-----------------------
>>> +
>>> +This documents the binding structure and common properties for serial
>>> +attached Realtek devices.
>>> +
>>> +Serial attached Realtek devices shall be a child node of the host UART
>>> +device the slave device is attached to. See ../serial/slave-device.txt
>>> +for more information
>>> +
>>> +Required properties:
>>> +- compatible: should contain one of the following:
>>> +    * "realtek,rtl8723bs-bluetooth"
>>> +    * "realtek,rtl8723ds-bluetooth"
>>> +
>>> +Optional properties:
>>> +- realtek,config-data: Bluetooth chipset configuration data which is
>>> +                     needed for communication (it typically contains
>>> +                     board specific settings like the baudrate and
>>> +                     whether flow-control is used).
>>> +                     This is an array of u8 values.
>>
>> any chance we can at least include the basic format of these config blobs. And I prefer at least an ACK from Rob here.
> with including the basic format you mean a description that the config
> blob should start with 0x55 0xab 0x23 0x87 (which translates to:
> 0x8723ab55)?

That and the size if it is fixed (or fixed per compatible). Also,
would be useful to state what are the defaults if not present.

If it is all documented somewhere else, a pointer to that is fine.

> I think all non-trivial dt-binding patches should be ACKed by the DT
> maintainers, so waiting for Rob's ACK is perfectly fine for me
>
>>> +- enable-gpios: GPIO specifier, used to enable/disable the BT module
>>> +- reset-gpios: GPIO specifier, used to reset the BT module

These should state active high or low.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
