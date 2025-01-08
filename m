Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E0F185939;
	Wed,  8 Jan 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358645; cv=none; b=SvvPe56YxcX8SyGtT8Mfs61MeiasjUuD1g6FWKzLxeSkeftaGneP8BQgQNFwxsmJvTXHSgCWW7h83oBA9sqDKLgKnbF5zby5FohyMG1DC3E1FyKfF0uM7jOlfhV4H0UMaMrqJQDTNddCYQkMhYqnlJGuSb/e7r/Sy6q7TaxAtBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358645; c=relaxed/simple;
	bh=TBUTuwERXtmICMrHwSDUzL3N0toSZf+QlY/PGhBBBbA=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=dQAapHqcqbkMmyaqa1TsnP85ZP9YnNu4tHy6CK3n2EFPJlrBCBD+BLKntYkvN9FisxZxGfba44fyfOuxSz/1d03n0qcGOBECpyg5nNY6+lmFwbR8HmSEMAwTQa/AnqMkzSGUK5Tp0xG00v+90zdkQUMjZOmqxzcUPdgBiE3cLlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=AR9bG/tw; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="AR9bG/tw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=SxtzBLuuidIkuxwvxCWZOj9ToRGIb/PwrO6tLxteOGg=; b=AR9bG/twJt3de+DlUGX3sIy2ua
	YjkRhe5dMOVHWv3GeKsuEWWfZRVjTXheQOIzplPLbkdaeU0yJJGaNvXw+23BS5GOB0Ka0w5FoF2Zd
	MFHBmldUxYRdR9th9FQ2F0Ub7e3tTNY8Gx9x0nDi2X06EcJ9+fLSjhVJxL7lJUb5mxWo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:51086 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1tVZYI-0002lK-Lh; Wed, 08 Jan 2025 12:09:07 -0500
Date: Wed, 8 Jan 2025 12:09:06 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 hvilleneuve@dimonoff.com, andy@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 lech.perczak@camlingroup.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org
Message-Id: <20250108120906.92cda1fba339b072aceec039@hugovil.com>
In-Reply-To: <20250107142947.327508-2-andre.werner@systec-electronic.com>
References: <20250107142947.327508-1-andre.werner@systec-electronic.com>
	<20250107142947.327508-2-andre.werner@systec-electronic.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -2.9 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v3 2/2] serial: sc16is7xx: Add polling feature if no IRQ
 usage possible
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue,  7 Jan 2025 15:29:47 +0100
Andre Werner <andre.werner@systec-electronic.com> wrote:

Hi Andre,

> Fall back to polling mode if no interrupt is configured because not
> possible. If "interrupts" property is missing in devicetree the driver
> uses a delayed worker to pull state of interrupt status registers.

"not possible" is confusing. Maybe:

"Fall back to polling mode if interrupt pin is not connected
or available."

You also could change the commit title in a similar way (Add polling
feature if no IRQ pin is available).

I would also replace "feature" with "mode" for consistency with your
other comments below.

> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> ---
> V2:
> - Change warning for polling mode to debug log entry
> - Correct typo: Resuse -> Reuse
> - Format define with missing tabs for SC16IS7XX_POLL_PERIOD
> - Format struct declaration sc16is7xx_one_config with missing tabs for polling and shutdown
> - Adapt dtbinding with new polling feature
> V3:
> - Use suffix with units and drop a comment SC16IS7XX_POLL_PERIOD_MS. Sorry for that miss.
> - Make Kernel lowercase.
> ---
> ---
>  drivers/tty/serial/sc16is7xx.c | 40 ++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index a3093e09309f..57be5d55205a 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -314,6 +314,7 @@
>  #define SC16IS7XX_FIFO_SIZE		(64)
>  #define SC16IS7XX_GPIOS_PER_BANK	4
>  
> +#define SC16IS7XX_POLL_PERIOD_MS	10
>  #define SC16IS7XX_RECONF_MD		BIT(0)
>  #define SC16IS7XX_RECONF_IER		BIT(1)
>  #define SC16IS7XX_RECONF_RS485		BIT(2)
> @@ -348,6 +349,9 @@ struct sc16is7xx_port {
>  	u8				mctrl_mask;
>  	struct kthread_worker		kworker;
>  	struct task_struct		*kworker_task;
> +	struct kthread_delayed_work	poll_work;
> +	bool				polling;
> +	bool				shutdown;
>  	struct sc16is7xx_one		p[];
>  };
>  
> @@ -861,6 +865,19 @@ static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static void sc16is7xx_transmission_poll(struct kthread_work *work)

Maybe drop "transmission", as this is used for tx/rx?

And other kthread work functions use _proc suffix, so rename to follow
the same convention -> sc16is7xx_poll_proc()

They also use "wk" as argument name, so also rename it for consistency.

> +{
> +	struct sc16is7xx_port *s = container_of(work, struct sc16is7xx_port, poll_work.work);
> +
> +	/* Reuse standard IRQ handler. Interrupt ID is unused in this context. */
> +	sc16is7xx_irq(0, s);
> +
> +	/* Setup delay based on SC16IS7XX_POLL_PERIOD_MS */
> +	if (!s->shutdown)
> +		kthread_queue_delayed_work(&s->kworker, &s->poll_work,
> +					   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD_MS));
> +}
> +
>  static void sc16is7xx_tx_proc(struct kthread_work *ws)
>  {
>  	struct uart_port *port = &(to_sc16is7xx_one(ws, tx_work)->port);
> @@ -1149,6 +1166,7 @@ static int sc16is7xx_config_rs485(struct uart_port *port, struct ktermios *termi
>  static int sc16is7xx_startup(struct uart_port *port)
>  {
>  	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
> +	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
>  	unsigned int val;
>  	unsigned long flags;
>  
> @@ -1210,6 +1228,11 @@ static int sc16is7xx_startup(struct uart_port *port)
>  	uart_port_lock_irqsave(port, &flags);
>  	sc16is7xx_enable_ms(port);
>  	uart_port_unlock_irqrestore(port, flags);

Insert blank line

> +	if (s->polling) {
> +		s->shutdown = false;
> +		kthread_queue_delayed_work(&s->kworker, &s->poll_work,
> +					   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD_MS));
> +	}
>  
>  	return 0;
>  }
> @@ -1232,6 +1255,10 @@ static void sc16is7xx_shutdown(struct uart_port *port)
>  
>  	sc16is7xx_power(port, 0);
>  
> +	if (s->polling) {
> +		s->shutdown = true;

Can we avoid using this shutdown variable?

From what I see, kthread_cancel_delayed_work_sync()
itself will call kthread_cancel_work_sync(), and doc for it states that:

    "This function can be used even if the work re-queues itself"


> +		kthread_cancel_delayed_work_sync(&s->poll_work);
> +	}

Blank line

>  	kthread_flush_worker(&s->kworker);
>  }
>  
> @@ -1537,7 +1564,13 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  
>  	/* Always ask for fixed clock rate from a property. */
>  	device_property_read_u32(dev, "clock-frequency", &uartclk);

Blank line

> +	s->polling = !device_property_present(dev, "interrupts");
>  

Remove blank line

> +	if (s->polling) {
> +		dev_dbg(dev,
> +			"No interrupt definition found. Falling back to polling mode.\n");

Maybe: "No interrupt pin definition, falling back to polling mode\n"

(add pin and gets rid of trailing point)

> +		irq = 0;
> +	}

Blank line

>  	s->clk = devm_clk_get_optional(dev, NULL);
>  	if (IS_ERR(s->clk))
>  		return PTR_ERR(s->clk);
> @@ -1664,6 +1697,11 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  	if (ret)
>  		goto out_ports;
>  #endif

Blank line

> +	if (s->polling) {
> +		/* Initialize kernel thread for polling */
> +		kthread_init_delayed_work(&s->poll_work, sc16is7xx_transmission_poll);
> +		return 0;
> +	}
>  
>  	/*
>  	 * Setup interrupt. We first try to acquire the IRQ line as level IRQ.
> @@ -1724,6 +1762,8 @@ void sc16is7xx_remove(struct device *dev)
>  		sc16is7xx_power(&s->p[i].port, 0);
>  	}
>  
> +	if (s->polling)
> +		kthread_cancel_delayed_work_sync(&s->poll_work);

Blank line

>  	kthread_flush_worker(&s->kworker);
>  	kthread_stop(s->kworker_task);
>  
> -- 
> 2.47.1
> 
> 
> 


-- 
Hugo Villeneuve
