Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CA818A6BC;
	Tue, 20 Aug 2024 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152359; cv=none; b=KhPVYXNC5e/oundtcMcQTl5VvrGw8vI1x12fiqcG931x3qruiqdQ10iQM3Z2ooIQi9vNQPID09e5aoVXcufUtPvJXj+40j433leZ4Up/32arR9Hvq5oLCBk6lINUygl6RXYqrHBsAwyMmodX54ixy15F6WPceqBGWEi7T6/LFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152359; c=relaxed/simple;
	bh=wggzba2KQ9Vt2ZvqIO/9sJpT6BjbyF3+LIx+pHS15fQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AZUjtr7E9prHiwY3zwDjaeEUByRwk2lOg/a2yKofyQ3FznMSzB69metmEFWJ2ipKbofEdpacCxUX64WgH7TVGqM+GmHd7SQVHjB19gw/H266x1DFb5GCONxvoBrWz+jh6wwRDMlcRrivrpWKLon/zFvxVjpqwhGjMrBMLcJmM/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIuKyluW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIuKyluW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724152358; x=1755688358;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=wggzba2KQ9Vt2ZvqIO/9sJpT6BjbyF3+LIx+pHS15fQ=;
  b=MIuKyluWPAEg8AdqN8actGCqXzrIKtknGvueoip8DeTy4X4njauBwLm9
   zARH7IgY0otGkK3HfARdERP1/AOLU7Z2F1gf+JO2cHNR6Bw9G1Gqxx2te
   LZ1m8lo8I6O0H/shk+iMtRnhUNWsqgvi3o+9jZ5sKxSWGEhr5ZG1xu74+
   pGVj9ntIrxjt5meWClW333sHYOTm/iGfpw5AHYXZTe5WQaGMVM5a5AfiJ
   EeQYyxFTuF6h9hGYuULgI7HVy4XD0yxXlfH5Me71+XKhwVH3BqcBzOdqC
   C+gPczWJahhtUjl5f5K0OXErAuSAFgXADNi2rxahMmjjKAWaIoMd2b/hD
   g==;
X-CSE-ConnectionGUID: RuALSIQ1QsyURoVHybvcQg==
X-CSE-MsgGUID: 3vOoObPpQmeohRH9Gd0pHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22609195"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22609195"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:12:24 -0700
X-CSE-ConnectionGUID: V4bYPdaLSMuq818kGMaZKg==
X-CSE-MsgGUID: RZzcHT03R1WH5AfKeVidVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65055217"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.102])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:12:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 Aug 2024 14:12:15 +0300 (EEST)
To: John Ogness <john.ogness@linutronix.de>
cc: Petr Mladek <pmladek@suse.com>, 
    Sergey Senozhatsky <senozhatsky@chromium.org>, 
    Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, 
    Tony Lindgren <tony@atomide.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Geert Uytterhoeven <geert+renesas@glider.be>, 
    Arnd Bergmann <arnd@arndb.de>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
    =?ISO-8859-15?Q?Th=E9o_Lebrun?= <theo.lebrun@bootlin.com>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH printk v8 11/35] serial: core: Introduce wrapper to set
 @uart_port->cons
In-Reply-To: <20240820063001.36405-12-john.ogness@linutronix.de>
Message-ID: <a4bb64e8-126c-6a50-bd39-77926aa6010e@linux.intel.com>
References: <20240820063001.36405-1-john.ogness@linutronix.de> <20240820063001.36405-12-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-182483464-1724152253=:1119"
Content-ID: <48ef72ec-aad6-d4bc-433f-0c00788492e2@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-182483464-1724152253=:1119
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <2a93f174-05f9-556e-9215-6594301a4278@linux.intel.com>

On Tue, 20 Aug 2024, John Ogness wrote:

> Introduce uart_port_set_cons() as a wrapper to set @cons of a
> uart_port. The wrapper sets @cons under the port lock in order
> to prevent @cons from disappearing while another context is
> holding the port lock. This is necessary for a follow-up
> commit relating to the port lock wrappers, which rely on @cons
> not changing between lock and unlock.
>=20
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Tested-by: Th=E9o Lebrun <theo.lebrun@bootlin.com> # EyeQ5, AMBA-PL011
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/tty/serial/8250/8250_core.c |  6 +++---
>  drivers/tty/serial/amba-pl011.c     |  2 +-
>  drivers/tty/serial/serial_core.c    | 16 ++++++++--------
>  include/linux/serial_core.h         | 17 +++++++++++++++++
>  4 files changed, 29 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index 29e4b83e0376..5f9f06911795 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -423,11 +423,11 @@ static int univ8250_console_setup(struct console *c=
o, char *options)
> =20
>  =09port =3D &serial8250_ports[co->index].port;
>  =09/* link port to console */
> -=09port->cons =3D co;
> +=09uart_port_set_cons(port, co);
> =20
>  =09retval =3D serial8250_console_setup(port, options, false);
>  =09if (retval !=3D 0)
> -=09=09port->cons =3D NULL;
> +=09=09uart_port_set_cons(port, NULL);
>  =09return retval;
>  }
> =20
> @@ -485,7 +485,7 @@ static int univ8250_console_match(struct console *co,=
 char *name, int idx,
>  =09=09=09continue;
> =20
>  =09=09co->index =3D i;
> -=09=09port->cons =3D co;
> +=09=09uart_port_set_cons(port, co);
>  =09=09return serial8250_console_setup(port, options, true);
>  =09}
> =20
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 8b1644f5411e..7d0134ecd82f 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2480,7 +2480,7 @@ static int pl011_console_match(struct console *co, =
char *name, int idx,
>  =09=09=09continue;
> =20
>  =09=09co->index =3D i;
> -=09=09port->cons =3D co;
> +=09=09uart_port_set_cons(port, co);
>  =09=09return pl011_console_setup(co, options);
>  =09}
> =20
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 9a18d0b95a41..61c7e1268957 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3168,8 +3168,15 @@ static int serial_core_add_one_port(struct uart_dr=
iver *drv, struct uart_port *u
>  =09state->uart_port =3D uport;
>  =09uport->state =3D state;
> =20
> +=09/*
> +=09 * If this port is in use as a console then the spinlock is already
> +=09 * initialised.
> +=09 */
> +=09if (!uart_console_registered(uport))
> +=09=09uart_port_spin_lock_init(uport);
> +
>  =09state->pm_state =3D UART_PM_STATE_UNDEFINED;
> -=09uport->cons =3D drv->cons;
> +=09uart_port_set_cons(uport, drv->cons);
>  =09uport->minor =3D drv->tty_driver->minor_start + uport->line;
>  =09uport->name =3D kasprintf(GFP_KERNEL, "%s%d", drv->dev_name,
>  =09=09=09=09drv->tty_driver->name_base + uport->line);
> @@ -3178,13 +3185,6 @@ static int serial_core_add_one_port(struct uart_dr=
iver *drv, struct uart_port *u
>  =09=09goto out;
>  =09}
> =20
> -=09/*
> -=09 * If this port is in use as a console then the spinlock is already
> -=09 * initialised.
> -=09 */
> -=09if (!uart_console_registered(uport))
> -=09=09uart_port_spin_lock_init(uport);
> -
>  =09if (uport->cons && uport->dev)
>  =09=09of_console_check(uport->dev->of_node, uport->cons->name, uport->li=
ne);
> =20
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 8872cd21e70a..2cf03ff2056a 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -608,6 +608,23 @@ static inline void __uart_port_unlock_irqrestore(str=
uct uart_port *up, unsigned
>  =09spin_unlock_irqrestore(&up->lock, flags);
>  }
> =20
> +/**
> + * uart_port_set_cons - Safely set the @cons field for a uart
> + * @up:=09=09The uart port to set
> + * @con:=09The new console to set to
> + *
> + * This function must be used to set @up->cons. It uses the port lock to
> + * synchronize with the port lock wrappers in order to ensure that the c=
onsole
> + * cannot change or disappear while another context is holding the port =
lock.
> + */
> +static inline void uart_port_set_cons(struct uart_port *up, struct conso=
le *con)
> +{
> +=09unsigned long flags;
> +
> +=09__uart_port_lock_irqsave(up, &flags);
> +=09up->cons =3D con;
> +=09__uart_port_unlock_irqrestore(up, flags);
> +}
>  /**
>   * uart_port_lock - Lock the UART port
>   * @up:=09=09Pointer to UART port structure
>=20
--8323328-182483464-1724152253=:1119--
