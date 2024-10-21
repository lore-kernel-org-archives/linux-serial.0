Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859A71E105F;
	Mon, 21 Oct 2024 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500769; cv=none; b=WcOwjjdNYdT8oZ+Y1ka8If8Je/yWRT4n8yaeR9XrCzUb/VpUjeLC8fjlVGy89YKNsL651gakRx+/xERV94pOQ2kGC2stauHHYmp3EwKDBD/U3qp3uWRn/vm4blDZTwumMg4FhuCgw0JaOLyOPjSD0WR/9HvIApzD1pfnSkLAF+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500769; c=relaxed/simple;
	bh=KNa0CDt5hAs5PcllatEa5gYmNjWVk13nA+som17lvEw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TWenjBrIewtL50Fuw0684jkykojUCFhNZxbXhV6oXToD/pTw1n72neoVPHvp/x2YdDVxd+1B8t4FxGVEv9KecR7YZFXQBhRMWPjvmvIISCCr8DC82H7ZDNxbBOa8WqFnvL7T6LJpuybJnIllOvJRBm/++Pr5UBUpT6YUYWh1BLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/LpwdAY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/LpwdAY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729500768; x=1761036768;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=KNa0CDt5hAs5PcllatEa5gYmNjWVk13nA+som17lvEw=;
  b=i/LpwdAYvOQralZ3S5JKldq0lsf0siXOXZZNl4OxS85aFN7DblD40UWw
   NefVn3wIi/+LKHi78S9sLOroFgXbWrwsYbnB7jim2naQDjiR4gFIZsepK
   RgyFBwspMh8k4j6gX9OWJuRPmVJktfh9RBArRPfAqFFLqKlhQXffpS1Qq
   CtijAVaE5axSGabnu5/VP50KF2juv8Csz2DvlQ06p2avewF1eDH5xmFpg
   XFSdX7rgu4MJhQ/MttRXJLNTSs2xf1zOHz5wTqZaKQ7gpFLgfj1eHbDh0
   z4c7R1MCLl6hwWwAX8b4g3Vu0KsqDIBJw7hoT3SD7rUGuFtQGacFyM5cu
   Q==;
X-CSE-ConnectionGUID: AkfrRo6QSa2XFDhXwbJOvg==
X-CSE-MsgGUID: qItG1Wp2TMuNmXSM1s9YqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="16604862"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="16604862"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:52:47 -0700
X-CSE-ConnectionGUID: lYTVu2RJSu+j3md2eBbt4w==
X-CSE-MsgGUID: U9eAezjBT1u8LdoFbVn67A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="102782076"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:52:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Oct 2024 11:52:38 +0300 (EEST)
To: Inochi Amaoto <inochiama@gmail.com>
cc: Chen Wang <unicorn_wang@outlook.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Inochi Amaoto <inochiama@outlook.com>, Yixun Lan <dlan@gentoo.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, 
    linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/2] serial: 8250_dw: Add Sophgo SG2044 quirk
In-Reply-To: <20241021072606.585878-3-inochiama@gmail.com>
Message-ID: <29d8e2a6-d0e7-0f74-1f5c-4f285ec1e9ee@linux.intel.com>
References: <20241021072606.585878-1-inochiama@gmail.com> <20241021072606.585878-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-804874517-1729500492=:1065"
Content-ID: <a56336c7-de7f-8f28-b067-e7ff9bf5772d@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-804874517-1729500492=:1065
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <c4d9adfb-df42-a5c8-e914-7775c0394366@linux.intel.com>

On Mon, 21 Oct 2024, Inochi Amaoto wrote:

> SG2044 relys on an internal divisor when calculating bitrate, which
> means a wrong clock for the most common bitrates. So add a quirk for
> this uart device to skip the set rate call and only relys on the
> internal UART divisor.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

I wonder though does this mean the numbers userspace can read from kernel=
=20
are bogus and if something can be done about that?

--=20
 i.

> ---
>  drivers/tty/serial/8250/8250_dw.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index ab9e7f204260..51894c93c8a3 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -750,7 +750,7 @@ static const struct dw8250_platform_data dw8250_renes=
as_rzn1_data =3D {
>  =09.quirks =3D DW_UART_QUIRK_CPR_VALUE | DW_UART_QUIRK_IS_DMA_FC,
>  };
> =20
> -static const struct dw8250_platform_data dw8250_starfive_jh7100_data =3D=
 {
> +static const struct dw8250_platform_data dw8250_skip_set_rate_data =3D {
>  =09.usr_reg =3D DW_UART_USR,
>  =09.quirks =3D DW_UART_QUIRK_SKIP_SET_RATE,
>  };
> @@ -760,7 +760,8 @@ static const struct of_device_id dw8250_of_match[] =
=3D {
>  =09{ .compatible =3D "cavium,octeon-3860-uart", .data =3D &dw8250_octeon=
_3860_data },
>  =09{ .compatible =3D "marvell,armada-38x-uart", .data =3D &dw8250_armada=
_38x_data },
>  =09{ .compatible =3D "renesas,rzn1-uart", .data =3D &dw8250_renesas_rzn1=
_data },
> -=09{ .compatible =3D "starfive,jh7100-uart", .data =3D &dw8250_starfive_=
jh7100_data },
> +=09{ .compatible =3D "sophgo,sg2044-uart", .data =3D &dw8250_skip_set_ra=
te_data },
> +=09{ .compatible =3D "starfive,jh7100-uart", .data =3D &dw8250_skip_set_=
rate_data },
>  =09{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, dw8250_of_match);
>=20
--8323328-804874517-1729500492=:1065--
