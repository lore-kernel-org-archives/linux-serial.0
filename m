Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6890222586;
	Thu, 19 Dec 2024 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600166; cv=none; b=E6VI04X5FxENMdjp5AMr+ypyVrgENDATsQ/hmFGY5tT2rdZYcDQnsvCq24eKeDyHLtlLopffEexXmk0EwWhwtPxI5TofKEaR9/fiBEoqCXQYxrcT76fYGUWTgxq3uQ/ZEWZG06ZWcqcnj9yz2txMRupBX7/a0Y60wkX/1j9u1vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600166; c=relaxed/simple;
	bh=mrgbF5jofN96KP6PD/nLGC9wzBTKxJswB5DJYN2n/g8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QhZ5mX4MehzNcwNQ3nUTPV6qd9ACMKX1308c2mudZTCQvq2oP7QM1rMq3u2LoOVIq0qhFQGERkIhPxd81DEsxfOJ2O2poE/z6vK9WcKxNMwemVvmt3yWNs03ykWMBKPIZnCo6aVjYugx/yoAtFmI/75+Boog7/cJplPjaflItjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=GDIdoSRy; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="GDIdoSRy"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 13AA494016B2;
	Thu, 19 Dec 2024 10:22:41 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id YDFPTysQv5Hh; Thu, 19 Dec 2024 10:22:40 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id D83AC94016B3;
	Thu, 19 Dec 2024 10:22:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com D83AC94016B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1734600160; bh=eTBgdvq0oyGkUcNoAqaZYhgOUrWf2pYbdoTk6SWFoIo=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=GDIdoSRyUQfnQSnVNqZR2l9jLzCiZUc9O+2EDrk1YPthd/f3Ep8wbPPczV2drDIv6
	 B6FcgvHEa9rNOFurBKpVPKdBavhbZhK3D0BzVlRQgAye9xh8t1uB/mbdnKv+TQqUmf
	 uqv/67jO2cbRH5JSl+7jyHSQchR6nD1StbjeI7gmADMpzClEefBamNQzKqt/N5Ce+u
	 p0BCFVh4a6uALD387qXQyGic4Rmcvqld6nNokkG9OJgEWjWqw0oBqOrE5GoGHALLM2
	 QzFXp/YJCR6lcxmc64eLIRG4JxwH03fGE4c9eb09ghtAFaBS9ZrVEBE7WeB3kuJGad
	 rG7iKGa4dROjw==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id d9M31Fz8Swgb; Thu, 19 Dec 2024 10:22:40 +0100 (CET)
Received: from ws565760 (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 7BB8C94016B2;
	Thu, 19 Dec 2024 10:22:40 +0100 (CET)
Date: Thu, 19 Dec 2024 10:22:40 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: Greg KH <gregkh@linuxfoundation.org>
cc: Andre Werner <andre.werner@systec-electronic.com>, jirislaby@kernel.org, 
    hvilleneuve@dimonoff.com, andy@kernel.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, lech.perczak@camlingroup.com
Subject: Re: [External Email] Re: [PATCH] serial: sc16is7xx: Add polling
 feature if no IRQ usage possible
In-Reply-To: <2024121931-turbojet-preamble-b520@gregkh>
Message-ID: <fbd224a3-8f10-3ccf-5480-38fcd839d409@systec-electronic.com>
References: <20241219084638.960253-1-andre.werner@systec-electronic.com> <2024121931-turbojet-preamble-b520@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463798257-1196194127-1734600160=:961237"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463798257-1196194127-1734600160=:961237
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dear Greg,
On Thu, 19 Dec 2024, Greg KH wrote:

> On Thu, Dec 19, 2024 at 09:46:38AM +0100, Andre Werner wrote:
> > Fall back to polling mode if no interrupt is configured because not
> > possible. If "interrupts" property is missing in devicetree the drive=
r
> > uses a delayed worker to pull state of interrupt status registers.
> >
> > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > ---
> > This driver was tested on Linux 5.10. We had a custom board that was =
not
> > able to connect the interrupt port. Only I2C was available.
>
> Could you not test this on the latest tree?  5.10 is _VERY_ old now.

I will try it on devboard with a 6.1 Kernel. Is that okay for you?

>
> > ---
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 40 ++++++++++++++++++++++++++++++++=
++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16=
is7xx.c
> > index a3093e09309f..31962fdca178 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -314,6 +314,7 @@
> >  #define SC16IS7XX_FIFO_SIZE		(64)
> >  #define SC16IS7XX_GPIOS_PER_BANK	4
> >
> > +#define SC16IS7XX_POLL_PERIOD 10 /*ms*/
>
> Please use a tab here.
>
> >  #define SC16IS7XX_RECONF_MD		BIT(0)
> >  #define SC16IS7XX_RECONF_IER		BIT(1)
> >  #define SC16IS7XX_RECONF_RS485		BIT(2)
> > @@ -348,6 +349,9 @@ struct sc16is7xx_port {
> >  	u8				mctrl_mask;
> >  	struct kthread_worker		kworker;
> >  	struct task_struct		*kworker_task;
> > +	struct kthread_delayed_work	poll_work;
> > +	bool polling;
> > +	bool shutdown;
> >  	struct sc16is7xx_one		p[];
> >  };
> >
> > @@ -861,6 +865,19 @@ static irqreturn_t sc16is7xx_irq(int irq, void *=
dev_id)
> >  	return IRQ_HANDLED;
> >  }
> >
> > +static void sc16is7xx_transmission_poll(struct kthread_work *work)
> > +{
> > +	struct sc16is7xx_port *s =3D container_of(work, struct sc16is7xx_po=
rt, poll_work.work);
> > +
> > +	/* Resuse standard IRQ handler. Interrupt ID is unused in this cont=
ext. */
> > +	sc16is7xx_irq(0, s);
> > +
> > +	/* setup delay based on SC16IS7XX_POLL_PERIOD */
> > +	if (!s->shutdown)
> > +		kthread_queue_delayed_work(&s->kworker, &s->poll_work,
> > +					   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD));
> > +}
> > +
> >  static void sc16is7xx_tx_proc(struct kthread_work *ws)
> >  {
> >  	struct uart_port *port =3D &(to_sc16is7xx_one(ws, tx_work)->port);
> > @@ -1149,6 +1166,7 @@ static int sc16is7xx_config_rs485(struct uart_p=
ort *port, struct ktermios *termi
> >  static int sc16is7xx_startup(struct uart_port *port)
> >  {
> >  	struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
> > +	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
> >  	unsigned int val;
> >  	unsigned long flags;
> >
> > @@ -1210,6 +1228,11 @@ static int sc16is7xx_startup(struct uart_port =
*port)
> >  	uart_port_lock_irqsave(port, &flags);
> >  	sc16is7xx_enable_ms(port);
> >  	uart_port_unlock_irqrestore(port, flags);
> > +	if (s->polling) {
> > +		s->shutdown =3D false;
> > +		kthread_queue_delayed_work(&s->kworker, &s->poll_work,
> > +					   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD));
> > +	}
> >
> >  	return 0;
> >  }
> > @@ -1232,6 +1255,10 @@ static void sc16is7xx_shutdown(struct uart_por=
t *port)
> >
> >  	sc16is7xx_power(port, 0);
> >
> > +	if (s->polling) {
> > +		s->shutdown =3D true;
> > +		kthread_cancel_delayed_work_sync(&s->poll_work);
> > +	}
> >  	kthread_flush_worker(&s->kworker);
> >  }
> >
> > @@ -1537,7 +1564,13 @@ int sc16is7xx_probe(struct device *dev, const =
struct sc16is7xx_devtype *devtype,
> >
> >  	/* Always ask for fixed clock rate from a property. */
> >  	device_property_read_u32(dev, "clock-frequency", &uartclk);
> > +	s->polling =3D !device_property_present(dev, "interrupts");
> >
> > +	if (s->polling) {
> > +		dev_warn(dev,
> > +			 "No interrupt definition found. Falling back to polling mode.\n"=
);
>
> What is a user supposed to do with this message?  And why would a devic=
e
> NOT have any interrupts?  This feels like it is just going to pound on
> the device and cause a lot of power drain for just a simple little uart=
.

I thought it could be interesting to know that the device has missing
interrupt support.

>
> Why can't your system provide a valid irq line?
>

In our case we have only an I2C available in a connection cable and the
GPIOs are linked through a two way level shifter.
It was a very special situation in our case because target platform and
sensor platform are provided.
The IRQ from the sensor war not able to drive the two way level shifter l=
ow so
we always detect outgoing traffic and the IRQ signal but at the target
board after the level shifter the signal remains stable. So
communication failed with a timeout. So we need to force polling the
interrupt status register because
both HW solution should not be changed in any way.

> thanks,
>
> greg k-h
>


Regards, Andr=E9
---1463798257-1196194127-1734600160=:961237--
