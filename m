Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9E1EB1A6;
	Tue, 18 Feb 2025 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864912; cv=none; b=V8+G5R1Wd7iKRYdOimA2D25qlCZVUyImwQYjtHnZMXOuVBvncEvxJizySf4QwlB0SaT21JfGTgYjmBapkM3oPwZlBsj9D5aoNlKjxR+TsWA3vmZ0Ua9Ua7rPBgD2AQcg26tNgYyjLOfIYvoEKQzjDK+1v1kwJpJeTZFo7H4SEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864912; c=relaxed/simple;
	bh=cHfAJgIoCgOtNEd/GF4Hm8IkxlgsMyvSUGdzZZTXZyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwHZ8+9I+pK3Xp6MaLM25CxwuJpp2eOt5RKhGWbbhYSxxeUt4X5NJu8kK/G6V6wGbf+MUGFxtGYFmjHJxWTjCrIxtmq7qftCPfN8woSLzcA2oV/7uoE1ind1J799gUKLwKeP7htgORCWbdXkKFdsIdQLx3YPzgme6tTDVGUpDNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lARXc0qC; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lARXc0qC"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5175E4441A;
	Tue, 18 Feb 2025 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739864907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMTDEK1y+pxUYj5R5auZ/e91gpoZMVBM46QtwX9nJ9E=;
	b=lARXc0qCpvrroQhnCTJ8OxG4O43O7gpj4+QCC7usIaFQbMycmawh08KhjMk/Ul9JFYiOb1
	pg4lVyqpEqDCK5rHbuRXlprC7udnYf5Sknc4wPYR6sERHLne9XwSr61VMQ6SZnZuiZGRh0
	x2v6WEIVpKGZvuUGHTy1qJYd1Q+1/bjck+nXcg7pHZFNjVb2mLPlUjj055u9sCPBFv/RXC
	beMEY1TOauuulEpCP77f9COm3DAgIoyxsbMr2064amztMlRKXRnjLo+s5vVr+SYJ6djvuB
	5hQwLRooXmRUWKa2G87TQ9HDkJiJb8bW4MYsN2kCuw+7lMnphjCgVC/K2PTXeQ==
Message-ID: <b963c2ea-ae5e-4928-997a-879f6415a638@bootlin.com>
Date: Tue, 18 Feb 2025 08:48:25 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] serial: mctrl_gpio: split disable_ms into sync and
 no_sync APIs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-doc@vger.kernel.org
References: <20250217-atomic_sleep_mctrl_serial_gpio-v3-1-59324b313eef@bootlin.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20250217-atomic_sleep_mctrl_serial_gpio-v3-1-59324b313eef@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfhojggtgfesthekredttddvjeenucfhrhhomheptfhitghhrghrugcuiffgpffqfgffuceorhhitghhrghrugdrghgvnhhouhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekjeetgeeggfefjeetfedtfeeukeetuedukeehheffvefhueejleejjeehgfeffeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemvgdtrgemudekudemledtugdtmegvtdejieemgegshegrmeefrgekjeemfeeiheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedukedumeeltdgutdemvgdtjeeimeegsgehrgemfegrkeejmeefieehhedphhgvlhhopeglkffrggeimedvrgdtudemvgdtrgemudekudemledtugdtmegvtdejieemgegshegrmeefrgekjeemfeeiheehngdpmhgrihhlfhhrohhmpehrihgthhgrrhgurdhgvghnohhuugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepghhrv
 ghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshdrfhgvrhhrvgesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheptghlrghuughiuhdrsggviihnvggrsehtuhigohhnrdguvghvpdhrtghpthhtohepshhhrgifnhhguhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrdhhrghuvghrsehpvghnghhuthhrohhnihigrdguvg
X-GND-Sasl: richard.genoud@bootlin.com

Le 17/02/2025 à 07:21, Alexis Lothoré a écrit :
> The following splat has been observed on a SAMA5D27 platform using
> atmel_serial:
> 
> BUG: sleeping function called from invalid context at kernel/irq/manage.c:738
> in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 27, name: kworker/u5:0
> preempt_count: 1, expected: 0
> INFO: lockdep is turned off.
> irq event stamp: 0
> hardirqs last  enabled at (0): [<00000000>] 0x0
> hardirqs last disabled at (0): [<c01588f0>] copy_process+0x1c4c/0x7bec
> softirqs last  enabled at (0): [<c0158944>] copy_process+0x1ca0/0x7bec
> softirqs last disabled at (0): [<00000000>] 0x0
> CPU: 0 UID: 0 PID: 27 Comm: kworker/u5:0 Not tainted 6.13.0-rc7+ #74
> Hardware name: Atmel SAMA5
> Workqueue: hci0 hci_power_on [bluetooth]
> Call trace:
>    unwind_backtrace from show_stack+0x18/0x1c
>    show_stack from dump_stack_lvl+0x44/0x70
>    dump_stack_lvl from __might_resched+0x38c/0x598
>    __might_resched from disable_irq+0x1c/0x48
>    disable_irq from mctrl_gpio_disable_ms+0x74/0xc0
>    mctrl_gpio_disable_ms from atmel_disable_ms.part.0+0x80/0x1f4
>    atmel_disable_ms.part.0 from atmel_set_termios+0x764/0x11e8
>    atmel_set_termios from uart_change_line_settings+0x15c/0x994
>    uart_change_line_settings from uart_set_termios+0x2b0/0x668
>    uart_set_termios from tty_set_termios+0x600/0x8ec
>    tty_set_termios from ttyport_set_flow_control+0x188/0x1e0
>    ttyport_set_flow_control from wilc_setup+0xd0/0x524 [hci_wilc]
>    wilc_setup [hci_wilc] from hci_dev_open_sync+0x330/0x203c [bluetooth]
>    hci_dev_open_sync [bluetooth] from hci_dev_do_open+0x40/0xb0 [bluetooth]
>    hci_dev_do_open [bluetooth] from hci_power_on+0x12c/0x664 [bluetooth]
>    hci_power_on [bluetooth] from process_one_work+0x998/0x1a38
>    process_one_work from worker_thread+0x6e0/0xfb4
>    worker_thread from kthread+0x3d4/0x484
>    kthread from ret_from_fork+0x14/0x28
> 
> This warning is emitted when trying to toggle, at the highest level,
> some flow control (with serdev_device_set_flow_control) in a device
> driver. At the lowest level, the atmel_serial driver is using
> serial_mctrl_gpio lib to enable/disable the corresponding IRQs
> accordingly.  The warning emitted by CONFIG_DEBUG_ATOMIC_SLEEP is due to
> disable_irq (called in mctrl_gpio_disable_ms) being possibly called in
> some atomic context (some tty drivers perform modem lines configuration
> in regions protected by port lock).
> 
> Split mctrl_gpio_disable_ms into two differents APIs, a non-blocking one
> and a blocking one. Replace mctrl_gpio_disable_ms calls with the
> relevant version depending on whether the call is protected by some port
> lock.
> 
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Acked-by: Richard Genoud <richard.genoud@bootlin.com>

> ---
> Changes in v3:
> - Fix commit message
> - Link to v2: https://lore.kernel.org/r/20250214-atomic_sleep_mctrl_serial_gpio-v2-1-1e60c732fd90@bootlin.com
> 
> Changes in v2:
> - create dedicated APIs instead of using custom flag
> - Link to v1: https://lore.kernel.org/r/20250213-atomic_sleep_mctrl_serial_gpio-v1-1-201ee6a148ad@bootlin.com
> ---
>   Documentation/driver-api/serial/driver.rst |  2 +-
>   drivers/tty/serial/8250/8250_port.c        |  2 +-
>   drivers/tty/serial/atmel_serial.c          |  2 +-
>   drivers/tty/serial/imx.c                   |  2 +-
>   drivers/tty/serial/serial_mctrl_gpio.c     | 34 ++++++++++++++++++++++++------
>   drivers/tty/serial/serial_mctrl_gpio.h     | 17 ++++++++++++---
>   drivers/tty/serial/sh-sci.c                |  2 +-
>   drivers/tty/serial/stm32-usart.c           |  2 +-
>   8 files changed, 47 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
> index 84b43061c11be2d6b4e3cd29fb8e6ecbdebe646d..60434f2b0286373d64b7aa8ae309454d7bd8859e 100644
> --- a/Documentation/driver-api/serial/driver.rst
> +++ b/Documentation/driver-api/serial/driver.rst
> @@ -103,4 +103,4 @@ Some helpers are provided in order to set/get modem control lines via GPIO.
>   .. kernel-doc:: drivers/tty/serial/serial_mctrl_gpio.c
>      :identifiers: mctrl_gpio_init mctrl_gpio_free mctrl_gpio_to_gpiod
>              mctrl_gpio_set mctrl_gpio_get mctrl_gpio_enable_ms
> -           mctrl_gpio_disable_ms
> +           mctrl_gpio_disable_ms_sync mctrl_gpio_disable_ms_no_sync
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index d7976a21cca9ce50557ca5f13bb01448ced0728b..218a1d98f1ed3e2697624444be33243050df3a85 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1680,7 +1680,7 @@ static void serial8250_disable_ms(struct uart_port *port)
>   	if (up->bugs & UART_BUG_NOMSR)
>   		return;
>   
> -	mctrl_gpio_disable_ms(up->gpios);
> +	mctrl_gpio_disable_ms_no_sync(up->gpios);
>   
>   	up->ier &= ~UART_IER_MSI;
>   	serial_port_out(port, UART_IER, up->ier);
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index f44f9d20a97440c9aea41e9ebe34c34d4dfa0a1c..8918fbd4bddd5dfe7705a75d4132dda59fe9e5e6 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -700,7 +700,7 @@ static void atmel_disable_ms(struct uart_port *port)
>   
>   	atmel_port->ms_irq_enabled = false;
>   
> -	mctrl_gpio_disable_ms(atmel_port->gpios);
> +	mctrl_gpio_disable_ms_no_sync(atmel_port->gpios);
>   
>   	if (!mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS))
>   		idr |= ATMEL_US_CTSIC;
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 9c59ec128bb4fc0ff54cb9a1a66eabbc9e391a9a..cfeb3f8cf45eaeea8afaa767a4ad849bb8d19f69 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1608,7 +1608,7 @@ static void imx_uart_shutdown(struct uart_port *port)
>   		imx_uart_dma_exit(sport);
>   	}
>   
> -	mctrl_gpio_disable_ms(sport->gpios);
> +	mctrl_gpio_disable_ms_sync(sport->gpios);
>   
>   	uart_port_lock_irqsave(&sport->port, &flags);
>   	ucr2 = imx_uart_readl(sport, UCR2);
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index 8855688a5b6c09f073349bd144586f54331d891f..ca55bcc0b61119d0b76e6943e0f223a4a9e25c02 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -322,11 +322,7 @@ void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
>   }
>   EXPORT_SYMBOL_GPL(mctrl_gpio_enable_ms);
>   
> -/**
> - * mctrl_gpio_disable_ms - disable irqs and handling of changes to the ms lines
> - * @gpios: gpios to disable
> - */
> -void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
> +static void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios, bool sync)
>   {
>   	enum mctrl_gpio_idx i;
>   
> @@ -342,10 +338,34 @@ void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
>   		if (!gpios->irq[i])
>   			continue;
>   
> -		disable_irq(gpios->irq[i]);
> +		if (sync)
> +			disable_irq(gpios->irq[i]);
> +		else
> +			disable_irq_nosync(gpios->irq[i]);
>   	}
>   }
> -EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);
> +
> +/**
> + * mctrl_gpio_disable_ms_sync - disable irqs and handling of changes to the ms
> + * lines, and wait for any pending IRQ to be processed
> + * @gpios: gpios to disable
> + */
> +void mctrl_gpio_disable_ms_sync(struct mctrl_gpios *gpios)
> +{
> +	mctrl_gpio_disable_ms(gpios, true);
> +}
> +EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms_sync);
> +
> +/**
> + * mctrl_gpio_disable_ms_no_sync - disable irqs and handling of changes to the
> + * ms lines, and return immediately
> + * @gpios: gpios to disable
> + */
> +void mctrl_gpio_disable_ms_no_sync(struct mctrl_gpios *gpios)
> +{
> +	mctrl_gpio_disable_ms(gpios, false);
> +}
> +EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms_no_sync);
>   
>   void mctrl_gpio_enable_irq_wake(struct mctrl_gpios *gpios)
>   {
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
> index fc76910fb105a3d560e824baa43e9515576e895a..79e97838ebe5672a1b00ef848dcda1e8c1b9568e 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.h
> +++ b/drivers/tty/serial/serial_mctrl_gpio.h
> @@ -87,9 +87,16 @@ void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios);
>   void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
>   
>   /*
> - * Disable gpio interrupts to report status line changes.
> + * Disable gpio interrupts to report status line changes, and block until
> + * any corresponding IRQ is processed
>    */
> -void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
> +void mctrl_gpio_disable_ms_sync(struct mctrl_gpios *gpios);
> +
> +/*
> + * Disable gpio interrupts to report status line changes, and return
> + * immediately
> + */
> +void mctrl_gpio_disable_ms_no_sync(struct mctrl_gpios *gpios);
>   
>   /*
>    * Enable gpio wakeup interrupts to enable wake up source.
> @@ -148,7 +155,11 @@ static inline void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
>   {
>   }
>   
> -static inline void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
> +static inline void mctrl_gpio_disable_ms_sync(struct mctrl_gpios *gpios)
> +{
> +}
> +
> +static inline void mctrl_gpio_disable_ms_no_sync(struct mctrl_gpios *gpios)
>   {
>   }
>   
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index b1ea48f38248eb42d98353daa289bbe67191d201..41f987632bce82c9d041d9ab1f5162d2af1a78e4 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2298,7 +2298,7 @@ static void sci_shutdown(struct uart_port *port)
>   	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
>   
>   	s->autorts = false;
> -	mctrl_gpio_disable_ms(to_sci_port(port)->gpios);
> +	mctrl_gpio_disable_ms_sync(to_sci_port(port)->gpios);
>   
>   	uart_port_lock_irqsave(port, &flags);
>   	sci_stop_rx(port);
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index 1ec5d8c3aef8ddbca615a149c2fe81c90c83a22b..4c97965ec43b30113a255661e6a64a6b476d7a9c 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -944,7 +944,7 @@ static void stm32_usart_enable_ms(struct uart_port *port)
>   
>   static void stm32_usart_disable_ms(struct uart_port *port)
>   {
> -	mctrl_gpio_disable_ms(to_stm32_port(port)->gpios);
> +	mctrl_gpio_disable_ms_sync(to_stm32_port(port)->gpios);
>   }
>   
>   /* Transmit stop */
> 
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250213-atomic_sleep_mctrl_serial_gpio-885f6feb585b
> 
> Best regards,

Thanks !


