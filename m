Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352498;
	b=uDncOWixGbxpXmUMF3mTDHcC4WK+bAHdOApjd+uOWdxBH/3x4Lodc4WWxPm4G9Of7W8t
	 q1l1tySckFEEu4lECK+zqYsb4IauSybxbiu0qvXGA/nH6efliJ2Nc70GDMzWrAt2BA9WF
	 7nyQpUn2gC3FXOaIoCa4h/xWdUgwqhZm0gHOcGWH1vHwYylTWEY2ZYOILCd4y0cWwpHeH
	 ZrHpUMNxOmTkknp6fTgB0GHWKWuZ3CcpuWxsnk2WPNDwQyYQ09fOvfdR1tDL942sXXrDf
	 JdX5He7oInyLbUcYqPVQgcf6tDIbF5lafJym0iSWp13J8E/gdLuDbcjBWKll95K7+5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352498;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=njqMJnp6/HE68bbK6MSV2Wy4GJh92K9iO3Rz8LAhcKo=;
	b=shy9RrgzNPmIIlrzNjZFy1D+QoC4npxByUz9oLPq/CfhCrqLSJ0Qei8eJ/XrgxaxcTeg
	 v6dYc8a/lDg0qW6oSVBCiVt1/bp8eJWHatWe7wAIYkLwUtlKJVkN+8J5Y8x/JS3C5+Q26
	 +lCcALjOO+ghHnaCcWppMXJe68TnB0N8ua74Xw60WqI/OW2rqKGhz9yipJBEgfwv7Czao
	 ASqmYfuG3lgpHmcTIKiBIO5aJ7edm1URjll4+a/G/Ju7VeutYmZm4JusX2aeVJw1so6Rq
	 M8Ok/U96dCgCEno37xY/xgHlPkKV+en6Hp6QoHDO9lDl6Q7ffxVngsT7vLSbUkcttSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Uh4C+0ff;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A653606A31C;
	Fri, 30 Oct 2026 09:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A653606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Uh4C+0ff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793352498; x=1824888498;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=s0MvRPb2Qurw45msDO/DZM5UC5qzvS3+BVl3NGmaV+0=;
  b=Uh4C+0ff3T4WI3ajL4CuYCZSfFD0TNuzWkrLEb3gwT4TGERtTIdDslgP
   NC8FQ0OzXCeNpuS9/rQvBOuEyEBy0Szj8XTYeRFoVCT4GipBon66kzsmU
   Kq/unc9sKDCuB7SMVWtA02LW6J4oCxqE6FFaAh+Bk5QFDe3QhaGFCDCOj
   JQXGJom2USC9qtIVcCkXzY3e2SixddvLkQjqF8PsnIdLL7UGrQQ+2gc59
   OG2Qb7WP8LF8aq59+X/ghK0NuLySByjuYctuuKbEwN6KUYt+vl2SuMiCB
   s5p5hycS+Ae7D1HZVl4I1dUXvLHiDXZf9csm8ZW/yhDLPZkHJ/BPPrN2A
   Q==;
X-CSE-ConnectionGUID: L3DLwNl4T6Okn4hWzFelkA==
X-CSE-MsgGUID: GFApqLRSTEWY4nKIlbJSYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1988997"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="1988997"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:28:18 -0700
X-CSE-ConnectionGUID: 5OZpA/gSQiyytTYeB5Xo7w==
X-CSE-MsgGUID: NN2wxNBBT5GP6Izv2MSDIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5350236"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:28:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Oct 2026 11:28:09 +0200 (EET)
To: James Hilliard <james.hilliard1@gmail.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
    Jernej Skrabec <jernej.skrabec@gmail.com>, 
    Samuel Holland <samuel@sholland.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v5 1/8] serial: 8250_dw: select port setup through platform
 data
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-1-53b433aebbf8@gmail.com>
Message-ID: <30123495-5e2a-4340-baac-abab8d511000@linux.intel.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com> <20261029-submit-h616-uart-fifo-v1-v5-1-53b433aebbf8@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-295185156-1793352489=:1187"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-295185156-1793352489=:1187
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 29 Oct 2026, James Hilliard wrote:

> Select feature discovery and DMA attachment through a platform-data setup
> callback. The generic callback probes the optional registers and attaches
> DMA when a FIFO size is available. Integrations with a fixed configuratio=
n
> can supply their own setup before the port is registered. Allow setup to
> return an error so integrations can reject invalid configuration before
> registration.
>=20
> Replace skip_autocfg with the Octeon setup selection. Octeon is a 64-bit
> platform and continues to skip optional-register probing while retaining
> its DMA setup. Select the DMA setup helper directly for this integration.
> Keep generic setup for devices without matched platform data as well.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 41 ++++++++++++++++++++++++++++-----=
------
>  1 file changed, 30 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index 9cbe076463e0..a546cf2de7b6 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -64,6 +64,7 @@ struct dw8250_platform_data {
>  =09u8 usr_reg;
>  =09u32 cpr_value;
>  =09unsigned int quirks;
> +=09int (*setup)(struct uart_port *p);
>  };
> =20
>  struct dw8250_data {
> @@ -76,7 +77,6 @@ struct dw8250_data {
>  =09struct clk=09=09*pclk;
>  =09struct reset_control=09*rst;
> =20
> -=09unsigned int=09=09skip_autocfg:1;
>  =09unsigned int=09=09uart_16550_compatible:1;
>  =09unsigned int=09=09in_idle:1;
> =20
> @@ -596,7 +596,6 @@ static void dw8250_quirks(struct uart_port *p, struct=
 dw8250_data *data)
>  =09=09p->serial_out =3D dw8250_serial_outq;
>  =09=09p->flags =3D UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
>  =09=09p->type =3D PORT_OCTEON;
> -=09=09data->skip_autocfg =3D true;
>  =09}
>  #endif
> =20
> @@ -631,6 +630,28 @@ static void dw8250_shutdown(struct uart_port *port)
>  =09d->no_int_count =3D 0;
>  }
> =20
> +static int dw8250_setup_dma(struct uart_port *p)
> +{
> +=09struct dw8250_data *data =3D to_dw8250_data(p->private_data);
> +=09struct uart_8250_port *up =3D up_to_u8250p(p);
> +
> +=09/* DMA setup requires a FIFO */
> +=09if (!p->fifosize)
> +=09=09return 0;
> +
> +=09data->data.dma.rxconf.src_maxburst =3D p->fifosize / 4;
> +=09data->data.dma.txconf.dst_maxburst =3D p->fifosize / 4;
> +=09up->dma =3D &data->data.dma;
> +
> +=09return 0;
> +}
> +
> +static int dw8250_setup(struct uart_port *p)
> +{
> +=09dw8250_setup_port(p);
> +=09return dw8250_setup_dma(p);
> +}
> +
>  static int dw8250_probe(struct platform_device *pdev)
>  {
>  =09struct uart_8250_port uart =3D {}, *up =3D &uart;
> @@ -765,19 +786,16 @@ static int dw8250_probe(struct platform_device *pde=
v)
> =20
>  =09dw8250_setup_dma_filter(p, data);
> =20
> -=09if (!data->skip_autocfg)
> -=09=09dw8250_setup_port(p);
> +=09if (data->pdata && data->pdata->setup)
> +=09=09err =3D data->pdata->setup(p);
> +=09else
> +=09=09err =3D dw8250_setup(p);
> +=09if (err)
> +=09=09return err;
> =20
>  =09/* Use the BUSY-safe sequence for both integer and fractional divisor=
s. */
>  =09p->set_divisor =3D dw8250_set_divisor;
> =20
> -=09/* If we have a valid fifosize, try hooking up DMA */
> -=09if (p->fifosize) {
> -=09=09data->data.dma.rxconf.src_maxburst =3D p->fifosize / 4;
> -=09=09data->data.dma.txconf.dst_maxburst =3D p->fifosize / 4;
> -=09=09up->dma =3D &data->data.dma;
> -=09}
> -
>  =09data->data.uport =3D serial8250_register_8250_port(up);
>  =09if (IS_ERR(data->data.uport))
>  =09=09return PTR_ERR(data->data.uport);
> @@ -860,6 +878,7 @@ static const struct dw8250_platform_data dw8250_dw_ap=
b =3D {
>  static const struct dw8250_platform_data dw8250_octeon_3860_data =3D {
>  =09.usr_reg =3D OCTEON_UART_USR,
>  =09.quirks =3D DW_UART_QUIRK_OCTEON,
> +=09.setup =3D dw8250_setup_dma,
>  };
> =20
>  static const struct dw8250_platform_data dw8250_armada_38x_data =3D {

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-295185156-1793352489=:1187--
