Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101193;
	b=maFuHqWfDL/JCT7hlHNkLX88YHApIUm03OvdqwIU6Ej7wQmsm5zJySo1JcIRwl/kQy+1
	 AwTkXnvlxi2i4MACO/yWpDhXrgvpmpDdJxY7OiRHCDqkdxwZRwvvuqz90w1I4t4O5BQ5f
	 YL7tHOsazmpPZqRtH4pFdrmA42kErNrbjMueJUolFsE8UInHRoX4PK3+b7fGj1Q3aLf4F
	 jBa0yptaU0UdzsISztouPBI+LGhGp7JkvQg9xUT93CbIIdPLWGyTnpwAWrZyxt4/ZKfLY
	 /60jEDPqoTDOGCi6aRCUBtuCdicHiEGS1Hg0tmnYmrA9JyaufGDeWTZ5fTw5HQ/1miQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101193;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=fvfm5QHWeT+5y5RyRY9bq6ty8daU5y7ybSf8CKQi8iU=;
	b=TuXgpK1y79KPULTNNpKLOeYSSPTbP42JqmTHuQk4r8WBaj7IFDHuUV/q5uNvSEyESo/U
	 zxnZvkADCgYscoy2UgM0WgJigFBareoywOdGxihHT/6xwaIBU9pjCSPYuuxJaK65sIm4t
	 AVMftLhv2gGmphr5DdbrvFo36bErwGtRagqXOUTHNcJqdr5yzMUch7cXbBokwBl+sW4wj
	 1aSA4thM1xn3byc81lwrQRP4ixRSc4Qa/pb2mCASfnwmSeXWo/n0Fmv2JDPLdCFzMVWki
	 guHX0MJRPbUWdq8tq20d8i6ifTAI9EG/bZTeSsA90vOEGqfIKFFc53bd4kPA6KbkYzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EkrAeAVk;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D487606AED3;
	Tue, 27 Oct 2026 11:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D487606AED3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EkrAeAVk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793101192; x=1824637192;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iGPNvXEcwlA5POsZZSDnagM9sJITGnqx2ASpq6Bi4fY=;
  b=EkrAeAVkjAm4JC/C4R7VExTpGzsTRw9EzldXfkk84KywXSc0rWP5dbEN
   PeQR46h8Uk7URVgTwUTi4vwBzBjfZKm6JSiRHU5TLja3jAoFo/HZnuO+f
   8dn/pHQNVnXyGqB59xVr+UEM4uEI2fKYQGIRwa5XSpqHwgFHq8npBCNxl
   u2JsEvUrgOSGVCJ7i3FtEIkPFKCUn/kLyepwdzPy/8z7jAfKibPOcEuAU
   IrV20odlMtzqoV0fg65x4sgVRN3og4RGQ26Imka07MRyXUevrkSVmSvAR
   8q5RJcKloaV8Dr/3by5M4K+vG9z3OlMFUromhhFKktuQ1dNYejzmG5LFb
   A==;
X-CSE-ConnectionGUID: 3KPT2/xIR9e9XSpuDhwUNg==
X-CSE-MsgGUID: DiyWe2rTSDShYxp1Ajxnrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1706714"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1706714"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 04:39:51 -0700
X-CSE-ConnectionGUID: Mwtodx+eSW6TwgCAM2oBGA==
X-CSE-MsgGUID: Aii4mqylT3eKG+ZJrBtEKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6397978"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 04:39:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Oct 2026 13:39:34 +0200 (EET)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>, 
    Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
    Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>, 
    Florian Fainelli <f.fainelli@gmail.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Peter Hurley <peter@hurleysoftware.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>, 
    Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, 
    Manivannan Sadhasivam <mani@kernel.org>, Olof Johansson <olof@lixom.net>, 
    =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>, 
    Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
    Peter Griffin <peter.griffin@linaro.org>, 
    Alim Akhtar <alim.akhtar@samsung.com>, 
    Robert Baldyga <r.baldyga@samsung.com>, 
    Thomas Abraham <thomas.abraham@linaro.org>, 
    Kukjin Kim <kgene.kim@samsung.com>, 
    Patrice Chotard <patrice.chotard@foss.st.com>, 
    Srinivas Kandagatla <srini@kernel.org>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Andy Shevchenko <andy.shevchenko@gmail.com>, 
    Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, 
    Al Cooper <alcooperx@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, stable <stable@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    Tate Whiteberg <whiteberg@arista.com>, 
    Christian Marangi <ansuelsmth@gmail.com>, 
    John Ogness <john.ogness@linutronix.de>, 
    Fushuai Wang <wangfushuai@baidu.com>
Subject: Re: [PATCH 03/24] serial: 8250: don't wait for the em485 timers
 locked
In-Reply-To: <20261027-tty-llm-v1-3-99b0202ae546@linuxfoundation.org>
Message-ID: <c53e055a-b2c4-9360-41e4-dfbe757c86d4@linux.intel.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-3-99b0202ae546@linuxfoundation.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1123129667-1793101174=:1182"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1123129667-1793101174=:1182
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> serial8250_em485_destroy() is called with the port lock held and
> interrupts off, from ->rs485_config() and from
> serial8250_unregister_port().  It calls hrtimer_cancel(), which waits
> for a handler which is running, and both handlers start by taking the
> port lock:
>=20
>   CPU0                                  CPU1
>   ioctl(TIOCSRS485), rs485 off
>   uart_set_rs485_config()
>     uart_port_lock_irqsave()            serial8250_em485_handle_stop_tx()
>     serial8250_em485_config()             uart_port_lock_irqsave()
>       serial8250_em485_destroy()            spins
>         hrtimer_cancel()
>           spins
>=20
> All it takes is to turn RS485 off right after the end of a transmission,
> when the timer for delay_rts_after_send expires.
>=20
> The handlers do nothing unless em485->active_timer points to their
> timer, so it is enough to clear that pointer.  What cannot be done with
> the lock held is to free the structure: hrtimer_try_to_cancel() fails
> for a timer whose handler is running, even if it has been started again
> in the meantime.  So keep the structure in the port when RS485 is turned
> off, use it again when RS485 is turned on, and free it when the port is
> unregistered, where the timers can be waited for without the lock.
>=20
> A port on which RS485 emulation has been used once keeps the structure,
> about 150 bytes, until it is unregistered.
>=20
> Fixes: 6e0a5de2136b ("serial: 8250: Use hrtimers for rs485 delays")
> Cc: stable <stable@kernel.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: "Uwe Kleine-K=C3=B6nig (The Capable Hub)" <u.kleine-koenig@baylibre.c=
om>
> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: Tate Whiteberg <whiteberg@arista.com>
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> Cc: Fushuai Wang <wangfushuai@baidu.com>
> Cc: Rafael Gago Castano <rgc@hms.se>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/8250/8250.h      |  1 +
>  drivers/tty/serial/8250/8250_core.c |  5 +---
>  drivers/tty/serial/8250/8250_port.c | 60 ++++++++++++++++++++++++++++++-=
------
>  include/linux/serial_8250.h         |  1 +
>  4 files changed, 52 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/825=
0.h
> index 21ed9c41b751..82a3b8359643 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -235,6 +235,7 @@ int serial8250_em485_config(struct uart_port *port, s=
truct ktermios *termios,
>  void serial8250_em485_start_tx(struct uart_8250_port *p, bool toggle_ier=
);
>  void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)=
;
>  void serial8250_em485_destroy(struct uart_8250_port *p);
> +void serial8250_em485_free(struct uart_8250_port *p);
>  extern struct serial_rs485 serial8250_em485_supported;
> =20
>  /* MCR <-> TIOCM conversion */
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index 42319843cb5b..0951d3e42e1f 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -947,10 +947,7 @@ void serial8250_unregister_port(struct uart_8250_por=
t *uart)
>  {
>  =09guard(mutex)(&serial_mutex);
> =20
> -=09if (uart->em485) {
> -=09=09guard(uart_port_lock_irqsave)(&uart->port);
> -=09=09serial8250_em485_destroy(uart);
> -=09}
> +=09serial8250_em485_free(uart);
> =20
>  =09uart_remove_one_port(&serial8250_reg, &uart->port);
>  =09if (serial8250_isa_devs) {
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 36b2b0a2c05c..3d47f535d6f1 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -574,15 +574,22 @@ static int serial8250_em485_init(struct uart_8250_p=
ort *p)
>  =09if (p->em485)
>  =09=09goto deassert_rts;
> =20
> -=09p->em485 =3D kmalloc_obj(struct uart_8250_em485, GFP_ATOMIC);
> -=09if (!p->em485)
> -=09=09return -ENOMEM;
> +=09if (p->em485_idle) {
> +=09=09p->em485 =3D p->em485_idle;
> +=09=09p->em485_idle =3D NULL;
> +=09} else {
> +=09=09p->em485 =3D kmalloc_obj(struct uart_8250_em485, GFP_ATOMIC);
> +=09=09if (!p->em485)
> +=09=09=09return -ENOMEM;
> =20
> -=09hrtimer_setup(&p->em485->stop_tx_timer, &serial8250_em485_handle_stop=
_tx, CLOCK_MONOTONIC,
> -=09=09      HRTIMER_MODE_REL);
> -=09hrtimer_setup(&p->em485->start_tx_timer, &serial8250_em485_handle_sta=
rt_tx, CLOCK_MONOTONIC,
> -=09=09      HRTIMER_MODE_REL);
> -=09p->em485->port =3D p;
> +=09=09hrtimer_setup(&p->em485->stop_tx_timer,
> +=09=09=09      &serial8250_em485_handle_stop_tx, CLOCK_MONOTONIC,
> +=09=09=09      HRTIMER_MODE_REL);
> +=09=09hrtimer_setup(&p->em485->start_tx_timer,
> +=09=09=09      &serial8250_em485_handle_start_tx, CLOCK_MONOTONIC,
> +=09=09=09      HRTIMER_MODE_REL);
> +=09=09p->em485->port =3D p;
> +=09}
>  =09p->em485->active_timer =3D NULL;
>  =09p->em485->tx_stopped =3D true;
> =20
> @@ -604,6 +611,11 @@ static int serial8250_em485_init(struct uart_8250_po=
rt *p)
>   *=09The function is supposed to be called from .rs485_config callback
>   *=09or from any other callback protected with p->port.lock spinlock.
>   *
> + *=09The handlers of the timers take that lock, so they cannot be waited=
 for
> + *=09here. One which is running does nothing, as no timer is active any =
more.
> + *=09The memory is kept for the next serial8250_em485_init() and freed b=
y
> + *=09serial8250_em485_free().
> + *
>   *=09See also serial8250_em485_init()
>   */
>  void serial8250_em485_destroy(struct uart_8250_port *p)
> @@ -611,14 +623,40 @@ void serial8250_em485_destroy(struct uart_8250_port=
 *p)
>  =09if (!p->em485)
>  =09=09return;
> =20
> -=09hrtimer_cancel(&p->em485->start_tx_timer);
> -=09hrtimer_cancel(&p->em485->stop_tx_timer);
> +=09hrtimer_try_to_cancel(&p->em485->start_tx_timer);
> +=09hrtimer_try_to_cancel(&p->em485->stop_tx_timer);
> +=09p->em485->active_timer =3D NULL;
> =20
> -=09kfree(p->em485);
> +=09p->em485_idle =3D p->em485;
>  =09p->em485 =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(serial8250_em485_destroy);

The name is pretty misleading after this change when all it now does is=20
stop timers.

--
 i.

> =20
> +/**
> + *=09serial8250_em485_free() - release the rs485 emulation of a port
> + *=09@p:=09uart_8250_port port instance
> + *
> + *=09Must be called without p->port.lock, as it waits for the timers.
> + */
> +void serial8250_em485_free(struct uart_8250_port *p)
> +{
> +=09struct uart_8250_em485 *em485;
> +
> +=09scoped_guard(uart_port_lock_irqsave, &p->port) {
> +=09=09serial8250_em485_destroy(p);
> +=09=09em485 =3D p->em485_idle;
> +=09=09p->em485_idle =3D NULL;
> +=09}
> +
> +=09if (!em485)
> +=09=09return;
> +
> +=09hrtimer_cancel(&em485->start_tx_timer);
> +=09hrtimer_cancel(&em485->stop_tx_timer);
> +=09kfree(em485);
> +}
> +EXPORT_SYMBOL_GPL(serial8250_em485_free);
> +
>  struct serial_rs485 serial8250_em485_supported =3D {
>  =09.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_=
AFTER_SEND |
>  =09=09 SER_RS485_TERMINATE_BUS | SER_RS485_RX_DURING_TX,
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index d91c0477be9d..0556bb722db4 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -173,6 +173,7 @@ struct uart_8250_port {
>  =09void=09=09=09(*dl_write)(struct uart_8250_port *up, u32 value);
> =20
>  =09struct uart_8250_em485 *em485;
> +=09struct uart_8250_em485 *em485_idle;=09/* kept while rs485 is off */
>  =09void=09=09=09(*rs485_start_tx)(struct uart_8250_port *up, bool toggle=
_ier);
>  =09void=09=09=09(*rs485_stop_tx)(struct uart_8250_port *up, bool toggle_=
ier);
> =20
>=20
>=20
--8323328-1123129667-1793101174=:1182--
