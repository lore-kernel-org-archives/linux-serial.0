From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv3 7/9] arm: vt8500: doc: Add device tree bindings for
 arch-vt8500 devices
Date: Wed, 22 Aug 2012 15:07:21 -0600
Message-ID: <50354A09.7070507@wwwdotorg.org>
References: <1345582058-2291-1-git-send-email-linux@prisktech.co.nz> <1345582058-2291-8-git-send-email-linux@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1345582058-2291-8-git-send-email-linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Cc: vt8500-wm8505-linux-kernel-/JYPxA39Uh6Zox4op4iWzw@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 08/21/2012 02:47 PM, Tony Prisk wrote:
> Bindings for gpio, interrupt controller, power management controller,
> timer, realtime clock, serial uart, ehci and uhci controllers and
> framebuffer controllers used on the arch-vt8500 platform.
> 
> Framebuffer binding also specifies a 'display' node which is required
> for determining the lcd panel data.

> diff --git a/Documentation/devicetree/bindings/gpio/gpio_vt8500.txt b/Documentation/devicetree/bindings/gpio/gpio_vt8500.txt

> +- #gpio-cells : should be <3>.
> +	1) bank
> +	2) pin number
> +	3) flags

Should this enumerate what legal values are for flags, or point at a
standard document that does?

> diff --git a/Documentation/devicetree/bindings/tty/serial/via,vt8500-uart.txt b/Documentation/devicetree/bindings/tty/serial/via,vt8500-uart.txt

> +	uart@d8210000 {
> +		compatible = "via,vt8500-uart";
> +		reg = <0xd8210000 0x1040>;
> +		interrupts = <47>;
> +	};

How does the UART know what frequency its clock input is, in order to
calculate dividers? Should there be a clocks property to link to the
input clock, so the rate can be queried? If so, a reference to the
common clock binding, plus a specification of which clocks must be
listed in the clock property should be included here.

> diff --git a/Documentation/devicetree/bindings/video/via,vt8500-fb.txt b/Documentation/devicetree/bindings/video/via,vt8500-fb.txt

> +VIA VT8500 Display
> +-----------------------------------------------------
> +Required properties:
> +- xres : lcd panel horizontal resolution
> +- yres : lcd panel vertical resolution
> +- left-margin,
> +- right-margin,
> +- hsync-len: lcd panel horizontal timings in pixels
> +- upper-margin,
> +- lower-margin,
> +- vsync-len: lcd panel verticals timings in pixels
> +- bpp: lcd panel bit-depth.
> +	<16> for RGB565, <32> for RGB888

Shouldn't this reference Sascha Hauer's binding document (although I
suppose it isn't checked in yet), and just document the additions? I
wonder if this binding should be written assuming Sascha's binding doc
will be checked in?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
