Received: from ocn-dfr-mts-113c1.ocn.ad.jp (ocn-dfr-mts-113c1.ocn.ad.jp [153.128.190.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156644E664;
	Tue,  4 Aug 2026 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.128.190.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852074; cv=none; b=sxsuMVhxTqE25wQSfGTCSvR6lTuOIyShnYE8MEf2yeim9OM90lK3Hw+oQ6ODlvQgq6AphPwO1GOtCssWOdxVfOEgYHFDLQgJzWRPvgLIDPaeOa9iWR3aKRbYC17uPRK7f2925LVSyv86LK9UEwuR0y/sukJkI/8Kh2TQXQaELRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852074; c=relaxed/simple;
	bh=P0yavnRqrLdehpmTis/Fb8ET09nK2NpWNmfhVxosv2E=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qFY2LE16qqGD58K869NZjhn58Z+IirIylcbV8DxkFwwYIyMDvScFwNe2+bREP4gAy7ca9aMFIYGZaiVt4aHDZuVlaMKYMwl+9eLDXFX/oJuQCmSJURxcgM0ufiBzG4G4Ow9eIZG8jP5Y5S8WPcOBdM39UsQYQWdq0wWp1/LE4+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mba.ocn.ne.jp; spf=pass smtp.mailfrom=mba.ocn.ne.jp; dkim=pass (2048-bit key) header.d=mba.ocn.ne.jp header.i=@mba.ocn.ne.jp header.b=KMhQEhdv; arc=none smtp.client-ip=153.128.190.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mba.ocn.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mba.ocn.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mba.ocn.ne.jp header.i=@mba.ocn.ne.jp header.b="KMhQEhdv"
Received: from ocn-ckd-mts-112c31.ocn.ad.jp (ocn-ckd-mts-112c31.ocn.ad.jp [180.8.113.160])
	by ocn-dfr-mts-113c1.ocn.ad.jp (Postfix) with ESMTP id 7AB5436F;
	Tue,  4 Aug 2026 22:52:48 +0900 (JST)
Received: from ocn-spm-mts-107c1.ocn.ad.jp (ocn-spm-mts-107c1.ocn.ad.jp [153.128.190.238])
	by ocn-ckd-mts-112c31.ocn.ad.jp (Postfix) with ESMTP id C896F50002EA9;
	Tue,  4 Aug 2026 22:52:40 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mba.ocn.ne.jp;
	s=20240118; t=1785851560;
	bh=P0yavnRqrLdehpmTis/Fb8ET09nK2NpWNmfhVxosv2E=;
	h=Date:To:Cc:Subject:From:In-Reply-To:References:From;
	b=KMhQEhdv7fF9DTsGdYqLZcQP99L0OCOBoFRPTkpKSvrtkYJrETmZilZUgJO07L97F
	 eNpWAQxrncg3dmkTKYpLz83vJ2tT6hR9NXmbz4rqq2DtqgpA//41fgouib9vRQFXn0
	 b0NuiB5Ef+IzpCZ6gqLpi4RS4WGTigT+7YsID2Yo2goUM7TshNZVm5ku8FOaTLbphC
	 p3Gmrt4Rgq9Ktk/8RghWocbJVofVv3bH57lwo8DCeArW/peiSikmcKf6yCES9vZhfU
	 h483wAxbHSYylr+ki+Py1/Sy+h56ZcXRrrnitbFnsyGuBOcmQSNmgKsWkX4aORmKFL
	 WM/xjKQ6ywtjg==
Received: from ocn-vc-mts-112c1.ocn.ad.jp ([153.149.236.166])
 by ocn-spm-mts-107c1 with ngmta
 id 88d72142-18c89e885a5f773f; Tue, 04 Aug 2026 22:52:40 +0900
Received: from ocn-sdpx-mts-110c1.ocn.ad.jp ([153.128.117.202])
 by ocn-vc-mts-112c1 with ngmta
 id 7d56460e-18c89e884a5652f8; Tue, 04 Aug 2026 22:52:40 +0900
Received: from localhost (p1601136-ipoe.ipoe.ocn.ne.jp [114.172.254.135])
	by ocn-sdpx-mts-110c1.ocn.ad.jp (Postfix) with ESMTPA;
	Tue,  4 Aug 2026 22:52:40 +0900 (JST)
Date: Tue, 04 Aug 2026 22:52:36 +0900 (JST)
Message-Id: <20260804.225236.1648692120067580029.anemo@mba.ocn.ne.jp>
To: u.kleine-koenig@baylibre.com
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 hvilleneuve@dimonoff.com, john.ogness@linutronix.de, alan@redhat.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Geert
 Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/8] serial: txx9: Drop noop probe function and
 dangerous remove callback
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <2165469758f26f79c0267386bc6cd92379fb0e2c.1785832297.git.u.kleine-koenig@baylibre.com>
References: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
	<2165469758f26f79c0267386bc6cd92379fb0e2c.1785832297.git.u.kleine-koenig@baylibre.com>
X-Mailer: Mew version 6.8 on Emacs 30.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue,  4 Aug 2026 10:57:53 +0200, Uwe Kleine-K=F6nig (The Capable Hub=
) <u.kleine-koenig@baylibre.com> wrote:
> The only platform device that can be bound to the driver is allocated=
 by
> the driver itself. That device doesn't have platdata, so the probe
> function only consists of a loop that is never run and thus can be
> dropped without loss of functionality.

The noop loop might came from old 8250 driver I referenced at that time=
.=

Now I think it can be removed safely.
Thank you for this cleanup.

Reviewed-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto

On Tue,  4 Aug 2026 10:57:53 +0200, Uwe Kleine-K=F6nig (The Capable Hub=
) <u.kleine-koenig@baylibre.com> wrote:
> The only platform device that can be bound to the driver is allocated=
 by
> the driver itself. That device doesn't have platdata, so the probe
> function only consists of a loop that is never run and thus can be
> dropped without loss of functionality.
> =

> The remove function then should better not undo things that were not
> done in the first place. That happens because serial_txx9_init() call=
s
> serial_txx9_register_ports() with the created platform device and so
> up->dev =3D=3D &dev->dev evaluates to true and uart_remove_one_port()=
 is
> called twice for each port.
> =

> So let serial_txx9_exit() undo exactly what serial_txx9_init() does a=
nd
> remove the useless respectively wrong functions.
> =

> Fixes: 0970769aceb9 ("[SERIAL] serial_txx9 driver update")
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@=
baylibre.com>
> ---
>  drivers/tty/serial/serial_txx9.c | 55 ++----------------------------=
--
>  1 file changed, 3 insertions(+), 52 deletions(-)
> =

> diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/se=
rial_txx9.c
> index 4ae9a45c8e3a..ef56979321b9 100644
> --- a/drivers/tty/serial/serial_txx9.c
> +++ b/drivers/tty/serial/serial_txx9.c
> @@ -1009,7 +1009,8 @@ static void serial_txx9_unregister_port(int lin=
e)
>  	struct uart_port *uart =3D &serial_txx9_ports[line];
>  =

>  	mutex_lock(&serial_txx9_mutex);
> -	uart_remove_one_port(&serial_txx9_reg, uart);
> +	if (uart->iobase || uart->mapbase)
> +		uart_remove_one_port(&serial_txx9_reg, uart);
>  	uart->flags =3D 0;
>  	uart->type =3D PORT_UNKNOWN;
>  	uart->iobase =3D 0;
> @@ -1019,52 +1020,6 @@ static void serial_txx9_unregister_port(int li=
ne)
>  	mutex_unlock(&serial_txx9_mutex);
>  }
>  =

> -/*
> - * Register a set of serial devices attached to a platform device.
> - */
> -static int serial_txx9_probe(struct platform_device *dev)
> -{
> -	struct uart_port *p =3D dev_get_platdata(&dev->dev);
> -	struct uart_port port;
> -	int ret, i;
> -
> -	memset(&port, 0, sizeof(struct uart_port));
> -	for (i =3D 0; p && p->uartclk !=3D 0; p++, i++) {
> -		port.iobase	=3D p->iobase;
> -		port.membase	=3D p->membase;
> -		port.irq	=3D p->irq;
> -		port.uartclk	=3D p->uartclk;
> -		port.iotype	=3D p->iotype;
> -		port.flags	=3D p->flags;
> -		port.mapbase	=3D p->mapbase;
> -		port.dev	=3D &dev->dev;
> -		port.has_sysrq	=3D IS_ENABLED(CONFIG_SERIAL_TXX9_CONSOLE);
> -		ret =3D serial_txx9_register_port(&port);
> -		if (ret < 0) {
> -			dev_err(&dev->dev, "unable to register port at index %d "
> -				"(IO%lx MEM%llx IRQ%d): %d\n", i,
> -				p->iobase, (unsigned long long)p->mapbase,
> -				p->irq, ret);
> -		}
> -	}
> -	return 0;
> -}
> -
> -/*
> - * Remove serial ports registered against a platform device.
> - */
> -static void serial_txx9_remove(struct platform_device *dev)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < UART_NR; i++) {
> -		struct uart_port *up =3D &serial_txx9_ports[i];
> -
> -		if (up->dev =3D=3D &dev->dev)
> -			serial_txx9_unregister_port(i);
> -	}
> -}
> -
>  #ifdef CONFIG_PM
>  static int serial_txx9_suspend(struct platform_device *dev, pm_messa=
ge_t state)
>  {
> @@ -1096,8 +1051,6 @@ static int serial_txx9_resume(struct platform_d=
evice *dev)
>  #endif
>  =

>  static struct platform_driver serial_txx9_plat_driver =3D {
> -	.probe		=3D serial_txx9_probe,
> -	.remove		=3D serial_txx9_remove,
>  #ifdef CONFIG_PM
>  	.suspend	=3D serial_txx9_suspend,
>  	.resume		=3D serial_txx9_resume,
> @@ -1251,9 +1204,7 @@ static void __exit serial_txx9_exit(void)
>  	platform_driver_unregister(&serial_txx9_plat_driver);
>  	platform_device_unregister(serial_txx9_plat_devs);
>  	for (i =3D 0; i < UART_NR; i++) {
> -		struct uart_port *up =3D &serial_txx9_ports[i];
> -		if (up->iobase || up->mapbase)
> -			uart_remove_one_port(&serial_txx9_reg, up);
> +		serial_txx9_unregister_port(i);
>  	}
>  =

>  	uart_unregister_driver(&serial_txx9_reg);
> -- =

> 2.55.0.11.g153666a7d9bb
> =

