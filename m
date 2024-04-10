Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352A1161330
	for <linux-serial@vger.kernel.org>; Wed, 10 Apr 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756968; cv=none; b=qwMZur06PR8SnMz6ezkRo1ReNjvsrQY/TZnIP/omxCgmnt0c6yuVmJoWY3v/kymvCmqZmvTAfTGgEX2B3bs/53XC9SB3//aLe3WR+L9NchsygM/mp60tLV38yce7EuRuSyTS5Mv18MeJpxz7MAWyqCgiu6wrFd6OsBVMOu+ZVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756968; c=relaxed/simple;
	bh=60qSjcC97KW5MpPcD5SRVtMeoIVK7N59aN9nfneG/tk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XOu6oruonAvSXd34CmSVBMYynWdRDEGIjsEy+2IT8r3mesAR//gUE9VbUEYbdXodY5bsU2I/Yihv2BB0eq+IqpcfjFdSYVP9IqgeF5k318r8XhyIx9OHCi8h4z29wt4mQ30aF5fjGe5WMM/DzI1tnhXmCdITjJ4V3bb4uiVV3z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KpbokLtD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KpbokLtD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712756966; x=1744292966;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=60qSjcC97KW5MpPcD5SRVtMeoIVK7N59aN9nfneG/tk=;
  b=KpbokLtDmjEf7dJikiqhA8O7+F6V1VjiSaB2H1afMCbV+AtR/EBMkOUd
   udT7tXfN1QWIYcJmelxuzBlXpTFSydNZGYEhCv62Pj7IJNrCSJJMGte1f
   X+iO+RJjhvMs6CtBHFbsGuRXjLKFgHaaa+AEBRAdl9Xl0RyiH0THJBlW2
   2IL+3NkZyiP5zgPc8H1TRJmzpMf4xJzczKAr4+fEWgkXrFfD4ibWgZLR3
   f+WB4xbCEADjKY1SGAUVn5WG+vmBEs3Hgd/uFmr2VWHDUxWj8YdHhI1p0
   cV897Y17DNgi+uXksLD6bupNgGnefEWvNGf9cR2H37gg+cM5qQJhewe5q
   Q==;
X-CSE-ConnectionGUID: 2W1HX7mPT4yL2eNrEStxHA==
X-CSE-MsgGUID: hNtAHLsxQLa41K2O/pVZFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8283170"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8283170"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:49:26 -0700
X-CSE-ConnectionGUID: ToBc+fYFQgWa3Qfvs7ckNw==
X-CSE-MsgGUID: 8C53wuaOS4qYEj8g5WabKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51540405"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:49:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 10 Apr 2024 16:49:20 +0300 (EEST)
To: Matthew Howell <matthew.howell@sealevel.com>
cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
    "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
    Jeff Baldwin <jeff.baldwin@sealevel.com>, 
    Darren Beeson <darren.beeson@sealevel.com>, 
    Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Re: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
In-Reply-To: <cbe7931db7a6841369505b83ee3c747c981c16f2.camel@sealevel.com>
Message-ID: <41c9bb61-8f40-7ead-5870-d67632ab4936@linux.intel.com>
References: <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>  <a9519d301f542c921260b11b4576cd68cc929b52.camel@sealevel.com>  <937e10172eaf46cbb6e355666e15ba33344f2c51.camel@sealevel.com>  <74b591e8-c8b1-7a9b-e2ea-c375f3d712c2@linux.intel.com>
 <cbe7931db7a6841369505b83ee3c747c981c16f2.camel@sealevel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-996554535-1712756960=:1963"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-996554535-1712756960=:1963
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 8 Apr 2024, Matthew Howell wrote:

> On Mon, 2024-04-08 at 19:48 +0300, Ilpo J=C3=A4rvinen wrote:
> > [Some people who received this message don't often get email from ilpo.=
jarvinen@linux.intel.com. Learn why this is important at https://aka.ms/Lea=
rnAboutSenderIdentification ]
> >=20
> > =E2=9A=A0Caution: External email. Exercise extreme caution with links o=
r attachments.=E2=9A=A0
> >=20
> >=20
> > On Mon, 8 Apr 2024, Matthew Howell wrote:
> >=20
> > > On Wed, 2024-02-21 at 16:16 -0500, Matthew Howell wrote:
> > > > Allows the use of the EN485 hardware pin by preserving the value of
> > > > FCTR[5] in pci_xr17v35x_setup().
> > > >=20
> > > > Per the XR17V35X datasheet, the EN485 hardware pin works by setting
> > > > FCTR[5] when the pin is active. pci_xr17v35x_setup() prevented the =
use
> > > > of EN485 because it overwrote the FCTR register.
> > > >=20
> > > > Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> > > > ---
> > > > V1 -> V2
> > > > Fixed wordwrap in diff
> > > >=20
> > > > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/seri=
al/8250/8250_exar.c
> > > > index 23366f868..97711606f 100644
> > > > --- a/drivers/tty/serial/8250/8250_exar.c
> > > > +++ b/drivers/tty/serial/8250/8250_exar.c
> > > > @@ -596,6 +596,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struc=
t pci_dev *pcidev,
> > > >     unsigned int baud =3D 7812500;
> > > >     u8 __iomem *p;
> > > >     int ret;
> > > > +   u8 en485mask;
> > > >=20
> > > >     port->port.uartclk =3D baud * 16;
> > > >     port->port.rs485_config =3D platform->rs485_config;
> > > > @@ -618,7 +619,8 @@ pci_xr17v35x_setup(struct exar8250 *priv, struc=
t pci_dev *pcidev,
> > > >     p =3D port->port.membase;
> > > >=20
> > > >     writeb(0x00, p + UART_EXAR_8XMODE);
> > > > -   writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
> > > > +   en485mask =3D readb(p + UART_EXAR_FCTR) & UART_FCTR_EXAR_485;
> > > > +   writeb(UART_FCTR_EXAR_TRGD | en485mask, p + UART_EXAR_FCTR);
> > > >     writeb(128, p + UART_EXAR_TXTRG);
> > > >     writeb(128, p + UART_EXAR_RXTRG);
> >=20
> > Why you need to read rs485 state from the register? It should be availa=
ble
> > in ->rs485.flags & SER_RS485_ENABLED.
> >=20
>=20
> Please correct me if I am wrong, but my understanding is that
> SER_RS485_ENABLED is set from userspace using the TIOCRS485 IOCTL.=20

Thought that and device_property_read_bool(dev,=20
"linux,rs485-enabled-at-boot-time")

> However, this is not the only way that the FCTR register can be changed.
> In particular, per XR17V35X datasheet, the EN485 pin is sampled on
> power-on and transfers the logic state to FCTR[5]. Our card takes
> advantage of this to allow users to configure RS485 in scenarios where
> they cannot, or do not want to, modify their software to set
> SER_RS485_ENABLED.
>
> However, this functionality of the UART does not currently work with
> this driver because the entire FCTR register is being overwritten,
> thereby erasing whatever value was written to FCTR[5] on UART power-up.
>=20
> The driver cannot know whether FCTR[5] was set on power-up without
> reading the FCTR, therefore it must be read.

???

Are you saying RS485 is enabled without kernel knowing about it? I don't=20
think that's the correct way to do things.

> > pci_fastcom335_setup() seems to have the same problem? That small part
> > seems to be common code anyway which should be moved into helper, only =
the
> > trigger threshold seems to differ which can be given in a parameter.
> >=20
>=20
> Technically, yes mit has the same problem, but I am not sure it is an
> actual issue and am hesitant make the suggested changes for the
> following reasons:
>=20
>=20
> 1) The fastcom card may depend on the behaviour working as-is.
> 2) I only have Sealevel & reference Exar hardware to test, not Fastcom,
> so I have no way to test if the changes negatively impact fastcom
> 3) Finally, while I am not familar with the fastcom 335, it doesn't have
> any dip-switches or jumpers, which leads me to believe it doesn't have a
> way for users to utilize the EN485 pin. If this is the case, then there
> is no end-user benefit to 'fixing' this in pci_fastcom335_setup().
>=20
> If someone with a fastcom 335 card is willing to test then I can take a
> stab at the suggested change, but at the moment I see at least some
> 'risk' in making this change, but no 'reward' for doing so.

Okay, it seems fastcom part of the driver doesn't support rs485.
There's  stupid naming in this driver, "generic_rs485_config()" isn't=20
really that generic it seems (and on top of that, the init flow is
hard to follow). :-/



--=20
 i.

--8323328-996554535-1712756960=:1963--
