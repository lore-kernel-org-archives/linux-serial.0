From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Tue, 29 Aug 2006 17:32:35 +0400
Message-ID: <44F441F3.8050301@ru.mvista.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608220057.52213.thomas.koeller@baslerweb.com> <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp> <200608260038.13662.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:39081 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S964960AbWH2Nbd
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Aug 2006 09:31:33 -0400
In-Reply-To: <200608260038.13662.thomas.koeller@baslerweb.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org

Hello.

Thomas Koeller wrote:

>>If you have an another standard 8250 port. this driver cannot support it
>>You should do as well as AU1X00.

> so far nobody commented on my recent mail, in which I explained why I
> think that the AU1X00 code in 8250.c is not entirely correct, so I assume
> nobody cares. I therefore modified my code to take the same approach,

    Not everybody have time to comment instantly. And the issue you've pointed
out is only theoretical at this point -- the "half-compatible" UARTs like
Alchemy's one are seen only in the SOCs so far...

> although I still have my doubts about it. Here's the updated patch:

    Now, to the patch itself...

> Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
> ---
> 832ac1406f2530b7971cb0d23d3ede20a6057fa1
>  drivers/serial/8250.c       |   86 ++++++++++++++++++++++++++++++++++---------
>  drivers/serial/Kconfig      |    9 +++++
>  include/linux/serial_core.h |    3 +-
>  3 files changed, 78 insertions(+), 20 deletions(-)

> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index 0ae9ced..afe0e1f 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -251,9 +251,16 @@ static const struct serial8250_config ua
>  		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
>  		.flags		= UART_CAP_FIFO | UART_CAP_UUE,
>  	},
> +	[PORT_RM9000] = {
> +		.name		= "RM9000",
> +		.fifo_size	= 16,
> +		.tx_loadsz	= 16,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
> +		.flags		= UART_CAP_FIFO,
> +	},
>  };

    What was the point of introducing the separate port type if its settings
are the same as for PORT_16550A?

> -#ifdef CONFIG_SERIAL_8250_AU1X00
> +#if defined (CONFIG_SERIAL_8250_AU1X00)
>  
>  /* Au1x00 UART hardware has a weird register layout */
>  static const u8 au_io_in_map[] = {
> @@ -289,6 +296,36 @@ static inline int map_8250_out_reg(struc
>  	return au_io_out_map[offset];
>  }
>  
> +#elif defined (CONFIG_SERIAL_8250_RM9K)
> +
> +static const u8
> +	regmap_in[8] = {
> +		[UART_RX]	= 0x00,
> +		[UART_IER]	= 0x0c,
> +		[UART_IIR]	= 0x14,
> +		[UART_LCR]	= 0x1c,
> +		[UART_MCR]	= 0x20,
> +		[UART_LSR]	= 0x24,
> +		[UART_MSR]	= 0x28,
> +		[UART_SCR]	= 0x2c
> +	},
> +	regmap_out[8] = {
> +		[UART_TX] 	= 0x04,
> +		[UART_IER]	= 0x0c,
> +		[UART_FCR]	= 0x18,
> +		[UART_LCR]	= 0x1c,
> +		[UART_MCR]	= 0x20,
> +		[UART_LSR]	= 0x24,
> +		[UART_MSR]	= 0x28,
> +		[UART_SCR]	= 0x2c
> +	};

    I guess you're using regshift == 0?

> +
> +#define map_8250_in_reg(up, offset) \
> +	(((up)->port.type == PORT_RM9000) ? regmap_in[offset] : (offset))
> +#define map_8250_out_reg(up, offset) \
> +	(((up)->port.type == PORT_RM9000) ? regmap_out[offset] : (offset))
> +
> +

    Why you're not using specific iotype for RM9000 UARTs?

>  #else
> @@ -374,21 +411,21 @@ #define serial_inp(up, offset)		serial_i
>  #define serial_outp(up, offset, value)	serial_out(up, offset, value)
>  
>  /* Uart divisor latch read */
> -static inline int _serial_dl_read(struct uart_8250_port *up)
> +static inline unsigned int _serial_dl_read(struct uart_8250_port *up)
>  {
>  	return serial_inp(up, UART_DLL) | serial_inp(up, UART_DLM) << 8;
>  }
>  
>  /* Uart divisor latch write */
> -static inline void _serial_dl_write(struct uart_8250_port *up, int value)
> +static inline void _serial_dl_write(struct uart_8250_port *up, unsigned int value)
>  {
>  	serial_outp(up, UART_DLL, value & 0xff);
>  	serial_outp(up, UART_DLM, value >> 8 & 0xff);
>  }
>  
> -#ifdef CONFIG_SERIAL_8250_AU1X00
> +#if defined (CONFIG_SERIAL_8250_AU1X00)
>  /* Au1x00 haven't got a standard divisor latch */
> -static int serial_dl_read(struct uart_8250_port *up)
> +static unsigned int serial_dl_read(struct uart_8250_port *up)
>  {
>  	if (up->port.iotype == UPIO_AU)
>  		return __raw_readl(up->port.membase + 0x28);
> @@ -396,13 +433,26 @@ static int serial_dl_read(struct uart_82
>  		return _serial_dl_read(up);
>  }
>  
> -static void serial_dl_write(struct uart_8250_port *up, int value)
> +static void serial_dl_write(struct uart_8250_port *up, unsigned int value)
>  {
>  	if (up->port.iotype == UPIO_AU)
>  		__raw_writel(value, up->port.membase + 0x28);
>  	else
>  		_serial_dl_write(up, value);
>  }
> +#elif defined (CONFIG_SERIAL_8250_RM9K)
> +static inline unsigned int serial_dl_read(struct uart_8250_port *up)
> +{
> +	return
> +		((readl(up->port.membase + 0x10) << 8) |
> +		(readl(up->port.membase + 0x08) & 0xff)) & 0xffff;
> +}
> +
> +static inline void serial_dl_write(struct uart_8250_port *up, unsigned int value)
> +{
> +	writel(value, up->port.membase + 0x08);
> +	writel(value >> 8, up->port.membase + 0x10);
> +}

    And why this doesn't check for up->port.type == PORT_RM9000 first? This
way it won't work with any compatible UARTs anymore. This is wrong.

> @@ -576,22 +626,17 @@ static int size_fifo(struct uart_8250_po
>   */
>  static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
>  {
> -	unsigned char old_dll, old_dlm, old_lcr;
> -	unsigned int id;
> +	unsigned char old_lcr;
> +	unsigned int id, old_dl;
>  
>  	old_lcr = serial_inp(p, UART_LCR);
>  	serial_outp(p, UART_LCR, UART_LCR_DLAB);
> +	old_dl = _serial_dl_read(p);
>  
> -	old_dll = serial_inp(p, UART_DLL);
> -	old_dlm = serial_inp(p, UART_DLM);
> -
> -	serial_outp(p, UART_DLL, 0);
> -	serial_outp(p, UART_DLM, 0);
> -
> -	id = serial_inp(p, UART_DLL) | serial_inp(p, UART_DLM) << 8;
> +	serial_dl_write(p, 0);
> +	id = serial_dl_read(p);
>  
> -	serial_outp(p, UART_DLL, old_dll);
> -	serial_outp(p, UART_DLM, old_dlm);
> +	serial_dl_write(p, old_dl);
>  	serial_outp(p, UART_LCR, old_lcr);
>  
>  	return id;

    Not sure the autoconfig code was intended for half-compatible UARTs. Note 
that it sets up->port.type as its result. However, your change seems correct, 
it just have nothing to do with RM9000.

    As a side note, I think that the code that sets DLAB before and resets it
after the divisor latch read/write should be part of serial_dl_read() and
serial_dl_write() actually. In the Alchemy UARTs this bit is reserved.

> @@ -1138,8 +1183,11 @@ static void serial8250_start_tx(struct u
>  		if (up->bugs & UART_BUG_TXEN) {
>  			unsigned char lsr, iir;
>  			lsr = serial_in(up, UART_LSR);
> -			iir = serial_in(up, UART_IIR);
> -			if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT)
> +			iir = serial_in(up, UART_IIR) & 0x0f;
> +			if ((up->port.type == PORT_RM9000) ?
> +			   	(lsr & UART_LSR_THRE &&
> +				(iir == UART_IIR_NO_INT || iir == UART_IIR_THRI)) :
> +				(lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT))
>  				transmit_chars(up);
>  		}
>  	}

    It would be good to clarify why this is needed...

WBR, Sergei
