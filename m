Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B381FC48BE6
	for <linux-serial@archiver.kernel.org>; Wed, 16 Jun 2021 06:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E541613BF
	for <linux-serial@archiver.kernel.org>; Wed, 16 Jun 2021 06:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhFPGcF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Jun 2021 02:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231636AbhFPGbX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Jun 2021 02:31:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 256A9613C2;
        Wed, 16 Jun 2021 06:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623824957;
        bh=iS6BFCJPTZwDFmA1LAvtf4xTLCYj46S1LYq86CwMQgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z6ey7M1JJAdr2bV7sJVS0ZxM3acoGW6GJ+do5F5Nh+FKTTDgQqkJcll4SF040mvPw
         wyolF4Du+mA1eoVpdsFA6xi0GOV/emk4a7dyjf1gbu7ljVVR49qjHm/5PY4Cdxi9Dm
         wgmLeA39Xa2x2g1LhJrOObdSUTPpquF6tUp/V8ak=
Date:   Wed, 16 Jun 2021 08:29:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, linux@armlinux.org.uk,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: amba-pl011: add RS485 support
Message-ID: <YMmaOn8tEl7PcOE8@kroah.com>
References: <20210610135004.7585-1-LinoSanfilippo@gmx.de>
 <5f00ff43-9287-4027-7d80-474da957703c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f00ff43-9287-4027-7d80-474da957703c@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 16, 2021 at 08:18:01AM +0200, Jiri Slaby wrote:
> On 10. 06. 21, 15:50, Lino Sanfilippo wrote:
> > Add basic support for RS485: Provide a callback to configure rs485
> > settings. Handle the RS485 specific part in the functions
> > pl011_rs485_tx_start() and pl011_rs485_tx_stop() which extend the generic
> > start/stop callbacks.
> > Beside via IOCTL from userspace RS485 can be enabled by means of the
> > device tree property "rs485-enabled-at-boot-time".
> > 
> > Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> > ---
> > This patch has been tested with a Raspberry Pi CM3.
> > 
> >   drivers/tty/serial/amba-pl011.c | 143 +++++++++++++++++++++++++++++++-
> >   1 file changed, 140 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> > index 78682c12156a..36e8b938cdba 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> ...
> > @@ -1380,6 +1415,31 @@ static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c,
> >   	return true;
> >   }
> > +static void pl011_rs485_tx_start(struct uart_amba_port *uap)
> > +{
> > +	struct uart_port *port = &uap->port;
> > +	u32 cr;
> > +
> > +	/* Enable transmitter */
> > +	cr = pl011_read(uap, REG_CR);
> > +	cr |= UART011_CR_TXE;
> > +	/* Disable receiver if half-duplex */
> > +	if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
> > +		cr &= ~UART011_CR_RXE;
> > +
> > +	if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
> > +		cr &= ~UART011_CR_RTS;
> > +	else
> > +		cr |= UART011_CR_RTS;
> > +
> > +	pl011_write(cr, uap, REG_CR);
> > +
> > +	if (port->rs485.delay_rts_before_send)
> > +		mdelay(port->rs485.delay_rts_before_send);
> 
> This is up to 1 second delay with interrupts disabled. Definitely not nice.
> 8250 clamps this to 100 ms at least, why did you choose 1000 ms?
> 
> > +
> > +	uap->rs485_tx_started = true;
> > +}
> > +
> >   /* Returns true if tx interrupts have to be (kept) enabled  */
> >   static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
> >   {
> ...
> > @@ -1941,6 +2021,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
> >   	unsigned int lcr_h, old_cr;
> >   	unsigned long flags;
> >   	unsigned int baud, quot, clkdiv;
> > +	unsigned int bits;
> >   	if (uap->vendor->oversampling)
> >   		clkdiv = 8;
> > @@ -1968,25 +2049,32 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
> >   	switch (termios->c_cflag & CSIZE) {
> >   	case CS5:
> >   		lcr_h = UART01x_LCRH_WLEN_5;
> > +		bits = 7;
> >   		break;
> >   	case CS6:
> >   		lcr_h = UART01x_LCRH_WLEN_6;
> > +		bits = 8;
> >   		break;
> >   	case CS7:
> >   		lcr_h = UART01x_LCRH_WLEN_7;
> > +		bits = 9;
> >   		break;
> >   	default: // CS8
> >   		lcr_h = UART01x_LCRH_WLEN_8;
> > +		bits = 10;
> >   		break;
> >   	}
> > -	if (termios->c_cflag & CSTOPB)
> > +	if (termios->c_cflag & CSTOPB) {
> >   		lcr_h |= UART01x_LCRH_STP2;
> > +		bits++;
> > +	}
> >   	if (termios->c_cflag & PARENB) {
> >   		lcr_h |= UART01x_LCRH_PEN;
> >   		if (!(termios->c_cflag & PARODD))
> >   			lcr_h |= UART01x_LCRH_EPS;
> >   		if (termios->c_cflag & CMSPAR)
> >   			lcr_h |= UART011_LCRH_SPS;
> > +		bits++;
> >   	}
> 
> You can do simply:
>   bits = tty_get_frame_size(termios->c_cflag);
> now:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-testing&id=3ec2ff37230e1c961d4b0d0118dd23c46b5bcdbb

I was wondering about that.

I'll go drop this patch from my tty-next branch and wait for a new
version that fixes the above delay issue and it can use this new call as
well.

thanks,

greg k-h
