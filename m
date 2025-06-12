Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F10921C178;
	Thu, 12 Jun 2025 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719926; cv=none; b=JwQ5ochXbFmNb18Hieqjrm+2VaC4KsR/wZzYeYwDUNJHpAzPadlSRnGZTIWX3RX1Y+Us/DgxFcEwpgwehJvbDXsKcz47ubzdI6vyNJUh8qYONV6j3l2QzDoJ47Le+or89ovf8Aeho36I5U47xQAoL0Hc4xbqnOhKYxcHF0YCbyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719926; c=relaxed/simple;
	bh=p6AQhqNJvHkmuCFbaI+9cOCMZDEhMXTJmKgUnQA0StM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lSABf/PDOlBAB0w1ztRDxg9Vy8ZIG9CcA+wvxcGRoVgAI+KW7we7fXtUmviqM7lAujUvP7wGGSvYRbKYyokN3kJ2j7plOXJuLassnzV8occM9LzBllcCcDnrvvp+hmOfAvqSW3DyWKkkcpNw7Hu50YC+JkgaewWfxjQ4wES8aNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXcP7cYi; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXcP7cYi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749719925; x=1781255925;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=p6AQhqNJvHkmuCFbaI+9cOCMZDEhMXTJmKgUnQA0StM=;
  b=MXcP7cYiyz+7WQNGpuTxgjUkOfl9lqrRhINmLTTKXXYR5sLJ1L5IrrCm
   Xxco6K8vHCnsZ9/MaMyHbTmg8VI9JKJ4XnUAVj3VK243k5SfsJh16KRyg
   mrsxc/Q93Y9+9ThSJb0M55RUIHJpPIVAHREkjFrJC50150YEQsw4XFOJ5
   hPWQeMIVEKUBA6/dY8HehYVnmUCFEXfe6CS6D5cmFE68ViODkYicHJHQX
   M0LYmBD0ad9VHifdSqEtPdDw/7HMgFBlzjVH6s6q5aKvTU6kji1hl1PbB
   lwyLE3liRaVm9Ezvdj35k+H+gwDxt/8t6auKuV3fgZkHCV3etwHfy23VM
   w==;
X-CSE-ConnectionGUID: afW3SPj4SYKaWws6kcvX7g==
X-CSE-MsgGUID: o20TxZNGQomgoWhKX6ACHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63299119"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63299119"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 02:18:44 -0700
X-CSE-ConnectionGUID: uZcevFszSt2bGm+mHraiEA==
X-CSE-MsgGUID: rjJhRMO6RyKxtMoJnwRHjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="152227579"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.140])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 02:18:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 12 Jun 2025 12:18:39 +0300 (EEST)
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/33] serial: 8250: extract serial8250_THRE_test()
In-Reply-To: <b6c85f8e-da53-4268-ae34-421dcf9e373c@kernel.org>
Message-ID: <8fe35d82-bee7-03e1-6e07-73df9f351728@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-16-jirislaby@kernel.org> <2c7977aa-831d-16be-667f-9f761ea0060f@linux.intel.com> <b6c85f8e-da53-4268-ae34-421dcf9e373c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-499402911-1749719919=:943"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-499402911-1749719919=:943
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Jun 2025, Jiri Slaby wrote:

> On 11. 06. 25, 14:03, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:
> ...
> > > +=09/*
> > > +=09 * Test for UARTs that do not reassert THRE when the transmitter =
is
> > > idle and the interrupt
> > > +=09 * has already been cleared.  Real 16550s should always reassert =
this
> > > interrupt whenever the
> > > +=09 * transmitter is idle and the interrupt is enabled.  Delays are
> > > necessary to allow register
> > > +=09 * changes to become visible.
> >=20
> > Very long comment lines are hard to read. (This is mostly not related t=
o
> > line length limits, but with eye movement required.)
> >=20
> > It may make sense to place some of the descriptive comment text into a
> > function comment instead of placing them mid-function.
> >=20
> > > +=09 *
> > > +=09 * Synchronize UART_IER access against the console.
> > > +=09 */
> > > +=09uart_port_lock_irqsave(port, &flags);
> > > +
> > > +=09wait_for_xmitr(up, UART_LSR_THRE);
> > > +=09serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> > > +=09udelay(1); /* allow THRE to set */
> >=20
> > These comments mix visually into the code making this look a big wall o=
f
> > text overall. Maybe consider adding empty lines to the logic as well as
> > there are what looks clear steps in this logic.
>=20
>=20
> What about this:
> > /*
> >  * Test for UARTs that do not reassert THRE when the transmitter is idl=
e and
> > the
> >  * interrupt has already been cleared. Real 16550s should always reasse=
rt
> > this
> >  * interrupt whenever the transmitter is idle and the interrupt is enab=
led.
> >  * Delays are necessary to allow register changes to become visible.
> >  */
> > static void serial8250_THRE_test(struct uart_port *port)
> > {               struct uart_8250_port *up =3D up_to_u8250p(port);
> >         unsigned long flags;
> >         bool iir_noint1, iir_noint2;
> >=20
> >         if (!port->irq)
> >                 return;
> >                                 if (up->port.flags & UPF_NO_THRE_TEST)
> >                 return;
> >                 if (port->irqflags & IRQF_SHARED)
> >                 disable_irq_nosync(port->irq);
> >                 /* Synchronize UART_IER access against the console. */
> >         uart_port_lock_irqsave(port, &flags);
> >                 wait_for_xmitr(up, UART_LSR_THRE);
> >         serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> >         /* allow THRE to set */
> >         udelay(1);=20
> >         iir_noint1 =3D serial_port_in(port, UART_IIR) & UART_IIR_NO_INT=
;
> >         serial_port_out(port, UART_IER, 0);
> >         serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> >         /* allow a working UART time to re-assert THRE */
> >         udelay(1);=20
> >         iir_noint2 =3D serial_port_in(port, UART_IIR) & UART_IIR_NO_INT=
;
> >         serial_port_out(port, UART_IER, 0);
> >=20
> >         uart_port_unlock_irqrestore(port, flags);
> >=20
> >         if (port->irqflags & IRQF_SHARED)
> >                 enable_irq(port->irq);                                 =
/*
> >          * If the interrupt is not reasserted, or we otherwise don't tr=
ust
> > the
> >          * iir, setup a timer to kick the UART on a regular basis.
> >          */
> >         if ((!iir_noint1 && iir_noint2) || up->port.flags & UPF_BUG_THR=
E)
> >                 up->bugs |=3D UART_BUG_THRE;
> > }
> >=20
>=20
> ?

I don't know what part exactly you wanted to ask about but it looks mostly=
=20
fine (sans what is broken due to email).

--=20
 i.
--8323328-499402911-1749719919=:943--
