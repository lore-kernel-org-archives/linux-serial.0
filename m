Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63006C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 15:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4741D60EC0
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 15:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbhG2PC5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Jul 2021 11:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236712AbhG2PC4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Jul 2021 11:02:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBFE760720;
        Thu, 29 Jul 2021 15:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627570973;
        bh=D1RIARDbAI4djTLntepjJNZ61g5IsnTqeNGUKMm3K+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6395eewXaPjUAvp4wMC/kXrkSnve14VhV9ybFpoMRwRcX3raIv3cHbk9wgbQ2yJ4
         HvyvqcmXJsQ7/fzkKppE06kMZFKn7txwYBoEsz/djPo18Dc9HEGNc34r2cW42o+F0F
         znSUbyMmqQi76qTVStbI8euJD3g6//u85AZMbmOI=
Date:   Thu, 29 Jul 2021 17:02:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 4/5] tty: serial: uartlite: Initialize termios with fixed
 synthesis parameters
Message-ID: <YQLDGujm26qrtIsM@kroah.com>
References: <20210723223152.648326-1-sean.anderson@seco.com>
 <20210723223152.648326-5-sean.anderson@seco.com>
 <302ea0f9-6e61-ee8d-eb40-63f3bb81a278@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <302ea0f9-6e61-ee8d-eb40-63f3bb81a278@seco.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 26, 2021 at 04:53:39PM -0400, Sean Anderson wrote:
> 
> 
> On 7/23/21 6:31 PM, Sean Anderson wrote:
> > This reads the various new devicetree parameters to discover how the
> > uart was configured when it was synthesized. Note that these properties
> > are fixed and undiscoverable. Once we have determined how the uart is
> > configured, we set the termios to let users know, and to initialize the
> > timeout to the correct value.
> > 
> > The defaults match ulite_console_setup. xlnx,use-parity,
> > xlnx,odd-parity, and xlnx,data-bits are optional since there were
> > in-tree users (and presumably out-of-tree users) who did not set them.
> > 
> > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> > ---
> > 
> >   drivers/tty/serial/uartlite.c | 66 +++++++++++++++++++++++++++++++----
> >   1 file changed, 60 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> > index f42ccc40ffa6..39c17ab206ca 100644
> > --- a/drivers/tty/serial/uartlite.c
> > +++ b/drivers/tty/serial/uartlite.c
> > @@ -60,9 +60,20 @@
> >   static struct uart_port *console_port;
> >   #endif
> > 
> > +/**
> > + * struct uartlite_data: Driver private data
> > + * reg_ops: Functions to read/write registers
> > + * clk: Our parent clock, if present
> > + * baud: The baud rate configured when this device was synthesized
> > + * parity: The parity settings, like for uart_set_options()
> > + * bits: The number of data bits
> > + */
> >   struct uartlite_data {
> >   	const struct uartlite_reg_ops *reg_ops;
> >   	struct clk *clk;
> > +	int baud;
> > +	int parity;
> > +	int bits;
> >   };
> > 
> >   struct uartlite_reg_ops {
> > @@ -652,6 +663,9 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
> >   	port->type = PORT_UNKNOWN;
> >   	port->line = id;
> >   	port->private_data = pdata;
> > +	/* Initialize the termios to what was configured at synthesis-time */
> > +	uart_set_options(port, NULL, pdata->baud, pdata->parity, pdata->bits,
> > +			 'n');
> 
> I did some testing today, and discovered that the termios are not set
> properly. I think I missed this the first time around because on
> Microblaze QEMU this UART is the console, and the baud etc. gets set
> properly because of stdout-path (or bootargs). However, uart_set_options
> doesn't actually do anything with the termios when co is NULL.
> 
> The initial termios are set up by tty_init_termios (called from
> tty_init_dev). They come from either tty->driver->init_termios, or from
> tty->driver->termios[idx]. There is only one init_termios per-driver,
> so we would need to have multiple drivers if we wanted to have multiple
> UARTs with different (e.g.) bauds.
> 
> The indexed termios are designed to keep the settings from the previous
> time the tty was opened. So I think (ab)using them is not too terrible,
> especially since we will only set them once. Unfortunately, we cannot
> use tty_save_termios to initialize the indexed termio, since the tty is
> not set until tty_port_open, which is called after tty_init_dev.
> 
> Based on this, I think the neatest cut would be something like
> 
> /* perhaps just do this in ulite_assign? */
> ulite_request_port () {
> 	/* ... */
> 	termios = &ulite_uart_driver.tty_driver->termios[port->line];
> 	termios = kzalloc(sizeof(*termios));
> 	if (!termios)
> 		/* ... */
> 	termios.c_cflags = /* ... */
> 	/* etc */
> }
> 
> Unfortunately, according to include/linux/serial_core.h, tty_driver is
> not supposed to be touched by the low-level driver. But I think we have
> a bit of an unusual case here with a device that can't change baud. If
> anyone has other suggestions, I'm all for them.

If a driver can not support changes in baud rates, then just ignore all
changes to baud rates as there will not be an issue for anyone :)

thanks,

greg k-h
