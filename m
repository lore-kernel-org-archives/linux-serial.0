Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB761EEA5D;
	Tue, 24 Jun 2025 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763737; cv=none; b=WAbjM5IxrpRjdsa3/TjCPqIZfoEiqUPEj6yeBVeRRjxPv9A5sMLlFy5nwF6i0XLFPfeM6rr3ueVB1WlUQ/go4eatIjwiX9eAr3SOuolkM26pHhBWVxrl8Tgh1QAeZqVVKKB3pGI32ejHD/rhSYmSQLRRuf3UexGr/fmN813NAcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763737; c=relaxed/simple;
	bh=giBJWbKCZDCZomcuUzUBk68/z0/RqLrNjY/vqUVWhCI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aNXfDVchGu9poUVqziJ1kAdxkL/o/binig+IdJj0YkDySFwYrS0vSf1KSP/zNqWRbqFizBC2mXRAoTcFQjwQrnj2OEoJ6V3vJqh5VhBjrlJGP1mdcItv7Tty5GO4eH5IJwHxQEkR8uu8REUuOyhXT/mBjNIz/eEdZREETV+R15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USaWoSJ2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USaWoSJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750763736; x=1782299736;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=giBJWbKCZDCZomcuUzUBk68/z0/RqLrNjY/vqUVWhCI=;
  b=USaWoSJ2+YEEzZAMTxsCn/6yhtvqcTXvgbqKLws9/+BrsQVNkEOhPFvu
   l2QQFsmAZ0uJjKvV35jKXdJn/AwOaEIXto4PQ47NRvYw5uaGh+1FVdl+A
   zPz7xO+yAtM8Mz9ziwJrRooRu4jkZO03MNwEifL1QvEudOvmpIQQmqpB2
   +K0sBdXLi5WUft5Ez+ApAk/4x2ir8QnWLQqV/LP1ozubJWKA7AnxNK0VO
   Pz9yaVMi+3jfUHvcNz/nBS+kJ1/vROCXUaGveyr6sdiQkGYW4LpJEdhQ1
   NpMP0rwwY03bxpK7rPZ5eX0EhjMXSWYzfePg91+PqwBaG644HBsuzqxKI
   Q==;
X-CSE-ConnectionGUID: wPFkYcnkTtG9hiEsl2Ucdg==
X-CSE-MsgGUID: zu+SE7qLR0WU9cK9CpaM6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52868942"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52868942"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:15:34 -0700
X-CSE-ConnectionGUID: sos1YxJXTWyQvlTESp5sfw==
X-CSE-MsgGUID: dG8yJcKGQDObuBxfiZ+oVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152397365"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.16])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:15:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Jun 2025 14:15:27 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/5] serial: 8250: extract serial8250_init_mctrl()
In-Reply-To: <b78023eb-f5ab-6287-1cd7-5db76d905eed@linux.intel.com>
Message-ID: <4d6b65af-294c-fd02-af91-099e22420472@linux.intel.com>
References: <20250624080641.509959-1-jirislaby@kernel.org> <20250624080641.509959-2-jirislaby@kernel.org> <b78023eb-f5ab-6287-1cd7-5db76d905eed@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-865615950-1750763727=:943"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-865615950-1750763727=:943
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 24 Jun 2025, Ilpo J=C3=A4rvinen wrote:

> On Tue, 24 Jun 2025, Jiri Slaby (SUSE) wrote:
>=20
> > After commit 795158691cc0 ("serial: 8250: extract
> > serial8250_initialize()"), split serial8250_initialize() even more --
> > the mctrl part of this code can be separated into
> > serial8250_init_mctrl() -- done now.
> >=20
> > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Heh, I didn't even realize I was suggesting this :-D but it's good=20
> nonetheless.
>=20
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> > [v2]
> > * use port-> directly.
> > * do not remove curly braces.
> > Both rebase errors -- noticed by Andy.
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 48c30e158cb8..0f85a2f292fc 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2216,15 +2216,8 @@ static void serial8250_THRE_test(struct uart_por=
t *port)
> >  =09=09up->bugs |=3D UART_BUG_THRE;
> >  }
> > =20
> > -static void serial8250_initialize(struct uart_port *port)
> > +static void serial8250_init_mctrl(struct uart_port *port)
> >  {
> > -=09struct uart_8250_port *up =3D up_to_u8250p(port);
> > -=09unsigned long flags;
> > -=09bool lsr_TEMT, iir_NOINT;
> > -
> > -=09serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> > -
> > -=09uart_port_lock_irqsave(port, &flags);
> >  =09if (port->flags & UPF_FOURPORT) {

I should have also added what I meant with my earlier suggestion. AFAICT,=
=20
this UPF_FOURPORT thing can only occur if SERIAL_8250_FOURPORT is enabled.

The challenge obviously are the if/else constructs but there are a few=20
places that do port->flags & UPF_FOURPORT specific thing and something=20
else otherwise. That hw-specific code could be placed into the hw-specific=
=20
8250_fourport.c file if the hw-specific function is made to return true=20
if it did match, and the generic code runs otherwise.

I also have no idea why serial/sunsu.c checks UPF_FOURPORT, perhaps that's=
=20
copy-paste in action. :-)

> >  =09=09if (!port->irq)
> >  =09=09=09port->mctrl |=3D TIOCM_OUT1;
> > @@ -2235,6 +2228,18 @@ static void serial8250_initialize(struct uart_po=
rt *port)
> >  =09}
> > =20
> >  =09serial8250_set_mctrl(port, port->mctrl);
> > +}
> > +
> > +static void serial8250_initialize(struct uart_port *port)
> > +{
> > +=09struct uart_8250_port *up =3D up_to_u8250p(port);
> > +=09unsigned long flags;
> > +=09bool lsr_TEMT, iir_NOINT;
> > +
> > +=09serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> > +
> > +=09uart_port_lock_irqsave(port, &flags);
> > +=09serial8250_init_mctrl(port);
> > =20
> >  =09/*
> >  =09 * Serial over Lan (SoL) hack:
> >=20
>=20
>=20

--=20
 i.

--8323328-865615950-1750763727=:943--
