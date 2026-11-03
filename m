Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706935;
	b=CC28+IukMc4CkckclqhrGpZ126GwoJCcR5UKZVk0Kvd1ZfW/lUW3MjWtrV90PIZ5n73E
	 9SbVp4zCjJnEcTOftDUuOhBxwiJVS7MUifu8oamwrPaEZKXPBOeN2rs+oG1Se1bo1Vkky
	 gN8h15ZwlkqZ2Y2yM7RVXFCcxijHhionltUK+Rb9VAChIcNnyoehACMMH9F7WvG1PJxvF
	 eI6TPfuRvCMVGVLaWuKf2WK4ma56koJDD7eR5phyUWOJSfERaYCTzXgPqgDw5jIXp1V8g
	 atiSL46UjExxjazIKH4T85PzMuONlkx/JKmWltD+v4MEZwzKSSCyboqGOA+noo8Nq2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706935;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=HCorhxQxJT3W15/Ol75aTGcFGkkBMt7oxlNw+Tltp1E=;
	b=S1p9anvZauYlBf84OoEBgpCApXFJnpFkvN91XmZ6FoLReKPS1mZLDc1W6dO9V3cpuoeH
	 4xhI1hwawdoXo8fbYHFMJY8Cyv22tphuNTdUOzvvzCYeoLF4sKXl9KAE3TT0lWApYrWgG
	 xbvSZK7kSdVReYStvsXonr247UM4z9RrXcMY94ZhAtBgzKMYZKimAMSqPps7N8hHbnkJX
	 bjklXEalGHVrPxvD2IcvrK/tYyOW9J8NBNJvWolXHiKNqXWYIyc0nv7WnMUyALl1wojcp
	 KYNecbnQWnn6oZMkw1TKt31cQRxZpSR1OPraQJTIPXrvwliOm5SibNTzLmZPDcQJkEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="T/zDPAgz";
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F288606A326;
	Tue,  3 Nov 2026 11:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F288606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T/zDPAgz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793706935; x=1825242935;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NRlGTsFdID6TOhr7uHXdva//9pjtlPak/4evBt26tjw=;
  b=T/zDPAgzuEFD59j2H+Sgu94i7H8U26fZpKFi/mkdTUOyCM8ppp+TE9Uk
   ggfFDmdQJmH49gQB6KyhdPLznJdP+QU7zXzuJpc940liIvJgbwsb3ny2T
   TxpxOTkUug8+kpvmxGMtkEB7LTlqfvnljcd+l7YQ72tDpU+STOpcyUT2b
   j4dupaAr/mSPsjCZJtkgdLgPGL8hpSgL6ZxOg7EY6/VPWORl4EfM55+lc
   ZMNVY72Tv2BFmqAHiUKLaL1QuH2NyP1A0mlibe5i6TEgenhysisX9+C7Q
   /V8pMLtCKHcaWoJb+5U9zZVF0QQiC2veL/uyOEppPfXvtdt/ipM/H5Yum
   g==;
X-CSE-ConnectionGUID: Xkis6m7sRJ6XuSJoYhUUMA==
X-CSE-MsgGUID: tNoHbzE6SHGIgCq55FPLEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2454751"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2454751"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:55:34 -0800
X-CSE-ConnectionGUID: UXG0LlmJSGON8WP14xs+zg==
X-CSE-MsgGUID: /usHt9haTsq5iys1QJ0A4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6265075"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:55:25 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Nov 2026 13:55:20 +0200 (EET)
To: James Hilliard <james.hilliard1@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Tony Lindgren <tony@atomide.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Richard Genoud <richard.genoud@bootlin.com>, 
    Nicolas Ferre <nicolas.ferre@microchip.com>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
    Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
    =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>, 
    Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, Timur Tabi <timur@kernel.org>, 
    Peter Ujfalusi <peter.ujfalusi@ti.com>, 
    Vignesh Raghavendra <vigneshr@ti.com>, 
    Patrice Chotard <patrice.chotard@foss.st.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 3/8] serial: 8250_omap: serialize RX DMA completion
 and flushing
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-3-9159caade148@gmail.com>
Message-ID: <a95c92c6-afe3-52e3-c320-6d7ccd357965@linux.intel.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-3-9159caade148@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 2 Nov 2026, James Hilliard wrote:

> Moving RX DMA locking out of __dma_rx_do_complete() left the DMA
> completion callback calling it without rx_dma_lock. Shutdown and runtime
> suspend flush RX under rx_dma_lock but without the port lock, allowing
> these paths to overlap the callback's buffer accounting and flip-buffer
> insertion. RX submission and UART interrupt handling also require the
> port lock.
> 
> Take rx_dma_lock inside the port lock in the completion callback. Hold
> the port lock around the shutdown and runtime-suspend flushes, matching
> the existing interrupt-path lock order. Assert both locks in the common
> completion helper and the port lock at the flush entry point.
> 
> Fixes: 789898416749 ("serial: 8250: 8250_omap: Move locking out from __dma_rx_do_complete()")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index b6f108d34854..322403cec2de 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -771,8 +771,10 @@ static void omap_8250_shutdown(struct uart_port *port)
>  	guard(serial8250_rpm)(up);
>  
>  	flush_work(&priv->qos_work);
> -	if (up->dma)
> +	if (up->dma) {
> +		guard(uart_port_lock_irq)(port);
>  		omap_8250_rx_dma_flush(up);
> +	}
>  
>  	serial_out(up, UART_OMAP_WER, 0);
>  	if (priv->habit & UART_HAS_EFR2)
> @@ -898,7 +900,7 @@ static int omap8250_rs485_config(struct uart_port *port,
>  #ifdef CONFIG_SERIAL_8250_DMA
>  static int omap_8250_rx_dma(struct uart_8250_port *p);
>  
> -/* Must be called while priv->rx_dma_lock is held */
> +/* Must be called with the port lock and priv->rx_dma_lock held. */

Nit, following kerneldoc's style, this would start with Context: (you 
don't need to make it full kerneldoc but it is useful to follow the kernel 
doc style where possible).

>  static void __dma_rx_do_complete(struct uart_8250_port *p)
>  {
>  	struct uart_8250_dma    *dma = p->dma;
> @@ -911,6 +913,9 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
>  	int			ret;
>  	u32			reg;
>  
> +	lockdep_assert_held_once(&p->port.lock);
> +	lockdep_assert_held_once(&priv->rx_dma_lock);
> +
>  	if (!dma->rx_running)
>  		goto out;
>  
> @@ -977,7 +982,8 @@ static void __dma_rx_complete(void *param)
>  	if (dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state) != DMA_COMPLETE)
>  		return;
>  
> -	__dma_rx_do_complete(p);
> +	scoped_guard(spinlock, &priv->rx_dma_lock)
> +		__dma_rx_do_complete(p);
>  	if (priv->throttled)
>  		return;
>  
> @@ -995,6 +1001,8 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
>  	unsigned long		flags;
>  	int ret;
>  
> +	lockdep_assert_held_once(&p->port.lock);
> +
>  	spin_lock_irqsave(&priv->rx_dma_lock, flags);
>  
>  	if (!dma->rx_running) {
> @@ -1811,8 +1819,10 @@ static int omap8250_runtime_suspend(struct device *dev)
>  		}
>  	}
>  
> -	if (up && up->dma && up->dma->rxchan)
> +	if (up && up->dma && up->dma->rxchan) {
> +		guard(uart_port_lock_irqsave)(&up->port);
>  		omap_8250_rx_dma_flush(up);
> +	}
>  
>  	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
>  	schedule_work(&priv->qos_work);
> 
> 

-- 
 i.

