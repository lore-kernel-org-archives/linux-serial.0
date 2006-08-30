From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Wed, 30 Aug 2006 17:22:37 +0400
Message-ID: <44F5911D.8020807@ru.mvista.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608260038.13662.thomas.koeller@baslerweb.com> <44F441F3.8050301@ru.mvista.com> <200608300100.32836.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:1742 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1750835AbWH3NVe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Aug 2006 09:21:34 -0400
In-Reply-To: <200608300100.32836.thomas.koeller@baslerweb.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org, =?ISO-8859-1?Q?Thomas_?= =?ISO-8859-1?Q?K=F6ller?= <thomas@koeller.dyndns.org>

Hello.

Thomas Koeller wrote:

>>>+	[PORT_RM9000] = {
>>>+		.name		= "RM9000",
>>>+		.fifo_size	= 16,
>>>+		.tx_loadsz	= 16,
>>>+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
>>>+		.flags		= UART_CAP_FIFO,
>>>+	},
>>> };

>>    What was the point of introducing the separate port type if its
>>settings are the same as for PORT_16550A?

> I was under the impression that for every serial port hardware that is not
> exactly identical to one of the standard types, a distinct port type is
> required to be able to write code that takes care of its peculiarities.
> But from what you have written so far I conclude that this was a
> misconception.

    Yes, I see one case where the distinct port type serves its purpose --
iotype could have been used instead anyway.

>>>@@ -289,6 +296,36 @@ static inline int map_8250_out_reg(struc
>>> 	return au_io_out_map[offset];
>>> }
>>> 
>>>+#elif defined (CONFIG_SERIAL_8250_RM9K)
>>>+
>>>+static const u8
>>>+	regmap_in[8] = {
>>>+		[UART_RX]	= 0x00,
>>>+		[UART_IER]	= 0x0c,
>>>+		[UART_IIR]	= 0x14,
>>>+		[UART_LCR]	= 0x1c,
>>>+		[UART_MCR]	= 0x20,
>>>+		[UART_LSR]	= 0x24,
>>>+		[UART_MSR]	= 0x28,
>>>+		[UART_SCR]	= 0x2c
>>>+	},
>>>+	regmap_out[8] = {
>>>+		[UART_TX] 	= 0x04,
>>>+		[UART_IER]	= 0x0c,
>>>+		[UART_FCR]	= 0x18,
>>>+		[UART_LCR]	= 0x1c,
>>>+		[UART_MCR]	= 0x20,
>>>+		[UART_LSR]	= 0x24,
>>>+		[UART_MSR]	= 0x28,
>>>+		[UART_SCR]	= 0x2c
>>>+	};

>>    I guess you're using regshift == 0?

> Yes.

    Well, regshift of 2 seems more fitting for the 32-bit registers. This is 
not principal but using 0 regshift don't actually buy anything -- the shift 
will be perfomed anyway.

>>>+
>>>+#define map_8250_in_reg(up, offset) \
>>>+	(((up)->port.type == PORT_RM9000) ? regmap_in[offset] : (offset))
>>>+#define map_8250_out_reg(up, offset) \
>>>+	(((up)->port.type == PORT_RM9000) ? regmap_out[offset] : (offset))
>>>+
>>>+

>>    Why you're not using specific iotype for RM9000 UARTs?

> Because I did not realize that this was necessary. The device registers are

    This is strange as you had an opposite example before your eyes.

> ioremapped, and so the standard UPIO_MEM32 seemed the right thing to use. I

    It is not.

> will return to this topic further down.

    So, read on... :-)

>>>@@ -374,21 +411,21 @@ #define serial_inp(up, offset)		serial_i
[...]
>>>-#ifdef CONFIG_SERIAL_8250_AU1X00
>>>+#if defined (CONFIG_SERIAL_8250_AU1X00)
>>> /* Au1x00 haven't got a standard divisor latch */
>>>-static int serial_dl_read(struct uart_8250_port *up)
>>>+static unsigned int serial_dl_read(struct uart_8250_port *up)
>>> {
>>> 	if (up->port.iotype == UPIO_AU)
>>> 		return __raw_readl(up->port.membase + 0x28);
>>>@@ -396,13 +433,26 @@ static int serial_dl_read(struct uart_82
>>> 		return _serial_dl_read(up);
>>> }
>>>
>>>-static void serial_dl_write(struct uart_8250_port *up, int value)
>>>+static void serial_dl_write(struct uart_8250_port *up, unsigned int
>>>value) {
>>> 	if (up->port.iotype == UPIO_AU)
>>> 		__raw_writel(value, up->port.membase + 0x28);
>>> 	else
>>> 		_serial_dl_write(up, value);
>>> }
>>>+#elif defined (CONFIG_SERIAL_8250_RM9K)
>>>+static inline unsigned int serial_dl_read(struct uart_8250_port *up)
>>>+{
>>>+	return
>>>+		((readl(up->port.membase + 0x10) << 8) |
>>>+		(readl(up->port.membase + 0x08) & 0xff)) & 0xffff;
>>>+}
>>>+
>>>+static inline void serial_dl_write(struct uart_8250_port *up, unsigned
>>>int value) +{
>>>+	writel(value, up->port.membase + 0x08);
>>>+	writel(value >> 8, up->port.membase + 0x10);
>>>+}

>>    And why this doesn't check for up->port.type == PORT_RM9000 first? This
>>way it won't work with any compatible UARTs anymore. This is wrong.

> Because it is inside a conditional block already. I now realize that even if
> the driver is configured for some special silicon it still has to support
> the standard types, something that escaped me when I started to write the
> code.

    Yes. And it's after you have yourself pointed out the compatibility 
issues. :-)

>>>@@ -576,22 +626,17 @@ static int size_fifo(struct uart_8250_po
>>>  */
>>> static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
>>> {
>>>-	unsigned char old_dll, old_dlm, old_lcr;
>>>-	unsigned int id;
>>>+	unsigned char old_lcr;
>>>+	unsigned int id, old_dl;
>>>
>>> 	old_lcr = serial_inp(p, UART_LCR);
>>> 	serial_outp(p, UART_LCR, UART_LCR_DLAB);
>>>+	old_dl = _serial_dl_read(p);
>>>
>>>-	old_dll = serial_inp(p, UART_DLL);
>>>-	old_dlm = serial_inp(p, UART_DLM);
>>>-
>>>-	serial_outp(p, UART_DLL, 0);
>>>-	serial_outp(p, UART_DLM, 0);
>>>-
>>>-	id = serial_inp(p, UART_DLL) | serial_inp(p, UART_DLM) << 8;
>>>+	serial_dl_write(p, 0);
>>>+	id = serial_dl_read(p);
>>>
>>>-	serial_outp(p, UART_DLL, old_dll);
>>>-	serial_outp(p, UART_DLM, old_dlm);
>>>+	serial_dl_write(p, old_dl);
>>> 	serial_outp(p, UART_LCR, old_lcr);
>>>
>>> 	return id;

>>    Not sure the autoconfig code was intended for half-compatible UARTs.
>>Note that it sets up->port.type as its result. However, your change seems
>>correct, it just have nothing to do with RM9000.

> Should I factor out this part and create a separate patch for it?

    Now this is up to Russel. :-)

>>    As a side note, I think that the code that sets DLAB before and resets
>>it after the divisor latch read/write should be part of serial_dl_read()
>>and serial_dl_write() actually. In the Alchemy UARTs this bit is reserved.

    BTW, I guess for RM9000 it should be also reserved?

>>>@@ -1138,8 +1183,11 @@ static void serial8250_start_tx(struct u
>>> 		if (up->bugs & UART_BUG_TXEN) {
>>> 			unsigned char lsr, iir;
>>> 			lsr = serial_in(up, UART_LSR);
>>>-			iir = serial_in(up, UART_IIR);
>>>-			if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT)
>>>+			iir = serial_in(up, UART_IIR) & 0x0f;
>>>+			if ((up->port.type == PORT_RM9000) ?
>>>+			   	(lsr & UART_LSR_THRE &&
>>>+				(iir == UART_IIR_NO_INT || iir == UART_IIR_THRI)) :
>>>+				(lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT))
>>> 				transmit_chars(up);
>>> 		}
>>> 	}

>>    It would be good to clarify why this is needed...

> The RM9000 serial h/w also needs to be kicked if a transmitter holding register empty
> interrupt is pending. Oh, and no need to tell me, I realize that I have to deal with
> the standard case here as well...

    Does RM9000 have UART_BUG_TXEN flag set?  Note that this code will only 
execute in such case.

> I would like to return to the port type vs. iotype  stuff once again. From what you
> wrote I seem to understand that the iotype is not just a method of accessing device
> registers, but also the primary means of discrimination between different h/w

    No, it's intended as just a method of accessing device registers.

> implementations, and hence every code to support a nonstandard device must define an
> iotype of its own, even though one of the existing iotypes would work just fine? In my

    UPIO_MEM32 doesn't actually cover your case as it corresponds to the UART 
with the
fully 8250-compatible register set, just having 32-bit registers instead of 
the usual
8-bit ones. RM9000 is clearly not fully compatible to 8250 in regard to the 
register
addresses since it has RX/TX regs, FCR and the divisor latch mapped to the 
separate
addresses, just like Alchemy UART. And I stressed that it's the main issue 
with this
UART's compatibility to 8250 in my first followup.

> case, UPIO_AU might be the best choice,

    Alchemy UARTs have *different* address mapping, so UPIO_AU clearly 
*cannot* be used for RM9000 UART.

> as __raw_readl() and __raw_writel() are insensitive
> to CONFIG_SWAP_IO_SPACE, and that is what I want.

    Why you've used readl() and writel() then, may I ask? :-)

> Would I still need to invent UPIO_RM9K,

    Yes.

> just to have a distinct iotype, and be able to do 'if (up->port.iotype == UPIO_RM9K)'

    A good "just to".

> where I now use 'if (up->port.type == PORT_RM9000)'? That seems a bit weird.

    Why?

> Thomas

WBR, Sergei

