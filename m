From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC RESEND] serdev binding for QCA7000 UART driver
Date: Thu, 23 Mar 2017 10:55:25 -0500
Message-ID: <CAL_JsqJsPKnzDdPmbSpOVbpMEfZaAfBHb4G+eibUruFBN3bR7w@mail.gmail.com>
References: <b2273c4a-069b-0b9a-83d3-aed782920c34@i2se.com>
 <CAL_JsqJS05gw80B4oUWZHEHOg5iPpwKie8XdBr82UD=7WB1cdg@mail.gmail.com> <9127690c-3b6e-d60d-6af1-97bb9ad34628@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9127690c-3b6e-d60d-6af1-97bb9ad34628-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 23, 2017 at 10:13 AM, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> wrote:
> Hi Rob,
>
> Am 22.03.2017 um 21:32 schrieb Rob Herring:
>> On Mon, Mar 13, 2017 at 11:16 AM, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> wrote:
>>> Hi Rob,
>>>
>>> since serdev has been merged, i'm currently working on a
>>> suitable ethernet driver for the QCA7000 [1]. In order to provide a plug
>>> and play solution for the network interface i suggest the following
>>> binding, which uses common properties for UART configuration:
>>>
>>> * Qualcomm QCA7000 (Ethernet over UART protocol)
>>>
>>> Note: The QCA7000 is also useable as a UART slave device.
>> Should this be s/UART/SPI/ ?
>
> i rewrote this note in my second version below.
>
>>
>>> Required properties:
>>> - compatible        : Should be "qca,qca7000-uart"
>>>
>>> Optional properties:
>>> - local-mac-address : 6 bytes, Specifies MAC address
>>> - current-speed     : Specifies current serial device speed in
>>>                       bits per second (default = 115200)
>>> - data-bits         : Specifies number of data bits (default = 8)
>>> - use-parity        : If present, this enables the parity
>>>                       error detection (default = off)
>>> - odd-parity        : If present, this specifies that the parity
>>>                       of each character must be odd (default = even)
>>>
>>> Example:
>>>
>>> /* Freescale i.MX28 UART */
>>> auart0: serial@8006a000 {
>>>     compatible = "fsl,imx28-auart", "fsl,imx23-auart";
>>>     reg = <0x8006a000 0x2000>;
>>>     pinctrl-names = "default";
>>>     pinctrl-0 = <&auart0_2pins_a>;
>>>     status = "okay";
>>>
>>>     qca7000: ethernet {
>>>         compatible = "qca,qca7000-uart";
>>>         local-mac-address = [ A0 B0 C0 D0 E0 F0 ];
>>>         current-speed = <38400>;
>> Unless this device supports auto-baud (generally only AT command set
>> devices do), this is setup by a bootloader (and you have no way to
>> reset the device), or the speed changes with different firmware, I
>> don't think you should need this. Devices typically have a fixed,
>> initial baudrate that is known, so the driver should know it.
>
> Unfortunately the QCA7000 firmware can be freely preconfigured to a
> fixed baudrate and there is no way to determine, because Ethernet frames
> are send nearly directly to the UART and vice versa. I agree this isn't
> best practice.
>
>>>         data-bits = <8>;
>> Nearly everything uses 8 bits, so this should be the default.
>
> I will drop it completly.
>
>>
>>>         use-parity;
>>>         odd-parity;
>> I don't think we need 2 properties here. "even-parity" and
>> "odd-parity" booleans should be enough to enable and set parity type.
>
> Your suggestion is better, but it's possible to define wrongly both
> which isn't nice per design.
> Anyway i decide to drop this, too. So it could be implemented later.

could also do 'parity = "(even|odd)";' or a line-config property with
"8N1", "7E1", etc. for values though I tend to prefer booleans and
discreet properties per setting.

>
> So here is the new version:
>
> * Qualcomm QCA7000 (Ethernet over UART protocol)
>
> Note: This binding applies in case the QCA7000 is configured as a
> UART slave device. It is possible to preconfigure the UART settings
> of the QCA7000 firmware, which can't be changed during runtime.
>
> Required properties:
> - compatible        : Should be "qca,qca7000-uart"
>
> Optional properties:
> - local-mac-address : 6 bytes, Specifies MAC address
> - current-speed     : Specifies the serial device speed in
>                       bits per second (default = 115200), which is
>                       predefined by the QCA7000 firmware configuration
>
> Example:
>
> /* Freescale i.MX28 UART */
> auart0: serial@8006a000 {
>     compatible = "fsl,imx28-auart", "fsl,imx23-auart";
>     reg = <0x8006a000 0x2000>;
>     pinctrl-names = "default";
>     pinctrl-0 = <&auart0_2pins_a>;
>     status = "okay";
>
>     qca7000: ethernet {
>         compatible = "qca,qca7000-uart";
>         local-mac-address = [ A0 B0 C0 D0 E0 F0 ];
>         current-speed = <38400>;
>     };
> };

Looks good to me.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
