Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A783C1417;
	Wed, 22 Apr 2026 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848530; cv=none; b=apA3tBPCjrf7VcmAegYLpd1nqVAoBkRk6CC4spDZuRmzuYrudNWbHrVVelFwgZ4/sef01O2h2TZp6fiFqjcc4rJDkbBoqUIQBtLQ4J1EI0u5CQeLjGnz/Y2ivcVNwWI16E3XXOp/IZQ+x3dIBP64uK1eX10ZDZAPyQ91TudMJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848530; c=relaxed/simple;
	bh=eFEpSTx513p917u/mqYfZYZIkWvyfz/QZhR2Ix0apS4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lb5yXyIkbtiRelOQtjzMpmVa0pZTxONYczEGfH2KXFtsLzjjiLdu1C2B/JcxTuJ7XyEOqSR8XBDFLtSks61Rb+vAyYWxZLfx8Ed76L1xvOF7FLskyCX129C543/zvKrPSoJsGPnpr/+gBvXfDeo5gWb219uyxAUnMeHLzZVQE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0Z1Y3oP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0Z1Y3oP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776848528; x=1808384528;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=eFEpSTx513p917u/mqYfZYZIkWvyfz/QZhR2Ix0apS4=;
  b=B0Z1Y3oPrqYF/ogC6N/kj8hUwAK6/w8XZdITTNdd0LLFNcVlKUnGFaVf
   AVFpVY8Ly9lmicfhEkgYatVmnF+hvM2NrSpNHa/KFhGLTLIH2poFnYsWO
   c1u/hUpf4hxul+er9dgpygSYcncsRF0j3dg4po8/Mj7IL6j1Z6PGKqS8A
   pCXH7JlmHZCydpBbL9jvWKMxhrkZLlgB3ItUBUNbVAww66Oz/TYoOf/9u
   Me/ctDEgEQnO2kXCsHDsn/KvjOx3BgILe8uAdC030a3t4FsZPMTk4BZFD
   noiOJ3ve+yGbW+DrR1pjYBRw8LrVn1CPAxrHvUitXUWVjTu5JLKMlPYVy
   Q==;
X-CSE-ConnectionGUID: pQctg3hTTkOPMxcswNa2Fw==
X-CSE-MsgGUID: 3c2SpzIvR9ul+L0voChk2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="65332828"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="65332828"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:02:07 -0700
X-CSE-ConnectionGUID: vrpzJcD3SBW0457Yk8KW3w==
X-CSE-MsgGUID: KN4gIIbQR0q6cRF9UDr7xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="229128550"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.4])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:02:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 22 Apr 2026 12:01:59 +0300 (EEST)
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
Subject: Re: [PATCH v3 2/2] serial: 8250_dw: Use a fixed CPR value for
 UltraRISC DP1000 UART
In-Reply-To: <177681947637.2697678.10937675549830278979.b4-reply@b4>
Message-ID: <446bf928-002a-456a-ae50-28220883dade@linux.intel.com>
References: <20260421-ultrarisc-serial-v3-0-3d7f09c2420e@ultrarisc.com> <20260421-ultrarisc-serial-v3-2-3d7f09c2420e@ultrarisc.com> <979c9543-3ea0-25de-f97b-9c6d2fa3ac61@linux.intel.com> <177681947637.2697678.10937675549830278979.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-722053607-1776847501=:1863"
Content-ID: <776e978f-a4db-fa9d-03fb-c7486575998e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-722053607-1776847501=:1863
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <98a11172-7f21-a467-ee73-d3a2c91a5640@linux.intel.com>

On Wed, 22 Apr 2026, Jia Wang wrote:

> On 2026-04-21 15:18 +0300, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 21 Apr 2026, Jia Wang wrote:
> >=20
> > > The UltraRISC DP1000 UART does not provide the standard CPR register =
used
> > > by 8250_dw to discover port capabilities.
> > >=20
> > > Provide a fixed CPR value for the DP1000-specific compatible so the
> > > driver can configure the port correctly.
> > >=20
> > > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_dw.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8=
250/8250_dw.c
> > > index 94beadb4024d..ca6dbdf75918 100644
> > > --- a/drivers/tty/serial/8250/8250_dw.c
> > > +++ b/drivers/tty/serial/8250/8250_dw.c
> > > @@ -962,6 +962,12 @@ static const struct dw8250_platform_data dw8250_=
intc10ee =3D {
> > >  =09.quirks =3D DW_UART_QUIRK_IER_KICK,
> > >  };
> > > =20
> > > +static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_dat=
a =3D {
> > > +=09.usr_reg =3D DW_UART_USR,
> > > +=09.cpr_value =3D 0x00022022,
> >=20
> > Hi,
> >=20
> > Please construct the cpr_value by ORing DW_UART_CPR_* defines together.
> > For fields, FIELD_PREP_CONST() may be useful.
> >=20
> > In order to be able to use the DW_UART_CPR_* defines, they need to be=
=20
> > moved into 8250_dwlib.h (I'd move all DW_UART register defines in a=20
> > preparatory patch).
> >=20
> > I know the existing Renesas' .cpr_value doesn't follow this convention =
but=20
> > that could be converted as well (in another patch, or leave the Renesas=
=20
> > entry conversion to me if you don't want to do that).
> >
>=20
> Thanks for the review.
>=20
> Just to confirm: since you mentioned that the preparatory patch moving
> the DW_UART register defines is already in place, I don't need to move
> them again, correct?

I'm not sure where that preparatory patch is. Those defines still appear=20
in 8250_dwlib.c AFAICT.

To be clear, DW_UART_CPR_* defines are in 8250_dwlib.c but you're=20
modifying 8250_dw.c file here so you cannot use those pre-existing defines=
=20
as is in 8250_dw.c. To solve that, please add a preparatory patch into=20
your series which relocates all those defines from 8250_dwlib.c to=20
8250_dwlib.h. If there's a patch which does that already, it has missed my=
=20
radar.

And my suggestion is to move not just DW_UART_CPR_* defines into=20
8250_dwlib.h but all DW UART specific register defines to keep them in=20
the same place.

Hopefully this clears up any misunderstanding.


My main point all along is that do not do the define move in the same=20
patch where you're adding UltraRISC DP1000 UART (which is a common pitfall=
=20
to many submitters so I try to give pro-active instructions while=20
reviewing to avoid extra versions because of them).

> I will update my patch to use the DW_UART_CPR_* macros and
> FIELD_PREP_CONST() accordingly, and I=E2=80=99m happy to add a separate p=
atch in
> the next revision to convert the Renesas .cpr_value as well.

Great, thanks.

> > > +=09.quirks =3D DW_UART_QUIRK_CPR_VALUE,
> > > +};

--=20
 i.
--8323328-722053607-1776847501=:1863--
