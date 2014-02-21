From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH tty-next v2 4/4] Documentation: devicetree: add bindings documentation for bcm63xx-uart
Date: Fri, 21 Feb 2014 13:49:05 +0100
Message-ID: <3250738.VGSO94B75K@wuerfel>
References: <1392920154-3642-1-git-send-email-f.fainelli@gmail.com> <1392920154-3642-5-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59360 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436AbaBUMtO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Feb 2014 07:49:14 -0500
In-Reply-To: <1392920154-3642-5-git-send-email-f.fainelli@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, gregkh@linuxfoundation.org, mark.rutland@arm.com, gregory.0xf0@gmail.com

Two more comments:

On Thursday 20 February 2014 10:15:54 Florian Fainelli wrote:
> +- clock-names: should contain "periph" for the functional clock

I think we should really start standardizing on the clock names more.
We don't have any uart that calls its functional clock "periph" so
far.

How about naming it "fclk" or "uart"?

I'd actually prefer making it an anonymous clock, but I know that
will just trigger comments about what might happen if it turns
out we need more than one clock for a future version of this device.

> +Example:
> +
> +serial0: uart@600 {
> +       compatible = "brcm,bcm6345-uart";
> +       reg = <0x600 0x1b>;
> +       interrupts = <GIC_SPI 32 0>;
> +       clocks = <&periph_clk>;
> +       clock-names = "periph";
> +};

The device name for a uart is "serial" by convention, not "uart",
so better make this serial@600.

	Arnd
