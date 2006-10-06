From: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Xscale UART detection false positive
Date: Fri, 6 Oct 2006 04:36:45 -0700
Message-ID: <20061006113645.GA20513@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from xyzzy.farnsworth.org ([65.39.95.219]:48397 "HELO farnsworth.org")
	by vger.kernel.org with SMTP id S1751215AbWJFLgs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Oct 2006 07:36:48 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

The following code from autoconfig_16550a() incorrectly determines that
the UARTS in the Tundra TSI108 are Xscale UARTS and misconfigures them.

>	/*
>	 * Try writing and reading the UART_IER_UUE bit (b6).
>	 * If it works, this is probably one of the Xscale platform's
>	 * internal UARTs.
>	 * We're going to explicitly set the UUE bit to 0 before
>	 * trying to write and read a 1 just to make sure it's not
>	 * already a 1 and maybe locked there before we even start start.
>	 */
>	iersave = serial_in(up, UART_IER);
>	serial_outp(up, UART_IER, iersave & ~UART_IER_UUE);
>	if (!(serial_in(up, UART_IER) & UART_IER_UUE)) {
>		/*
>		 * OK it's in a known zero state, try writing and reading
>		 * without disturbing the current state of the other bits.
>		 */
>		serial_outp(up, UART_IER, iersave | UART_IER_UUE);
>		if (serial_in(up, UART_IER) & UART_IER_UUE) {
>			/*
>			 * It's an Xscale.
>			 * We'll leave the UART_IER_UUE bit set to 1 (enabled).
>			 */
>			DEBUG_AUTOCONF("Xscale ");
>			up->port.type = PORT_XSCALE;
>			up->capabilities |= UART_CAP_UUE;
>			return;
>		}
>	} else {
>		/*
>		 * If we got here we couldn't force the IER_UUE bit to 0.
>		 * Log it and continue.
>		 */
>		DEBUG_AUTOCONF("Couldn't force IER_UUE to 0 ");
>	}
>	serial_outp(up, UART_IER, iersave);

Right now, I work around this by ifdeffing out that code.
Any ideas on alternative methods for autodetecting Xscale UARTS?

Dale Farnsworth
