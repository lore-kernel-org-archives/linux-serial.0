From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Fri, 11 Aug 2006 23:39:25 +0400
Message-ID: <44DCDCED.7000404@ru.mvista.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56350 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S932338AbWHKTiU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Aug 2006 15:38:20 -0400
In-Reply-To: <200608102318.52143.thomas.koeller@baslerweb.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org

Hello.

Thomas Koeller wrote:

> This patch adds support for the integrated serial ports of the MIPS RM9122
> processor and its relatives. While the hardware manual claims the serial port
> hardware to be 16550 compatible, the differences are in fact rather large,
> the biggest of them being that all register accesses must be 32-bit wide.

    Nothing uncommon here, 8250 drivers supported 32-bit MMIO for years. The 
different register layout is a real problem.

> Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
> ---
>  drivers/serial/8250.c       |   14 +++++++++++--
>  drivers/serial/Kconfig      |    6 +++++
>  include/linux/serial_core.h |    3 ++-
>  include/linux/serial_reg.h  |   48 
> +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index 0ae9ced..b89de8b 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -251,6 +251,13 @@ static const struct serial8250_config ua
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
>  
>  #ifdef CONFIG_SERIAL_8250_AU1X00
> @@ -1138,8 +1145,11 @@ static void serial8250_start_tx(struct u
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
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 9799cce..6ae58ba 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -979,3 +979,9 @@ config SERIAL_NETX_CONSOLE
>  	  CPU you can make it the console by answering Y to this option.
>  
>  endmenu
> +
> +config SERIAL_RM9000
> +	bool "MIPS RM9000 integrated serial port support"
> +	help
> +	  Provide support for the integrated serial ports found on
> +	  MIPS RM912x processors.
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 86501a3..8a97caf 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -39,7 +39,8 @@ #define PORT_16850	12
>  #define PORT_RSA	13
>  #define PORT_NS16550A	14
>  #define PORT_XSCALE	15
> -#define PORT_MAX_8250	15	/* max port ID */
> +#define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
> +#define PORT_MAX_8250	16	/* max port ID */
>  
>  /*
>   * ARM specific type numbers.  These are not currently guaranteed
> diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
> index 3c8a6aa..c5c991a 100644
> --- a/include/linux/serial_reg.h
> +++ b/include/linux/serial_reg.h
> @@ -14,13 +14,24 @@
>  #ifndef _LINUX_SERIAL_REG_H
>  #define _LINUX_SERIAL_REG_H
>  
> +#include <linux/config.h>
> +
>  /*
>   * DLAB=0
>   */
> +#if defined(CONFIG_SERIAL_RM9000)
> +#define UART_RX		0x00	/* In:  Receive buffer*/
> +#define UART_TX		0x04	/* Out: Transmit buffer*/
> +#else
>  #define UART_RX		0	/* In:  Receive buffer */
>  #define UART_TX		0	/* Out: Transmit buffer */
> +#endif
>  
> +#if defined(CONFIG_SERIAL_RM9000)
> +#define UART_IER	0x0c	/* Out: Interrupt Enable Register */
> +#else
>  #define UART_IER	1	/* Out: Interrupt Enable Register */
> +#endif
>  #define UART_IER_MSI		0x08 /* Enable Modem status interrupt */
>  #define UART_IER_RLSI		0x04 /* Enable receiver line status interrupt */
>  #define UART_IER_THRI		0x02 /* Enable Transmitter holding register int. */
> @@ -30,7 +41,11 @@ #define UART_IER_RDI		0x01 /* Enable rec
>   */
>  #define UART_IERX_SLEEP		0x10 /* Enable sleep mode */
>  
> +#if defined(CONFIG_SERIAL_RM9000)
> +#define UART_IIR	0x14	/* In:  Interrupt ID Register */
> +#else
>  #define UART_IIR	2	/* In:  Interrupt ID Register */
> +#endif
>  #define UART_IIR_NO_INT		0x01 /* No interrupts pending */
>  #define UART_IIR_ID		0x06 /* Mask for the interrupt ID */
>  #define UART_IIR_MSI		0x00 /* Modem status interrupt */
> @@ -38,7 +53,11 @@ #define UART_IIR_THRI		0x02 /* Transmitt
>  #define UART_IIR_RDI		0x04 /* Receiver data interrupt */
>  #define UART_IIR_RLSI		0x06 /* Receiver line status interrupt */
>  
> +#if defined(CONFIG_SERIAL_RM9000)
> +#define UART_FCR	0x18	/* Out: FIFO Control Register */
> +#else
>  #define UART_FCR	2	/* Out: FIFO Control Register */
> +#endif
>  #define UART_FCR_ENABLE_FIFO	0x01 /* Enable the FIFO */
>  #define UART_FCR_CLEAR_RCVR	0x02 /* Clear the RCVR FIFO */
>  #define UART_FCR_CLEAR_XMIT	0x04 /* Clear the XMIT FIFO */
> @@ -81,7 +100,11 @@ #define UART_FCR6_T_TRIGGER_24  0x20 /* 
>  #define UART_FCR6_T_TRIGGER_30	0x30 /* Mask for transmit trigger set at 30 */
>  #define UART_FCR7_64BYTE	0x20 /* Go into 64 byte mode (TI16C750) */
>  
> +#if defined(CONFIG_SERIAL_RM9000)
> +#define UART_LCR	0x1c	/* Out: Line Control Register */
> +#else
>  #define UART_LCR	3	/* Out: Line Control Register */
> +#endif
>  /*
>   * Note: if the word length is 5 bits (UART_LCR_WLEN5), then setting 
>   * UART_LCR_STOP will select 1.5 stop bits, not 2 stop bits.
> @@ -97,7 +120,11 @@ #define UART_LCR_WLEN6		0x01 /* Wordleng
>  #define UART_LCR_WLEN7		0x02 /* Wordlength: 7 bits */
>  #define UART_LCR_WLEN8		0x03 /* Wordlength: 8 bits */
>  
> +#if defined(CONFIG_SERIAL_RM9000)
> +#define UART_MCR	0x20	/* Out: Modem Control Register */
> +#else
>  #define UART_MCR	4	/* Out: Modem Control Register */
> +#endif
>  #define UART_MCR_CLKSEL		0x80 /* Divide clock by 4 (TI16C752, EFR[4]=1) */
>  #define UART_MCR_TCRTLR		0x40 /* Access TCR/TLR (TI16C752, EFR[4]=1) */
>  #define UART_MCR_XONANY		0x20 /* Enable Xon Any (TI16C752, EFR[4]=1) */
> @@ -108,7 +135,11 @@ #define UART_MCR_OUT1		0x04 /* Out1 comp
>  #define UART_MCR_RTS		0x02 /* RTS complement */
>  #define UART_MCR_DTR		0x01 /* DTR complement */
>  
> +#if defined(CONFIG_SERIAL_RM9000)
> +#define UART_LSR	0x24	/* In:  Line Status Register */
> +#else
>  #define UART_LSR	5	/* In:  Line Status Register */
> +#endif
>  #define UART_LSR_TEMT		0x40 /* Transmitter empty */
>  #define UART_LSR_THRE		0x20 /* Transmit-hold-register empty */
>  #define UART_LSR_BI		0x10 /* Break interrupt indicator */
> @@ -117,7 +148,11 @@ #define UART_LSR_PE		0x04 /* Parity erro
>  #define UART_LSR_OE		0x02 /* Overrun error indicator */
>  #define UART_LSR_DR		0x01 /* Receiver data ready */
>  
> +#if defined(CONFIG_SERIAL_RM9000)
> +#define UART_MSR	0x28	/* In:  Modem Status Register */
> +#else
>  #define UART_MSR	6	/* In:  Modem Status Register */
> +#endif
>  #define UART_MSR_DCD		0x80 /* Data Carrier Detect */
>  #define UART_MSR_RI		0x40 /* Ring Indicator */
>  #define UART_MSR_DSR		0x20 /* Data Set Ready */
> @@ -128,18 +163,31 @@ #define UART_MSR_DDSR		0x02 /* Delta DSR
>  #define UART_MSR_DCTS		0x01 /* Delta CTS */
>  #define UART_MSR_ANY_DELTA	0x0F /* Any of the delta bits! */
>  
> +#if defined(CONFIG_SERIAL_RM9000)
> +#define UART_SCR	0x2c	/* I/O: Scratch Register */
> +#else
>  #define UART_SCR	7	/* I/O: Scratch Register */
> +#endif
>  
>  /*
>   * DLAB=1
>   */
> +#if defined(CONFIG_SERIAL_RM9000)
> +#define UART_DLL	0x08	/* Out: Divisor Latch Low */
> +#define UART_DLM	0x10	/* Out: Divisor Latch High */
> +#else
>  #define UART_DLL	0	/* Out: Divisor Latch Low */
>  #define UART_DLM	1	/* Out: Divisor Latch High */
> +#endif
>  
>  /*
>   * LCR=0xBF (or DLAB=1 for 16C660)
>   */
> +#if defined(CONFIG_SERIAL_RM9000)
> +#define UART_EFR	0xff	/* I/O: Extended Features Register */
> +#else
>  #define UART_EFR	2	/* I/O: Extended Features Register */
> +#endif
>  #define UART_EFR_CTS		0x80 /* CTS flow control */
>  #define UART_EFR_RTS		0x40 /* RTS flow control */
>  #define UART_EFR_SCD		0x20 /* Special character detect */

    I highly doubt this is how it should be done. Look at the Alchemy code as 
an example how the "partly-compatible" UART support should be written. Alchemy 
also has 32-bit MMIO and some registers mapped differently.

WBR, Sergei
