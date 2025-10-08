Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039C621D3F4
	for <linux-serial@vger.kernel.org>; Wed,  8 Oct 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929129; cv=none; b=iEUs7/ElTm9JpBOwL57Yoc47dW4TgNpJbp2SPhJzWgktqMpUwzKjMF+CZYBdewF5/is9fgpSCzNUGqO/XsbAkb9nP8I0DN2jxaaKCKzwY4SbTYiTHjBRVXel1KVFVTQaTHJoTbljNVx2Js75IXPL/n0z4fogl56qL1/jaWPEYkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929129; c=relaxed/simple;
	bh=/jhQ24CSxC+jwge5sc2JJgi8Jc1tlRns/MQ4rUyi+d4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ig+lcTiimGLUvN8ckhW4t8yRk/YwsVbHiczNCK3bwThBhmDTvD60PAFLSD0g71qDeEHVVic4hBI7U6N0GtdRjHCBHyO7aMw2PlJXhEm/KGyERDNIzFsSoePxr3/n2+XWr53JwTjdATCxck1AjZCZAi6+oWWXuVIhaoezjaPGXoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYTsKsIz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYTsKsIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759929127; x=1791465127;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/jhQ24CSxC+jwge5sc2JJgi8Jc1tlRns/MQ4rUyi+d4=;
  b=cYTsKsIzfnIHkEYSOaNM2UxTzTBWJt0Mgs2TFq93INL37krNKAIQ91DN
   ACCEOnkhA0ESzFgwN1WSSYvrP7PufPRtqg1WZUbzBrsc8eSRflp6z1JPM
   X3QBPMi1CJ9ABWe1pTQIcpw12eDi4g/Y1BWVF9SAtb1XFuF4C677YEx0v
   YI4O9gXsfEJKf6PZ0Z3EXym9FFIvtzBlODbqHScH8UotjIFANEuMc1aBh
   5edvn5A4isQnyP9Rm+VTKyqUpM+J1HN6koCjcFm+Xj9pW4CC5cBF4KIL4
   OH3BLP3y5ieGIG0f5b/qxgTF+/DGphkIgERaHRDztWxJ2UQWvLPAUPKU1
   Q==;
X-CSE-ConnectionGUID: 0frH+TGZTWO3OkGtANfFjA==
X-CSE-MsgGUID: wBy2Qcm4RqOBvmXLWprsww==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="73548419"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="73548419"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 06:12:05 -0700
X-CSE-ConnectionGUID: L/saEPX/Rou4p4WNKqAWkA==
X-CSE-MsgGUID: Kg1MQOM8ThqseI4+YRnerw==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 06:12:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 Oct 2025 16:11:59 +0300 (EEST)
To: Adriana Nicolae <adriana@arista.com>
cc: linux-serial <linux-serial@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, prasad@arista.com
Subject: Re: [PATCH] serial: 8250 dw: clear FIFO before writting LCR
In-Reply-To: <CAERbo5xOg4OegoWYid3ZBCX1Fi+MBUMb59EtaQLrYkZy9MzSJA@mail.gmail.com>
Message-ID: <21796013-0fa1-3d1f-9b89-173ef85c7508@linux.intel.com>
References: <20250819182322.3451959-1-adriana@arista.com> <945af1e4-1d43-bd4b-6b07-733c06d18b17@linux.intel.com> <CAERbo5zSPSMyfSDQpw9-js=7kZHaB5mS9uib8RSw-Hqzwn3mGQ@mail.gmail.com> <6ab9afb2-e308-6231-e938-d28d05d62a9a@linux.intel.com>
 <CAERbo5xOg4OegoWYid3ZBCX1Fi+MBUMb59EtaQLrYkZy9MzSJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-780668117-1759929119=:950"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-780668117-1759929119=:950
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 8 Oct 2025, Adriana Nicolae wrote:
> Hello, Sorry for missing an update, the exact root cause is not clear, cu=
rrently the
> brute force method of draining FIFO right before setting or clearing DLAB=
 was stable
> during tests.
>=20
> The serial stuck seems to be a failed attempt to clear the DLAB.
> This operation fails because the USR indicates the hardware is
> still busy, even though the UART is in loopback mode and should
> be inactive.
>=20
> To isolate the issue, I tried the following without success:
> - Added delays: I inserted 100 repeated ndelay(p->frame_time)
> calls before and after enabling loopback mode to allow the FIFO
> to clear.
> - Cleared FIFO: I explicitly cleared the FIFO in addition to
> adding the delay.
> - Checked status: I printed the LSR just before the DLAB clear
> attempt and checked the USB busy bit.

Okay, so the BUSY must be stuck asserted.

Another idea, maybe test tx + rx over loopback to see if that manages to=20
de-freeze the BUSY bit. A patch to that effect below.

(I've only added the new block into dw8250_idle_enter() compared with the=
=20
old patch but rebasing to tty-next resulted in some other changes due to=20
conflicts.)


Only thing besides BUSY being stuck asserted is something Tx'ing after the=
=20
idle enter sequence. I think we could trap/check that too in=20
dw8250_serial_out() by using something along these lines:

=09if (d->in_idle && offset =3D=3D UART_TX) {
=09=09WARN_ON_ONCE(1);
=09=09return;
=09}

(I think that should catch even console writes but I'm not 100% sure of=20
that and it will should get us where the rogue Tx originates from).

> The critical finding was that immediately before the DLAB clear
> operation (p->serial_out(p, UART_LCR, up->lcr);), the LSR value
> was 0x6a and the USR busy bit [0] was set. This confirms the UART
> is busy, which blocks the DLAB modification.
>=20
> This is occurring on a device with a single UART console. The setup
> does not use DMA or modem control; only the Rx/Tx lines are connected.
>=20
> The trace below, from a single process, shows one successful DLAB
> clear followed by a failing one. The second attempt repeatedly logs
> "USR still busy" before eventually succeeding. This can lead to
> subsequent failures in dw8250_check_lcr: dw8250_idle_entered.
>=20
> Trace Log:
>=20
> <...>-15440 =C2=A08583.592533: dw8250_idle_enter: in_idle =3D 1
> login-15440 =C2=A08583.713817: dw8250_idle_enter: in loopback mode
> login-15440 =C2=A08583.835099: dw8250_idle_enter: LSR in loopback mode is=
 0x63
> login-15440 =C2=A08583.835103: dw8250_set_divisor: UART_LCR_DLAB cleared =
13
> login-15440 =C2=A08583.835104: dw8250_idle_exit: idle exit
> login-15440 =C2=A08583.835105: dw8250_idle_exit: out of loopback mode
> login-15440 =C2=A08583.835105: dw8250_idle_exit: in_idle =3D 0
> login-15440 =C2=A08583.835352: dw8250_idle_enter: in_idle =3D 1
> login-15440 =C2=A08583.956633: dw8250_idle_enter: in loopback mode
> login-15440 =C2=A08583.956638: dw8250_idle_enter: LSR in loopback mode is=
 0x6a
> login-15440 =C2=A08583.963918: dw8250_set_divisor: USR still busy dl_writ=
e =C2=A0 =C2=A0 =C2=A0
> login-15440 =C2=A08584.000332: dw8250_set_divisor: USR still busy dl_writ=
e
> login-15440 =C2=A08584.040385: dw8250_set_divisor: USR still busy dl_writ=
e
> login-15440 =C2=A08584.078012: dw8250_set_divisor: UART_LCR_DLAB cleared =
93
> login-15440 =C2=A08584.078013: dw8250_idle_exit: idle exit
> login-15440 =C2=A08584.078014: dw8250_idle_exit: out of loopback mode
> login-15440 =C2=A08584.078015: dw8250_idle_exit: in_idle =3D 0



--
From=2001df58736a10f7f34aca895ef08e5519953f8572 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.intel=
=2Ecom>
Date: Wed, 8 Oct 2025 15:40:19 +0300
Subject: [PATCH 1/1] serial: 8250_dw: Ensure BUSY is deasserted
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

DW UART cannot write to LCR, DLL, and DLH while BUSY is asserted.
Existance of BUSY depends on uart_16550_compatible, if UART HW is
configured with 16550 compatible those registers can always be
written.

There currently is dw8250_force_idle() which attempts to archive
non-BUSY state by disabling FIFO, however, the solution is unreliable
when Rx keeps getting more and more characters.

Create a sequence of operations to enforce that ensures UART cannot
keep BUSY asserted indefinitely. The new sequence relies on enabling
loopback mode temporarily to prevent incoming Rx characters keeping
UART BUSY.

Use the new dw8250_idle_enter/exit() to do divisor writes and LCR
writes.

This issue was reported by qianfan Zhao who put lots of debugging
effort into understanding the solution space.

Reported-by: qianfan Zhao <qianfanguijin@163.com>
Reported-by: Adriana Nicolae <adriana@arista.com>
Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 159 +++++++++++++++++++++---------
 1 file changed, 115 insertions(+), 44 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/82=
50_dw.c
index a53ba04d9770..8e25dfe8e653 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -42,6 +42,8 @@
 /* DesignWare specific register fields */
 #define DW_UART_MCR_SIRE=09=09BIT(6)
=20
+#define DW_UART_USR_BUSY=09=09BIT(0)
+
 /* Renesas specific register fields */
 #define RZN1_UART_xDMACR_DMA_EN=09=09BIT(0)
 #define RZN1_UART_xDMACR_1_WORD_BURST=09(0 << 1)
@@ -77,6 +79,7 @@ struct dw8250_data {
=20
 =09unsigned int=09=09skip_autocfg:1;
 =09unsigned int=09=09uart_16550_compatible:1;
+=09unsigned int=09=09in_idle:1;
 };
=20
 static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data *=
data)
@@ -108,36 +111,103 @@ static inline u32 dw8250_modify_msr(struct uart_port=
 *p, unsigned int offset, u3
 }
=20
 /*
- * This function is being called as part of the uart_port::serial_out()
- * routine. Hence, it must not call serial_port_out() or serial_out()
- * against the modified registers here, i.e. LCR.
+ * Ensure BUSY is not asserted. If DW UART is configured with
+ * !uart_16550_compatible, the writes to LCR, DLL, and DLH fail while
+ * BUSY is asserted.
+ *
+ * Context: port's lock must be held
  */
-static void dw8250_force_idle(struct uart_port *p)
+static int dw8250_idle_enter(struct uart_port *p)
 {
+=09struct dw8250_data *d =3D to_dw8250_data(p->private_data);
 =09struct uart_8250_port *up =3D up_to_u8250p(p);
-=09unsigned int lsr;
+=09u32 lsr;
=20
-=09/*
-=09 * The following call currently performs serial_out()
-=09 * against the FCR register. Because it differs to LCR
-=09 * there will be no infinite loop, but if it ever gets
-=09 * modified, we might need a new custom version of it
-=09 * that avoids infinite recursion.
-=09 */
-=09serial8250_clear_and_reinit_fifos(up);
+=09if (d->uart_16550_compatible)
+=09=09return 0;
+
+=09d->in_idle =3D 1;
+
+=09/* Prevent triggering interrupt from RBR filling */
+=09p->serial_out(p, UART_IER, 0);
+
+=09serial8250_rx_dma_flush(up);
+=09// What about Tx DMA? Should probably pause that too and resume
+=09// afterwards.
+
+=09p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
+=09if (up->capabilities & UART_CAP_FIFO)
+=09=09p->serial_out(p, UART_FCR, 0);
+
+=09if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY)
+=09=09ndelay(p->frame_time);
+
+=09lsr =3D serial_lsr_in(up);
+=09if (lsr & UART_LSR_DR) {
+=09=09p->serial_in(p, UART_RX);
+=09=09up->lsr_saved_flags =3D 0;
+=09}
=20
 =09/*
-=09 * With PSLVERR_RESP_EN parameter set to 1, the device generates an
-=09 * error response when an attempt to read an empty RBR with FIFO
-=09 * enabled.
+=09 * BUSY might still be frozen to asserted, try to de-freeze it by
+=09 * sending a character over the loopback and receiving it.
 =09 */
-=09if (up->fcr & UART_FCR_ENABLE_FIFO) {
-=09=09lsr =3D serial_port_in(p, UART_LSR);
-=09=09if (!(lsr & UART_LSR_DR))
-=09=09=09return;
+=09if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY) {
+=09=09p->serial_out(p, UART_TX, 0);
+=09=09ndelay(p->frame_time);
+=09=09lsr =3D serial_lsr_in(up);
+=09=09if (lsr & UART_LSR_DR) {
+=09=09=09p->serial_in(p, UART_RX);
+=09=09=09up->lsr_saved_flags =3D 0;
+=09=09}
 =09}
=20
-=09serial_port_in(p, UART_RX);
+=09/* Now guaranteed to have BUSY deasserted? Just sanity check */
+=09if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY)
+=09=09return -EBUSY;
+
+=09return 0;
+}
+
+static void dw8250_idle_exit(struct uart_port *p)
+{
+=09struct dw8250_data *d =3D to_dw8250_data(p->private_data);
+=09struct uart_8250_port *up =3D up_to_u8250p(p);
+
+=09if (d->uart_16550_compatible)
+=09=09return;
+
+=09if (up->capabilities & UART_CAP_FIFO)
+=09=09p->serial_out(p, UART_FCR, up->fcr);
+=09p->serial_out(p, UART_MCR, up->mcr);
+=09p->serial_out(p, UART_IER, up->ier);
+
+=09// Maybe move the DMA Rx restart check in dma_rx_complete() to own
+=09// function (serial8250_rx_dma_restart()) and call it from here.
+=09// DMA Tx resume
+
+=09d->in_idle =3D 0;
+}
+
+static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
+=09=09=09       unsigned int quot, unsigned int quot_frac)
+{
+=09struct uart_8250_port *up =3D up_to_u8250p(p);
+=09int ret;
+
+=09ret =3D dw8250_idle_enter(p);
+=09if (ret < 0)
+=09=09goto idle_failed;
+
+=09p->serial_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
+=09if (!(p->serial_in(p, UART_LCR) & UART_LCR_DLAB))
+=09=09goto idle_failed;
+
+=09serial_dl_write(up, quot);
+=09p->serial_out(p, UART_LCR, up->lcr);
+
+idle_failed:
+=09dw8250_idle_exit(p);
 }
=20
 /*
@@ -148,37 +218,37 @@ static void dw8250_force_idle(struct uart_port *p)
 static void dw8250_check_lcr(struct uart_port *p, unsigned int offset, u32=
 value)
 {
 =09struct dw8250_data *d =3D to_dw8250_data(p->private_data);
-=09void __iomem *addr =3D p->membase + (offset << p->regshift);
-=09int tries =3D 1000;
+=09u32 lcr =3D p->serial_in(p, UART_LCR);
+=09int ret;
=20
 =09if (offset !=3D UART_LCR || d->uart_16550_compatible)
 =09=09return;
=20
 =09/* Make sure LCR write wasn't ignored */
-=09while (tries--) {
-=09=09u32 lcr =3D serial_port_in(p, offset);
-
-=09=09if ((value & ~UART_LCR_SPAR) =3D=3D (lcr & ~UART_LCR_SPAR))
-=09=09=09return;
+=09if ((value & ~UART_LCR_SPAR) =3D=3D (lcr & ~UART_LCR_SPAR))
+=09=09return;
=20
-=09=09dw8250_force_idle(p);
+=09if (d->in_idle) {
+=09=09/*
+=09=09 * FIXME: this deadlocks if port->lock is already held
+=09=09 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
+=09=09 */
+=09=09return;
+=09}
=20
-#ifdef CONFIG_64BIT
-=09=09if (p->type =3D=3D PORT_OCTEON)
-=09=09=09__raw_writeq(value & 0xff, addr);
-=09=09else
-#endif
-=09=09if (p->iotype =3D=3D UPIO_MEM32)
-=09=09=09writel(value, addr);
-=09=09else if (p->iotype =3D=3D UPIO_MEM32BE)
-=09=09=09iowrite32be(value, addr);
-=09=09else
-=09=09=09writeb(value, addr);
+=09ret =3D dw8250_idle_enter(p);
+=09if (ret < 0) {
+=09=09/*
+=09=09 * FIXME: this deadlocks if port->lock is already held
+=09=09 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
+=09=09 */
+=09=09goto idle_failed;
 =09}
-=09/*
-=09 * FIXME: this deadlocks if port->lock is already held
-=09 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
-=09 */
+
+=09p->serial_out(p, UART_LCR, value);
+
+idle_failed:
+=09dw8250_idle_exit(p);
 }
=20
 /* Returns once the transmitter is empty or we run out of retries */
@@ -547,6 +617,7 @@ static int dw8250_probe(struct platform_device *pdev)
 =09p->dev=09=09=3D dev;
 =09p->set_ldisc=09=3D dw8250_set_ldisc;
 =09p->set_termios=09=3D dw8250_set_termios;
+=09p->set_divisor=09=3D dw8250_set_divisor;
=20
 =09data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 =09if (!data)

base-commit: d21b26cad33250be758ea9d860ff9d5c3992c459
--=20
2.39.5

--8323328-780668117-1759929119=:950--
