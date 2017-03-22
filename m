From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC RESEND] serdev binding for QCA7000 UART driver
Date: Wed, 22 Mar 2017 15:32:13 -0500
Message-ID: <CAL_JsqJS05gw80B4oUWZHEHOg5iPpwKie8XdBr82UD=7WB1cdg@mail.gmail.com>
References: <b2273c4a-069b-0b9a-83d3-aed782920c34@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b2273c4a-069b-0b9a-83d3-aed782920c34-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 13, 2017 at 11:16 AM, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> wrote:
> Hi Rob,
>
> since serdev has been merged, i'm currently working on a
> suitable ethernet driver for the QCA7000 [1]. In order to provide a plug
> and play solution for the network interface i suggest the following
> binding, which uses common properties for UART configuration:
>
> * Qualcomm QCA7000 (Ethernet over UART protocol)
>
> Note: The QCA7000 is also useable as a UART slave device.

Should this be s/UART/SPI/ ?

>
> Required properties:
> - compatible        : Should be "qca,qca7000-uart"
>
> Optional properties:
> - local-mac-address : 6 bytes, Specifies MAC address
> - current-speed     : Specifies current serial device speed in
>                       bits per second (default = 115200)
> - data-bits         : Specifies number of data bits (default = 8)
> - use-parity        : If present, this enables the parity
>                       error detection (default = off)
> - odd-parity        : If present, this specifies that the parity
>                       of each character must be odd (default = even)
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

Unless this device supports auto-baud (generally only AT command set
devices do), this is setup by a bootloader (and you have no way to
reset the device), or the speed changes with different firmware, I
don't think you should need this. Devices typically have a fixed,
initial baudrate that is known, so the driver should know it. Many
devices switch to a higher speed with some command which the driver
should also know. Unless there is some board limitation of the max
speed, then you shouldn't really need a baudrate property. And for max
baudrate, I added "max-speed".

>         data-bits = <8>;

Nearly everything uses 8 bits, so this should be the default.

>         use-parity;
>         odd-parity;

I don't think we need 2 properties here. "even-parity" and
"odd-parity" booleans should be enough to enable and set parity type.

>     };
> };
>
> Is it okay for you or do you want a different kind of configuration?
> Are there any plans for parity handling?

I don't have any. Patches welcome. :)

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
