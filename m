Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FFB1DDE9
	for <linux-serial@vger.kernel.org>; Thu, 11 Apr 2024 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824045; cv=none; b=YFINiijdi2S8Y/cDCEVP14Z2EbLpId7Sn0ceEuCN5GYkaNSFDetFXV3jv2Gz9TzAF5tfEAAGn7yes5hXuc2oovTZ6ro+keoQaU8zZme/t5XTuGLBdu8/Iucvg7SgNJpVL39e9DjAAb3+XDFYkx3Hwo2httdytkt0bmaetaLe8Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824045; c=relaxed/simple;
	bh=gIoR84UbycdVNKtuQA59WQQ8dshwVA9EO5STxNDf+lI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E+uua2OuhRxCM2vBtSfyiWhDB0VHGMnKh8U46fjTjMZJ25tLiW7OUzresv4jxDvVRk9OcrYOcQ8emVFmdqLRDsEo+SdNv/zGIcYwMSCVV1ITZVgFIBj8FHVH4EMC7L/t5L+dt1yLXmYPsKYoHgbsTdp1bJTvkYoxODHmeWhZy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7EjnGKF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7EjnGKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712824043; x=1744360043;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=gIoR84UbycdVNKtuQA59WQQ8dshwVA9EO5STxNDf+lI=;
  b=R7EjnGKF593OXLK7DCCrWi8fvLs3/28P+84lSzbyxh3L245hlHS+1bNs
   t1eLBa0+Vgv+yts4r/1Q1TiRgB8uyG1g5jvbZS7SwBkhTBbvJLDS2B8ex
   QaBJF8Izcn7/kuk0oII9lzGIkO6zdlN7YS5A+DKxhCuzA1eBGXpNC9/Yl
   KpuQ7zHk6FNKeUm3DQ1t/NyRbfKjlOx6PLle2Ii2rzNRYnwVG0dshq4Yj
   XKaLWGTYv/LNX30QL58RmMnO5D0eTIrGMd5hShhmNZ3IdQWBzAS+60T1p
   7i2K65Sj3ptzphQvGqpD8Lf9HuMfkb4OkrC+idxUVQirKSAVWNWOnT/n5
   A==;
X-CSE-ConnectionGUID: VrgwG70VRK+JufX5juKIYQ==
X-CSE-MsgGUID: bk+MUrFdRu69DEpIdlPPQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18782861"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="18782861"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 01:27:22 -0700
X-CSE-ConnectionGUID: NuznF1XVSyaiwNVEr1xaOg==
X-CSE-MsgGUID: uTVypOmTTZKEmC4MtJ1Qcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="20808190"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 01:27:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Apr 2024 11:27:14 +0300 (EEST)
To: Matthew Howell <matthew.howell@sealevel.com>
cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
    Darren Beeson <darren.beeson@sealevel.com>, 
    "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
    Jeff Baldwin <jeff.baldwin@sealevel.com>, 
    Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Re: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
In-Reply-To: <a1f93f46966b087ce392263b886790bbc3abc317.camel@sealevel.com>
Message-ID: <da99e0fa-47a2-42e3-7b29-85dda41c3bbd@linux.intel.com>
References: <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>   <a9519d301f542c921260b11b4576cd68cc929b52.camel@sealevel.com>   <937e10172eaf46cbb6e355666e15ba33344f2c51.camel@sealevel.com>   <74b591e8-c8b1-7a9b-e2ea-c375f3d712c2@linux.intel.com>
  <cbe7931db7a6841369505b83ee3c747c981c16f2.camel@sealevel.com>  <41c9bb61-8f40-7ead-5870-d67632ab4936@linux.intel.com> <a1f93f46966b087ce392263b886790bbc3abc317.camel@sealevel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-44243042-1712823558=:1017"
Content-ID: <607bdf1e-6859-f802-39f2-49dc342d575e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-44243042-1712823558=:1017
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <b23502ce-70bf-e4a3-2246-2bb0bfbb081f@linux.intel.com>

On Wed, 10 Apr 2024, Matthew Howell wrote:
> On Wed, 2024-04-10 at 16:49 +0300, Ilpo J=E4rvinen wrote:
> > On Mon, 8 Apr 2024, Matthew Howell wrote:
> > > On Mon, 2024-04-08 at 19:48 +0300, Ilpo J=E4rvinen wrote:
> > > > On Mon, 8 Apr 2024, Matthew Howell wrote:
> > > >=20
> > > > > On Wed, 2024-02-21 at 16:16 -0500, Matthew Howell wrote:
> > > > > > Allows the use of the EN485 hardware pin by preserving the valu=
e of
> > > > > > FCTR[5] in pci_xr17v35x_setup().
> > > > > >=20
> > > > > > Per the XR17V35X datasheet, the EN485 hardware pin works by set=
ting
> > > > > > FCTR[5] when the pin is active. pci_xr17v35x_setup() prevented =
the use
> > > > > > of EN485 because it overwrote the FCTR register.
> > > > > >=20
> > > > > > Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> > > > > > ---
> > > > > > V1 -> V2
> > > > > > Fixed wordwrap in diff
> > > > > >=20
> > > > > > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/=
serial/8250/8250_exar.c
> > > > > > index 23366f868..97711606f 100644
> > > > > > --- a/drivers/tty/serial/8250/8250_exar.c
> > > > > > +++ b/drivers/tty/serial/8250/8250_exar.c
> > > > > > @@ -596,6 +596,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, s=
truct pci_dev *pcidev,
> > > > > >     unsigned int baud =3D 7812500;
> > > > > >     u8 __iomem *p;
> > > > > >     int ret;
> > > > > > +   u8 en485mask;
> > > > > >=20
> > > > > >     port->port.uartclk =3D baud * 16;
> > > > > >     port->port.rs485_config =3D platform->rs485_config;
> > > > > > @@ -618,7 +619,8 @@ pci_xr17v35x_setup(struct exar8250 *priv, s=
truct pci_dev *pcidev,
> > > > > >     p =3D port->port.membase;
> > > > > >=20
> > > > > >     writeb(0x00, p + UART_EXAR_8XMODE);
> > > > > > -   writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
> > > > > > +   en485mask =3D readb(p + UART_EXAR_FCTR) & UART_FCTR_EXAR_48=
5;
> > > > > > +   writeb(UART_FCTR_EXAR_TRGD | en485mask, p + UART_EXAR_FCTR)=
;
> > > > > >     writeb(128, p + UART_EXAR_TXTRG);
> > > > > >     writeb(128, p + UART_EXAR_RXTRG);
> > > >=20
> > > > Why you need to read rs485 state from the register? It should be av=
ailable
> > > > in ->rs485.flags & SER_RS485_ENABLED.
> > > >=20
> > >=20
> > > Please correct me if I am wrong, but my understanding is that
> > > SER_RS485_ENABLED is set from userspace using the TIOCRS485 IOCTL.
> >=20
> > Thought that and device_property_read_bool(dev,
> > "linux,rs485-enabled-at-boot-time")
> >=20
>=20
> I am not familiar with that property. Is that something that can be set
> in userspace or via a kernel parameter? Or is it 'hard-coded' into the
> device tree binding for a particular device?

Through DT, yes (or ACPI equivalent).

> > > However, this is not the only way that the FCTR register can be chang=
ed.
> > > In particular, per XR17V35X datasheet, the EN485 pin is sampled on
> > > power-on and transfers the logic state to FCTR[5]. Our card takes
> > > advantage of this to allow users to configure RS485 in scenarios wher=
e
> > > they cannot, or do not want to, modify their software to set
> > > SER_RS485_ENABLED.
> > >=20
> > > However, this functionality of the UART does not currently work with
> > > this driver because the entire FCTR register is being overwritten,
> > > thereby erasing whatever value was written to FCTR[5] on UART power-u=
p.
> > >=20
> > > The driver cannot know whether FCTR[5] was set on power-up without
> > > reading the FCTR, therefore it must be read.
> >=20
> > ???
> >=20
> > Are you saying RS485 is enabled without kernel knowing about it? I don'=
t
> > think that's the correct way to do things.
>=20
> That is correct. However, I wouldn't say it is an incorrect way of doing
> things. Some reasoning/justification below:
>=20
> * Kernel/Driver/Software independent RS485 Auto Enable is not new. I
> can't speak for other vendors, but Sealevel has been creating products
> with this functionality for several decades, dating back to at least
> 1994.=20
>=20
> * In those products, the kernel was *necessarily* entirely unaware of
> whether RS485 was in use because most OS's and applications did not
> support RS485 at the time and as such was implement to be entirely
> transparent to the OS and application.
>=20
> * Since then, many UARTs have integrated Auto RS485 Enable into a single
> package and we have moved towards utilizing this integrated
> functionality when it is available.
>=20
> * I say the above to point out that there is a long history of RS485
> Auto Enable without kernel involvement, and therefore in my view it is
> just as valid to have RS485 Auto Enabled set via hardware without the
> kernel being aware as it is for the kernel to be aware.

Is this "Auto" thing done with some dip switches/jumpers and is cast to=20
stone after hw init? So driver's .probe() could just read that state
and adjust kernel rs485 state based one it?

> * Finally, to the day many applications still do not support RS485.
> Therefore, having the ability to set RS485 via hardware is still a
> valuable feature for users, and one that Exar/Maxlinear seems to have
> recognized, as I don't know why they would even have the EN485 pin if
> not for this sort of use-case.

Once the serial line has been transitioned into RS485 mode, userspace does=
=20
not need to be aware of it (which can happen through DT so no userspace=20
involvement). So this shouldn't be seen as a problem.

> Perhaps the optimal solution would be if there were a method for the
> hardware to inform the kernel that it is configured for RS485 Auto
> Enable via hardware, but I'm not aware of a supported way of doing this.
> The only thing I can think of at the moment is just a check in the
> init/setup that sets SER_RS485_ENABLED if FCTR[5] is enabled. I don't
> know if this would be considered an improvement though.

I don't think such mechanism exists beyond DT currently, but I don't see=20
why it could be added.

--=20
 i.
--8323328-44243042-1712823558=:1017--
