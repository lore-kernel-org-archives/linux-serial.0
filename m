From: Thomas Koeller <thomas.koeller@baslerweb.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Wed, 30 Aug 2006 01:00:32 +0200
Message-ID: <200608300100.32836.thomas.koeller@baslerweb.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608260038.13662.thomas.koeller@baslerweb.com> <44F441F3.8050301@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail02.hansenet.de ([213.191.73.62]:40416 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S965033AbWH2XGy
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Aug 2006 19:06:54 -0400
In-Reply-To: <44F441F3.8050301@ru.mvista.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org, Thomas =?iso-8859-1?q?K=F6ller?= <thomas@koeller.dyndns.org>

On Tuesday 29 August 2006 15:32, Sergei Shtylyov wrote:
> > +	[PORT_RM9000] = {
> > +		.name		= "RM9000",
> > +		.fifo_size	= 16,
> > +		.tx_loadsz	= 16,
> > +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
> > +		.flags		= UART_CAP_FIFO,
> > +	},
> >  };
>
>     What was the point of introducing the separate port type if its
> settings are the same as for PORT_16550A?

I was under the impression that for every serial port hardware that is not
exactly identical to one of the standard types, a distinct port type is
required to be able to write code that takes care of its peculiarities.
But from what you have written so far I conclude that this was a
misconception.

>
> > -#ifdef CONFIG_SERIAL_8250_AU1X00
> > +#if defined (CONFIG_SERIAL_8250_AU1X00)
> >
> >  /* Au1x00 UART hardware has a weird register layout */
> >  static const u8 au_io_in_map[] = {
> > @@ -289,6 +296,36 @@ static inline int map_8250_out_reg(struc
> >  	return au_io_out_map[offset];
> >  }
> >
> > +#elif defined (CONFIG_SERIAL_8250_RM9K)
> > +
> > +static const u8
> > +	regmap_in[8] = {
> > +		[UART_RX]	= 0x00,
> > +		[UART_IER]	= 0x0c,
> > +		[UART_IIR]	= 0x14,
> > +		[UART_LCR]	= 0x1c,
> > +		[UART_MCR]	= 0x20,
> > +		[UART_LSR]	= 0x24,
> > +		[UART_MSR]	= 0x28,
> > +		[UART_SCR]	= 0x2c
> > +	},
> > +	regmap_out[8] = {
> > +		[UART_TX] 	= 0x04,
> > +		[UART_IER]	= 0x0c,
> > +		[UART_FCR]	= 0x18,
> > +		[UART_LCR]	= 0x1c,
> > +		[UART_MCR]	= 0x20,
> > +		[UART_LSR]	= 0x24,
> > +		[UART_MSR]	= 0x28,
> > +		[UART_SCR]	= 0x2c
> > +	};
>
>     I guess you're using regshift == 0?

Yes.

>
> > +
> > +#define map_8250_in_reg(up, offset) \
> > +	(((up)->port.type == PORT_RM9000) ? regmap_in[offset] : (offset))
> > +#define map_8250_out_reg(up, offset) \
> > +	(((up)->port.type == PORT_RM9000) ? regmap_out[offset] : (offset))
> > +
> > +
>
>     Why you're not using specific iotype for RM9000 UARTs?

Because I did not realize that this was necessary. The device registers are
ioremapped, and so the standard UPIO_MEM32 seemed the right thing to use. I
will return to this topic further down.

>
> >  #else
> > @@ -374,21 +411,21 @@ #define serial_inp(up, offset)		serial_i
> >  #define serial_outp(up, offset, value)	serial_out(up, offset, value)
> >
> >  /* Uart divisor latch read */
> > -static inline int _serial_dl_read(struct uart_8250_port *up)
> > +static inline unsigned int _serial_dl_read(struct uart_8250_port *up)
> >  {
> >  	return serial_inp(up, UART_DLL) | serial_inp(up, UART_DLM) << 8;
> >  }
> >
> >  /* Uart divisor latch write */
> > -static inline void _serial_dl_write(struct uart_8250_port *up, int
> > value) +static inline void _serial_dl_write(struct uart_8250_port *up,
> > unsigned int value) {
> >  	serial_outp(up, UART_DLL, value & 0xff);
> >  	serial_outp(up, UART_DLM, value >> 8 & 0xff);
> >  }
> >
> > -#ifdef CONFIG_SERIAL_8250_AU1X00
> > +#if defined (CONFIG_SERIAL_8250_AU1X00)
> >  /* Au1x00 haven't got a standard divisor latch */
> > -static int serial_dl_read(struct uart_8250_port *up)
> > +static unsigned int serial_dl_read(struct uart_8250_port *up)
> >  {
> >  	if (up->port.iotype == UPIO_AU)
> >  		return __raw_readl(up->port.membase + 0x28);
> > @@ -396,13 +433,26 @@ static int serial_dl_read(struct uart_82
> >  		return _serial_dl_read(up);
> >  }
> >
> > -static void serial_dl_write(struct uart_8250_port *up, int value)
> > +static void serial_dl_write(struct uart_8250_port *up, unsigned int
> > value) {
> >  	if (up->port.iotype == UPIO_AU)
> >  		__raw_writel(value, up->port.membase + 0x28);
> >  	else
> >  		_serial_dl_write(up, value);
> >  }
> > +#elif defined (CONFIG_SERIAL_8250_RM9K)
> > +static inline unsigned int serial_dl_read(struct uart_8250_port *up)
> > +{
> > +	return
> > +		((readl(up->port.membase + 0x10) << 8) |
> > +		(readl(up->port.membase + 0x08) & 0xff)) & 0xffff;
> > +}
> > +
> > +static inline void serial_dl_write(struct uart_8250_port *up, unsigned
> > int value) +{
> > +	writel(value, up->port.membase + 0x08);
> > +	writel(value >> 8, up->port.membase + 0x10);
> > +}
>
>     And why this doesn't check for up->port.type == PORT_RM9000 first? This
> way it won't work with any compatible UARTs anymore. This is wrong.

Because it is inside a conditional block already. I now realize that even if
the driver is configured for some special silicon it still has to support
the standard types, something that escaped me when I started to write the
code.

>
> > @@ -576,22 +626,17 @@ static int size_fifo(struct uart_8250_po
> >   */
> >  static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
> >  {
> > -	unsigned char old_dll, old_dlm, old_lcr;
> > -	unsigned int id;
> > +	unsigned char old_lcr;
> > +	unsigned int id, old_dl;
> >
> >  	old_lcr = serial_inp(p, UART_LCR);
> >  	serial_outp(p, UART_LCR, UART_LCR_DLAB);
> > +	old_dl = _serial_dl_read(p);
> >
> > -	old_dll = serial_inp(p, UART_DLL);
> > -	old_dlm = serial_inp(p, UART_DLM);
> > -
> > -	serial_outp(p, UART_DLL, 0);
> > -	serial_outp(p, UART_DLM, 0);
> > -
> > -	id = serial_inp(p, UART_DLL) | serial_inp(p, UART_DLM) << 8;
> > +	serial_dl_write(p, 0);
> > +	id = serial_dl_read(p);
> >
> > -	serial_outp(p, UART_DLL, old_dll);
> > -	serial_outp(p, UART_DLM, old_dlm);
> > +	serial_dl_write(p, old_dl);
> >  	serial_outp(p, UART_LCR, old_lcr);
> >
> >  	return id;
>
>     Not sure the autoconfig code was intended for half-compatible UARTs.
> Note that it sets up->port.type as its result. However, your change seems
> correct, it just have nothing to do with RM9000.

Should I factor out this part and create a separate patch for it?

>
>     As a side note, I think that the code that sets DLAB before and resets
> it after the divisor latch read/write should be part of serial_dl_read()
> and serial_dl_write() actually. In the Alchemy UARTs this bit is reserved.
>
> > @@ -1138,8 +1183,11 @@ static void serial8250_start_tx(struct u
> >  		if (up->bugs & UART_BUG_TXEN) {
> >  			unsigned char lsr, iir;
> >  			lsr = serial_in(up, UART_LSR);
> > -			iir = serial_in(up, UART_IIR);
> > -			if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT)
> > +			iir = serial_in(up, UART_IIR) & 0x0f;
> > +			if ((up->port.type == PORT_RM9000) ?
> > +			   	(lsr & UART_LSR_THRE &&
> > +				(iir == UART_IIR_NO_INT || iir == UART_IIR_THRI)) :
> > +				(lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT))
> >  				transmit_chars(up);
> >  		}
> >  	}
>
>     It would be good to clarify why this is needed...

The RM9000 serial h/w also needs to be kicked if a transmitter holding register empty
interrupt is pending. Oh, and no need to tell me, I realize that I have to deal with
the standard case here as well...



I would like to return to the port type vs. iotype  stuff once again. From what you
wrote I seem to understand that the iotype is not just a method of accessing device
registers, but also the primary means of discrimination between different h/w
implementations, and hence every code to support a nonstandard device must define an
iotype of its own, even though one of the existing iotypes would work just fine? In my
case, UPIO_AU might be the best choice, as __raw_readl() and __raw_writel() are insensitive
to CONFIG_SWAP_IO_SPACE, and that is what I want. Would I still need to invent UPIO_RM9K,
just to have a distinct iotype, and be able to do 'if (up->port.iotype == UPIO_RM9K)'
where I now use 'if (up->port.type == PORT_RM9000)'? That seems a bit weird.


Thomas
-- 
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com

