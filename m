Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D45522BAC8;
	Mon, 13 Jan 2025 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780025; cv=none; b=CuiwLie/U7EwwzXpzKQvSIxUMbIqgI51Gie3IUW1nmqtQpgAmyYNThjWV3gQjmax2HsOdlduCAY0w3LZ6yG4RZQ+xiPII3qtCSVxYwB4baSHuR9d+oh7umAu4TlIUuaWOQPdQlT0Nvuvqp4x9sidNcJR1/OIAIFn+qGPAIEzX6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780025; c=relaxed/simple;
	bh=bqzH04A6cBKVCFaS4bRYc+LsF/h7ks2mUkV/inCw8hM=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=WWl2pcw0lz8DmBoloytejLmQio2yUtacUzWEMMA9Y67wJ24W7S+D1npeTSqvegqcniqzf7KlXGqnSXn9ux47nbLVDZMk97JXzbiuEdeeHJHNPKPKWHld/vY7AACTJzhlLoh/ZEwK457KONGkpDj4Kcdw2jLWbCRLtQRAPNXZwoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=N5X1yVZO; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="N5X1yVZO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=U11dyIvXIMO3dAD1yKnKPDScOmCAaiP0x5FqmbSwOHk=; b=N5X1yVZOgWHXAITtuskUc8Tcf1
	cdEoCHq8STkxjud5NReqxsy1pQkXCYt8Hw2UhjCCeK4IiR9A7p/IMuWSbOssPj5L00wa9C4lcIojU
	If5xl959lyjB9rPXV4+stnbg/1d+9C9r2jos1Am2cIFJ6QfHsRdJfbdoBM9aIDarh+BU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:37960 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1tXLoi-00073g-Na; Mon, 13 Jan 2025 09:53:25 -0500
Date: Mon, 13 Jan 2025 09:53:24 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andre Werner <andre.werner@systec-electronic.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jirislaby@kernel.org" <jirislaby@kernel.org>, "hvilleneuve@dimonoff.com"
 <hvilleneuve@dimonoff.com>, "andy@kernel.org" <andy@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "lech.perczak@camlingroup.com" <lech.perczak@camlingroup.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>
Message-Id: <20250113095324.560a091d90642528ae820aae@hugovil.com>
In-Reply-To: <CAHp75VdP7M4Jwjn095mwkr5Eh6mwvHXGthKxGwVkyYcpKnea+w@mail.gmail.com>
References: <20250110073104.1029633-1-andre.werner@systec-electronic.com>
	<20250110073104.1029633-2-andre.werner@systec-electronic.com>
	<CAHp75VdP7M4Jwjn095mwkr5Eh6mwvHXGthKxGwVkyYcpKnea+w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.5 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v5 2/2] serial: sc16is7xx: Add polling mode if no IRQ
 pin is available
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Fri, 10 Jan 2025 20:37:29 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> пʼятниця, 10 січня 2025 р. Andre Werner <andre.werner@systec-electronic.com>
> пише:
> 
> > Fall back to polling mode if no interrupt is configured because there
> > is no possibility to connect the interrupt pin.
> > If "interrupts" property is missing in devicetree the driver
> > uses a delayed worker to pull the state of interrupt status registers.
> >
> > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > ---
> > V2:
> > - Change warning for polling mode to debug log entry
> > - Correct typo: Resuse -> Reuse
> > - Format define with missing tabs for SC16IS7XX_POLL_PERIOD
> > - Format struct declaration sc16is7xx_one_config with missing tabs for
> > polling and shutdown
> > - Adapt dtbinding with new polling feature
> > V3:
> > - Use suffix with units and drop a comment SC16IS7XX_POLL_PERIOD_MS. Sorry
> > for that miss.
> > - Make Kernel lowercase.
> > V4:
> > - Reword commit messages for better understanding.
> > - Remove 'shutdown' property for canceling delayed worker.
> > - Rename worker function: sc16is7xx_transmission_poll ->
> > sc16is7xx_poll_proc
> > - Unify argument for worker functions: kthread_work *work -> kthread_work
> > *ws
> > V5:
> > - Replace of_property check with IRQ number check to set polling
> >   property. This will add support
> 
> 
> >
> It other way around, i.e. it won’t break the existing support of
> interrupt-driven non-DT setups.
> 
> 
> > for usage without device tree
> >   definitions. Thanks for that advice.
> > - Add blank line es requested.
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 37 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/
> > sc16is7xx.c
> > index a3093e09309f..7b51cdc274fd 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -314,6 +314,7 @@
> >  #define SC16IS7XX_FIFO_SIZE            (64)
> >  #define SC16IS7XX_GPIOS_PER_BANK       4
> >
> > +#define SC16IS7XX_POLL_PERIOD_MS       10
> >  #define SC16IS7XX_RECONF_MD            BIT(0)
> >  #define SC16IS7XX_RECONF_IER           BIT(1)
> >  #define SC16IS7XX_RECONF_RS485         BIT(2)
> > @@ -348,6 +349,8 @@ struct sc16is7xx_port {
> >         u8                              mctrl_mask;
> >         struct kthread_worker           kworker;
> >         struct task_struct              *kworker_task;
> > +       struct kthread_delayed_work     poll_work;
> > +       bool                            polling;
> >         struct sc16is7xx_one            p[];
> >  };
> >
> > @@ -861,6 +864,18 @@ static irqreturn_t sc16is7xx_irq(int irq, void
> > *dev_id)
> >         return IRQ_HANDLED;
> >  }
> >
> > +static void sc16is7xx_poll_proc(struct kthread_work *ws)
> > +{
> > +       struct sc16is7xx_port *s = container_of(ws, struct sc16is7xx_port,
> > poll_work.work);
> > +
> > +       /* Reuse standard IRQ handler. Interrupt ID is unused in this
> > context. */
> > +       sc16is7xx_irq(0, s);
> > +
> > +       /* Setup delay based on SC16IS7XX_POLL_PERIOD_MS */
> > +       kthread_queue_delayed_work(&s->kworker, &s->poll_work,
> > +                                  msecs_to_jiffies(SC16IS7XX_
> > POLL_PERIOD_MS));
> > +}
> > +
> >  static void sc16is7xx_tx_proc(struct kthread_work *ws)
> >  {
> >         struct uart_port *port = &(to_sc16is7xx_one(ws, tx_work)->port);
> > @@ -1149,6 +1164,7 @@ static int sc16is7xx_config_rs485(struct uart_port
> > *port, struct ktermios *termi
> >  static int sc16is7xx_startup(struct uart_port *port)
> >  {
> >         struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
> > +       struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
> >         unsigned int val;
> >         unsigned long flags;
> >
> > @@ -1211,6 +1227,10 @@ static int sc16is7xx_startup(struct uart_port *port)
> >         sc16is7xx_enable_ms(port);
> >         uart_port_unlock_irqrestore(port, flags);
> >
> > +       if (s->polling)
> > +               kthread_queue_delayed_work(&s->kworker, &s->poll_work,
> > +                                          msecs_to_jiffies(SC16IS7XX_
> > POLL_PERIOD_MS));
> > +
> >         return 0;
> >  }
> >
> > @@ -1232,6 +1252,9 @@ static void sc16is7xx_shutdown(struct uart_port
> > *port)
> >
> >         sc16is7xx_power(port, 0);
> >
> > +       if (s->polling)
> > +               kthread_cancel_delayed_work_sync(&s->poll_work);
> > +
> >         kthread_flush_worker(&s->kworker);
> >  }
> >
> > @@ -1538,6 +1561,11 @@ int sc16is7xx_probe(struct device *dev, const
> > struct sc16is7xx_devtype *devtype,
> >         /* Always ask for fixed clock rate from a property. */
> >         device_property_read_u32(dev, "clock-frequency", &uartclk);
> >
> > +       s->polling = !!irq;
> 
> 
> This is incorrect, you should check for positive numbers only for IRQ
> support and for the rest otherwise. I do not see that frameworks guarantee
> this never be negative.

Hi Greg,
I just noticed that v5 of this patch is now in the tty-testing
branch. It should not, as there is currently a v6 fixing it, and
possibly a v7 coming.

Hugo.



> > +       if (s->polling)
> > +               dev_dbg(dev,
> > +                       "No interrupt pin definition, falling back to
> > polling mode\n");
> > +
> >         s->clk = devm_clk_get_optional(dev, NULL);
> >         if (IS_ERR(s->clk))
> >                 return PTR_ERR(s->clk);
> > @@ -1665,6 +1693,12 @@ int sc16is7xx_probe(struct device *dev, const
> > struct sc16is7xx_devtype *devtype,
> >                 goto out_ports;
> >  #endif
> >
> > +       if (s->polling) {
> > +               /* Initialize kernel thread for polling */
> > +               kthread_init_delayed_work(&s->poll_work,
> > sc16is7xx_poll_proc);
> > +               return 0;
> 
> 
> 
> > +       }
> > +
> >         /*
> >          * Setup interrupt. We first try to acquire the IRQ line as level
> > IRQ.
> >          * If that succeeds, we can allow sharing the interrupt as well.
> > @@ -1724,6 +1758,9 @@ void sc16is7xx_remove(struct device *dev)
> >                 sc16is7xx_power(&s->p[i].port, 0);
> >         }
> >
> > +       if (s->polling)
> > +               kthread_cancel_delayed_work_sync(&s->poll_work);
> > +
> >         kthread_flush_worker(&s->kworker);
> >         kthread_stop(s->kworker_task);
> >
> > --
> > 2.47.1
> >
> >


-- 
Hugo Villeneuve
