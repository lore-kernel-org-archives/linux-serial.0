From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2 1/2] dt/bindings: serial: bcm2835: add binding documentation for bcm2835-aux-uart
Date: Sun, 10 Jan 2016 11:49:19 +0100
Message-ID: <175E89CE-581C-48AB-B7FF-6E9A41B033D5@martin.sperl.org>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org> <1452344854-2576-2-git-send-email-kernel@martin.sperl.org> <10159898.8xe3rmYdEi@wuerfel>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <10159898.8xe3rmYdEi@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


> On 09.01.2016, at 21:53, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> 
> On Saturday 09 January 2016 13:07:32 kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>> +
>> +       uart1: uart@7e215040 {
>> +               compatible = "brcm,bcm2835-aux-uart";
>> +               reg = <0x7e215040 0x40>;
>> +               interrupts = <1 29>;
>> +               clocks = <&aux BCM2835_AUX_CLOCK_UART>;
>> +       };
>> 
> 
> The node name should always be "serial@...", not "uart@..."
> 
> 	Arnd

The existing dts arch/arm/boot/dts/bcm2835.dtsi already contains:
                uart0: uart@7e201000 {
                        compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
                        reg = <0x7e201000 0x1000>;
                        interrupts = <2 25>;
                        clocks = <&clocks BCM2835_CLOCK_UART>,
                                 <&clocks BCM2835_CLOCK_VPU>;
                        clock-names = "uartclk", "apb_pclk";
                        arm,primecell-periphid = <0x00241011>;
                };
for the primary uart.

So I was just following that example and would hesitate to
use a different nomenclature in the same file (even though I
saw serial examples elsewhere).

I guess this is a more general thing that needs to get resolved.

If you tell me to re-spin the patch because of this then I can do that,
but that would not solve the issue with uart0.

Thanks,
	Martin


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
