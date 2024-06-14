Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF21836DE;
	Fri, 14 Jun 2024 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353713; cv=none; b=RD+EhWUoj5pDu0vZng+JPruKf8HSno/KYH9nBNrBHo6fsjhXQWm6sSuNfPPvF0ckdmI8MXboEaYzme28BnHOqrfy6Gwdf9j+MHqT3RuHCqdiZESCizE26GsIbTioOr41o9q556ZEcObgbiI2MSbCAa/BpZTHQ3uYaqnFMxXUuOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353713; c=relaxed/simple;
	bh=3Wg/Po2Loo+reS1EmZmVGQq87fLm9QQsUXRnohnMAbo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZXS2K92ynMYmiey/nENXOAQ7i0z9+AkX698sEdqEfSWkcZpzg2b0y1YiuzFMDU0fWZIaQDj9lKAkOpH/8iHvndQzRyjTlqcGBS4BOOugYaxpUTm6JjBVnAU79+w0yEW5vzP04zG/TQup9QM4CpGwQw6rEWcj8Af1UsOldUdk1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlXE9xfI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlXE9xfI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718353712; x=1749889712;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3Wg/Po2Loo+reS1EmZmVGQq87fLm9QQsUXRnohnMAbo=;
  b=jlXE9xfIFYXggu501qbNu34pWBW9nmrLB12eHOLmLu6iE6Ao7Den987P
   uCKpNqnR0w+CI6EJKW+USZ7zgv70dXULhRDZ52sFLskhVKz77WVRYJNxE
   T+UYRYEhYkQXJIeNMATmIrFCiqNTwy/C8HV/l5pP8deUUgYzSoU2ZBNho
   J4aBst3ZTjfYHCL6eZ9MF3wwzxrQr0ZADnDw0fBrOnrDIy2qWR0bR9ELt
   pXZS41NMdZ9Fepl4AzD8ApLVg8cKJglaJc98NpkQRNapvEHomcrIIOvfa
   fWOPagzgjwBK1V3JDUuDk7dY6F5l+rVZdhkRXPa5L4T6oISLvERxKxYus
   g==;
X-CSE-ConnectionGUID: J+2u2QbuS1SxhHTH0nmkRg==
X-CSE-MsgGUID: 6750PwdgReOa7FkhwacaxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15389740"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15389740"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:28:31 -0700
X-CSE-ConnectionGUID: lKJeMOyDStGEerfMw5hvrQ==
X-CSE-MsgGUID: jcZo1bZjRxak9W8kutW/DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40398062"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:28:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Jun 2024 11:28:23 +0300 (EEST)
To: Udit Kumar <u-kumar1@ti.com>
cc: vigneshr@ti.com, nm@ti.com, Tony Lindgren <tony@atomide.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, u.kleine-koenig@pengutronix.de, 
    ronald.wahl@raritan.com, thomas.richard@bootlin.com, tglx@linutronix.de, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_omap: Implementation of Errata i2310
In-Reply-To: <20240614061314.290840-1-u-kumar1@ti.com>
Message-ID: <9ed7e96a-c538-aac1-5b52-b7b1d72bb6a0@linux.intel.com>
References: <20240614061314.290840-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 14 Jun 2024, Udit Kumar wrote:

> As per Errata i2310[0], Erroneous timeout can be triggered,
> if this Erroneous interrupt is not cleared then it may leads
> to strom of interrupts, therefore apply Errata i2310 solution.
> 
> [0] https://www.ti.com/lit/pdf/sprz536 page 23
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 170639d12b2a..38eb639f78d3 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -115,6 +115,10 @@
>  /* RX FIFO occupancy indicator */
>  #define UART_OMAP_RX_LVL		0x19
>  
> +/* Timeout Low and High */
> +#define UART_OMAP_TO_L                 0x26
> +#define UART_OMAP_TO_H                 0x27
> +
>  /*
>   * Copy of the genpd flags for the console.
>   * Only used if console suspend is disabled
> @@ -663,13 +667,24 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
>  
>  	/*
>  	 * On K3 SoCs, it is observed that RX TIMEOUT is signalled after
> -	 * FIFO has been drained, in which case a dummy read of RX FIFO
> -	 * is required to clear RX TIMEOUT condition.
> +	 * FIFO has been drained or erroneously.
> +	 * So apply solution of Errata i2310 as mentioned in
> +	 * https://www.ti.com/lit/pdf/sprz536
>  	 */
>  	if (priv->habit & UART_RX_TIMEOUT_QUIRK &&
> -	    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
> -	    serial_port_in(port, UART_OMAP_RX_LVL) == 0) {
> -		serial_port_in(port, UART_RX);
> +		(iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT) {
> +		unsigned char efr2, timeout_h, timeout_l;
> +
> +		efr2 = serial_in(up, UART_OMAP_EFR2);
> +		timeout_h = serial_in(up, UART_OMAP_TO_H);
> +		timeout_l = serial_in(up, UART_OMAP_TO_L);
> +		serial_out(up, UART_OMAP_TO_H, 0xFF);
> +		serial_out(up, UART_OMAP_TO_L, 0xFF);
> +		serial_out(up, UART_OMAP_EFR2, 0x1);

Eh, this doesn't match the workaround in the errata???

Also, don't use literals but name the bits with defines (for the correct 
bit there's probably a pre-existing define but it's not named as good as 
it could be, I'd say it should be named as 
UART_OMAP_EFR2_TIMEOUT_PERIODIC).

> +		serial_in(up, UART_IIR);
> +		serial_out(up, UART_OMAP_EFR2, efr2);
> +		serial_out(up, UART_OMAP_TO_H, timeout_h);
> +		serial_out(up, UART_OMAP_TO_L, timeout_l);

-- 
 i.

