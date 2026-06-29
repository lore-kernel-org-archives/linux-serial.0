Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA722771B;
	Mon, 29 Jun 2026 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748596; cv=none; b=CUJMKdMgsmnkB6mXDu5VswTh87G9+d01l/UIFPJHk39+Jx6T62qYUvXnC2JKyAAXbW5IO5gSD7Tp9zcqSOmHaEnNpl8AWgfIXkW61Ifv/MQzgWK7MN3WGq1pqrgO+BrY9gocoAlBdON693RKdVkkPeWSQSVNLMOYcZNF2oBH9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748596; c=relaxed/simple;
	bh=541JJueLdTk7tSRDhrQ1S+HU6wh/zGoV8BvwYyhb/WM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P0qfvLF8RkHVNAL8Ooq/zoEaFFS0hgP0Nz/kIeG1daCIJZfIGC7ODY2y/1dAESQsYssUv1PQGcUNsNa9CJfFufjCwiSk4hxgNETlMLvHzIo8bzAUp6H5g2giSgYn05eUMnSh2olaBAXFFjyp9CkdFImc6NslAjGT8+PI+hTDH/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPK9A4tH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPK9A4tH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782748595; x=1814284595;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=541JJueLdTk7tSRDhrQ1S+HU6wh/zGoV8BvwYyhb/WM=;
  b=FPK9A4tH8gLzjzedq9A3XWvn4yQrAGzl77LaTcmwmHDz+LsWrRqeEHq8
   DDoqUpdDCkpiXP0Wwq0Fowmju/zWKmSPstz1WiY0wS3VlTBox62fOCs84
   D6CO3ftJzxbUcZDVLq8+GA6LilfhagW4I4pmKaOEY5ppPmMV/KUrmxh2l
   rv0KlAY4F1Q+e85f6cv0eHMFDJOMlkmAyWjCuUsXJNd6ZqHqJNDJCZnAq
   vHXk/08dNiTZDY/Nu3HGmjs9hiYZKX11rSg+q5bC1Q0n+JojzOr+ELjyn
   XaScnryiLAj4lXVNDTpaaHtMe4y4YKp4MAKW4p+Ge0Dyek5MdE5y93Ps/
   g==;
X-CSE-ConnectionGUID: 5VSXikK6Ru2ZlJJBS/zALg==
X-CSE-MsgGUID: mcWzi8FtRTeI6GbtBp2Xog==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83493498"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83493498"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:56:34 -0700
X-CSE-ConnectionGUID: Ve/a75+rTWWXepwiyQePTA==
X-CSE-MsgGUID: rfYh0glARbGHntKPHvjsFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="275222730"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.42])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:56:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Jun 2026 18:56:28 +0300 (EEST)
To: Yicong Yang <yang.yicong@picoheart.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, geshijian@picoheart.com, 
    yangyang.8776@picoheart.com, yanligen@picoheart.com
Subject: Re: [PATCH] serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround
 if available
In-Reply-To: <20260629075510.32854-1-yang.yicong@picoheart.com>
Message-ID: <1ef5a875-2c01-5b4b-7d2b-07e6ea3db2b3@linux.intel.com>
References: <20260629075510.32854-1-yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Jun 2026, Yicong Yang wrote:

> The DW uart could get into the cases where a bogus RX timeout
> interrupt is asserted but no available data. This could be
> workaround by doing a bogus read.
> 
> Currently the driver's using the standard RBR (receive buffer
> register) for this bogus read. However the reading of RBR
> in this case is allowed to raise a hardware error if vendor
> choose to implement in this way (our platform). It's also
> allowed to do the bogus read using SRBR (shadow RBR) for
> workaround which won't raise the hardware error. So change
> to use the SRBR to workaround the issue if it's available.
> 
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c    | 15 +++++++++++++--
>  drivers/tty/serial/8250/8250_dwlib.c |  3 +++
>  drivers/tty/serial/8250/8250_dwlib.h |  4 ++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 84ffba045ffa..fea7dfa30e78 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -440,8 +440,19 @@ static int dw8250_handle_irq(struct uart_port *p)
>  	if (!up->dma && rx_timeout) {
>  		status = serial_lsr_in(up);
>  
> -		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> -			serial_port_in(p, UART_RX);
> +		if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
> +			/*
> +			 * Do the bogus read from Shadow RBR (SRBR) if provided.
> +			 * Both RBR and SRBR are supported ways to workaround

Hi,

I've not come across this being mentioned anywhere else than in kernel 
related context, but you seem to imply there something that tells about 
"supported ways"?

If there's no such thing, I'm bit hesitant to declare presence of SRBR 
guarantees reading it universally solves this issue.

BUT, I suppose it does on your HW since you must have hit this code path, 
and thus PSLVERR, yourself to actually discover this issue so I assume 
you've then also confirmed that this patch solves the issue in your case 
which isn't entirely without merit either.

> +			 * this problem. But read RBR can cause hardware error
> +			 * (PSLVERR) if hardware choose to implement in this way
> +			 * (implement REG_TIMEOUT_WIDTH to 0), whereas SRBR won't.
> +			 */
> +			if (d->data.shadow_support)
> +				serial_port_in(p, DW_UART_SRBR_0);
> +			else
> +				serial_port_in(p, UART_RX);

How about:
			serial_port_in(p, d->data.shadow_support ? DW_UART_SRBR_0
								 : UART_RX);

--
 i.

> +		}
>  	}
>  
>  	/* Manually stop the Rx DMA transfer when acting as flow controller */
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
> index 8859e66d2d71..19d997a59541 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.c
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -247,5 +247,8 @@ void dw8250_setup_port(struct uart_port *p)
>  
>  	if (reg & DW_UART_CPR_SIR_MODE)
>  		up->capabilities |= UART_CAP_IRDA;
> +
> +	if (reg & DW_UART_CPR_SHADOW)
> +		pd->shadow_support = true;
>  }
>  EXPORT_SYMBOL_GPL(dw8250_setup_port);
> diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
> index 1fe52332e774..3ad412d984ed 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.h
> +++ b/drivers/tty/serial/8250/8250_dwlib.h
> @@ -13,6 +13,7 @@
>  #include "8250.h"
>  
>  /* Offsets for the DesignWare specific registers */
> +#define DW_UART_SRBR_0	0x0c /* Shadow Receive Buffer Register */
>  #define DW_UART_USR	0x1f /* UART Status Register */

It seems USR and now SRBR_0 are without regshift whereas the reset of 
the register defines are with it.

Somewhat unrelated to this patch, I really hate this 
dw8250_readl/writel_ext() mess even more now... Why are those needed 
anyway, should the .serial_in/out callbacks handle those byte-order, etc. 
variations just fine?

Are those _ext calls only required for some early things during probe?
I guess 8250_lpss hasn't setup the callbacks yet before calling 
dw8250_setup_port() (I'm not even sure where it gets set with it after 
looking for it for a few minutes)?

-- 
 i.

>  #define DW_UART_DMASA	0xa8 /* DMA Software Ack */
>  #define DW_UART_TCR	0xac /* Transceiver Control Register (RS485) */
> @@ -90,6 +91,9 @@ struct dw8250_port_data {
>  
>  	/* RS485 variables */
>  	bool			hw_rs485_support;
> +
> +	/* Support Shadow registers */
> +	bool			shadow_support;
>  };
>  
>  void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
> 
