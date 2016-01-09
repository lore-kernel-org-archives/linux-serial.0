From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V2 1/2] dt/bindings: serial: bcm2835: add binding documentation for bcm2835-aux-uart
Date: Sat, 09 Jan 2016 21:53:47 +0100
Message-ID: <10159898.8xe3rmYdEi@wuerfel>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org> <1452344854-2576-2-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452344854-2576-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Saturday 09 January 2016 13:07:32 kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> +
> +       uart1: uart@7e215040 {
> +               compatible = "brcm,bcm2835-aux-uart";
> +               reg = <0x7e215040 0x40>;
> +               interrupts = <1 29>;
> +               clocks = <&aux BCM2835_AUX_CLOCK_UART>;
> +       };
> 

The node name should always be "serial@...", not "uart@..."

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
