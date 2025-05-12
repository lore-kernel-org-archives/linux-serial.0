Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F2F25B684;
	Mon, 12 May 2025 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045645; cv=none; b=dCLfxaVjoohk11JxC6bhBxR8Pc/oPcZHeaWTcrsXTnCJCChhfKgJw4zcBkAEuPoyJgYe5Q6T0jFkGdb7t13FJQY0QmR6V8CxxP7k4MpV+A3VA+J6xpqTaojM40kLRV9VnxwziDPnlcKvPSayLb67NgSjT1qAcWK36ZnaH5m8aZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045645; c=relaxed/simple;
	bh=QJC+i0w74wyMM5b20YQUi7TyHgHPd7h2uy6hA/N5pkI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pMtstfIEPHGU7Nfqa2PICi4eNeoj7HXWTcTTd5AG437yeUoyTs8RFDjeOqFAM2WCFhpcgfm4yKJgRqx1finxQVPGB4vtEL+qnvn6UB2Zbm39yW9Y+Jk3HrsrKd1ekojnkhMh9rHnMg8MK9iPyWR0ijHPbSgIJ59Qiss20gr/PeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXVebe9X; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXVebe9X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747045643; x=1778581643;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QJC+i0w74wyMM5b20YQUi7TyHgHPd7h2uy6hA/N5pkI=;
  b=VXVebe9Xd6fBZCE2jiC0bALmFSTcTon/oAdwoGuWniNO0SX7ZtW7KLWP
   Jyxxk/sNRRvbFvV43ZECt3txLRDiymS9eBug2BHG5cB0S6hhKtqD5WL6S
   XTSxmKdfmX7aFpu1bG1ZHCMpHrHZtnfyMm8ednbfe+HJTKM08cP77c6L2
   oSkzQzAM03Nu5edReCCIQeIs+aJ9AMMG2agkDReYFMzdF8WUW9ddailTE
   rG65/eEmkmBBNFJ/iLilYb9UPSHQuXxTPA8z3PUcf+YxDjLSbWsiRm6WO
   UYxdi8qucMmcqsvJzf1vryiouD/8IWYvBYpJoVBbFpFkBpWoQS6d0IIeD
   g==;
X-CSE-ConnectionGUID: NDLnB12RQR6Sckjb9CqzjQ==
X-CSE-MsgGUID: ToXLHd8fR4me/zOqd9ZdeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="48735872"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="48735872"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 03:27:23 -0700
X-CSE-ConnectionGUID: yX6nqsEzQWCZNxFzt81xeg==
X-CSE-MsgGUID: 1JPKRYBuQ++pBj6DHAEecQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="160582681"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 03:27:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 May 2025 13:27:12 +0300 (EEST)
To: yunhui cui <cuiyunhui@bytedance.com>
cc: arnd@arndb.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    benjamin.larsson@genexis.eu, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    heikki.krogerus@linux.intel.com, Jiri Slaby <jirislaby@kernel.org>, 
    jkeeping@inmusicbrands.com, john.ogness@linutronix.de, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, markus.mayer@linaro.org, 
    matt.porter@linaro.org, namcao@linutronix.de, paulmck@kernel.org, 
    pmladek@suse.com, schnelle@linux.ibm.com, sunilvl@ventanamicro.com, 
    tim.kryger@linaro.org
Subject: Re: [External] Re: [PATCH v5 2/4] serial: 8250: avoid potential
 PSLVERR issue
In-Reply-To: <CAEEQ3wnouWbVvkvhV1oB8MrOADNhN6BQB4-epUXa6cLYkKFRiw@mail.gmail.com>
Message-ID: <41066f2f-a690-83ef-5fbb-0bc1d956a19d@linux.intel.com>
References: <20250506112321.61710-1-cuiyunhui@bytedance.com> <20250506112321.61710-2-cuiyunhui@bytedance.com> <6801686d-a0b3-7093-1293-cdac6ad055e4@linux.intel.com> <CAEEQ3wnouWbVvkvhV1oB8MrOADNhN6BQB4-epUXa6cLYkKFRiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-607317035-1747045632=:929"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-607317035-1747045632=:929
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 12 May 2025, yunhui cui wrote:

> Hi Ilpo,
>=20
> On Tue, May 6, 2025 at 8:00=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Tue, 6 May 2025, Yunhui Cui wrote:
> >
> > > Failure to check the UART_LSR_DR before reading UART_RX, or the
> > > non-atomic nature of clearing the FIFO and reading UART_RX, poses
> > > potential risks that could lead to PSLVERR.
> >
> > Don't expect reader to know the condition how PSLVERR is triggered. I k=
now
> > it's worded out in the other patch but also explain it here.
> >
> > You're only explaining problem and missing what this patch does to solv=
e
> > the problem.
> >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >  drivers/tty/serial/8250/8250.h      | 13 +++++++++
> > >  drivers/tty/serial/8250/8250_port.c | 43 +++++++++++++++------------=
--
> > >  2 files changed, 35 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250=
/8250.h
> > > index b861585ca02a..6f97ff3a197d 100644
> > > --- a/drivers/tty/serial/8250/8250.h
> > > +++ b/drivers/tty/serial/8250/8250.h
> > > @@ -162,6 +162,19 @@ static inline u16 serial_lsr_in(struct uart_8250=
_port *up)
> > >       return lsr;
> > >  }
> > >
> > > +/*
> > > + * To avoid PSLVERR, check UART_LSR_DR in UART_LSR before
> > > + * reading UART_RX.
> > > + */
> > > +static inline void serial8250_discard_data(struct uart_8250_port *up=
)
> > > +{
> > > +     u16 lsr;
> > > +
> > > +     lsr =3D serial_in(up, UART_LSR);
> > > +     if (lsr & UART_LSR_DR)
> > > +             serial_in(up, UART_RX);
> > > +}
> > > +
> > >  /*
> > >   * For the 16C950
> > >   */
> > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial=
/8250/8250_port.c
> > > index a913135d5217..1666b965f6a0 100644
> > > --- a/drivers/tty/serial/8250/8250_port.c
> > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > @@ -1357,9 +1357,8 @@ static void autoconfig_irq(struct uart_8250_por=
t *up)
> > >       /* Synchronize UART_IER access against the console. */
> > >       uart_port_lock_irq(port);
> > >       serial_out(up, UART_IER, UART_IER_ALL_INTR);
> > > +     serial8250_discard_data(up);
> > >       uart_port_unlock_irq(port);
> > > -     serial_in(up, UART_LSR);
> > > -     serial_in(up, UART_RX);
> > >       serial_in(up, UART_IIR);
> > >       serial_in(up, UART_MSR);
> > >       serial_out(up, UART_TX, 0xFF);
> > > @@ -2137,25 +2136,22 @@ static void wait_for_xmitr(struct uart_8250_p=
ort *up, int bits)
> > >  static int serial8250_get_poll_char(struct uart_port *port)
> > >  {
> > >       struct uart_8250_port *up =3D up_to_u8250p(port);
> > > -     int status;
> > > +     int status =3D NO_POLL_CHAR;
> > >       u16 lsr;
> > > +     unsigned long flags;
> > >
> > >       serial8250_rpm_get(up);
> > >
> > > +     uart_port_lock_irqsave(port, &flags);
> > >       lsr =3D serial_port_in(port, UART_LSR);
> > > +     if (lsr & UART_LSR_DR)
> > > +             status =3D serial_port_in(port, UART_RX);
> > > +     uart_port_unlock_irqrestore(port, flags);
> > >
> > > -     if (!(lsr & UART_LSR_DR)) {
> > > -             status =3D NO_POLL_CHAR;
> > > -             goto out;
> > > -     }
> > > -
> > > -     status =3D serial_port_in(port, UART_RX);
> > > -out:
> > >       serial8250_rpm_put(up);
> > >       return status;
> >
> > Not a problem that originates from you, but IMO calling this variable
> > "status" is quite misleading when it is the character (or NO_POLL_CHAR
> > is no character is present).
> >
> > >  }
> > >
> > > -
> > >  static void serial8250_put_poll_char(struct uart_port *port,
> > >                        unsigned char c)
> > >  {
> > > @@ -2264,13 +2260,17 @@ int serial8250_do_startup(struct uart_port *p=
ort)
> > >        * Clear the FIFO buffers and disable them.
> > >        * (they will be reenabled in set_termios())
> > >        */
> > > +     uart_port_lock_irqsave(port, &flags);
> > >       serial8250_clear_fifos(up);
> > >
> > >       /*
> > > -      * Clear the interrupt registers.
> > > +      * Read UART_RX to clear interrupts (e.g., Character Timeout).
> > > +      * No data on UART_IIR_RX_TIMEOUT, UART_LSR_DR won't set.
> > > +      * FIFO disabled, read UART_RX without LSR check, no PSLVERR.
> >
> > I don't understand what the last two lines mean and I don't see the
> > connection to the code that is below the comment either, could you try =
to
> > rephrase the comment.
>=20
> The original intention was to check UART_LSR_DR first when reading
> UART_RX. However, the purpose of serial_port_in(port, UART_RX) here is
> to clear the interrupt, such as the interrupt caused by RX_TIMEOUT.

I understood the first sentence in the comment but the rest of it is very=
=20
cryptic and has many grammar issues too. Also, the extent of passive voice=
=20
there makes it hard to know who does what (UART / kernel).

> The logic for clearing the interrupt in the interrupt handling
> function of RX_TIMEOUT is !UART_LSR_DR. And to avoid PSLVERR, we need
> to check UART_LSR_DR first. To meet the requirements of both, the FIFO
> needs to be disabled.

The grammar is so broken, it failed to convey that message.

> Therefore, we should put serial8250_clear_fifos() and the execution of
> serial_port_in(port, UART_RX) without checking UART_LSR_DR under the
> port->lock.
>=20
> >
> > >        */
> > >       serial_port_in(port, UART_LSR);
> > >       serial_port_in(port, UART_RX);
> > > +     uart_port_unlock_irqrestore(port, flags);
> > >       serial_port_in(port, UART_IIR);
> > >       serial_port_in(port, UART_MSR);
> > >
> > > @@ -2429,15 +2429,14 @@ int serial8250_do_startup(struct uart_port *p=
ort)
> > >       }
> > >
> > >  dont_test_tx_en:
> > > -     uart_port_unlock_irqrestore(port, flags);
> > >
> > >       /*
> > >        * Clear the interrupt registers again for luck, and clear the
> > >        * saved flags to avoid getting false values from polling
> > >        * routines or the previous session.
> > >        */
> > > -     serial_port_in(port, UART_LSR);
> > > -     serial_port_in(port, UART_RX);
> > > +     serial8250_discard_data(up);
> > > +     uart_port_unlock_irqrestore(port, flags);
> > >       serial_port_in(port, UART_IIR);
> > >       serial_port_in(port, UART_MSR);
> > >       up->lsr_saved_flags =3D 0;
> > > @@ -2519,7 +2518,6 @@ void serial8250_do_shutdown(struct uart_port *p=
ort)
> > >               port->mctrl &=3D ~TIOCM_OUT2;
> > >
> > >       serial8250_set_mctrl(port, port->mctrl);
> > > -     uart_port_unlock_irqrestore(port, flags);
> > >
> > >       /*
> > >        * Disable break condition and FIFOs
> > > @@ -2527,6 +2525,14 @@ void serial8250_do_shutdown(struct uart_port *=
port)
> > >       serial_port_out(port, UART_LCR,
> > >                       serial_port_in(port, UART_LCR) & ~UART_LCR_SBC)=
;
> > >       serial8250_clear_fifos(up);
> > > +     /*
> > > +      * Read data port to reset things, and then unlink from
> > > +      * the IRQ chain.
> > > +      * Since reading UART_RX clears interrupts, doing so with
> > > +      * FIFO disabled won't trigger PSLVERR.
> > > +      */
> > > +     serial_port_in(port, UART_RX);
> > > +     uart_port_unlock_irqrestore(port, flags);
> > >
> > >  #ifdef CONFIG_SERIAL_8250_RSA
> > >       /*
> > > @@ -2535,11 +2541,6 @@ void serial8250_do_shutdown(struct uart_port *=
port)
> > >       disable_rsa(up);
> > >  #endif
> > >
> > > -     /*
> > > -      * Read data port to reset things, and then unlink from
> > > -      * the IRQ chain.
> > > -      */
> > > -     serial_port_in(port, UART_RX);
> > >       serial8250_rpm_put(up);
> > >
> > >       up->ops->release_irq(up);
> > >
> >
> > --
> >  i.
> >
>=20
> Thanks,
> Yunhui
>=20

--=20
 i.

--8323328-607317035-1747045632=:929--
