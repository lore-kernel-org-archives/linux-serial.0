Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503E416ABFA;
	Tue, 28 May 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891955; cv=none; b=iJUytsKlFfyiY915bxKbjVESmrN6nL5/lR/WZr8GoOCwmc8Xt5WTNQ+vnt1OqnYHPUrB8A5KXUuS8NJQhIzMi2ePQj3F1XkMjtfq3CYNTNLGAHkDb5ro9V2M+Km/dOzFjptMdMCnpBzdMQa9zYyAVC3Ow8uUAia1ySehUD9kQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891955; c=relaxed/simple;
	bh=tgPh+RpBIfdWk/QjkJbuJ+eXr/a+KHa8hR+sOmjii/0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GGjRS0uISsQoxbYg5HHrCUGGNVmxaRkl/jS+06otnP3EELy53WZqOLZYYi7kkPVyuajXGrN8ebu+TnRRAPKxirRbs6GXP3N4lzwgvuseIvaoGIbDMNEO5vKWBPq7eDHPg9jfqct4MvBfu7O+STcT7+pM65MlFl6OsDmIymtlDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrzXGd07; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrzXGd07"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716891954; x=1748427954;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tgPh+RpBIfdWk/QjkJbuJ+eXr/a+KHa8hR+sOmjii/0=;
  b=SrzXGd07Yup5olRkgoSxq3XgaCjjSF4Z6qyOzWqmZhl9lqvPUVkonUTs
   GM2BvqKMk5DCfIBy4UIv2AvChx6asP6x1w2Pw2jh0ws1eKQtdb5Np6mvp
   Y67JctYh4pPDW7S9eQw/Y7qT7H6QmrwK19h14Ju9YGGYWFmnkI/S9MtxV
   QWkogBwUq8rw2eiXUK1AhJtgm8oFYATed57EfNQUgcwCcrpzDopwcO9j5
   1w4cXJnO/Mp1y+HPCaJPnN2uIHcdmaR/y2ygPkMDLwVY1Srv8pfIsoJmT
   UoXP1XWDu0WCJTgr6NzB1HczpX6akVdGZynRH43jQBLPfmrbUDds4lIt8
   g==;
X-CSE-ConnectionGUID: 9tbprW8ySRGpoXc+Ayc9hw==
X-CSE-MsgGUID: 4x8U4z09QB6fu3WLHpUslA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="23892143"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="23892143"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 03:25:54 -0700
X-CSE-ConnectionGUID: L9RQ2n1MTXisYN38Q8FxiQ==
X-CSE-MsgGUID: MMTs3l13TW2g4FLH0Q3cJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="65860340"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 03:25:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 May 2024 13:25:45 +0300 (EEST)
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
    Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, imx@lists.linux.dev, 
    linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: imx: stop casting struct uart_port to struct
 imx_port
In-Reply-To: <20240528094022.2161066-1-linux@rasmusvillemoes.dk>
Message-ID: <a38e5be1-bd59-9c49-9cbd-a38016339056@linux.intel.com>
References: <20240528094022.2161066-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-270992698-1716891945=:5869"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-270992698-1716891945=:5869
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 28 May 2024, Rasmus Villemoes wrote:

> struct imx_port does have a struct uart_port as its first member, so
> the current code works, but it is not how kernel code is usually
> written.
>=20
> Similar to many other serial drivers, introduce and use a
> to_imx_port() helper based on container_of(). No functional change.
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

>  drivers/tty/serial/imx.c | 41 ++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 2eb22594960f..f5cfe5571e0e 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -264,6 +264,11 @@ static const struct of_device_id imx_uart_dt_ids[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(of, imx_uart_dt_ids);
> =20
> +static inline struct imx_port *to_imx_port(struct uart_port *port)
> +{
> +        return container_of(port, struct imx_port, port);
> +}
> +
>  static inline void imx_uart_writel(struct imx_port *sport, u32 val, u32 =
offset)
>  {
>  =09writel(val, sport->port.membase + offset);
> @@ -377,7 +382,7 @@ static void imx_uart_disable_loopback_rs485(struct im=
x_port *sport)
>  /* called with port.lock taken and irqs off */
>  static void imx_uart_start_rx(struct uart_port *port)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09unsigned int ucr1, ucr2;
> =20
>  =09ucr1 =3D imx_uart_readl(sport, UCR1);
> @@ -401,7 +406,7 @@ static void imx_uart_start_rx(struct uart_port *port)
>  /* called with port.lock taken and irqs off */
>  static void imx_uart_stop_tx(struct uart_port *port)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09u32 ucr1, ucr4, usr2;
> =20
>  =09if (sport->tx_state =3D=3D OFF)
> @@ -466,7 +471,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
> =20
>  static void imx_uart_stop_rx_with_loopback_ctrl(struct uart_port *port, =
bool loopback)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09u32 ucr1, ucr2, ucr4, uts;
> =20
>  =09ucr1 =3D imx_uart_readl(sport, UCR1);
> @@ -511,7 +516,7 @@ static void imx_uart_stop_rx(struct uart_port *port)
>  /* called with port.lock taken and irqs off */
>  static void imx_uart_enable_ms(struct uart_port *port)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
> =20
>  =09mod_timer(&sport->timer, jiffies);
> =20
> @@ -662,7 +667,7 @@ static void imx_uart_dma_tx(struct imx_port *sport)
>  /* called with port.lock taken and irqs off */
>  static void imx_uart_start_tx(struct uart_port *port)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09struct tty_port *tport =3D &sport->port.state->port;
>  =09u32 ucr1;
> =20
> @@ -1043,7 +1048,7 @@ static irqreturn_t imx_uart_int(int irq, void *dev_=
id)
>   */
>  static unsigned int imx_uart_tx_empty(struct uart_port *port)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09unsigned int ret;
> =20
>  =09ret =3D (imx_uart_readl(sport, USR2) & USR2_TXDC) ?  TIOCSER_TEMT : 0=
;
> @@ -1058,7 +1063,7 @@ static unsigned int imx_uart_tx_empty(struct uart_p=
ort *port)
>  /* called with port.lock taken and irqs off */
>  static unsigned int imx_uart_get_mctrl(struct uart_port *port)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09unsigned int ret =3D imx_uart_get_hwmctrl(sport);
> =20
>  =09mctrl_gpio_get(sport->gpios, &ret);
> @@ -1069,7 +1074,7 @@ static unsigned int imx_uart_get_mctrl(struct uart_=
port *port)
>  /* called with port.lock taken and irqs off */
>  static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctr=
l)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09u32 ucr3, uts;
> =20
>  =09if (!(port->rs485.flags & SER_RS485_ENABLED)) {
> @@ -1112,7 +1117,7 @@ static void imx_uart_set_mctrl(struct uart_port *po=
rt, unsigned int mctrl)
>   */
>  static void imx_uart_break_ctl(struct uart_port *port, int break_state)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09unsigned long flags;
>  =09u32 ucr1;
> =20
> @@ -1434,7 +1439,7 @@ static void imx_uart_disable_dma(struct imx_port *s=
port)
> =20
>  static int imx_uart_startup(struct uart_port *port)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09int retval;
>  =09unsigned long flags;
>  =09int dma_is_inited =3D 0;
> @@ -1548,7 +1553,7 @@ static int imx_uart_startup(struct uart_port *port)
> =20
>  static void imx_uart_shutdown(struct uart_port *port)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09unsigned long flags;
>  =09u32 ucr1, ucr2, ucr4, uts;
> =20
> @@ -1622,7 +1627,7 @@ static void imx_uart_shutdown(struct uart_port *por=
t)
>  /* called with port.lock taken and irqs off */
>  static void imx_uart_flush_buffer(struct uart_port *port)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09struct scatterlist *sgl =3D &sport->tx_sgl[0];
> =20
>  =09if (!sport->dma_chan_tx)
> @@ -1649,7 +1654,7 @@ static void
>  imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>  =09=09     const struct ktermios *old)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09unsigned long flags;
>  =09u32 ucr2, old_ucr2, ufcr;
>  =09unsigned int baud, quot;
> @@ -1852,7 +1857,7 @@ imx_uart_verify_port(struct uart_port *port, struct=
 serial_struct *ser)
> =20
>  static int imx_uart_poll_init(struct uart_port *port)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09unsigned long flags;
>  =09u32 ucr1, ucr2;
>  =09int retval;
> @@ -1901,7 +1906,7 @@ static int imx_uart_poll_init(struct uart_port *por=
t)
> =20
>  static int imx_uart_poll_get_char(struct uart_port *port)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09if (!(imx_uart_readl(sport, USR2) & USR2_RDR))
>  =09=09return NO_POLL_CHAR;
> =20
> @@ -1910,7 +1915,7 @@ static int imx_uart_poll_get_char(struct uart_port =
*port)
> =20
>  static void imx_uart_poll_put_char(struct uart_port *port, unsigned char=
 c)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09unsigned int status;
> =20
>  =09/* drain */
> @@ -1932,7 +1937,7 @@ static void imx_uart_poll_put_char(struct uart_port=
 *port, unsigned char c)
>  static int imx_uart_rs485_config(struct uart_port *port, struct ktermios=
 *termios,
>  =09=09=09=09 struct serial_rs485 *rs485conf)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
>  =09u32 ucr2;
> =20
>  =09if (rs485conf->flags & SER_RS485_ENABLED) {
> @@ -1986,7 +1991,7 @@ static struct imx_port *imx_uart_ports[UART_NR];
>  #if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
>  static void imx_uart_console_putchar(struct uart_port *port, unsigned ch=
ar ch)
>  {
> -=09struct imx_port *sport =3D (struct imx_port *)port;
> +=09struct imx_port *sport =3D to_imx_port(port);
> =20
>  =09while (imx_uart_readl(sport, imx_uart_uts_reg(sport)) & UTS_TXFULL)
>  =09=09barrier();
>=20

--8323328-270992698-1716891945=:5869--
