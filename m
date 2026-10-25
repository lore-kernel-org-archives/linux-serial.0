Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792905008;
	b=X/osK+COpKSlsMvUPejZITaAJTE2oOV3EAALdfitl4FhwWw9800rBf2Liyb1Pz+qocpe
	 W9nIeY1Ww8HrXnkBQ9YrSyvhxXPOSPemi5gVs00A0aWT3dTBrSqLBPVs66l2XwZhNtQFX
	 nxJ13uDjF3JV22vwEhh/h+Wbb8BgOEzDz2Abx5G8udQs3fUAQr7N/F6ZqCUJrwbVHBq9l
	 ZuhcJXOQMvn2wdnRDLZBn3owgSFWeNcOsGd4XCwZ5ax8bzOKJ5bEVzrM93zy52Xb/a5Eo
	 ch6V/u6hgy0isSetvrO81MDTOE//dZxRbP4q1i3Ro8wPFGj/Zp0n4soeebJZ+q6LCxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792905008;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=8e88usUcYauyf3azJlO/PIAv73piHOHPPh8TVgMWY7s=;
	b=pzPuvZmxgvlTwddU3u6OthAkS/+kYnaXIhlR6TS5r8q9w1fhK3+QVP6iUsKnKqdBR0yJ
	 cjXg+ByYYErSYU1IbO9npXWOKP6gbXI3bm4INvIS8AXqNht+Tz62MXY88sgSHwcnNunMR
	 vjpOG1MMNADOX/v7acILuDHKmAsWlnhPa969y/a0uXl9IbFujeZUtsWEWc0eY8Z0kIgCA
	 DkkVbTo5dIeqXGBp9Im/s182pZWCvGchn17CHkyG9ZioIxvpgeszGDBPYaWUU7xQrFvGC
	 RMe1Cgza8AUboWPqJJCIew4CaUBd7gCDLSjsH1/X0s0yLM/PFZAzBU1Y0ZlEfVrwNwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80536606A31B;
	Sun, 25 Oct 2026 05:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80536606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id EAB0892009C; Sun, 25 Oct 2026 06:10:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id DDFC292009B;
	Sun, 25 Oct 2026 05:10:03 +0000 (GMT)
Date: Sun, 25 Oct 2026 05:10:03 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: James Hilliard <james.hilliard1@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Tony Lindgren <tony@atomide.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Richard Genoud <richard.genoud@bootlin.com>, 
    Nicolas Ferre <nicolas.ferre@microchip.com>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
    Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
    =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
    Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
Message-ID: <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com> <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
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

On Sat, 24 Oct 2026, James Hilliard wrote:

> uart_write_wakeup() expects the UART port lock to be held. Several worker,
> DMA completion and interrupt paths call it without that lock, including
> indirect calls from uart_handle_cts_change() and the transmit helpers.

 Fair enough, and thank you for the cleanup and spotting the issue in the 
first place, however...

> diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
> index b4e1b90e5960..b15f76acd06b 100644
> --- a/drivers/tty/serial/sb1250-duart.c
> +++ b/drivers/tty/serial/sb1250-duart.c
> @@ -454,10 +454,12 @@ static irqreturn_t sbd_interrupt(int irq, void *dev_id)
>  
>  		if (intstat & M_DUART_ISR_RX)
>  			sbd_receive_chars(sport);
> -		if (intstat & M_DUART_ISR_IN)
> -			sbd_status_handle(sport);
> -		if (intstat & M_DUART_ISR_TX)
> -			sbd_transmit_chars(sport);
> +		scoped_guard(uart_port_lock_irqsave, uport) {
> +			if (intstat & M_DUART_ISR_IN)
> +				sbd_status_handle(sport);
> +			if (intstat & M_DUART_ISR_TX)
> +				sbd_transmit_chars(sport);
> +		}

... why do you think the whole functions need to be called with the lock 
held while they may or may not call the handlers in question even?  I 
think we should avoid excessive locking where possible to avoid holding 
execution elsewhere unnecessarily, shouldn't we?

  Maciej
