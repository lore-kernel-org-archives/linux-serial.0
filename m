Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC31A2631;
	Mon,  6 Jan 2025 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151048; cv=none; b=PADstswjl44tz2q459lD03UnpKjEVbpbubvC2fLjJ5mzwhUqjpSvxwqm3wmWqgTEG3zRsE9YQeTBt1pjD1D///TjpONkJ8ioKm+7iOHa7V7j1kvDPgcsxKBWOcaF0zx6I6Gpg40s9uJEtjqVyltONVNsDrbxeGXKieI3iw5bIb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151048; c=relaxed/simple;
	bh=CWqlxpT4EiaDDmueUpXeHkf8KK5+67DoTvgc81Tos2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aa8s2kf3o+t/dCzWKeVwb8W0t9S7uLM1owj8Z/tgkpamOiLpmCJT1AebjcN0dcOLnd5jS3lhFbX6C88AY7+qZanJLn8BMJYRwNe+CcUokeeYzb2qEAKflK5AVIPVfF2WPSZzTTj+KGhGYIcic3XxBu+uq939ljvI5//FUNWfOAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ndWeeq59; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ndWeeq59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3344DC4CED2;
	Mon,  6 Jan 2025 08:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736151047;
	bh=CWqlxpT4EiaDDmueUpXeHkf8KK5+67DoTvgc81Tos2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ndWeeq59+0wV8MvKV53MpqSiNy6bZJw2iCE55gEHXccbYAfGPpd/mu0e/yHysozQa
	 0XVmOt28jS0dWfw0pUfdPwCw26kpeKdFPMZGCcBcnr9pz+MJmVu1kWpHTtU47MSZDb
	 wJT5geFzjHDDnrftiAmOaUS7ENYonnyuGO40VHOs=
Date: Mon, 6 Jan 2025 09:09:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	ansuelsmth@gmail.com, lorenzo@kernel.org
Subject: Re: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
Message-ID: <2025010646-nacho-grinning-cd35@gregkh>
References: <20250105131147.2290237-1-benjamin.larsson@genexis.eu>
 <20250105131147.2290237-3-benjamin.larsson@genexis.eu>
 <2025010500-subscript-expectant-144a@gregkh>
 <45f22ec5-76da-4a1d-bdf5-22246dc8f692@genexis.eu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45f22ec5-76da-4a1d-bdf5-22246dc8f692@genexis.eu>

On Sun, Jan 05, 2025 at 09:44:52PM +0100, Benjamin Larsson wrote:
> Hi.
> 
> On 05/01/2025 16:59, Greg KH wrote:
> > 
> > On Sun, Jan 05, 2025 at 02:11:47PM +0100, Benjamin Larsson wrote:
> > > Support for Airoha AN7581 SoC UART and HSUART baud rate
> > > calculation routine.
> > > 
> > > Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > > ---
> > >   drivers/tty/serial/8250/8250_airoha.c | 85 +++++++++++++++++++++++++++
> > >   drivers/tty/serial/8250/8250_of.c     |  2 +
> > >   drivers/tty/serial/8250/8250_port.c   | 26 ++++++++
> > >   drivers/tty/serial/8250/Kconfig       | 10 ++++
> > >   drivers/tty/serial/8250/Makefile      |  1 +
> > >   include/linux/serial_8250.h           |  1 +
> > >   include/uapi/linux/serial_core.h      |  6 ++
> > >   include/uapi/linux/serial_reg.h       |  9 +++
> > >   8 files changed, 140 insertions(+)
> > >   create mode 100644 drivers/tty/serial/8250/8250_airoha.c
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250_airoha.c b/drivers/tty/serial/8250/8250_airoha.c
> > > new file mode 100644
> > > index 000000000000..c57789dcc174
> > > --- /dev/null
> > > +++ b/drivers/tty/serial/8250/8250_airoha.c
> > > @@ -0,0 +1,85 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > 
> > Do you really mean "+" here?  Sorry, I have to ask.
> > 
> 
> I just try to follow the style of 8250_port.c. Whatever is fine by me.

That's your call, please talk about it with your company lawyers.

> > >   /* Uart divisor latch read */
> > > @@ -2847,6 +2863,16 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
> > > 
> > >        serial8250_set_divisor(port, baud, quot, frac);
> > > 
> > > +
> > > +     /*
> > > +      * Airoha SoCs have custom registers for baud rate settings
> > > +      */
> > > +#ifdef CONFIG_SERIAL_8250_AIROHA
> > 
> > Please don't put #ifdef in .c files, are you sure this is needed this
> > way?  Why not do it the other way around like other uart types do it?
> 
> There are other instances of ifdef in the code (#ifdef
> CONFIG_SERIAL_8250_RSA). Thus I used ifdefs.

Don't follow bad practices of others please.

> Should I use IS_REACHABLE or IS_ENABLED instead?

Neither, put it in a .h file properly instead.

> > > --- a/include/linux/serial_8250.h
> > > +++ b/include/linux/serial_8250.h
> > > @@ -195,6 +195,7 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
> > >   void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
> > >                               unsigned int quot);
> > >   int fsl8250_handle_irq(struct uart_port *port);
> > > +int airoha8250_set_baud_rate(struct uart_port *port, unsigned int baud, unsigned int hs);
> > 
> > Why is this here?
> 
> I use the same place as fsl8250_handle_irq() uses. Should I place it
> somewhere else ?

Yes please, put it in your own .h file which you will need anyway.

> > >   int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
> > >   u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
> > >   void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
> > > diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> > > index 9c007a106330..c71fb338accb 100644
> > > --- a/include/uapi/linux/serial_core.h
> > > +++ b/include/uapi/linux/serial_core.h
> > > @@ -231,6 +231,12 @@
> > >   /* Sunplus UART */
> > >   #define PORT_SUNPLUS 123
> > > 
> > > +/* Airoha UART */
> > > +#define PORT_AIROHA  124
> > > +
> > > +/* Airoha HSUART */
> > > +#define PORT_AIROHA_HS       125
> > 
> > Do you REALLY need these port definitions in userspace?  If so, what is
> > going to use them there?
> > 
> 
> Testing another PORT define gives this result:
> 
> grep -ri PORT_MTK_BTIF *
> 
> drivers/tty/serial/8250/8250_of.c:		.data = (void *)PORT_MTK_BTIF, },
> drivers/tty/serial/8250/8250_port.c:	[PORT_MTK_BTIF] = {
> include/uapi/linux/serial_core.h:#define PORT_MTK_BTIF	117
> 
> Per my understanding this is how the current code is designed to work.

That's a very old pattern, I'm asking you if you need this new number in
userspace, which is what you are doing here.  I'd prefer not to add new
values here as they are a pain to manage and we can never change them if
added.

> > > +
> > >   /* Generic type identifier for ports which type is not important to userspace. */
> > >   #define PORT_GENERIC (-1)
> > > 
> > > diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
> > > index 9c987b04e2d0..72a71e171602 100644
> > > --- a/include/uapi/linux/serial_reg.h
> > > +++ b/include/uapi/linux/serial_reg.h
> > > @@ -383,5 +383,14 @@
> > >   #define UART_ALTR_EN_TXFIFO_LW       0x01    /* Enable the TX FIFO Low Watermark */
> > >   #define UART_ALTR_TX_LOW     0x41    /* Tx FIFO Low Watermark */
> > > 
> > > +/*
> > > + * These are definitions for the Airoha UART
> > > + * Normalized because of 32 bit registers.
> > > + */
> > > +#define UART_BRDL            0
> > > +#define UART_BRDH            1
> > > +#define UART_XINCLKDR                10
> > > +#define UART_XYD             11
> > 
> > Why does the define not have your uart type in it?
> 
> I will address this in v2.
> 
> >  And what is
> > userspace going to do with these values?  Why do they need to be in this
> > file?
> 
> Per my understanding I am following the intended design.

What design?  Again what needs this in userspace to require it in this
.h file?  Why not just put them in your own private .h file as they are
only used by your module and nothing else, right?

thanks,

greg k-h
