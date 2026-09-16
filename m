Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7E4DD6E6;
	Wed, 16 Sep 2026 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555986; cv=none; b=U8fFtHLKN5xtATnctef82kcL9LLybtHnos8UQo1Pa+H61ysHuF9FequqMh32YmaQIRRmfjeVEV1XiMfqG5X324VSQedy5uYmnU9/P10zNZ/KTsjimdUsc3Brr2yYINnoKJHBft6oUmr2V8MiiabzU9hexUew/ghrlfVfG62GVH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555986; c=relaxed/simple;
	bh=EN05muyPZl8y29HxwBtv8bidEfTX/3yJQ6HpTJ1E8DA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hALecJXlONrlCSZdwGeUj1dkXT4mVyu/AtH+4w5u40RnHJnFlRJRzW2eBS9Hgs1e710V3o+F3tF6mjiEoqTLYQ+OzuIlh34NRflgGzEmThHiL5WP2bgTGLKb+cLlxA3z5JT/uJmE35heJsSyrPuuH438eHtjdyOd8A0begtqxGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElUYzeNC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElUYzeNC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789555968; x=1821091968;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EN05muyPZl8y29HxwBtv8bidEfTX/3yJQ6HpTJ1E8DA=;
  b=ElUYzeNClCD+wucrustsmAAq5uRrOQ07B0q1/Lpv//384V+DtLuwefHZ
   +9ZUbGNoew94SrFWV/c2H3ys01bURoXuz2OIeRQdcKbmm+8RWNABrEWTx
   KCZwg5Dy/PIzLlw0BjJe0ZcZMTz2LZUSu4hE/RV9jWas5+23zZid7hDk7
   uh8pPVR5XmXz22knRaz/j477+SqK8hTfTF9yxGu4YiS+jC+BxhId148MB
   fUHMWR1iTxlOjmzfwpZhm04Usou3aVn7vZGRETHr/212pXX6si2rSdpFp
   onMW3StPv/EE0fyV8gnzJPDEp91jLeXpUfQ97eZagRHysqy1Xn0hcKGaq
   Q==;
X-CSE-ConnectionGUID: cxXpkaqLTcy4KmaTMNQaSw==
X-CSE-MsgGUID: wJfpAQkHTySwBg1RmOQusA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112697298"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="112697298"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 03:52:43 -0700
X-CSE-ConnectionGUID: E5PJOV+5Q6WHtApWQzFhXA==
X-CSE-MsgGUID: QapwwthKR8WlVtveO89Vsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273274106"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.187])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 03:52:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 16 Sep 2026 13:52:34 +0300 (EEST)
To: Moteen Shah <m-shah@ti.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, krzk+dt@kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
    devicetree@vger.kernel.org, u-kumar1@ti.com, gehariprasath@ti.com, 
    vigneshr@ti.com, nm@ti.com, a-limaye@ti.com, y-abhilashchandra@ti.com
Subject: Re: [PATCH v2 2/2] serial: 8250_dw: Add capability to skip empty
 FIFO read
In-Reply-To: <20260916085520.2259420-3-m-shah@ti.com>
Message-ID: <5fe0efdf-6d61-dba4-9703-269dfd68ae13@linux.intel.com>
References: <20260916085520.2259420-1-m-shah@ti.com> <20260916085520.2259420-3-m-shah@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 16 Sep 2026, Moteen Shah wrote:

> dw8250_handle_irq() does a bogus RX read on RX_TIMEOUT with no data
> present, to avoid an interrupt storm. The UART core also performs
> unconditional reads on the empty FIFO during startup and shutdown
> of the port. On the IP version used in TDA54, that interrupt storm
> no longer occurs, but reading an empty FIFO instead triggers a data
> abort.
> 
> Add a new capability to guard against the empty FIFO reads, avoiding
> the data aborts.
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>  drivers/tty/serial/8250/8250.h      |  1 +
>  drivers/tty/serial/8250/8250_dw.c   | 16 +++++++++++++++-
>  drivers/tty/serial/8250/8250_port.c | 12 +++++++++---
>  3 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 77fe0588fd6b..45e13c3a8c14 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -86,6 +86,7 @@ struct serial8250_config {
>  					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
>  					 */
>  #define UART_CAP_NOTEMT	BIT(18)	/* UART without interrupt on TEMT available */
> +#define UART_CAP_RXFIFO_EMPTY_READ	BIT(19) /* UART needs LSR_DR check before RX read (TDA54) */

IMO, this define naming contradicts with the comment because you 
effectively say "capable of reading Rx while receive buffer is empty", not 
that it needs DR check before issuing that read on buffer (~ named exactly 
opposite of the actual meaning it is being used in the code).

>  
>  #define UART_BUG_QUOT	BIT(0)	/* UART has buggy quot LSB */
>  #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 5fba913f3301..325b620172a7 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -28,6 +28,7 @@
>  
>  #include <linux/serial_8250.h>
>  #include <linux/serial_reg.h>
> +#include <linux/of.h>
>  
>  #include "8250_dwlib.h"
>  
> @@ -436,7 +437,7 @@ static int dw8250_handle_irq(struct uart_port *p)
>  	 * This problem has only been observed so far when not in DMA mode
>  	 * so we limit the workaround only to non-DMA mode.
>  	 */
> -	if (!up->dma && rx_timeout) {
> +	if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) && !up->dma && rx_timeout) {
>  		status = serial_lsr_in(up);
>  
>  		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> @@ -758,6 +759,14 @@ static int dw8250_probe(struct platform_device *pdev)
>  
>  	if (!data->skip_autocfg)
>  		dw8250_setup_port(p);
> +	/*
> +	 * On this IP, reading UART_RX while the FIFO is empty raises a data
> +	 * abort. serial8250_clear_interrupts() and serial8250_do_shutdown()
> +	 * in the 8250 core unconditionally read UART_RX, so guard those
> +	 * reads with an LSR_DR check.
> +	 */
> +	if (of_device_is_compatible(pdev->dev.of_node, "ti,tda54-uart"))
> +		up->capabilities |= UART_CAP_RXFIFO_EMPTY_READ;

Wouldn't it be better that the extra caps would come from .data?

>  	/* If we have a valid fifosize, try hooking up DMA */
>  	if (p->fifosize) {
> @@ -888,6 +897,10 @@ static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
>  	.quirks = DW_UART_QUIRK_CPR_VALUE,
>  };
>  
> +static const struct dw8250_platform_data dw8250_tda54_data = {
> +	.usr_reg = DW_UART_USR,
> +};
> +
>  static const struct of_device_id dw8250_of_match[] = {
>  	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
>  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
> @@ -895,6 +908,7 @@ static const struct of_device_id dw8250_of_match[] = {
>  	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
>  	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_skip_set_rate_data },
>  	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
> +	{ .compatible = "ti,tda54-uart", .data = &dw8250_tda54_data },
>  	{ .compatible = "ultrarisc,dp1000-uart", .data = &dw8250_ultrarisc_dp1000_data },
>  	{ /* Sentinel */ }
>  };
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index e94a0802cbdd..4435df88a1b1 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -704,8 +704,13 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
>  /* Clear the interrupt registers. */
>  static void serial8250_clear_interrupts(struct uart_port *port)
>  {
> -	serial_port_in(port, UART_LSR);
> -	serial_port_in(port, UART_RX);
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	unsigned int lsr;
> +
> +	lsr = serial_port_in(port, UART_LSR);
> +	if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) || (lsr & UART_LSR_DR))

Is the logic correct way around? Ah, it's actually naming issue with the 
define (see above).

> +		serial_port_in(port, UART_RX);
> +
>  	serial_port_in(port, UART_IIR);
>  	serial_port_in(port, UART_MSR);
>  }
> @@ -2421,7 +2426,8 @@ void serial8250_do_shutdown(struct uart_port *port)
>  	 * Read data port to reset things, and then unlink from
>  	 * the IRQ chain.
>  	 */
> -	serial_port_in(port, UART_RX);
> +	if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) || (serial_lsr_in(up) & UART_LSR_DR))
> +		serial_port_in(port, UART_RX);
>  	/*
>  	 * LCR writes on DW UART can trigger late (unmaskable) IRQs.
>  	 * Handle them before releasing the handler.
> 

-- 
 i.

