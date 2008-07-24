From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Thu, 24 Jul 2008 13:10:50 +0100
Message-ID: <20080724121050.GA9327@flint.arm.linux.org.uk>
References: <200807241347.33261.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37674 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803AbYGXMLP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 08:11:15 -0400
Content-Disposition: inline
In-Reply-To: <200807241347.33261.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, Jul 24, 2008 at 01:47:29PM +0200, Laurent Pinchart wrote:
> This patch adds support for the automatic RS485 direction control feature
> present in 16850 UARTs.
> 
> A new termios c_cflag, CARTS, is introduced to configure automatic direction
> control from userspace.
> 
> This is a first proposal. I'm open to suggestions regarding the CARTS name.

I think CARTS is a bad name - if you look at other 8250 ports, they have
auto-flow control for normal communications which not only includes
stopping the transmitter when CTS deasserts, but also allows the device
to deassert RTS when the receive FIFO reaches a certain level.

That means that the name "auto RTS" is confusing.

Maybe a better name would be CRS485 to enable RS485 direction control?
Then we can use CRTSCTS to mean "on the RTS signal".  If/when a
CDTRDSR for DTR/DSR flow control is introduced, we could then use
that to switch to DTR RS485 direction control instead.

> I assume the CARTS flag will have to be added to all asm/termbits.h
> headers.

Yes...

> Why are the termios bits definitions platform specific ?

... though if you can find a free bit in the cflag on all platforms,
creating an asm-generic/termbits.h might be a good idea?

Alan should probably comment on that first though.

> diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
> index 3c8a6aa..3db78cc 100644
> --- a/include/linux/serial_reg.h
> +++ b/include/linux/serial_reg.h
> @@ -188,6 +188,7 @@
>  #define UART_FCTR_RTS_8DELAY	0x03
>  #define UART_FCTR_IRDA		0x04  /* IrDa data encode select */
>  #define UART_FCTR_TX_INT	0x08  /* Tx interrupt type select */
> +#define UART_FCTR_RS485		0x08  /* Auto RS485 direction control */

Please include in the comment which device this refers to (as the entries
below do.)

>  #define UART_FCTR_TRGA		0x00  /* Tx/Rx 550 trigger table select */
>  #define UART_FCTR_TRGB		0x10  /* Tx/Rx 650 trigger table select */
>  #define UART_FCTR_TRGC		0x20  /* Tx/Rx 654 trigger table select */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
