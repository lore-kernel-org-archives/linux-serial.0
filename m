From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq@rere.qmqm.pl>
Subject: Re: [patch 2/3] sc16is7x2: use threaded irqs
Date: Sat, 2 Oct 2010 01:37:53 +0200
Message-ID: <20101001233753.GB5733@rere.qmqm.pl>
References: <201010012118.o91LI4OP021284@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:40983 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754352Ab0JAXrS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Oct 2010 19:47:18 -0400
Content-Disposition: inline
In-Reply-To: <201010012118.o91LI4OP021284@imap1.linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: manuel.stahl@iis.fraunhofer.de
Cc: akpm@linux-foundation.org, greg@kroah.com, linux-serial@vger.kernel.org

On Fri, Oct 01, 2010 at 02:18:04PM -0700, akpm@linux-foundation.org wro=
te:
> From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
>=20
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>=20
>  drivers/serial/sc16is7x2.c |  115 ++++++++++++----------------------=
-
>  1 file changed, 40 insertions(+), 75 deletions(-)
>=20
> diff -puN drivers/serial/sc16is7x2.c~sc16is7x2-use-threaded-irqs driv=
ers/serial/sc16is7x2.c
> --- a/drivers/serial/sc16is7x2.c~sc16is7x2-use-threaded-irqs
> +++ a/drivers/serial/sc16is7x2.c
[...]
> @@ -1066,21 +1051,18 @@ static bool sc16is7x2_handle_channel(str
>  	return (chan->iir & UART_IIR_NO_INT) =3D=3D 0x00;
>  }
> =20
> -static void sc16is7x2_work(struct work_struct *w)
> +static irqreturn_t sc16is7x2_work(int irq, void *data)
>  {
> -	struct sc16is7x2_chip *ts =3D
> -			container_of(w, struct sc16is7x2_chip, work);
> +	struct sc16is7x2_chip *ts =3D (struct sc16is7x2_chip *)data;

You don't need to cast from (void *).

[...]
> =20
> -static irqreturn_t sc16is7x2_interrupt(int irq, void *dev_id)
> +static irqreturn_t sc16is7x2_irq(int irq, void *data)
>  {
> -	struct sc16is7x2_chip *ts =3D dev_id;
> -
> -	dev_dbg(&ts->spi->dev, "%s\n", __func__);
> +	struct sc16is7x2_chip *ts =3D (struct sc16is7x2_channel *)data;

This cast seems wrong. Better to just drop it, like in sc16is7x2_work()=
=2E

> =20
> -	if (!ts->force_end_work && !work_pending(&ts->work) &&
> -	    !freezing(current) && !ts->suspending)
> -		queue_work(ts->workqueue, &ts->work);
> -
> -	return IRQ_HANDLED;
> +	/* It takes too long to read the regs over SPI,
> +	 * so just wake up the thread */
> +	if (ts->channel[0].active || ts->channel[1].active)
> +		return IRQ_WAKE_THREAD;
> +	else
> +		return IRQ_NONE;
>  }
> =20
[...]

Since this is fixing up patch #1, wouldn't it be better to merge the tw=
o?

Best Regards,
Micha=B3 Miros=B3aw
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
