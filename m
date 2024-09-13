Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C82E17BED3;
	Fri, 13 Sep 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219038; cv=none; b=ZFFhMKtQ29a+/UbJ0WjHek+s2Ff3s7WKgUAMvVJx/nRLzldRRZPuaqeOzMUZvIhCy5SoiCcLXP6bxsBf6/f6IbaTqzi1S6CY+RBitm8D9z7/h9FJWcSoyi+OY/m5fmoPz/6uh7k+cmLPTI5luVM+fqiqhu3te4hVbZrVHTmXOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219038; c=relaxed/simple;
	bh=hMrF5SdlF17xoZq+/VZGpcQOWFrPq9ZfR0YLyh5OhxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ES9CTA4KE89yA/Snb55AwkC1J3expthpAzRAx7hP6N+B/a0z2mY05sIZTsS7zRIDJst4bqq2+9OC8fHxon1/NiRPwhEjaJNaqxA1es5ZAJZyggUnWRj3PfD+t6xNv/lgRQoq/i17qAnMk4ROJgW7zkHpyujQL2lEDrueO8ovHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ifQfiAOG; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=EAnQmZSI reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ifQfiAOG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EAnQmZSI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726219034; x=1757755034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5nyRXAZtZaPgsiU9hSdOI+jFy3OJbheXoiy71LlZp5k=;
  b=ifQfiAOGMXQzFKFawuLMUdgqcSAwoaJbhomjZ0Ere9sAltj26uyJOCCZ
   1c9Im0F4bxvaZbGLDEsXfXVU3vxlyNnEIwJeMxT6sfrlidmFe+XDF6dKf
   VWUS1si2lz7CWAb21gcmQ9Rd42gUigXPOZWB7ru4BNzHnBoOWF7WTFBYY
   LkGJTVo/jlUvjw9vUhb6My7sxIYROX4pyeeQ4MzeZOaxDcfYHgDoJI4D5
   lRFQuTyAs8TFS1pjmsrwE/76J3AnkYbjyZjyO5thLRbMb5jXTcX8hsPS2
   vEEbMJGOPNNF13FX7oGCkali0Kx40sM9km7s0T6evs0wwf4b9ErmLvPmq
   g==;
X-CSE-ConnectionGUID: p+R67PyMQLOUJgOdcEoSbQ==
X-CSE-MsgGUID: XvVlXnRDRI6dXMCAF3adjg==
X-IronPort-AV: E=Sophos;i="6.10,225,1719871200"; 
   d="scan'208";a="38929837"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Sep 2024 11:17:10 +0200
X-CheckPoint: {66E40316-20-5FF8EC80-F6CEE9F8}
X-MAIL-CPID: 74791384B45C96BF1AA1857C48273692_0
X-Control-Analysis: str=0001.0A782F1D.66E40317.0096,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76CBA167CB0;
	Fri, 13 Sep 2024 11:17:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726219026;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5nyRXAZtZaPgsiU9hSdOI+jFy3OJbheXoiy71LlZp5k=;
	b=EAnQmZSII4QJyrFQEhdzwtL9szLD0RYPMLcU4Q/LY4fcWXEfOzariAmcCYgUfGM9JQeKDZ
	2j2Ap9VUdwJYLTfL6DuZu2932doAJUwzCuF0B0lZPZJ2zd/RzfjD7a/1Y9XY+YVdW8ShtW
	vltqnbGcxVnuvBYvydqEir6CO5HinkmwGXUccMbpUJSG+e70HkTxwgVI/WpNw6+8Y6cZaH
	Hlkv6Ync38Phss+7eDwPe3w3CbLVTCq9rusbSxGWI1k8PdR0Uw5E2LZM6ZNhy+pnW0q7rW
	0Hy1KbF56hSS/EkGSX9g0JVL+i4c8ia0sGTZE87mxI9A16F952cTBPBTb/+5zA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, John Ogness <john.ogness@linuxtronix.de>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Esben Haabendal <esben@geanix.com>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH 2/2] serial: imx: Add more comments on port lock status
Date: Fri, 13 Sep 2024 11:17:04 +0200
Message-ID: <2200890.irdbgypaU6@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240913-serial-imx-lockfix-v1-2-4d102746c89d@geanix.com>
References: <20240913-serial-imx-lockfix-v1-0-4d102746c89d@geanix.com> <20240913-serial-imx-lockfix-v1-2-4d102746c89d@geanix.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Freitag, 13. September 2024, 10:39:50 CEST schrieb Esben Haabendal:
> Comments regarding status of port.lock on internal functions is useful wh=
en
> reviewing correct handling of registers that must be protected by this
> lock.
>=20
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/tty/serial/imx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index efa3eb3a2c57..bea4510743ef 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -370,6 +370,7 @@ static void imx_uart_soft_reset(struct imx_port *spor=
t)
>  	sport->idle_counter =3D 0;
>  }
> =20
> +/* called with port.lock taken and irqs off */
>  static void imx_uart_disable_loopback_rs485(struct imx_port *sport)
>  {
>  	unsigned int uts;

I think you are referring to sport.lock. On the other hand, instead of
just adding comments, wouldn't it be better to make it explicit?
Adding=20
> lockdep_assert_held(&sport->port->lock);
and/or sparse annoations
> __must_hold(&sport->port->lock)

seems more reasonable to me than adding non-enforcing comments.

Best regards,
Alexander

> @@ -470,6 +471,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
>  	}
>  }
> =20
> +/* called with port.lock taken and irqs off */
>  static void imx_uart_stop_rx_with_loopback_ctrl(struct uart_port *port, =
bool loopback)
>  {
>  	struct imx_port *sport =3D to_imx_port(port);
> @@ -803,6 +805,8 @@ static irqreturn_t imx_uart_txint(int irq, void *dev_=
id)
>   * issuing soft reset to the UART (just stop/start of RX does not help).=
 Note
>   * that what we do here is sending isolated start bit about 2.4 times sh=
orter
>   * than it is to be on UART configured baud rate.
> + *
> + * Called with port.lock taken and irqs off.
>   */
>  static void imx_uart_check_flood(struct imx_port *sport, u32 usr2)
>  {
> @@ -838,6 +842,7 @@ static void imx_uart_check_flood(struct imx_port *spo=
rt, u32 usr2)
>  	}
>  }
> =20
> +/* called with port.lock taken and irqs off */
>  static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>  {
>  	struct imx_port *sport =3D dev_id;
> @@ -916,6 +921,7 @@ static void imx_uart_clear_rx_errors(struct imx_port =
*sport);
>  /*
>   * We have a modem side uart, so the meanings of RTS and CTS are inverte=
d.
>   */
> +/* called with port.lock taken and irqs off */
>  static unsigned int imx_uart_get_hwmctrl(struct imx_port *sport)
>  {
>  	unsigned int tmp =3D TIOCM_DSR;
> @@ -938,6 +944,8 @@ static unsigned int imx_uart_get_hwmctrl(struct imx_p=
ort *sport)
> =20
>  /*
>   * Handle any change of modem status signal since we were last called.
> + *
> + * Called with port.lock taken and irqs off.
>   */
>  static void imx_uart_mctrl_check(struct imx_port *sport)
>  {
> @@ -1277,6 +1285,7 @@ static int imx_uart_start_rx_dma(struct imx_port *s=
port)
>  	return 0;
>  }
> =20
> +/* called with port.lock taken and irqs off */
>  static void imx_uart_clear_rx_errors(struct imx_port *sport)
>  {
>  	struct tty_port *port =3D &sport->port.state->port;
> @@ -1407,6 +1416,7 @@ static int imx_uart_dma_init(struct imx_port *sport)
>  	return ret;
>  }
> =20
> +/* called with port.lock taken and irqs off */
>  static void imx_uart_enable_dma(struct imx_port *sport)
>  {
>  	u32 ucr1;
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


