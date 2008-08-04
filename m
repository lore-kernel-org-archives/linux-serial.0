From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Mon, 4 Aug 2008 16:14:35 +0200
Message-ID: <014e01c8f63c$6d03dee0$2e01a8c0@acksys.local>
References: <200807241347.33261.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp01.msg.oleane.net ([62.161.4.1]:36097 "EHLO
	smtp01.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbYHDOQa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Aug 2008 10:16:30 -0400
In-Reply-To: <200807241347.33261.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Laurent Pinchart' <laurentp@cse-semaphore.com>, linux-serial@vger.kernel.org

About the flags names -- CARTS, UART_FCTR_RS485

May I suggest CRTSTOGGLE since it is known by that kind of name in other
OS's :-)

And further, it says was RTS will do, instead of why. Maybe someone could
use it for something other than RS485 ?

Regards

JP Tosoni

> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org
> [mailto:linux-serial-owner@vger.kernel.org]On Behalf Of
> Laurent Pinchart
> Sent: Thursday, July 24, 2008 1:47 PM
> To: linux-serial@vger.kernel.org
> Cc: Alan Cox; rmk@arm.linux.org.uk
> Subject: [PATCH/RFC] 8250: Auto RS485 direction control
>
>
> This patch adds support for the automatic RS485 direction
> control feature
> present in 16850 UARTs.
>
> A new termios c_cflag, CARTS, is introduced to configure
> automatic direction
> control from userspace.
>
> This is a first proposal. I'm open to suggestions regarding
> the CARTS name.
> I assume the CARTS flag will have to be added to all
> asm/termbits.h headers.
> Why are the termios bits definitions platform specific ?
>
> ---
>  drivers/serial/8250.c          |   14 ++++++++++++++
>  include/asm-powerpc/termbits.h |    1 +
>  include/linux/serial_reg.h     |    1 +
>  3 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index 62a2e49..a1351d5 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -2071,6 +2071,20 @@ serial8250_set_termios(struct
> uart_port *port, struct ktermios *termios,
>  	if (up->port.type == PORT_16750)
>  		serial_outp(up, UART_FCR, fcr);
>
> +#ifdef CARTS
> +	/* Auto RS485 Direction Control on 16850 UARTs */
> +	if (up->port.type == PORT_16850) {
> +		unsigned char fctr;
> +
> +		serial_outp(up, UART_LCR, 0xbf);
> +		fctr = serial_inp(up, UART_FCTR) & ~UART_FCTR_RS485;
> +		if (termios->c_cflag & CARTS)
> +			fctr |= UART_FCTR_RS485;
> +		serial_outp(up, UART_FCTR, fctr);
> +		serial_outp(up, UART_LCR, 0);
> +	}
> +#endif
> +
>  	serial_outp(up, UART_LCR, cval);		/* reset DLAB */
>  	up->lcr = cval;					/* Save LCR */
>  	if (up->port.type != PORT_16750) {
> diff --git a/include/asm-powerpc/termbits.h
> b/include/asm-powerpc/termbits.h
> index 5e79198..7b7ee27 100644
> --- a/include/asm-powerpc/termbits.h
> +++ b/include/asm-powerpc/termbits.h
> @@ -166,6 +166,7 @@ struct ktermios {
>  #define HUPCL	00040000
>
>  #define CLOCAL	00100000
> +#define CARTS	  004000000000		/* auto RTS control */
>  #define CMSPAR	  010000000000		/* mark or
> space (stick) parity */
>  #define CRTSCTS	  020000000000		/* flow control */
>
> diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
> index 3c8a6aa..3db78cc 100644
> --- a/include/linux/serial_reg.h
> +++ b/include/linux/serial_reg.h
> @@ -188,6 +188,7 @@
>  #define UART_FCTR_RTS_8DELAY	0x03
>  #define UART_FCTR_IRDA		0x04  /* IrDa data
> encode select */
>  #define UART_FCTR_TX_INT	0x08  /* Tx interrupt type select */
> +#define UART_FCTR_RS485		0x08  /* Auto RS485
> direction control */
>  #define UART_FCTR_TRGA		0x00  /* Tx/Rx 550
> trigger table select */
>  #define UART_FCTR_TRGB		0x10  /* Tx/Rx 650
> trigger table select */
>  #define UART_FCTR_TRGC		0x20  /* Tx/Rx 654
> trigger table select */
> --
> 1.5.0
>
> --
> Laurent Pinchart
> CSE Semaphore Belgium
>
> Chaussee de Bruxelles, 732A
> B-1410 Waterloo
> Belgium
>
> T +32 (2) 387 42 59
> F +32 (2) 387 42 75
>

