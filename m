From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial: samsung: Move uart_register_driver call to
 device probe
Date: Thu, 23 Jan 2014 18:04:23 +0000
Message-ID: <20140123180423.1a62611a@www.etchedpixels.co.uk>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
	<1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
	<20140120100530.GY15937@n2100.arm.linux.org.uk>
	<CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:33859 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbaAWSEz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 Jan 2014 13:04:55 -0500
In-Reply-To: <CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, jslaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Mark Brown <broonie@kernel.org>

> I had earlier submitted a patch [1] to remove the hard coded
> major/minor number for Samsung UART driver, but that was rejected
> because of userspace breakage. Without this patch, Samsung UART driver
> can't bind to the hard-coded device node. Changing the default
> major/minor will also not help to fix the objections raised in [1].
> 
> Would you please suggest a way forward?
> 
> [1] https://lkml.org/lkml/2013/12/27/2

So to go and try and put this to bed properly I would suggest the
following way forward. 

We add

CONFIG_LEGACY_STATIC_TTY

Some platforms historically used static device nodes for the console
devices. Select this if you are building a kernel for an old system which
has a static /dev.

Note that because some devices historically used incorrect clashing
numbering this may prevent you building a single kernel which can be
booted on multiple platforms.


And then we do

	.nr		= CONFIG_SERIAL_SAMSUNG_UARTS,
 	.cons		= S3C24XX_SERIAL_CONSOLE,
 	.dev_name	= S3C24XX_SERIAL_NAME,
#ifdef CONFIG_LEGACY_STATIC_TTY
	.major		= S3C24XX_SERIAL_MAJOR,
	.minor		= S3C24XX_SERIAL_MINOR,
#endif

for the afflicted ports (and anyone else who wants to migrate)


We can then enable that config option for ARM (and in time for any other
architecture that turns out to need/want it). Eventually it can go away
(not that its exactly doing any harm if it doesnt).


Does that sound a valid way forward for everyone ?

Alan
