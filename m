Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C117996;
	Thu,  9 Oct 2025 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010394; cv=none; b=o2tSXwL64EfRtSEzEjFX8/PquHlXQbE7sdRRi/vvJBXO38gR18vKcWE8wZxBbIgtcIkF1dAxOYRJbprWKuItATkS3xEdZTn0c3+hefZTIBjlvhMurokhAigAqCHto3ORryeQG86B7mGqQr4I0SVs6C7tiGehzQH8BuBqRLtr5J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010394; c=relaxed/simple;
	bh=mZZt5YdIwuaPegnVqL4be4LrmctNgNxtCGeCY51/RGw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=abFvhQXkHH61InoCL8EcYwwQiE17THUVzEAhsMsV+xIZm/VfYyrzwGWcfPeWsTLaezXl0aQJx4YXJbttNX19wzSuNsmNyYWu7mazsq98hx7cdfuR0ULL6l3mjK+vDodGIigkzMPOnI2Rbb0mQ8oftBh9MMJMEW+06sEfQM0RtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBPe/JHM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBPe/JHM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760010392; x=1791546392;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mZZt5YdIwuaPegnVqL4be4LrmctNgNxtCGeCY51/RGw=;
  b=TBPe/JHMRbQPh2dXGsBFkHtq1EnIis5O0uffkUjh0rdqI9ApxJj+tf3Y
   t+ddN2HFWs8ZasRZMklPhgd2/zWAyDm+JDk2TirHe1iI2t6zAPU2esIto
   mwDV2b95kQ9vIyiNMfwDzeoMeY+dUz1sJ7NNBD2Tn7n3hXB0fCjveFdh3
   JdwXGQo+aHxTZEyiANu7JaKd4Knr/i9zMabY/RwIH7aJWLVEpoJVcamJl
   QqywXYPKs2hWsyuUAdONJP5kLZEitHlHye7NwNLs6Mc3irrBky1HacXXH
   uCvyxBlkJNgLe9WMiu+HMfwua1ZXILXKreCxUrF7/Z2aZJn9WARSCvP62
   w==;
X-CSE-ConnectionGUID: ui4Rq/8kRoyDuDsckgPgww==
X-CSE-MsgGUID: HpmhIq9OQSu4eFsY7h9wew==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="65865422"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="65865422"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 04:46:32 -0700
X-CSE-ConnectionGUID: v/CHf2U8Q4WnRvXibbHLCg==
X-CSE-MsgGUID: 2WjfIzpqTli1vahEaLIIHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="185072214"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 04:46:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 9 Oct 2025 14:46:22 +0300 (EEST)
To: Binbin Zhou <zhoubb.aaron@gmail.com>
cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
    Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Haowei Zheng <zhenghaowei@loongson.cn>, 
    Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
    loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] serial: 8250: Add Loongson uart driver support
In-Reply-To: <CAMpQs4KS=hd3zvj5KYH7vBXpbEhPLmS61H9dLgnRpBpH+04ChA@mail.gmail.com>
Message-ID: <5e33cb28-0f03-519e-10e6-74d5305c1284@linux.intel.com>
References: <cover.1758676290.git.zhoubinbin@loongson.cn> <9823e7afe713450e210dab9dba6fa18683dc1fe0.1758676290.git.zhoubinbin@loongson.cn> <9cd368a1-4ba2-3b96-5cfe-0e600e77a3fe@linux.intel.com>
 <CAMpQs4KS=hd3zvj5KYH7vBXpbEhPLmS61H9dLgnRpBpH+04ChA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-604913320-1760010382=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-604913320-1760010382=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 9 Oct 2025, Binbin Zhou wrote:

> Hi Ilpo:
>=20
> Sorry for the late reply and thanks for your detailed review.
>=20
> On Tue, Sep 30, 2025 at 7:58=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Wed, 24 Sep 2025, Binbin Zhou wrote:
> >
> > > Add the driver for on-chip UART used on Loongson family chips.
> > >
> > > The hardware is similar to 8250, but there are the following
> > > differences:
> > >  - Some chips (such as Loongson-2K2000) have added a fractional divis=
ion
> > >    register to obtain the required baud rate accurately, so the
> > >    {get,set}_divisor callback is overridden.
> > >  - Due to hardware defects, quirk handling is required for
> > >    UART_MCR/UART_MSR.
> > >
> > > Co-developed-by: Haowei Zheng <zhenghaowei@loongson.cn>
> > > Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
> > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > ---

> > > +static unsigned int serial_fixup(struct uart_port *p, unsigned int o=
ffset, unsigned int val)
> > > +{
> > > +     struct loongson_uart_data *ddata =3D p->private_data;
> > > +
> > > +     if (offset =3D=3D UART_MCR)
> > > +             val ^=3D ddata->mcr_invert;
> > > +
> > > +     if (offset =3D=3D UART_MSR)
> > > +             val ^=3D ddata->msr_invert;

One additional thing, this could use switch/case.

I'd just do:

=09...
=09case UART_MSR:
=09=09return val ^ ddata->msr_invert;
=09default:
=09=09return val;
=09}

That way you don't need to use breaks.

> > > +     if (flags & LOONGSON_UART_HAS_FRAC) {
> > > +             uart.port.get_divisor =3D loongson_frac_get_divisor;
> > > +             uart.port.set_divisor =3D loongson_frac_set_divisor;
> > > +     }
> > > +
> > > +     if (flags & LOONGSON_UART_QUIRK_MCR)
> > > +             ddata->mcr_invert |=3D (UART_MCR_RTS | UART_MCR_DTR);
> > > +
> > > +     if (flags & LOONGSON_UART_QUIRK_MSR)
> > > +             ddata->msr_invert |=3D (UART_MSR_CTS | UART_MSR_DSR);
> >
> > I think it would be better to put these invert masks directly into a
> > struct which is then put into .data. LOONGSON_UART_HAS_FRAC can be bool
> > in that struct.
>=20
> I attempted the following refactoring:
>=20
> struct loongson_uart_ddata {
>         bool has_frac;
>         u8 mcr_invert;
>         u8 msr_invert;
> };
>=20
> static const struct loongson_uart_ddata ls2k0500_uart_data {
>         .has_frac =3D false,
>         .mcr_invert =3D UART_MCR_RTS | UART_MCR_DTR,
>         .msr_invert =3D UART_MSR_CTS | UART_MSR_DSR,
> };
>=20
> static const struct loongson_uart_ddata ls2k1500_uart_data {
>         .has_frac =3D true,
>         .mcr_invert =3D UART_MCR_RTS | UART_MCR_DTR,
>         .msr_invert =3D 0,
> };
>=20
> struct loongson_uart_priv {
>         int line;
>         struct clk *clk;
>         struct resource *res;
>         struct reset_control *rst;
>         struct loongson_uart_ddata *ddata;

This can and should be const struct as well as those underlying data=20
structs are const too.

> };
>=20
> .............
> In loongson_uart_probe():
>        priv->ddata =3D device_get_match_data(dev);
>=20
>         if (priv->ddata->has_frac) {
>                 port->get_divisor =3D loongson_frac_get_divisor;
>                 port->set_divisor =3D loongson_frac_set_divisor;
>         }
>=20
>=20
> .............
> static const struct of_device_id loongson_uart_of_ids[] =3D {
>         { .compatible =3D "loongson,ls2k0500-uart", .data =3D ls2k0500_ua=
rt_data },
>         { .compatible =3D "loongson,ls2k1500-uart", .data =3D ls2k1500_ua=
rt_data },
>         { },
> };


--=20
 i.

--8323328-604913320-1760010382=:944--
