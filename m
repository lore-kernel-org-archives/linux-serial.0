Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EB524BC07;
	Wed, 16 Apr 2025 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805080; cv=none; b=GQHVUAjVxVS5nT2LdLuJK3H+Rev40+kDBylsrmQSmR2QUYw+GRRmpHANEKOE2QHixWHOyWZToLi4ShHfxE038LVqTxp25kNZUnFtVQPTJYK/EsBKof6iy3ieFlJS/lVCFP8AbsTMNubPydIbeYtyR6NWMk4Utybfb2xvfMd9dvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805080; c=relaxed/simple;
	bh=dt2pl/21XRjfjBSr9SoElSDtuTvPIB2ynsRrkiCn1mM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CVd5SthaZSUyz7cx/oSCc9AAdKILT4nTDnReaMe5JuDE4XOvo+d614qmjbIM1+cyFXWc3rjLZz6pmkYIbUg1iSJwKessRJGXbXyCC7WjqXLrXt23xcFok1z/JXOJcwss0CmrGgYwRpRPe8pKbHIpQynHWtfFl+lKq8BSamymqrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3j/TddK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3j/TddK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744805078; x=1776341078;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dt2pl/21XRjfjBSr9SoElSDtuTvPIB2ynsRrkiCn1mM=;
  b=F3j/TddKj7z3fRH6vzjuJL8Hrtz4PkiVfM3CN7T5sZUFTm9/Yl52jS2W
   1OdKO71tDZkmxI5+CkD8FXfE1lPdMgtC/JDDAuk0Cr6q3pxxTOmOVs/so
   usCQ7Ha0Ben+jO0CS3Qc1PkEji6kvL1lThCdSq9fJggQ2y8UjenPu/oIi
   0smqQEAdEn0uBtB/PNPBXRAvlj441Ww274MHwgOTUz3KDKq7WiDSSIel/
   SlCvg37y6UTJm+QeSWySAmqOL6AFBHAPqheZLXKGEJksOsIyQkDWnNHtu
   oTKfONB8gHSjHy+yNHkNDxdVzKwLnDpcyNlsrFExcEfLffgVAhiwaZLA/
   A==;
X-CSE-ConnectionGUID: hBjtIx6+TNKJvrV5wVj24w==
X-CSE-MsgGUID: p6XsZkwhSOyXOdjirAop8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="50169671"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="50169671"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 05:04:37 -0700
X-CSE-ConnectionGUID: DU29bHeIQLedJe1U/CMbgA==
X-CSE-MsgGUID: ZHkiVqJCROGHHUS6kGoLAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="153654670"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.243])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 05:04:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 16 Apr 2025 15:04:27 +0300 (EEST)
To: Yunhui Cui <cuiyunhui@bytedance.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, john.ogness@linutronix.de, 
    pmladek@suse.com, arnd@arndb.de, namcao@linutronix.de, 
    benjamin.larsson@genexis.eu, schnelle@linux.ibm.com, 
    heikki.krogerus@linux.intel.com, markus.mayer@linaro.org, 
    tim.kryger@linaro.org, matt.porter@linaro.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3] serial: 8250: fix panic due to PSLVERR
In-Reply-To: <079c8fe6-9ce4-fa59-4b44-93e27dd376d6@linux.intel.com>
Message-ID: <6f4ed9f5-a6c7-e690-98e2-2d18ed20cc22@linux.intel.com>
References: <20250414031450.42237-1-cuiyunhui@bytedance.com> <079c8fe6-9ce4-fa59-4b44-93e27dd376d6@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1067653622-1744805067=:991"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1067653622-1744805067=:991
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 14 Apr 2025, Ilpo J=E4rvinen wrote:

> On Mon, 14 Apr 2025, Yunhui Cui wrote:
>=20
> > When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> > an error response if an attempt is made to read an empty RBR (Receive
> > Buffer Register) while the FIFO is enabled.
> >=20
> > In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> > UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> > dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> > function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> > Execution proceeds to the dont_test_tx_en label:
> > ...
> > serial_port_in(port, UART_RX);
> > This satisfies the PSLVERR trigger condition.
> >=20
> > Because another CPU(e.g., using printk()) is accessing the UART (UART
> > is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) =3D=
=3D
> > (lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().
> >=20
> > To fix this, all calls to serial_out(UART_LCR) and serial_in(UART_RX)
> > should be executed under port->lock. Additionally, checking the readine=
ss
> > via UART_LSR should also be done under port->lock.
> >=20
> > Panic backtrace:
> > [    0.442336] Oops - unknown exception [#1]
> > [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> > [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> > ...
> > [    0.442416] console_on_rootfs+0x26/0x70
> >=20
> > Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaroun=
d")
> > Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/=
T/
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>=20
> As Andy mentioned, this change looks it would benefit from splitting to=
=20
> multiple parts.
>=20
> However, this change brings back some memories from a few years back.
> Back then, there was a reporter who had issues issues related to=20
> dw8250_force_idle() or writing some of the registers (IIRC). I ended up=
=20
> looking into finding a better solution to the write-while-BUSY problem=20
> which entirely replaced dw8250_force_idle() that is quite hacky and seems=
=20
> unreliable on fundamendal level.
>=20
> Sadly, once I had posted a patch for testing, the reporter went dead=20
> silent so the patch was left rotting as I had no time to try to reproduce=
=2E
>=20
> Perhaps the patch I created back then would be useful for addressing this=
=20
> problem you're facing (the patch is attached). I've rebased the patch on=
=20
> top of the tty-next now (but I did no testing beyond compiling). There ar=
e=20
> a few further thoughts / missing bits mentioned in the comments within th=
e=20
> patch itself (I did not try to updated them now, so the comments may have=
=20
> rotten too).

After some further thinking. I realized you're interested in the opposite=
=20
case (empty rx), whereas my patch focused on addressing (rx getting=20
refilled constantly) so it doesn't seem that useful for your case. The=20
patch shows though the direction I'd like to head with idle forcing=20
approach.

--
 i.

> > ---
> >  drivers/tty/serial/8250/8250_dw.c   |  8 +++++
> >  drivers/tty/serial/8250/8250_port.c | 46 ++++++++++++++++++-----------
> >  2 files changed, 36 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
> > index af24ec25d976..e97200ff30e3 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/io.h>
> > +#include <linux/lockdep.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> >  #include <linux/notifier.h>
> > @@ -112,6 +113,13 @@ static void dw8250_force_idle(struct uart_port *p)
> >  =09struct uart_8250_port *up =3D up_to_u8250p(p);
> >  =09unsigned int lsr;
> > =20
> > +=09/*
> > +=09 * Serial_in(p, UART_RX) should be under port->lock, but we can't a=
dd
> > +=09 * it to avoid AA deadlock as we're unsure if serial_out*(...UART_L=
CR)
> > +=09 * is under port->lock.
> > +=09 */
> > +=09lockdep_assert_held_once(&p->lock);
> > +
> >  =09serial8250_clear_and_reinit_fifos(up);
> > =20
> >  =09/*
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 3f256e96c722..21bbd18195f5 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1328,6 +1328,7 @@ static void autoconfig_irq(struct uart_8250_port =
*up)
> >  =09unsigned int ICP =3D 0;
> >  =09unsigned long irqs;
> >  =09int irq;
> > +=09u16 lsr;
> > =20
> >  =09if (port->flags & UPF_FOURPORT) {
> >  =09=09ICP =3D (port->iobase & 0xfe0) | 0x1f;
> > @@ -1357,9 +1358,10 @@ static void autoconfig_irq(struct uart_8250_port=
 *up)
> >  =09/* Synchronize UART_IER access against the console. */
> >  =09uart_port_lock_irq(port);
> >  =09serial_out(up, UART_IER, UART_IER_ALL_INTR);
> > +=09lsr =3D serial_in(up, UART_LSR);
> > +=09if (lsr & UART_LSR_DR)
> > +=09=09serial_port_in(port, UART_RX);
> >  =09uart_port_unlock_irq(port);
> > -=09serial_in(up, UART_LSR);
> > -=09serial_in(up, UART_RX);
> >  =09serial_in(up, UART_IIR);
> >  =09serial_in(up, UART_MSR);
> >  =09serial_out(up, UART_TX, 0xFF);
> > @@ -2137,19 +2139,16 @@ static void wait_for_xmitr(struct uart_8250_por=
t *up, int bits)
> >  static int serial8250_get_poll_char(struct uart_port *port)
> >  {
> >  =09struct uart_8250_port *up =3D up_to_u8250p(port);
> > -=09int status;
> > +=09int status =3D NO_POLL_CHAR;
> >  =09u16 lsr;
> > =20
> >  =09serial8250_rpm_get(up);
> > =20
> > +=09uart_port_lock_irqsave(port, &flags);
> >  =09lsr =3D serial_port_in(port, UART_LSR);
> > -
> > -=09if (!(lsr & UART_LSR_DR)) {
> > -=09=09status =3D NO_POLL_CHAR;
> > -=09=09goto out;
> > -=09}
> > -
> > -=09status =3D serial_port_in(port, UART_RX);
> > +=09if ((lsr & UART_LSR_DR))
> > +=09=09status =3D serial_port_in(port, UART_RX);
> > +=09uart_port_unlock_irqrestore(port, flags);
> >  out:
> >  =09serial8250_rpm_put(up);
> >  =09return status;
> > @@ -2264,13 +2263,16 @@ int serial8250_do_startup(struct uart_port *por=
t)
> >  =09 * Clear the FIFO buffers and disable them.
> >  =09 * (they will be reenabled in set_termios())
> >  =09 */
> > +=09uart_port_lock_irqsave(port, &flags);
> >  =09serial8250_clear_fifos(up);
> > =20
> >  =09/*
> >  =09 * Clear the interrupt registers.
> >  =09 */
> > -=09serial_port_in(port, UART_LSR);
> > -=09serial_port_in(port, UART_RX);
> > +=09lsr =3D serial_port_in(port, UART_LSR);
> > +=09if (lsr & UART_LSR_DR)
> > +=09=09serial_port_in(port, UART_RX);
> > +=09uart_port_unlock_irqrestore(port, flags);
> >  =09serial_port_in(port, UART_IIR);
> >  =09serial_port_in(port, UART_MSR);
> > =20
> > @@ -2380,9 +2382,10 @@ int serial8250_do_startup(struct uart_port *port=
)
> >  =09/*
> >  =09 * Now, initialize the UART
> >  =09 */
> > -=09serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> > =20
> >  =09uart_port_lock_irqsave(port, &flags);
> > +=09serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> > +
> >  =09if (up->port.flags & UPF_FOURPORT) {
> >  =09=09if (!up->port.irq)
> >  =09=09=09up->port.mctrl |=3D TIOCM_OUT1;
> > @@ -2428,15 +2431,16 @@ int serial8250_do_startup(struct uart_port *por=
t)
> >  =09}
> > =20
> >  dont_test_tx_en:
>=20
> I don't see this in the tty-next branch?
>=20
> ~/linux/tty-next$ git grep dont_test_tx_en | cat -
> ~/linux/tty-next$=20
>=20
>=20
--8323328-1067653622-1744805067=:991--
