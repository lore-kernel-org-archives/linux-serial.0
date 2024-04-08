Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810747460
	for <linux-serial@vger.kernel.org>; Mon,  8 Apr 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597138; cv=none; b=c1GPzazFNOXMjICsFBnt1wR4tDHsSphWJb5eEW1s1hDSClsInvXsZqMjb9dQaZio9XHqOdV6x6pYdSyQTzAwk8yyfT74oDms5jWbHVCN0D1vl8HGO0EdakgH7uQnOiEAvyMQaHX652N9/3USLPuSIBBXLXYzaSwkJTUkkH8XIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597138; c=relaxed/simple;
	bh=MvYkYh0myG5kZ1rrWiFLsovRnF5sluU0TA5YZ0UxVaA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YrmqaEIwf1FTZwBJuWIPU+7pOCPB1eB7k40ehtMfqFzLzd7q+h3MqMjIcwSlccwlaxzSV7xAdE21OpXj9/HuX0Sw8h3j6ioJHh1FfWzHSY0+S7e1XnjmBFMg6CAuMfiEDhpeGs+E2qQ6qnxyNNOE1jjeHMi+G438O118xm2fO/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYFWgMIs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYFWgMIs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712597136; x=1744133136;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MvYkYh0myG5kZ1rrWiFLsovRnF5sluU0TA5YZ0UxVaA=;
  b=DYFWgMIsvY/3BMdzrepQqm9TKx9MExBdQHOJf3e8s/tlqbUWMcFPOfEl
   NDmkYef6aI+eO/VT4CVC+quuJmtNqitf6KJgx6rotWJ8M44Q+2NlIXlNB
   kYWPuBj0jhy1SV085Vc1vEzlGLnsJJL/aUGCQf1AVlSQDiyDrMCGYWaN0
   IJ7g6Yaa01WppsZbhdEBCyl74p1YESqZ72T2unPnWapuawIYkLqOkL9+G
   1wGfqQoqqoeJM9YmEyzstIoDD92kBWvFo4/fvQK/0OFMhJmxZDNAnGJG2
   9WjWogk1UPSVbrdUXgUoONZ8EOhuu9RDnpOZnCuELmOj7pC/9cqd6YyLX
   Q==;
X-CSE-ConnectionGUID: NRcfZN6ORm2zCDM3VIe39w==
X-CSE-MsgGUID: IzXPO4wRQ06mYIpQ44ayQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11667268"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="11667268"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 10:25:35 -0700
X-CSE-ConnectionGUID: qTQBH9KORsGCcCfEozAZWQ==
X-CSE-MsgGUID: Kj//SEGHRFGveQdKJ/41fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="43133392"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 10:25:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Apr 2024 20:25:28 +0300 (EEST)
To: Matthew Howell <matthew.howell@sealevel.com>
cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
    "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
    Darren Beeson <darren.beeson@sealevel.com>, 
    Jeff Baldwin <jeff.baldwin@sealevel.com>, 
    Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Re: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
In-Reply-To: <74b591e8-c8b1-7a9b-e2ea-c375f3d712c2@linux.intel.com>
Message-ID: <db3d5156-5ba7-e3e0-42c8-37f9d4f5efcb@linux.intel.com>
References: <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>  <a9519d301f542c921260b11b4576cd68cc929b52.camel@sealevel.com> <937e10172eaf46cbb6e355666e15ba33344f2c51.camel@sealevel.com> <74b591e8-c8b1-7a9b-e2ea-c375f3d712c2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1488353054-1712597128=:14302"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1488353054-1712597128=:14302
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 8 Apr 2024, Ilpo J=E4rvinen wrote:

> On Mon, 8 Apr 2024, Matthew Howell wrote:
>=20
> > On Wed, 2024-02-21 at 16:16 -0500, Matthew Howell wrote:
> > > Allows the use of the EN485 hardware pin by preserving the value of
> > > FCTR[5] in pci_xr17v35x_setup().
> > >=20
> > > Per the XR17V35X datasheet, the EN485 hardware pin works by setting
> > > FCTR[5] when the pin is active. pci_xr17v35x_setup() prevented the us=
e
> > > of EN485 because it overwrote the FCTR register.
> > >=20
> > > Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> > > ---
> > > V1 -> V2
> > > Fixed wordwrap in diff
> > >=20
> > > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial=
/8250/8250_exar.c
> > > index 23366f868..97711606f 100644
> > > --- a/drivers/tty/serial/8250/8250_exar.c
> > > +++ b/drivers/tty/serial/8250/8250_exar.c
> > > @@ -596,6 +596,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct =
pci_dev *pcidev,
> > >  =09unsigned int baud =3D 7812500;
> > >  =09u8 __iomem *p;
> > >  =09int ret;
> > > +=09u8 en485mask;
> > > =20
> > >  =09port->port.uartclk =3D baud * 16;
> > >  =09port->port.rs485_config =3D platform->rs485_config;
> > > @@ -618,7 +619,8 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct =
pci_dev *pcidev,
> > >  =09p =3D port->port.membase;
> > > =20
> > >  =09writeb(0x00, p + UART_EXAR_8XMODE);
> > > -=09writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
> > > +=09en485mask =3D readb(p + UART_EXAR_FCTR) & UART_FCTR_EXAR_485;
> > > +=09writeb(UART_FCTR_EXAR_TRGD | en485mask, p + UART_EXAR_FCTR);
> > >  =09writeb(128, p + UART_EXAR_TXTRG);
> > >  =09writeb(128, p + UART_EXAR_RXTRG);
>=20
> Why you need to read rs485 state from the register? It should be availabl=
e=20
> in ->rs485.flags & SER_RS485_ENABLED.
>=20
> pci_fastcom335_setup() seems to have the same problem? Path small part=20

I meant "That small part ..."

> seems to be common code anyway which should be moved into helper, only th=
e=20
> trigger threshold seems to differ which can be given in a parameter.
>=20
>=20

--=20
 i.

--8323328-1488353054-1712597128=:14302--
