Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D0DDC1;
	Mon, 21 Oct 2024 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505887; cv=none; b=Edx7iNCqFVqWrVYKfcr9N0DpiNVDBU2CuanaJQA8W6TMWSYGNO4gcDW7Jxv5r3QzCTE7UrzsFMzbFeYjt+Q0jG5Pshvn7AEx4UjDwcUqI+L/v0on82nohf0FxSXZa+3dKGMXBsPOdlMw8MbPyQr5CwgFlWHD4jGFQhrzF9YbXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505887; c=relaxed/simple;
	bh=Q4czTQPI4Z5Zy8B+MQf/hc42cmnbOK1BUsG1bn7iWN0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nKE6/sH1YdtwjcLlBasHTmrIv4zCr4PXjD4DmCycyo8JiZGETkTwkmexCK5C+swGjSacppBeSK+/G9+iJH0m+DWOw+9P7AZClEixQcgw7gWkNRkTximnZxtcI9q+kCLOqRi03rf0xtD1WEveU3V8O67sqYf8gAHJfndI1VzXSk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDOCHzje; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDOCHzje"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729505885; x=1761041885;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q4czTQPI4Z5Zy8B+MQf/hc42cmnbOK1BUsG1bn7iWN0=;
  b=lDOCHzje5IhvA1MeG7zXbxwuasOZOt2Nk6d+ltl0q//sydvmV6T3dWmf
   OEvNPhCDXvxfxl0vcm4X3K76HSdGNWpruZGobpqP7GHoAiCUaTbWz+eJ6
   HtEDfn0Cj2vUI5THx6xrHcW9TOQ9QL3cWDOMcUQ0UYdvweCO4suJ15hsc
   s2hjrpOfOiN9QTf1brbYh2VieMAzAK+fxT4xxffF/gYBoqhJ6+CnuqO2S
   exZ+M/WQTRIsYMHKooDYS8HS2CDb2XijTaNIccoypvYf0kD9kUMnH77JW
   l1BhenXoEfKNScVw2EwDQlUeJir5VaCs64N0h65QBC63g1W4Zri0lIair
   Q==;
X-CSE-ConnectionGUID: PX8QDsR+S/qcIVnEbh8hZw==
X-CSE-MsgGUID: VScUnll6Taqx5Rn84hwfcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="40353347"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="40353347"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:18:05 -0700
X-CSE-ConnectionGUID: TqhSGXDcQz67JFSfHQ8t7Q==
X-CSE-MsgGUID: CAUsUVz8TZmzpZ0FmnJhzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="80302518"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:17:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Oct 2024 13:17:55 +0300 (EEST)
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
In-Reply-To: <tm7jtf3swggiilznwo3xcqjlhd2a7cguwk3nay3bhmaxo23mf5@qw2fyjwapoxe>
Message-ID: <3dafd285-f56f-de2a-1544-b6ce092607b5@linux.intel.com>
References: <20241021072606.585878-1-inochiama@gmail.com> <20241021072606.585878-3-inochiama@gmail.com> <29d8e2a6-d0e7-0f74-1f5c-4f285ec1e9ee@linux.intel.com> <tm7jtf3swggiilznwo3xcqjlhd2a7cguwk3nay3bhmaxo23mf5@qw2fyjwapoxe>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2055814311-1729505875=:1065"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2055814311-1729505875=:1065
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 21 Oct 2024, Inochi Amaoto wrote:

> On Mon, Oct 21, 2024 at 11:52:38AM +0300, Ilpo J=E4rvinen wrote:
> > On Mon, 21 Oct 2024, Inochi Amaoto wrote:
> >=20
> > > SG2044 relys on an internal divisor when calculating bitrate, which
> > > means a wrong clock for the most common bitrates. So add a quirk for
> > > this uart device to skip the set rate call and only relys on the
> > > internal UART divisor.
> > >=20
> > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> >=20
> > Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> >=20
> > I wonder though does this mean the numbers userspace can read from kern=
el=20
> > are bogus and if something can be done about that?
> >=20
>=20
> I am not sure whether the clock rate can be read by the userspace.
> At least it report the right baud speed by using stty.

Okay, I meant baud & other settings. Thanks for checking it.

--=20
 i.

> Regards,
> Inochi
>=20
> >=20
> > > ---
> > >  drivers/tty/serial/8250/8250_dw.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8=
250/8250_dw.c
> > > index ab9e7f204260..51894c93c8a3 100644
> > > --- a/drivers/tty/serial/8250/8250_dw.c
> > > +++ b/drivers/tty/serial/8250/8250_dw.c
> > > @@ -750,7 +750,7 @@ static const struct dw8250_platform_data dw8250_r=
enesas_rzn1_data =3D {
> > >  =09.quirks =3D DW_UART_QUIRK_CPR_VALUE | DW_UART_QUIRK_IS_DMA_FC,
> > >  };
> > > =20
> > > -static const struct dw8250_platform_data dw8250_starfive_jh7100_data=
 =3D {
> > > +static const struct dw8250_platform_data dw8250_skip_set_rate_data =
=3D {
> > >  =09.usr_reg =3D DW_UART_USR,
> > >  =09.quirks =3D DW_UART_QUIRK_SKIP_SET_RATE,
> > >  };
> > > @@ -760,7 +760,8 @@ static const struct of_device_id dw8250_of_match[=
] =3D {
> > >  =09{ .compatible =3D "cavium,octeon-3860-uart", .data =3D &dw8250_oc=
teon_3860_data },
> > >  =09{ .compatible =3D "marvell,armada-38x-uart", .data =3D &dw8250_ar=
mada_38x_data },
> > >  =09{ .compatible =3D "renesas,rzn1-uart", .data =3D &dw8250_renesas_=
rzn1_data },
> > > -=09{ .compatible =3D "starfive,jh7100-uart", .data =3D &dw8250_starf=
ive_jh7100_data },
> > > +=09{ .compatible =3D "sophgo,sg2044-uart", .data =3D &dw8250_skip_se=
t_rate_data },
> > > +=09{ .compatible =3D "starfive,jh7100-uart", .data =3D &dw8250_skip_=
set_rate_data },
> > >  =09{ /* Sentinel */ }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, dw8250_of_match);
> > >=20
>=20
--8323328-2055814311-1729505875=:1065--
