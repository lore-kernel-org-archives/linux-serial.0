Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF52DE702
	for <linux-serial@vger.kernel.org>; Wed, 20 Aug 2025 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684183; cv=none; b=gIvV5oSA2kGqKzVgj6Uvxm7ScfoMbmbV/QPi6hUwqvNW3BqWNMIY47sEc+aJIK5lq+SYyChMpyUl5GrAxG2e/XDsouGTXjX6ehBONFqnu/vRXdBRLBcWb3WX+IeYifOpJBAYokhxPZB1TB0nwPUh4d86xOzotoGSM+sZdeg959w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684183; c=relaxed/simple;
	bh=X4S/NLb0dtyHxfB5lpSvZLFhU8IwHkes9DVJ9oTiPWY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KzMrzmTaalT0G2KMMprv26o/vzYegckvGmllwOs3wcVhO3imJPPsBP0haE9sNc+mExIT4OJrQbWOG4knzZAEsMJmo7lHySI48mK8m2a8VYu8BD1iHKp3Bc5HD/oCyGh9O8LztjLTlVws1Iy+HDtxx401VeJW0EDc8idNOQd/oGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B24QncLI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B24QncLI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755684178; x=1787220178;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=X4S/NLb0dtyHxfB5lpSvZLFhU8IwHkes9DVJ9oTiPWY=;
  b=B24QncLIJ2xeJQgxN4i3SWP/CYf/P4OlWD/8HjtlrQJQ63CQryihXSOm
   MDBKxixNoA92if8+RQ3S87n3kGeYrePxEyaqLbixo/yM2tFNOnUIHNrBN
   a7XLtrGsp6OY4pPchkfQa9vU1ogTAGsnE4w5Nfw9ru/IPAM87kE7vDfSQ
   qgvDL0m2aAI6v42eAXk77jnKP0p99nK+FJnmSSy49+nY9aZSOka04qhqP
   kWdyoOUWd4pMMan8kckM7tPEEG//Nb5TIWOxA0FfZJ+sQZnCMtqJlmgZ6
   RK5HBm6CN6ielJsgzV/56W5hgc4tz/p75dWiUjH6D8HfSmes0uoJkilEu
   A==;
X-CSE-ConnectionGUID: K4qC2T/NTH2mRaPP0G1pqg==
X-CSE-MsgGUID: znuaNhy/SRyvxl4m6n102Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58094930"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="58094930"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 03:02:56 -0700
X-CSE-ConnectionGUID: cyWAGAcrQYWpKgb3hU2ZbQ==
X-CSE-MsgGUID: 99ACPwUhRC22A3b6kZHocQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="205246558"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.83])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 03:02:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 20 Aug 2025 13:02:50 +0300 (EEST)
To: Adriana Nicolae <adriana@arista.com>
cc: linux-serial <linux-serial@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, prasad@arista.com
Subject: Re: [PATCH] serial: 8250 dw: clear FIFO before writting LCR
In-Reply-To: <20250819182322.3451959-1-adriana@arista.com>
Message-ID: <945af1e4-1d43-bd4b-6b07-733c06d18b17@linux.intel.com>
References: <20250819182322.3451959-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 19 Aug 2025, adriana@arista.com wrote:

> This patch is proposing a custom configuration for Synopsys DesignWare

Please try to avoid starting sentences in the changelog with "This patch" 
or other wordings with similar meaning. Write imperatively instead.

Preferrable, describe the problem first, then the solution.

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

What's wrong with dw8250_readl_ext() and dw8250_writel_ext()?

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

Please indent any continuation lines properly, in this case to the char 
after the opening parenthesis.

> +			writel(0, DW8250_REG(p, UART_FCR));
> +			udelay (1);
> +		}
> +	}

This seems to be just rehashing the same non-robust algorithm. There's no 
way to ensure UART wouldn't become BUSY again because of Rx at any time. 
Thus, any amount of clearing FIFOs is just never going be fully safe.

Long time ago, I attempted to create a more robust solution to this BUSY
problem by temporarily enabling loopback which should prevent any new Rx 
from reaching the UART.

Could you please try my patch that is attached to:

https://lore.kernel.org/linux-serial/079c8fe6-9ce4-fa59-4b44-93e27dd376d6@linux.intel.com/

(I haven't found a way to reproduce this myself and so far all the 
reporters of this problem have gone oddly quiet when asked to test this 
patch so it's hasn't moved forward for fea years.)

There are small Tx DMA related bits to add to the patch from robustness 
perspective (but a sane communication pattern shouldn't need those 
anyway, ie., no application should be sending something while trying to 
change these registers).

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

-- 
 i.

