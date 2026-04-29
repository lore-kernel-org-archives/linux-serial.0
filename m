Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552EE154425;
	Wed, 29 Apr 2026 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460125; cv=none; b=Tua135pBPwIJOTzEdtGV+3FuFVNBXW03Cg7iYybJxlwLqqf3TkTY6PGjA9fN4sT1cLCJbXy0LHQvKlXpdv2au0+gkrD1Kkr6KYx1etJPuSv4LHCBkmrdEiNLud2TGrm7+0utIBna13QrOr0oCVtpZYHEdGV0oSX2mMCfV09gc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460125; c=relaxed/simple;
	bh=QANXounuzkuFspZS0EBxjHhEE3xoQ7mCoC1U0Ehjids=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ydf1+NyKK6rc0rjtktCnoF/YsYP1JlzCpqNEeH+owyw0sXFK0CSUZsIgcLCdC9ZoxopKAq4rvJJDm2gNELfERa0mS0UpzfQxBSzA1E5D/+f2ZNL8bVJL+/RwBDT+IspN6W9t/DAR0GDvhiPTsdTwN9SdtOYYwMRLLdLIcvDj2P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKXToDcg; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKXToDcg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777460125; x=1808996125;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QANXounuzkuFspZS0EBxjHhEE3xoQ7mCoC1U0Ehjids=;
  b=OKXToDcgDd+gNbORRsaO3RJcMZsdBLVX8taif30xfwP/CiZh2aA7Xz0r
   pc470volDjJU0s++kAXaw6X3zSII3gHneEpuwRx1L+ohtGJvBU1HwGcqb
   Adz7KP+arRbdhJEAwspLAYQEVT1G+FjksoH2I6Rlnrgk1GAKIE9WKmg79
   KpXm4Th+rUff5ruXppBBCpG/g35Dan3+4wnn9aCxyxc1ifuLqHimlwGmV
   bWND/xT8GxLtbOVNUli8XGfFyYTCtylnLtkEaOJ4YO4G5/mc/nyoGfeHT
   3G/8mdwNQo00ipNjohMmvRYOJumkMT2phDH7dVvPi1hx1lbRiwixyflld
   A==;
X-CSE-ConnectionGUID: WQ3NJJGER7+dSpcuupj46A==
X-CSE-MsgGUID: VhEt53B9SVqvu146XIWvFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="101047263"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="101047263"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 03:55:12 -0700
X-CSE-ConnectionGUID: 2ov17KlCQWKWvrNs5yz2kg==
X-CSE-MsgGUID: ny0tfrM2RY+zSF/08m4Y4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229887480"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 03:55:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 29 Apr 2026 13:55:03 +0300 (EEST)
To: Jia Wang <wangjia@ultrarisc.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 4/4] serial: 8250_dw: Use a fixed CPR value for
 UltraRISC DP1000 UART
In-Reply-To: <20260429-ultrarisc-serial-v7-4-e475cce9e274@ultrarisc.com>
Message-ID: <66f322a7-70c5-13f9-3e97-6d0b18193f91@linux.intel.com>
References: <20260429-ultrarisc-serial-v7-0-e475cce9e274@ultrarisc.com> <20260429-ultrarisc-serial-v7-4-e475cce9e274@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-392823364-1777460103=:966"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-392823364-1777460103=:966
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 29 Apr 2026, Jia Wang wrote:

> The UltraRISC DP1000 UART does not provide the standard CPR register used
> by 8250_dw to discover port capabilities.
>=20
> Provide a fixed CPR value for the DP1000-specific compatible so the
> driver can configure the port correctly.
>=20
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index 480f82d89856..55e40c10f46a 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -959,6 +959,15 @@ static const struct dw8250_platform_data dw8250_intc=
10ee =3D {
>  =09.quirks =3D DW_UART_QUIRK_IER_KICK,
>  };
> =20
> +static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data =
=3D {
> +=09.usr_reg =3D DW_UART_USR,
> +=09.cpr_value =3D FIELD_PREP_CONST(DW_UART_CPR_ABP_DATA_WIDTH, 2) |
> +=09=09     DW_UART_CPR_THRE_MODE |
> +=09=09     DW_UART_CPR_DMA_EXTRA |
> +=09=09     DW_UART_CPR_FIFO_MODE_FROM_SIZE(32),
> +=09.quirks =3D DW_UART_QUIRK_CPR_VALUE,

Thanks for all the effort you put to this series,

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Unrelated to this patch, I suppose we wouldn't strictly need to have=20
DW_UART_QUIRK_CPR_VALUE in this driver as non-zero .cpr_value should be=20
enough to decide if the CPR quirk should be used or not (if the code is=20
adapted, obviously).

> +};
> +
>  static const struct of_device_id dw8250_of_match[] =3D {
>  =09{ .compatible =3D "snps,dw-apb-uart", .data =3D &dw8250_dw_apb },
>  =09{ .compatible =3D "cavium,octeon-3860-uart", .data =3D &dw8250_octeon=
_3860_data },
> @@ -966,6 +975,7 @@ static const struct of_device_id dw8250_of_match[] =
=3D {
>  =09{ .compatible =3D "renesas,rzn1-uart", .data =3D &dw8250_renesas_rzn1=
_data },
>  =09{ .compatible =3D "sophgo,sg2044-uart", .data =3D &dw8250_skip_set_ra=
te_data },
>  =09{ .compatible =3D "starfive,jh7100-uart", .data =3D &dw8250_skip_set_=
rate_data },
> +=09{ .compatible =3D "ultrarisc,dp1000-uart", .data =3D &dw8250_ultraris=
c_dp1000_data },
>  =09{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, dw8250_of_match);
>=20
>=20

--=20
 i.

--8323328-392823364-1777460103=:966--
