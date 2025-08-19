Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14651CA84
	for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2025 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628269; cv=none; b=hFnymE3TwrWyc1TUdbr0Tv0f5m37RxycxaTvdNqY/XQRqS0fFzygwfxhtZjNszMyuK80lTH37Ma2a+UJQeEtebIeLuyqIXmqb0f7wjCRFAbopTZvWMwDOaJwWH5SKI1XDKBaXxPcKeK2Q7ETyKA9Qsra0rfALonGjHaf4wTXUNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628269; c=relaxed/simple;
	bh=cIfSibrkFnqQ0xN+qFQbn8M1j4/X0X9rdE4QRCq+mPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6azHvwQYMfeSHjh9wbDYN4ZSlBY6j+hi71zhCWMdfz9Bm7IggIa6kKNfsixwXFwLnMUyBWKuJd7JtiDFxYe7rKskWPpTwjtWhZrB8DV4VI1z/LGEJF6k5AsLor7iC8fUxZBH1c038+lXgZ1RkYNVOo6iiFaB3vvDpz0MpSeG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zBav0ENq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zBav0ENq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD8DC4CEF1;
	Tue, 19 Aug 2025 18:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755628269;
	bh=cIfSibrkFnqQ0xN+qFQbn8M1j4/X0X9rdE4QRCq+mPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zBav0ENqFkJvhR3Igx7eB4odbXW1O2dmYmepoPZ8Ps8CBEdSrWD01XEfUgAWtbgqr
	 rLLlGnYs3HNe5xLna83rPmWtgKIFjfnGLFDaO9ZnQ0vzwNMDaXGF3asF5h28/5vw++
	 6BIqe4eYNwyAU0rfFSnt+aZ0/UhYTWWKGqxsMOn4=
Date: Tue, 19 Aug 2025 20:31:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: adriana@arista.com
Cc: linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com, prasad@arista.com
Subject: Re: [PATCH] serial: 8250 dw: clear FIFO before writting LCR
Message-ID: <2025081951-error-fragment-2035@gregkh>
References: <20250819182322.3451959-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819182322.3451959-1-adriana@arista.com>

On Tue, Aug 19, 2025 at 11:23:22AM -0700, adriana@arista.com wrote:
> This patch is proposing a custom configuration for Synopsys DesignWare
> serial to be used by products with associated compatible string in the
> device tree.
> 
> The PORT_DWAPB config will be used instead of the default PORT_16550A
> which does not include the UART_FCR_CLEAR_RCVR and UART_FCR_CLEAR_XMIT
> bits for the FIFO configuration register. Having those flags is necessary
> to clear FIFO when the serial port is reconfigured with do_set_termios.
> 
> Additionally, inside the do_set_termios we use the LCR (Line Control
> Register) to enable DLAB bit in order to access DLL/DLM (Divisor Latch
> Low/High) registers for baud rate setting. These 2 registers are sharing
> the same address space with UART_TX/UART_RX and UART_IER. The sequence is:
> 
> (1) enable DLAB -> (2) set baud -> (3) disable DLAB -> (4) reset FCR
> 
> When there is a TX or RX flow on the serial while we attempt to set/clear
> DLAB, the LCR write will be ignored and we will get a IIR_BUSY interrupt
> afterwards which is cleared by only reading the USR (UART status register).
> 
> The sequence above can leave the serial in an unstable state in two cases:
> 
> - if UART is busy while (1), then LCR is still pointing to the normal set of
> registers, which means the code setting DLL/DLM is actually writing into TX or
> modifying interrupts in UART_IER which may end with either a garbage character
> on the console or with serial interrupts disabled.
> 
> - if UART is busy while (3), then LCR remains pointing to DLL/DLM instead of
> moving back to RX/TX. The first transfer on the serial will be stuck because
> the transmit/receive registers are not accessible unless the DLAB bit
> is cleared.
> 
> The changes in this patch include a specific serial_out function for this UART
> type similar to the one for Armada-38x devices in commit
> b7639b0b15ddd1a4686b0142e70dfb122eefc88f with some changes in the tx_wait_empty
> function to check the UART status by looking at the USR register and actively
> try to clear FIFO to reduce time before a LCR write since the characters will
> be lost otherwise after baud rate change.
> 
> The USR register may report that UART is busy even if TX/TX FIFO is already
> empty so we will loop until all USR[0] (UART busy status) is cleared and USR[1]
> TX FIFO is empty (RX FIFO bits should be 0 in this case).
> Keeping the same timeout of 20ms as measurements with the 9600 baud when
> the console was busy it took max 1.9ms to get the UART free state.
> 
> Signed-off-by: Adriana Nicolae <adriana@arista.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c   |   52 +++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c |    8 +++++
>  include/uapi/linux/serial_core.h    |    3 ++
>  3 files changed, 63 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index a53ba04d9770..985a2650f3f3 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -33,6 +33,9 @@
>  /* Offsets for the DesignWare specific registers */
>  #define DW_UART_USR	0x1f /* UART Status Register */
>  #define DW_UART_DMASA	0xa8 /* DMA Software Ack */
> +#define DW_UART_USR_BUSY 0x1 /* UART Busy status */
> +#define DW_UART_USR_TFNF 0x2 /* UART TX FIFO not full */
> +#define DW_UART_USR_TFE  0x4 /* UART TX FIFO empty */
>  
>  #define OCTEON_UART_USR	0x27 /* UART Status Register */
>  
> @@ -56,6 +59,10 @@
>  #define DW_UART_QUIRK_IS_DMA_FC		BIT(3)
>  #define DW_UART_QUIRK_APMC0D08		BIT(4)
>  #define DW_UART_QUIRK_CPR_VALUE		BIT(5)
> +#define DW_UART_QUIRK_APB		BIT(6)
> +
> +#define DW8250_REG( p, reg ) \
> +	((void __iomem *)(p->membase + ((reg) << p->regshift)))
>  
>  struct dw8250_platform_data {
>  	u8 usr_reg;
> @@ -220,6 +227,47 @@ static void dw8250_serial_out38x(struct uart_port *p, unsigned int offset, u32 v
>  	dw8250_serial_out(p, offset, value);
>  }
>  
> +/* Drain FIFO and wait for USR to be not busy and TX/RX FIFO empty */
> +static void dw8250_tx_wait_empty_apb(struct uart_port *p)
> +{
> +	unsigned int tries = 20000;
> +	unsigned int delay_threshold = tries - 1000;
> +	unsigned int usr;
> +
> +	while (tries--) {
> +		usr = readl(DW8250_REG(p, DW_UART_USR));
> +
> +		/* Check UART free and TX/RX FIFO empty */
> +		if ((usr & ~DW_UART_USR_TFNF) == DW_UART_USR_TFE)
> +			break;
> +
> +		/* FIFO is still not empty, try to clear it */
> +		if (tries < delay_threshold) {
> +			writel(UART_FCR_ENABLE_FIFO, DW8250_REG(p, UART_FCR));
> +			writel(UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
> +			UART_FCR_CLEAR_XMIT, DW8250_REG(p, UART_FCR));
> +			writel(0, DW8250_REG(p, UART_FCR));
> +			udelay (1);
> +		}
> +	}
> +}
> +
> +static void dw8250_serial_outapb(struct uart_port *p, int offset, int value)
> +{
> +       struct dw8250_data *d = to_dw8250_data(p->private_data);
> +
> +	if(offset == UART_LCR && !d->uart_16550_compatible)
> +		dw8250_tx_wait_empty_apb(p);
> +
> +	writel(value, DW8250_REG(p, offset));
> +
> +	if (offset == UART_LCR && !d->uart_16550_compatible) {
> +		/* Check FIFO is left enabled and LCR was written */
> +		writel(UART_FCR_ENABLE_FIFO, DW8250_REG(p, UART_FCR));
> +		dw8250_check_lcr(p, value);
> +	}
> +}
> +
>  static u32 dw8250_serial_in(struct uart_port *p, unsigned int offset)
>  {
>  	u32 value = readb(p->membase + (offset << p->regshift));
> @@ -520,6 +568,12 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>  		p->serial_in = dw8250_serial_in32;
>  		data->uart_16550_compatible = true;
>  	}
> +	if (quirks & DW_UART_QUIRK_DWAPB) {
> +		p->type = PORT_DWAPB;
> +		p->flags |= UPF_FIXED_TYPE;
> +		p->serial_out = dw8250_serial_outapb;
> +		data->skip_autocfg = true;
> +	}
>  }
>  
>  static void dw8250_reset_control_assert(void *data)
> @@ -755,6 +809,7 @@ static const struct dev_pm_ops dw8250_pm_ops = {
>  
>  static const struct dw8250_platform_data dw8250_dw_apb = {
>  	.usr_reg = DW_UART_USR,
> +	.quirks = DW_UART_QUIRK_APB,
>  };
>  
>  static const struct dw8250_platform_data dw8250_octeon_3860_data = {
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 2da9db960d09..3882a71920f6 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -310,6 +310,14 @@ static const struct serial8250_config uart_config[] = {
>  		.rxtrig_bytes	= {1, 8, 16, 30},
>  		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
>  	},
> +	[PORT_DWAPB] = {
> +		.name		= "Synopsys DesignWare",
> +		.fifo_size	= 16,
> +		.tx_loadsz	= 16,
> +		.fcr		= UART_FCR_ENABLE_FIFO |
> +				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
> +		.flags		= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_IRDA,
> +	},
>  };
>  
>  /* Uart divisor latch read */
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 9c007a106330..8386436b813f 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -231,6 +231,9 @@
>  /* Sunplus UART */
>  #define PORT_SUNPLUS	123
>  
> +/* Synopsys DesignWare */
> +#define PORT_DWAPB		124
> +
>  /* Generic type identifier for ports which type is not important to userspace. */
>  #define PORT_GENERIC	(-1)
>  
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
