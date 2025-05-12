Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA3219E97C;
	Mon, 12 May 2025 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747051370; cv=none; b=YLvKrgPoBEV4ZwfS20YF2PlAtBKXqECshyPvuBW6BatP2ppq0ARNyg+qBK5e4QMN4/WBC8AbSfEgTjHt9K1YwNTiI0RfgLAz9tVlpt8cazs1iOOqCcLKZUapcQOkPpMLUJ4OM58p5coNCmhNQiDSzfH1kPCGFtYT7SUasSwkgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747051370; c=relaxed/simple;
	bh=HPI21mZ9LiKt9b3HxWT9R23PWPJ2DrusEN/wAhQi5WI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fUNOf2VUl36HItb7WrqEyuiEP7bFY3f3B/8S6IsLU1WNPQR34EHyk8wF1Pc7KcaYlQ0QW3Un4PsuLrPAQ606rBGEYW/a1r5DbiMSChv7+DgzOQH75qjOIBcmXQF0Cj1T8Ki7xpBMPujI7GrNc0MMfHk4UQRO0PrrvMwXfo6hO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIbhuogt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIbhuogt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747051369; x=1778587369;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HPI21mZ9LiKt9b3HxWT9R23PWPJ2DrusEN/wAhQi5WI=;
  b=YIbhuogt0d1pKSUI6Cg/rCswBsss5uhcnoDbjQKC4yvM39nPpRCJoFUj
   iVzykhg6YliuEW91mYul3D714QM+xMcuROKRnz5g2OzSOhlQeIr2ol3tg
   7w4IaJLCjge+txHDfqsXBV+hnKfVhUgzn6xgyBnokTbw4jApq0nMe6rlB
   ildFwawv1EUwU1YB+FybaeMqgHWALuTS+Asqo93w1FS3uqZ0EnLqbonVb
   yDx4cN30eHEm8QhuaqLdUm1hsjRSRfVvvCQefuIjVMHur01D5/F7MWCnB
   go2Kp7O6SXoWojB3b9do3AW2S+8+p8iqjyaI4BfgkY4dx49eNwEcSb1xi
   g==;
X-CSE-ConnectionGUID: +0X9iqipQ1u99rtwkAgnnA==
X-CSE-MsgGUID: jDKU4uENQc2iTgYJh/6RyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52492827"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="52492827"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 05:02:48 -0700
X-CSE-ConnectionGUID: 4JW8kLaTTdaqQxB4/1iJ7A==
X-CSE-MsgGUID: nHQrLTOqQpGyHpF4Z3pYwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="137757349"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 05:02:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 May 2025 15:02:40 +0300 (EEST)
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
In-Reply-To: <CAEEQ3w=xPmbyaCHLPtCBgFOzz7TzDYMkOnKt=EvpdknQqot=cA@mail.gmail.com>
Message-ID: <34f3c38c-b224-8a4d-3235-c1df04ac1d04@linux.intel.com>
References: <20250506112321.61710-1-cuiyunhui@bytedance.com> <20250506112321.61710-2-cuiyunhui@bytedance.com> <6801686d-a0b3-7093-1293-cdac6ad055e4@linux.intel.com> <CAEEQ3wnouWbVvkvhV1oB8MrOADNhN6BQB4-epUXa6cLYkKFRiw@mail.gmail.com>
 <41066f2f-a690-83ef-5fbb-0bc1d956a19d@linux.intel.com> <CAEEQ3w=xPmbyaCHLPtCBgFOzz7TzDYMkOnKt=EvpdknQqot=cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-239501703-1747051360=:929"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-239501703-1747051360=:929
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 12 May 2025, yunhui cui wrote:

> Hi Ilpo,
>=20
> On Mon, May 12, 2025 at 6:27=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Mon, 12 May 2025, yunhui cui wrote:
> >
> > > Hi Ilpo,
> > >
> > > On Tue, May 6, 2025 at 8:00=E2=80=AFPM Ilpo J=C3=A4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > >
> > > > On Tue, 6 May 2025, Yunhui Cui wrote:
> > > >
> > > > > Failure to check the UART_LSR_DR before reading UART_RX, or the
> > > > > non-atomic nature of clearing the FIFO and reading UART_RX, poses
> > > > > potential risks that could lead to PSLVERR.
> > > >
> > > > Don't expect reader to know the condition how PSLVERR is triggered.=
 I know
> > > > it's worded out in the other patch but also explain it here.
> > > >
> > > > You're only explaining problem and missing what this patch does to =
solve
> > > > the problem.
> > > >
> > > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > > ---
> > > > >  drivers/tty/serial/8250/8250.h      | 13 +++++++++
> > > > >  drivers/tty/serial/8250/8250_port.c | 43 +++++++++++++++--------=
------
> > > > >  2 files changed, 35 insertions(+), 21 deletions(-)
> > > > >
> > > > > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/=
8250/8250.h
> > > > > index b861585ca02a..6f97ff3a197d 100644
> > > > > --- a/drivers/tty/serial/8250/8250.h
> > > > > +++ b/drivers/tty/serial/8250/8250.h
> > > > > @@ -162,6 +162,19 @@ static inline u16 serial_lsr_in(struct uart_=
8250_port *up)
> > > > >       return lsr;
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * To avoid PSLVERR, check UART_LSR_DR in UART_LSR before
> > > > > + * reading UART_RX.
> > > > > + */
> > > > > +static inline void serial8250_discard_data(struct uart_8250_port=
 *up)
> > > > > +{
> > > > > +     u16 lsr;
> > > > > +
> > > > > +     lsr =3D serial_in(up, UART_LSR);
> > > > > +     if (lsr & UART_LSR_DR)
> > > > > +             serial_in(up, UART_RX);
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * For the 16C950
> > > > >   */
> > > > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/se=
rial/8250/8250_port.c
> > > > > index a913135d5217..1666b965f6a0 100644
> > > > > --- a/drivers/tty/serial/8250/8250_port.c
> > > > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > > > @@ -1357,9 +1357,8 @@ static void autoconfig_irq(struct uart_8250=
_port *up)
> > > > >       /* Synchronize UART_IER access against the console. */
> > > > >       uart_port_lock_irq(port);
> > > > >       serial_out(up, UART_IER, UART_IER_ALL_INTR);
> > > > > +     serial8250_discard_data(up);
> > > > >       uart_port_unlock_irq(port);
> > > > > -     serial_in(up, UART_LSR);
> > > > > -     serial_in(up, UART_RX);
> > > > >       serial_in(up, UART_IIR);
> > > > >       serial_in(up, UART_MSR);
> > > > >       serial_out(up, UART_TX, 0xFF);
> > > > > @@ -2137,25 +2136,22 @@ static void wait_for_xmitr(struct uart_82=
50_port *up, int bits)
> > > > >  static int serial8250_get_poll_char(struct uart_port *port)
> > > > >  {
> > > > >       struct uart_8250_port *up =3D up_to_u8250p(port);
> > > > > -     int status;
> > > > > +     int status =3D NO_POLL_CHAR;
> > > > >       u16 lsr;
> > > > > +     unsigned long flags;
> > > > >
> > > > >       serial8250_rpm_get(up);
> > > > >
> > > > > +     uart_port_lock_irqsave(port, &flags);
> > > > >       lsr =3D serial_port_in(port, UART_LSR);
> > > > > +     if (lsr & UART_LSR_DR)
> > > > > +             status =3D serial_port_in(port, UART_RX);
> > > > > +     uart_port_unlock_irqrestore(port, flags);
> > > > >
> > > > > -     if (!(lsr & UART_LSR_DR)) {
> > > > > -             status =3D NO_POLL_CHAR;
> > > > > -             goto out;
> > > > > -     }
> > > > > -
> > > > > -     status =3D serial_port_in(port, UART_RX);
> > > > > -out:
> > > > >       serial8250_rpm_put(up);
> > > > >       return status;
> > > >
> > > > Not a problem that originates from you, but IMO calling this variab=
le
> > > > "status" is quite misleading when it is the character (or NO_POLL_C=
HAR
> > > > is no character is present).
> > > >
> > > > >  }
> > > > >
> > > > > -
> > > > >  static void serial8250_put_poll_char(struct uart_port *port,
> > > > >                        unsigned char c)
> > > > >  {
> > > > > @@ -2264,13 +2260,17 @@ int serial8250_do_startup(struct uart_por=
t *port)
> > > > >        * Clear the FIFO buffers and disable them.
> > > > >        * (they will be reenabled in set_termios())
> > > > >        */
> > > > > +     uart_port_lock_irqsave(port, &flags);
> > > > >       serial8250_clear_fifos(up);
> > > > >
> > > > >       /*
> > > > > -      * Clear the interrupt registers.
> > > > > +      * Read UART_RX to clear interrupts (e.g., Character Timeou=
t).
> > > > > +      * No data on UART_IIR_RX_TIMEOUT, UART_LSR_DR won't set.
> > > > > +      * FIFO disabled, read UART_RX without LSR check, no PSLVER=
R.
> > > >
> > > > I don't understand what the last two lines mean and I don't see the
> > > > connection to the code that is below the comment either, could you =
try to
> > > > rephrase the comment.
> > >
> > > The original intention was to check UART_LSR_DR first when reading
> > > UART_RX. However, the purpose of serial_port_in(port, UART_RX) here i=
s
> > > to clear the interrupt, such as the interrupt caused by RX_TIMEOUT.
> >
> > I understood the first sentence in the comment but the rest of it is ve=
ry
> > cryptic and has many grammar issues too. Also, the extent of passive vo=
ice
> > there makes it hard to know who does what (UART / kernel).
> >
> > > The logic for clearing the interrupt in the interrupt handling
> > > function of RX_TIMEOUT is !UART_LSR_DR. And to avoid PSLVERR, we need
> > > to check UART_LSR_DR first. To meet the requirements of both, the FIF=
O
> > > needs to be disabled.
> >
> > The grammar is so broken, it failed to convey that message.
>=20
> The purpose of serial_port_in(port, UART_RX) is to clear interrupts
> such as rx_timeout. In dw8250_handle_irq(), serial_port_in(p, UART_RX)
> is called when the LSR does not have the UART_LSR_DR bit set.
>=20
> To avoid PSLVERR when the FIFO is enabled, serial_in(up, UART_RX)
> should be called only when the LSR has the UART_LSR_DR bit set.
>=20
> These two logics are clearly contradictory. Therefore, both
> serial8250_clear_fifos() and serial_port_in(port, UART_RX) are placed
> under the protection of port->lock.
>=20
> If you believe this is not a potential issue, that's fine. I can
> remove this patch in the next patchset version.

No, my goal is not to get this removed from the patch series.

I meant that the comment wording needs to be fixed for the next version=20
such that it is understandable for those that are not deeply familiar with=
=20
what is related to PSLVERR. Currently even I struggle to follow what's=20
written into that comment (unless I read heavily between lines and base=20
guesses on the extra knowledge I've about how this entire patchset relates=
=20
to PSLVERR).

> > > Therefore, we should put serial8250_clear_fifos() and the execution o=
f
> > > serial_port_in(port, UART_RX) without checking UART_LSR_DR under the
> > > port->lock.
> > >
> > > >
> > > > >        */
> > > > >       serial_port_in(port, UART_LSR);
> > > > >       serial_port_in(port, UART_RX);
> > > > > +     uart_port_unlock_irqrestore(port, flags);
> > > > >       serial_port_in(port, UART_IIR);
> > > > >       serial_port_in(port, UART_MSR);
> > > > >
> > > > > @@ -2429,15 +2429,14 @@ int serial8250_do_startup(struct uart_por=
t *port)
> > > > >       }
> > > > >
> > > > >  dont_test_tx_en:
> > > > > -     uart_port_unlock_irqrestore(port, flags);
> > > > >
> > > > >       /*
> > > > >        * Clear the interrupt registers again for luck, and clear =
the
> > > > >        * saved flags to avoid getting false values from polling
> > > > >        * routines or the previous session.
> > > > >        */
> > > > > -     serial_port_in(port, UART_LSR);
> > > > > -     serial_port_in(port, UART_RX);
> > > > > +     serial8250_discard_data(up);
> > > > > +     uart_port_unlock_irqrestore(port, flags);
> > > > >       serial_port_in(port, UART_IIR);
> > > > >       serial_port_in(port, UART_MSR);
> > > > >       up->lsr_saved_flags =3D 0;
> > > > > @@ -2519,7 +2518,6 @@ void serial8250_do_shutdown(struct uart_por=
t *port)
> > > > >               port->mctrl &=3D ~TIOCM_OUT2;
> > > > >
> > > > >       serial8250_set_mctrl(port, port->mctrl);
> > > > > -     uart_port_unlock_irqrestore(port, flags);
> > > > >
> > > > >       /*
> > > > >        * Disable break condition and FIFOs
> > > > > @@ -2527,6 +2525,14 @@ void serial8250_do_shutdown(struct uart_po=
rt *port)
> > > > >       serial_port_out(port, UART_LCR,
> > > > >                       serial_port_in(port, UART_LCR) & ~UART_LCR_=
SBC);
> > > > >       serial8250_clear_fifos(up);
> > > > > +     /*
> > > > > +      * Read data port to reset things, and then unlink from
> > > > > +      * the IRQ chain.
> > > > > +      * Since reading UART_RX clears interrupts, doing so with
> > > > > +      * FIFO disabled won't trigger PSLVERR.
> > > > > +      */
> > > > > +     serial_port_in(port, UART_RX);
> > > > > +     uart_port_unlock_irqrestore(port, flags);
> > > > >
> > > > >  #ifdef CONFIG_SERIAL_8250_RSA
> > > > >       /*
> > > > > @@ -2535,11 +2541,6 @@ void serial8250_do_shutdown(struct uart_po=
rt *port)
> > > > >       disable_rsa(up);
> > > > >  #endif
> > > > >
> > > > > -     /*
> > > > > -      * Read data port to reset things, and then unlink from
> > > > > -      * the IRQ chain.
> > > > > -      */
> > > > > -     serial_port_in(port, UART_RX);
> > > > >       serial8250_rpm_put(up);
> > > > >
> > > > >       up->ops->release_irq(up);
> > > > >
> > > >
> > > > --
> > > >  i.
> > > >
> > >
> > > Thanks,
> > > Yunhui
> > >
> >
> > --
> >  i.
>=20
> Thanks,
> Yunhui
>=20

--=20
 i.

--8323328-239501703-1747051360=:929--
