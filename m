From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH tty-next v2 4/4] Documentation: devicetree: add bindings documentation for bcm63xx-uart
Date: Fri, 21 Feb 2014 15:59:28 +0100
Message-ID: <3851734.OkR5IG0DHF@wuerfel>
References: <1392920154-3642-1-git-send-email-f.fainelli@gmail.com> <20140221134946.GA20449@e106331-lin.cambridge.arm.com> <CAOiHx==LEMeLVxLv2r+btWQNcPitndpVTsjbu0Ji4_tzmap51A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54873 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbaBUO7n (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Feb 2014 09:59:43 -0500
In-Reply-To: <CAOiHx==LEMeLVxLv2r+btWQNcPitndpVTsjbu0Ji4_tzmap51A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jonas Gorski <jogo@openwrt.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mbizon@freebox.fr" <mbizon@freebox.fr>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "gregory.0xf0@gmail.com" <gregory.0xf0@gmail.com>

On Friday 21 February 2014 15:48:04 Jonas Gorski wrote:
> 
> There already is a (non-OF) user for this driver that exports a
> "periph" clock, which is where the name comes from. It currently does
> all clock lookups purely based on the clock name, not the device name
> itself. Of course we can just make it get a different named clock when
> of_node is present; that should satisfy both.

I think you are referring to arch/mips/bcm63xx/clk.c, but that doesn't
actually use clkdev at all and instead expects device drivers to know
the name of *output* of the clock controllers. You can't use that
name in the binding for a device, which needs to know the name of
the *input* from the clock consumer point of view.

An easy solution would be to register a clkdev lookup table in
the above clock driver.

> Technically on BCM6345 there are actually two clocks (more or less),
> the "periph" for the reference clock rate, and a clock bit in the
> clock controller register for the uart block. All later chips do not
> expose a uart clock bit anymore, and the bootloader is expected to
> enable it on systems with the clock, so we can probably pretend that
> it does not exist. Also it's quite unlikely that BCM6345 will ever
> receive proper OF support, and if it does, we can add the second
> optional clock then if we find devices that need it.

That seems fine, but it does mean things would get tricky we use
an anonymous clock and then later need to add the second clock
after all, e.g. if the uart gets reused in a new product that
requires you to program both clocks.

	Arnd
