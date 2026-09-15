Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1EA431A3E;
	Tue, 15 Sep 2026 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472843; cv=none; b=vBoKc5yR3jg5zKSvWw366bshkHwrWCi25lvezC59p5WV/tTsMLbZaoQ42p7rlccbFsL7vI8EJTgdUsLco6f1M6Av3SZCNb+2Z+hDs/s5zuFjrWZ5BzvEehxeF9g6l9O7nPhxZaKOVlL5wmPNlnSek8uDN4pgwEAT/r6LosoHCeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472843; c=relaxed/simple;
	bh=deAw/7TDEohbf1HV3Iyjt4R4cZRwIuWCKoEuiGhjWkQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iFsQ1A07ueIm654wps1j1cQNCKI8n1OUSL/YTtsvFylzLNTYJvB90QJ74Y0y6jSDbJaFKecXg928h5hX8T9l5l4rbVm3H8r8A9KsWpk87H62seicBxUKuhoKZZU5afqxC/pmRO0IdFUyQYowJAIxvVl5DJJnh5ou30oJ9vA1FYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4a+k1mr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4a+k1mr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789472842; x=1821008842;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=deAw/7TDEohbf1HV3Iyjt4R4cZRwIuWCKoEuiGhjWkQ=;
  b=D4a+k1mrnJqwP5UriUKJC/Qt9VT2LHtQN4GdkQC+1bOskFFcXNB4n4ju
   2xdE2BAO5CVnqcxUxL8S1jHBSSXF9CDsGuxm07AmItc4VpcJpaC8LYD03
   ebJFlcGz1r0xcTE6Ii9Jo7+WKKXQb73QaAB6pOgo7FbI9O832TZV227e6
   obYW+4qCN3vMXHY2VqVLAZ7vJywgCGfAI4iYdmPAxcdafsR4W2uVj/ZRt
   SGnp7NnsuYZ2nuBWBEs9J3MqB6xNS7zPJqYhPtqutCp2f1emY8xFGLkPP
   PIfHLdWnDjTwuOqXElqmHvO3FX1c1xQVI+8aqh2gCEJO14a56B7uPC0uZ
   g==;
X-CSE-ConnectionGUID: neXevzuFQsydzvL9nHCVjg==
X-CSE-MsgGUID: kJYf5XdWSyi86gsP62WSqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88967167"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88967167"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 04:47:21 -0700
X-CSE-ConnectionGUID: G6cPanw3St+oo08ir6C0kQ==
X-CSE-MsgGUID: Z+tNzAXeQFy/qftCJFxY9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="311254377"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 04:47:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 15 Sep 2026 14:47:07 +0300 (EEST)
To: Long Zhao <longzhao@ambarella.com>
cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
    linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Michael Turquette <mturquette@baylibre.com>, 
    Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
    Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Long Zhao <zl020895@163.com>, Lee Jones <lee@kernel.org>, 
    mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
    linux-gpio@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 13/15] serial: 8250_dw: add Ambarella CV75 quirks
In-Reply-To: <20260915-cv75-v5-v7-13-3297d3fbc9c0@ambarella.com>
Message-ID: <4eca948b-ebf7-ee86-78e8-af886f19ed0c@linux.intel.com>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com> <20260915-cv75-v5-v7-13-3297d3fbc9c0@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-710529132-1789472827=:1365"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-710529132-1789472827=:1365
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 15 Sep 2026, Long Zhao via B4 Relay wrote:

> From: Long Zhao <longzhao@ambarella.com>
>=20
> The Ambarella CV75 UART is Ambarella IP, not a Synopsys DesignWare
> licensed block. At the register level it is close enough to DW APB UART
> that a full custom UART driver is unnecessary: reuse 8250_dw with a
> small platform quirk.
>=20
> Quirks:
> - keep IER ETOI (bit 5) set for RX timeout behaviour
> - skip set_rate; baud clock is managed outside the UART block
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index 5fba913f3301..19431c476c55 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -43,6 +43,9 @@
>  #define RZN1_UART_xDMACR_8_WORD_BURST=09(2 << 1)
>  #define RZN1_UART_xDMACR_BLK_SZ(x)=09((x) << 3)
> =20
> +/* Ambarella IER: receive timeout interrupt enable */
> +#define AMBARELLA_UART_IER_ETOI=09=09BIT(5)
> +
>  /* Quirks */
>  #define DW_UART_QUIRK_OCTEON=09=09BIT(0)
>  #define DW_UART_QUIRK_ARMADA_38X=09BIT(1)
> @@ -60,6 +63,7 @@
> =20
>  struct dw8250_platform_data {
>  =09u8 usr_reg;
> +=09u8 ier_mask;
>  =09u32 cpr_value;
>  =09unsigned int quirks;
>  };
> @@ -572,6 +576,25 @@ static void dw8250_prepare_rx_dma(struct uart_8250_p=
ort *p)
>  =09dw8250_writel_ext(up, RZN1_UART_RDMACR, val);
>  }
> =20
> +static int dw8250_ier_mask_startup(struct uart_port *p)
> +{
> +=09struct dw8250_data *d =3D to_dw8250_data(p->private_data);
> +=09struct uart_8250_port *up =3D up_to_u8250p(p);
> +=09int ret;
> +
> +=09ret =3D serial8250_do_startup(p);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/*
> +=09 * Ambarella keeps variant IER bits (e.g. ETOI) set for correct RX
> +=09 * timeout behaviour.
> +=09 */
> +=09up->ier |=3D d->pdata->ier_mask;
> +
> +=09return 0;
> +}
> +
>  static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>  {
>  =09unsigned int quirks =3D data->pdata->quirks;
> @@ -606,6 +629,8 @@ static void dw8250_quirks(struct uart_port *p, struct=
 dw8250_data *data)
>  =09=09p->serial_in =3D dw8250_serial_in32;
>  =09=09data->uart_16550_compatible =3D true;
>  =09}
> +=09if (data->pdata->ier_mask)
> +=09=09p->startup =3D dw8250_ier_mask_startup;
>  }
> =20
>  static void dw8250_reset_control_assert(void *data)
> @@ -879,6 +904,12 @@ static const struct dw8250_platform_data dw8250_intc=
10ee =3D {
>  =09.quirks =3D DW_UART_QUIRK_IER_KICK,
>  };
> =20
> +static const struct dw8250_platform_data dw8250_ambarella_cv75_data =3D =
{
> +=09.usr_reg =3D DW_UART_USR,
> +=09.ier_mask =3D AMBARELLA_UART_IER_ETOI,
> +=09.quirks =3D DW_UART_QUIRK_SKIP_SET_RATE,
> +};
> +
>  static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data =
=3D {
>  =09.usr_reg =3D DW_UART_USR,
>  =09.cpr_value =3D FIELD_PREP_CONST(DW_UART_CPR_ABP_DATA_WIDTH, 2) |
> @@ -889,6 +920,7 @@ static const struct dw8250_platform_data dw8250_ultra=
risc_dp1000_data =3D {
>  };
> =20
>  static const struct of_device_id dw8250_of_match[] =3D {
> +=09{ .compatible =3D "ambarella,cv75-uart", .data =3D &dw8250_ambarella_=
cv75_data },
>  =09{ .compatible =3D "snps,dw-apb-uart", .data =3D &dw8250_dw_apb },
>  =09{ .compatible =3D "cavium,octeon-3860-uart", .data =3D &dw8250_octeon=
_3860_data },
>  =09{ .compatible =3D "marvell,armada-38x-uart", .data =3D &dw8250_armada=
_38x_data },

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-710529132-1789472827=:1365--
