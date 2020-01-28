Return-Path: <SRS0=GjUI=3R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B323C2D0DB
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jan 2020 13:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7355320CC7
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jan 2020 13:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgA1NRJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:17:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:32842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgA1NRJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jan 2020 08:17:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 18C54B246;
        Tue, 28 Jan 2020 13:17:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <88af0fca-90d1-58ff-406d-73f185eb8b7e@gmail.com>
Date:   Tue, 28 Jan 2020 13:42:21 +0100
Subject: Re: [PATCH] serial: 8250_early: Add earlycon for BCM2835 aux uart
From:   "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
To:     "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Lukas Wunner" <lukas@wunner.de>, <matthias.bgg@kernel.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        "Matthias Brugger" <mbrugger@suse.com>,
        "Scott Branden" <sbranden@broadcom.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        "Ray Jui" <rjui@broadcom.com>,
        "Stephen Boyd" <swboyd@chromium.org>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <jslaby@suse.com>,
        <nsaenzjulienne@suse.de>
Message-Id: <C07FL64L9QNN.357K7JAUOSNA2@linux-9qgx>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun Jan 26, 2020 at 9:20 PM, Matthias Brugger wrote:
>
>
> On 26/01/2020 14:12, Lukas Wunner wrote:
> > On Sun, Jan 26, 2020 at 01:33:14PM +0100, matthias.bgg@kernel.org wrote=
:
> >> +#ifdef CONFIG_SERIAL_8250_CONSOLE
> >> +
> >> +static int __init early_bcm2835aux_setup(struct earlycon_device *devi=
ce,
> >> +					const char *options)
> >> +{
> >> +	if (!device->port.membase)
> >> +		return -ENODEV;
> >> +
> >> +	device->port.iotype =3D UPIO_MEM32;
> >> +	device->port.regshift =3D 2;
> >> +
> >> +	return early_serial8250_setup(device, NULL);
> >> +}
> >> +
> >> +OF_EARLYCON_DECLARE(bcm2835aux, "brcm,bcm2835-aux-uart",
> >> +		    early_bcm2835aux_setup);
> >> +#endif
> >=20
> > Does this really work?  I also tried to get it working recently and
> > the system just hung on boot.  Looking at it with a JTAG debugger
> > showed that the bcm2835aux registers were inaccessible because
> > the mini UART wasn't enabled in the AUXENB register.
> >=20
> > Maybe if you use OF_EARLYCON_DECLARE, the firmware recognizes that
> > serial1 is set as stdout-path and performs enablement of the mini UART?
> > Or are you using U-Boot which perhaps does the enablement?
>
> Yes I'm using U-Boot which enables the console for me. My understanding
> is that
> the early console is thought as a re-use of the console the boot FW used
> for
> logging. AFAIK for example it does not enable any needed clocks but
> expects
> these to be enabled already.
>
> Looking on the source code of U-Boot [1] I don't see that the AUXENB is
> written
> somewhere, so I suppose that the FW should already has enabled the
> aux-uart.
>
> I any case if it's just to set one bit, I think we can do that in
> early_bcm2835aux_setup().
>
> [1]
> https://gitlab.denx.de/u-boot/u-boot/blob/master/drivers/serial/serial_bc=
m283x_mu.c
>
> >=20
> > I also saw in the JTAG debugger that the uartclk member contained
> > an incorrect value, so I'd expect that it has to be set as well in
> > early_bcm2835aux_setup().
>
> In my case the clock was set by U-Boot already.

I'm testing this by booting directly from RPi4's bootloader. And it
works as long as I add this to config.txt:

enable_uart=3D1
gpu_freq=3D500

Which AFAIK blocks frequency scalin on the GPU and fixes the clock to a
point where the serial is set at 115200 bauds.

Ideally it'd be nice to be able to query the clock frequency, and
recalculate the divisors based on that. But I don't know if it's
feasible at that point in the boot process.

We could maybe leave a comment explaining what is expected from the
bootloader, given the different options around.

Regards,
Nicolas
