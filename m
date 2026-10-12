Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B3348642E;
	Mon, 12 Oct 2026 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806888; cv=none; b=Eye9MEpTpZosrusvrMlptWIxtbOanehEj/6iR1HO+eq21CoGdmmfE80ujsFDR3uDwcuz3o2/zI8A12oz8FLUGzi6Vi0xdZq3i6Dw1kb4UGUqhGjzWTRED+kDBJHz1Ouqkga05N+vOBhhP6xsT8s8oHI9pqbyic29y845MucNyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806888; c=relaxed/simple;
	bh=Af2rJwTr5nFcIKoopPQ4GInJJDGqew2SccZzEbRgXiw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F7VOUxXfXkYleIAy4NAbHPcnl3g7EvhR3ntKyHmHq/7pQ8qnjXf66gpGN+l/5ds9quKGXQ0RmxcHbu3li9RquN/BsmGqQ03u4/Ose3eMBIUvTfqdVS9yVjjTG4uKvyeB9o/w9lApxVdravTmHx+5zRiQ/ra2FoXMxxoCTwZMjoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWM95jLd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWM95jLd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791806887; x=1823342887;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Af2rJwTr5nFcIKoopPQ4GInJJDGqew2SccZzEbRgXiw=;
  b=TWM95jLdCGv4d4+hCPyG3mFYq/qNpd8+KUpuEYwBChe649gBJMRglPiS
   d0+GQ/56t+mtFOP+tsfgKGRPLZzfxzbMw+Z5HsqnhqJDg0/1+SHLwRPoV
   Yl4iFDMEkSyHpVF0YYKgWaNaD2zc9gQGdJh6lUljU6cdRpmAM4QZZIES3
   ZKwCkYbZYN1T3iBc6fkX8L1Lnig+bz+M0CpJyWnRCSt4dYsTGPnILDM5j
   +O98+N/s8uOrdeYljZnViNw+VL7FQFhvQgitFnVN/3Y19yRgb2V8j91Pv
   34T890ksFZJnOPFiTm/epvRR4KBURd16dKCTM3yOoG+2ukE4ErurIdtji
   Q==;
X-CSE-ConnectionGUID: mxXOfxZBQ1efqLFbWlHznA==
X-CSE-MsgGUID: 6uzFdAltRYu7u3LUwYhS7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="398563"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="398563"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 05:08:06 -0700
X-CSE-ConnectionGUID: XZBPbvynT6CoXx7hsw0ChA==
X-CSE-MsgGUID: TcM/EikPRCGHo8GaHbyr5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="983754"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 05:08:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 Oct 2026 15:08:00 +0300 (EEST)
To: khaliforce <kforce@gmail.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_dw: retain programmed timing for BUSY
 waits
In-Reply-To: <1791785420.8010663.945898876521967.uart-busy-frame-time@gmail.com>
Message-ID: <3f9f7b12-0edd-1683-6f8b-f14802db832f@linux.intel.com>
References: <1791785420.8010663.945898876521967.uart-busy-frame-time@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 Oct 2026, khaliforce wrote:

> Baud changes update frame_time before the programmed divisor changes.

Why not fix this problem instead? It would seem wrong to have wrong value 
in ->frame_time.

--
 i.

> A switch to a faster baud rate therefore shortens the DesignWare BUSY
> wait.
> The wait can expire while a frame at the old baud rate remains active.
> 
> Use the programmed frame duration for FIFO and BUSY waits.
> Account for UART clock changes.
> 
> Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
> Signed-off-by: khaliforce <kforce@gmail.com>
> ---
> Compared the complete patch off/on on MangoPi MQ Pro UART0.
> Kept other port patches, kernel options and DTB identical.
> Tested BUSY changes from 9600, 1200 and 300 to 115200.
> All 11 paired changes fail without the patch and pass with it.
> Each trial returns 64 matching loopback bytes.
> 
>  drivers/tty/serial/8250/8250_dw.c    | 20 ++++++++++++++++++--
>  drivers/tty/serial/8250/8250_dwlib.c |  4 ++++
>  drivers/tty/serial/8250/8250_dwlib.h |  4 ++++
>  3 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 51d026f20825..03be503bcef0 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -17,6 +17,8 @@
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/lockdep.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> @@ -131,6 +133,9 @@ static int dw8250_idle_enter(struct uart_port *p)
>  	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  	unsigned int usr_reg = d->pdata ? d->pdata->usr_reg : DW_UART_USR;
>  	struct uart_8250_port *up = up_to_u8250p(p);
> +	unsigned int frame_time = d->data.frame_time ?: p->frame_time;
> +	unsigned int saved_frame_time = p->frame_time;
> +	u64 scaled_frame_time;
>  	int retries;
>  	u32 lsr;
>  
> @@ -139,6 +144,12 @@ static int dw8250_idle_enter(struct uart_port *p)
>  	if (d->uart_16550_compatible)
>  		return 0;
>  
> +	if (d->data.frame_time && d->data.frame_time_uartclk && p->uartclk) {
> +		scaled_frame_time = (u64)frame_time * d->data.frame_time_uartclk;
> +		scaled_frame_time = DIV_ROUND_UP_ULL(scaled_frame_time, p->uartclk);
> +		frame_time = min_t(u64, scaled_frame_time, U32_MAX);
> +	}
> +
>  	d->in_idle = 1;
>  
>  	/* Prevent triggering interrupt from RBR filling */
> @@ -156,8 +167,10 @@ static int dw8250_idle_enter(struct uart_port *p)
>  	 *
>  	 * FIXME: frame_time delay is too long with very low baudrates.
>  	 */
> +	p->frame_time = frame_time;
>  	serial8250_fifo_wait_for_lsr_thre(up, NULL, p->fifosize);
> -	ndelay(p->frame_time);
> +	p->frame_time = saved_frame_time;
> +	ndelay(frame_time);
>  
>  	serial_port_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
>  
> @@ -167,7 +180,7 @@ static int dw8250_idle_enter(struct uart_port *p)
>  		if (!(serial_port_in(p, usr_reg) & DW_UART_USR_BUSY))
>  			break;
>  		/* FIXME: frame_time delay is too long with very low baudrates. */
> -		ndelay(p->frame_time);
> +		ndelay(frame_time);
>  	} while (--retries);
>  
>  	lsr = serial_lsr_in(up);
> @@ -188,6 +201,7 @@ static int dw8250_idle_enter(struct uart_port *p)
>  static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
>  			       unsigned int quot, unsigned int quot_frac)
>  {
> +	struct dw8250_port_data *d = p->private_data;
>  	struct uart_8250_port *up = up_to_u8250p(p);
>  	int ret;
>  
> @@ -200,6 +214,8 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
>  		goto idle_failed;
>  
>  	serial_dl_write(up, quot);
> +	d->frame_time = p->frame_time;
> +	d->frame_time_uartclk = p->uartclk;
>  	serial_port_out(p, UART_LCR, up->lcr);
>  
>  idle_failed:
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
> index 8859e66d2d71..d74ff203f904 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.c
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -39,8 +39,12 @@ static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
>  static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
>  			       unsigned int quot, unsigned int quot_frac)
>  {
> +	struct dw8250_port_data *d = p->private_data;
> +
>  	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
>  	serial8250_do_set_divisor(p, baud, quot);
> +	d->frame_time = p->frame_time;
> +	d->frame_time_uartclk = p->uartclk;
>  }
>  
>  void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios,
> diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
> index 1fe52332e774..5472c13ca92e 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.h
> +++ b/drivers/tty/serial/8250/8250_dwlib.h
> @@ -88,6 +88,10 @@ struct dw8250_port_data {
>  	u32			cpr_value;
>  	u8			dlf_size;
>  
> +	/* Timing for the programmed divisor. */
> +	u32			frame_time;
> +	u32			frame_time_uartclk;
> +
>  	/* RS485 variables */
>  	bool			hw_rs485_support;
>  };
> 
