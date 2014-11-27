From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 01/10] tty: Fallback to use dynamic major number
Date: Thu, 27 Nov 2014 15:33:58 +0100
Message-ID: <4316435.J1BtEYnd6C@wuerfel>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com> <5475E4EC.7090309@hurleysoftware.com> <CACxGe6uLWZav=AfaK2w17PW6vtxF8S0=OUvCMB-uFSvhs2cLtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:62033 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaK0OeM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Nov 2014 09:34:12 -0500
In-Reply-To: <CACxGe6uLWZav=AfaK2w17PW6vtxF8S0=OUvCMB-uFSvhs2cLtw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Kevin Cernekee <cernekee@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, tushar.b@samsung.com

On Thursday 27 November 2014 13:50:01 Grant Likely wrote:
> 
> Should be sufficient. Basically, if the hardware doesn't exist, the
> driver shouldn't be trying to grab the minor numbers.
> 
> Also, on hardware where both exists, there should be some sane
> fallback so that all UARTs get assigned numbers. On DT systems we can
> also use /aliases to ensure consistent assignment of numbers.

>From what I can see, this is really the ISA compatibility code
in the 8250 driver, and we should be able to make that optional
or even move it into a separate glue driver.

Basically the serial8250_init function tries to do a lot of things
at once (skipping error handling):

        serial8250_isa_init_ports();
        ret = sunserial_register_minors(&serial8250_reg, UART_NR);
	serial8250_reg.nr = UART_NR;
        ret = uart_register_driver(&serial8250_reg);
        ret = serial8250_pnp_init();
        serial8250_isa_devs = platform_device_alloc("serial8250",
                                                   PLAT8250_DEV_LEGACY);
        ret = platform_device_add(serial8250_isa_devs);
        serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
        ret = platform_driver_register(&serial8250_isa_driver);

The only thing we want from this is the uart_register_driver() call,
everything else is only needed together with the ISA support. The way
that uart_register_driver() works unfortunately implies that you know
the maximum number of ports at driver init time, which would need
to be changed if you want to share the numbers.

One idea I had a few years ago when we discussed this was to treat
the major 4 allocation differently so you could share it between all
sorts of drivers as an opt-in, but could have all unmodified continue
using their own device names and numbers.

	Arnd
