From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/4] tty/serial: Add helpers to use GPIOs to control
 modem lines
Date: Thu, 13 Feb 2014 09:37:39 -0800
Message-ID: <20140213173739.GA31431@kroah.com>
References: <1392140715-15295-1-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:32789 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbaBMRgV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 12:36:21 -0500
Content-Disposition: inline
In-Reply-To: <1392140715-15295-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Feb 11, 2014 at 06:45:11PM +0100, Richard Genoud wrote:
> The USART controller on sam9x5 chips (and also all AT91/SAMA5 chips
> but at91rm9200) are not capable of handling DTR/DSR/DCD/RI signal.
> Moreover, even if the controller can handle CTS/RTS, the dedicated
> CTS/RTS pins are already muxed for other peripherals (LCDC/EMAC/MMC).
> 
> So this patchset adds the possibility to control those lines via GPIO,
> as it is done for RTS in the patch "switch atmel serial to use gpiolib"
> 
> As it was suggested by Alexander Shiyan, I made that available for
> every board.
> 
> This is based on 3.14-rc2 + Linus Walleij/Nicolas Ferre's patch:
>  354e57f3a0a2 ARM/serial: at91: switch atmel serial to use gpiolib
> (in Uwe's tree git://git.pengutronix.de/git/ukl/linux.git dropmachtimexh )
> and Philipp Zabel's patch:
> gpiolib: make gpiod_direction_output take a logical value, add gpiod_direction_output_raw
> (there won't be a merge conflict if this last patch is not present, the
> gpios will "just" be on the wrong direction.)
>  
> Tested on at91sam9g35, with a null modem cable between 2 serial ports,
> one with CTS/RTS controlled by the USART controller, the other via GPIO,
> full duplex transfers.
> Did some tests also with null modem cables on a PC.
> 
> Updates from v2:
> 	- Instead of controlling modem signal only on atmel board, the
> 	code is now available for every board.
> 	- The active low flag from device tree is now used.

I'm confused, how does this series relate to the previously sent 8 patch
series?

As I don't know what is going on, I'm going to drop both from my
to-apply queue, and await a new set of patches.

thanks,

greg k-h
