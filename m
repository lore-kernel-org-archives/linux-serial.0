Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0711AC147;
	Thu, 19 Dec 2024 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734598582; cv=none; b=t61lQGEPxzWsrw2qElQYx0GvbaNW6OAyeSY8s82nLErffKSZDvAWSHuWwV6MphVz5amq3vm/0j5gXa/kdhduwVzcmCjc5ktk2RU5HisXCxdgwAxrPP+UvVEeugQQ4xuNGyVkj79kYfxc3TV626w9+cfNwKWnqvuus4OX3305D8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734598582; c=relaxed/simple;
	bh=F3pUnxpKhsb62P2lfdmS7KpwGkJzfdGous/s5hnmpIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmuTAHSAU6bUo7RCOPLn1qnsr9lG/RqvOZ2gHW78vLhrW+fX1VpZzFv5md4ph9hDydg3mL/I63xVQEwu+FUEdD4UddVhXSrTxu9izPS2AoQsGZ9NNM1mCstxJSfuQbmDo01Cs8f6i1QtQDtVtXFZk4dLMXNyiD5epYjb5rRzM/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1inqtrgE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1inqtrgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B37BC4CECE;
	Thu, 19 Dec 2024 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734598580;
	bh=F3pUnxpKhsb62P2lfdmS7KpwGkJzfdGous/s5hnmpIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1inqtrgEafi9/w6YUItFYjkv9kRblD5Tj1SyCmO7BfyKp0gY5e8gOOK12J/RKtuj+
	 6W7cPYXn98w6XwYKAmdFi3YeRpuIa0rDIgBNe/rWm8EuyhTmo/zFdrh2bWKOoxrZ6b
	 cIDkCKQ4P+mAfpFN5+DSGEg8h34UJ1h6CWorepbQ=
Date: Thu, 19 Dec 2024 09:56:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com, andy@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com
Subject: Re: [PATCH] serial: sc16is7xx: Add polling feature if no IRQ usage
 possible
Message-ID: <2024121931-turbojet-preamble-b520@gregkh>
References: <20241219084638.960253-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219084638.960253-1-andre.werner@systec-electronic.com>

On Thu, Dec 19, 2024 at 09:46:38AM +0100, Andre Werner wrote:
> Fall back to polling mode if no interrupt is configured because not
> possible. If "interrupts" property is missing in devicetree the driver
> uses a delayed worker to pull state of interrupt status registers.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> ---
> This driver was tested on Linux 5.10. We had a custom board that was not
> able to connect the interrupt port. Only I2C was available.

Could you not test this on the latest tree?  5.10 is _VERY_ old now.

> ---
> ---
>  drivers/tty/serial/sc16is7xx.c | 40 ++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index a3093e09309f..31962fdca178 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -314,6 +314,7 @@
>  #define SC16IS7XX_FIFO_SIZE		(64)
>  #define SC16IS7XX_GPIOS_PER_BANK	4
>  
> +#define SC16IS7XX_POLL_PERIOD 10 /*ms*/

Please use a tab here.

>  #define SC16IS7XX_RECONF_MD		BIT(0)
>  #define SC16IS7XX_RECONF_IER		BIT(1)
>  #define SC16IS7XX_RECONF_RS485		BIT(2)
> @@ -348,6 +349,9 @@ struct sc16is7xx_port {
>  	u8				mctrl_mask;
>  	struct kthread_worker		kworker;
>  	struct task_struct		*kworker_task;
> +	struct kthread_delayed_work	poll_work;
> +	bool polling;
> +	bool shutdown;
>  	struct sc16is7xx_one		p[];
>  };
>  
> @@ -861,6 +865,19 @@ static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static void sc16is7xx_transmission_poll(struct kthread_work *work)
> +{
> +	struct sc16is7xx_port *s = container_of(work, struct sc16is7xx_port, poll_work.work);
> +
> +	/* Resuse standard IRQ handler. Interrupt ID is unused in this context. */
> +	sc16is7xx_irq(0, s);
> +
> +	/* setup delay based on SC16IS7XX_POLL_PERIOD */
> +	if (!s->shutdown)
> +		kthread_queue_delayed_work(&s->kworker, &s->poll_work,
> +					   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD));
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
> +	if (s->polling) {
> +		s->shutdown = false;
> +		kthread_queue_delayed_work(&s->kworker, &s->poll_work,
> +					   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD));
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
> +		kthread_cancel_delayed_work_sync(&s->poll_work);
> +	}
>  	kthread_flush_worker(&s->kworker);
>  }
>  
> @@ -1537,7 +1564,13 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  
>  	/* Always ask for fixed clock rate from a property. */
>  	device_property_read_u32(dev, "clock-frequency", &uartclk);
> +	s->polling = !device_property_present(dev, "interrupts");
>  
> +	if (s->polling) {
> +		dev_warn(dev,
> +			 "No interrupt definition found. Falling back to polling mode.\n");

What is a user supposed to do with this message?  And why would a device
NOT have any interrupts?  This feels like it is just going to pound on
the device and cause a lot of power drain for just a simple little uart.

Why can't your system provide a valid irq line?

thanks,

greg k-h
