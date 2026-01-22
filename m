Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57672877F7
	for <linux-serial@vger.kernel.org>; Thu, 22 Jan 2026 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087915; cv=none; b=qZNPfsg/GsX1ygOrI51tY0usTuQCm51OQir+06l3Xf5KZJcAaYDCMW/LMYtdFuR9hP4GImxa8q9avbXgKAz2KcmAp6SU/pivBFs3e/o4W5JyGG7ijOUgBiyZGjWgHEl97eAl8V42t9hfFMbl4jk9wZ+u2Tbnj6fr2/4jFxupl5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087915; c=relaxed/simple;
	bh=augFc+32E0GJNteNOzS2Rs8Pcllxhh71466gFKkQl/0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Kp7xfkd4bGlHYUcaEaqYCbKfN++QgNxfkuwWJiTgnhDuTkhznSZSlXPLeIG4817ajLjKfst3qRdveFN+JUUiYNpAHz+8hSd0lliL8O2vBT3xINk2KXrfihS2A7kTTjXbfqvhOxDG4+z4TgzFJQ/3MrC1yZIGOj+ktjiFWJ9Di4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i11xMVe0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i11xMVe0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769087912; x=1800623912;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=augFc+32E0GJNteNOzS2Rs8Pcllxhh71466gFKkQl/0=;
  b=i11xMVe0/IdCkcCO7zKSqsnJqn1u2pImb+HS/ulwG1UUvDEce8qQjwXt
   2JijI8m80jpK69x8dn75UAbSSsYLrr1KWNhlFNkdnjjWlOPmadis+uGQQ
   G6QQfS6iqUR/Ss8V78OGR4LR6d8TFQlCoMnDDc90nm4GZ8V3IWHm11rvD
   AJ3XP7JjXo0yBD9WRgcpMCywIGhMUWMNqyklMAdzszyznA9U9Ruz3Ygv5
   8l9DwxtPtJpB7ZYKSwDmqCpgeK1n2u8OPUbaDlwt1IwDRn6VMKdPT9LGP
   ScMDQEj04/5J8lBNaGD2U0Es+fsLvmuX6sXD7/C9NL2LOGVNGzE4Az5p3
   A==;
X-CSE-ConnectionGUID: 3DwT3wYMTYG/uvzhr2JrxQ==
X-CSE-MsgGUID: GS0n30iBSr2X/XmjOaYfVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70228562"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70228562"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 05:18:32 -0800
X-CSE-ConnectionGUID: Sa+DnQZnS06g5cNaWYMgLg==
X-CSE-MsgGUID: D6et2zSlRSic6H3qJBv6Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211585876"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.15])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 05:18:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 22 Jan 2026 15:18:28 +0200 (EET)
To: Adriana Nicolae <adriana@arista.com>
cc: linux-serial <linux-serial@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, prasad@arista.com
Subject: Re: [PATCH] serial: 8250 dw: clear FIFO before writting LCR
In-Reply-To: <CAERbo5z2370GPWUNuSJuwZxga0se7CNH2XAnsnF-vtB7t6XREQ@mail.gmail.com>
Message-ID: <d93b7a48-c20f-5af5-080c-a5920304d60d@linux.intel.com>
References: <20250819182322.3451959-1-adriana@arista.com> <945af1e4-1d43-bd4b-6b07-733c06d18b17@linux.intel.com> <CAERbo5zSPSMyfSDQpw9-js=7kZHaB5mS9uib8RSw-Hqzwn3mGQ@mail.gmail.com> <6ab9afb2-e308-6231-e938-d28d05d62a9a@linux.intel.com>
 <CAERbo5xOg4OegoWYid3ZBCX1Fi+MBUMb59EtaQLrYkZy9MzSJA@mail.gmail.com> <21796013-0fa1-3d1f-9b89-173ef85c7508@linux.intel.com> <CAERbo5yjKDrVdfAZEAzWqeTSXoZJE_GZqbwov-4KGs1BPpwCiQ@mail.gmail.com> <faf3bae5-4656-7c47-d875-9103a5f2079e@linux.intel.com>
 <CAERbo5z2370GPWUNuSJuwZxga0se7CNH2XAnsnF-vtB7t6XREQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-846950400-1769087908=:1059"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-846950400-1769087908=:1059
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Jan 2026, Adriana Nicolae wrote:
> On Wed, Jan 21, 2026 at 4:31=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Fri, 31 Oct 2025, Adriana Nicolae wrote:
> > > On Wed, Oct 8, 2025 at 4:12=E2=80=AFPM Ilpo J=C3=A4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > On Wed, 8 Oct 2025, Adriana Nicolae wrote:
> > > > > Hello, Sorry for missing an update, the exact root cause is not c=
lear, currently the
> > > > > brute force method of draining FIFO right before setting or clear=
ing DLAB was stable
> > > > > during tests.
> > > > >
> > > > > The serial stuck seems to be a failed attempt to clear the DLAB.
> > > > > This operation fails because the USR indicates the hardware is
> > > > > still busy, even though the UART is in loopback mode and should
> > > > > be inactive.
> > > > >
> > > > > To isolate the issue, I tried the following without success:
> > > > > - Added delays: I inserted 100 repeated ndelay(p->frame_time)
> > > > > calls before and after enabling loopback mode to allow the FIFO
> > > > > to clear.
> > > > > - Cleared FIFO: I explicitly cleared the FIFO in addition to
> > > > > adding the delay.
> > > > > - Checked status: I printed the LSR just before the DLAB clear
> > > > > attempt and checked the USB busy bit.
> > > >
> > > > Okay, so the BUSY must be stuck asserted.
> > > >
> > > > Another idea, maybe test tx + rx over loopback to see if that manag=
es to
> > > > de-freeze the BUSY bit. A patch to that effect below.
> > > >
> > > > (I've only added the new block into dw8250_idle_enter() compared wi=
th the
> > > > old patch but rebasing to tty-next resulted in some other changes d=
ue to
> > > > conflicts.)
> > >
> > > I've tested the new dw8250_idle_enter() sequence, and you're right,
> > > the BUSY bit remains set after entering loopback mode.
> > >
> > > However, the sequence in the patch (including the single loopback
> > > tx/rx) wasn't quite enough. I didn't see any kernel panics or console
> > > stuck anymore, but I've monitored the traces and there were cases whe=
n
> > > the trace after "p->serial_out(p, UART_LCR, up->lcr);" showed both
> > > BUSY bit set and DLAB bit still enabled.
> > >
> > > >
> > > > Only thing besides BUSY being stuck asserted is something Tx'ing af=
ter the
> > > > idle enter sequence. I think we could trap/check that too in
> > > > dw8250_serial_out() by using something along these lines:
> > > >
> > > >         if (d->in_idle && offset =3D=3D UART_TX) {
> > > >                 WARN_ON_ONCE(1);
> > > >                 return;
> > > >         }
> > > >
> > > > (I think that should catch even console writes but I'm not 100% sur=
e of
> > > > that and it will should get us where the rogue Tx originates from).
> > >
> > > I also added the WARN_ON_ONCE check you suggested in
> > > dw8250_serial_out(). The warning has not triggered, so it seems we
> > > don't have a rogue Tx firing while in_idle is set.
> > >
> > > >
> > > > > The critical finding was that immediately before the DLAB clear
> > > > > operation (p->serial_out(p, UART_LCR, up->lcr);), the LSR value
> > > > > was 0x6a and the USR busy bit [0] was set. This confirms the UART
> > > > > is busy, which blocks the DLAB modification.
> > > > >
> > > > > This is occurring on a device with a single UART console. The set=
up
> > > > > does not use DMA or modem control; only the Rx/Tx lines are conne=
cted.
> > > > >
> > > > > The trace below, from a single process, shows one successful DLAB
> > > > > clear followed by a failing one. The second attempt repeatedly lo=
gs
> > > > > "USR still busy" before eventually succeeding. This can lead to
> > > > > subsequent failures in dw8250_check_lcr: dw8250_idle_entered.
> > > > >
> > > > > Trace Log:
> > > > >
> > > > > <...>-15440  8583.592533: dw8250_idle_enter: in_idle =3D 1
> > > > > login-15440  8583.713817: dw8250_idle_enter: in loopback mode
> > > > > login-15440  8583.835099: dw8250_idle_enter: LSR in loopback mode=
 is 0x63
> > > > > login-15440  8583.835103: dw8250_set_divisor: UART_LCR_DLAB clear=
ed 13
> > > > > login-15440  8583.835104: dw8250_idle_exit: idle exit
> > > > > login-15440  8583.835105: dw8250_idle_exit: out of loopback mode
> > > > > login-15440  8583.835105: dw8250_idle_exit: in_idle =3D 0
> > > > > login-15440  8583.835352: dw8250_idle_enter: in_idle =3D 1
> > > > > login-15440  8583.956633: dw8250_idle_enter: in loopback mode
> > > > > login-15440  8583.956638: dw8250_idle_enter: LSR in loopback mode=
 is 0x6a
> > > > > login-15440  8583.963918: dw8250_set_divisor: USR still busy dl_w=
rite
> > > > > login-15440  8584.000332: dw8250_set_divisor: USR still busy dl_w=
rite
> > > > > login-15440  8584.040385: dw8250_set_divisor: USR still busy dl_w=
rite
> > > > > login-15440  8584.078012: dw8250_set_divisor: UART_LCR_DLAB clear=
ed 93
> > > > > login-15440  8584.078013: dw8250_idle_exit: idle exit
> > > > > login-15440  8584.078014: dw8250_idle_exit: out of loopback mode
> > > > > login-15440  8584.078015: dw8250_idle_exit: in_idle =3D 0
> > > >
> > > >
> > > >
> > > > --
> > > > From 01df58736a10f7f34aca895ef08e5519953f8572 Mon Sep 17 00:00:00 2=
001
> > > > From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@lin=
ux.intel.com>
> > > > Date: Wed, 8 Oct 2025 15:40:19 +0300
> > > > Subject: [PATCH 1/1] serial: 8250_dw: Ensure BUSY is deasserted
> > > > MIME-Version: 1.0
> > > > Content-Type: text/plain; charset=3DUTF-8
> > > > Content-Transfer-Encoding: 8bit
> > > >
> > > > DW UART cannot write to LCR, DLL, and DLH while BUSY is asserted.
> > > > Existance of BUSY depends on uart_16550_compatible, if UART HW is
> > > > configured with 16550 compatible those registers can always be
> > > > written.
> > > >
> > > > There currently is dw8250_force_idle() which attempts to archive
> > > > non-BUSY state by disabling FIFO, however, the solution is unreliab=
le
> > > > when Rx keeps getting more and more characters.
> > > >
> > > > Create a sequence of operations to enforce that ensures UART cannot
> > > > keep BUSY asserted indefinitely. The new sequence relies on enablin=
g
> > > > loopback mode temporarily to prevent incoming Rx characters keeping
> > > > UART BUSY.
> > > >
> > > > Use the new dw8250_idle_enter/exit() to do divisor writes and LCR
> > > > writes.
> > > >
> > > > This issue was reported by qianfan Zhao who put lots of debugging
> > > > effort into understanding the solution space.
> > > >
> > > > Reported-by: qianfan Zhao <qianfanguijin@163.com>
> > > > Reported-by: Adriana Nicolae <adriana@arista.com>
> > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > > ---
> > > >  drivers/tty/serial/8250/8250_dw.c | 159 +++++++++++++++++++++-----=
----
> > > >  1 file changed, 115 insertions(+), 44 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial=
/8250/8250_dw.c
> > > > index a53ba04d9770..8e25dfe8e653 100644
> > > > --- a/drivers/tty/serial/8250/8250_dw.c
> > > > +++ b/drivers/tty/serial/8250/8250_dw.c
> > > > @@ -42,6 +42,8 @@
> > > >  /* DesignWare specific register fields */
> > > >  #define DW_UART_MCR_SIRE               BIT(6)
> > > >
> > > > +#define DW_UART_USR_BUSY               BIT(0)
> > > > +
> > > >  /* Renesas specific register fields */
> > > >  #define RZN1_UART_xDMACR_DMA_EN                BIT(0)
> > > >  #define RZN1_UART_xDMACR_1_WORD_BURST  (0 << 1)
> > > > @@ -77,6 +79,7 @@ struct dw8250_data {
> > > >
> > > >         unsigned int            skip_autocfg:1;
> > > >         unsigned int            uart_16550_compatible:1;
> > > > +       unsigned int            in_idle:1;
> > > >  };
> > > >
> > > >  static inline struct dw8250_data *to_dw8250_data(struct dw8250_por=
t_data *data)
> > > > @@ -108,36 +111,103 @@ static inline u32 dw8250_modify_msr(struct u=
art_port *p, unsigned int offset, u3
> > > >  }
> > > >
> > > >  /*
> > > > - * This function is being called as part of the uart_port::serial_=
out()
> > > > - * routine. Hence, it must not call serial_port_out() or serial_ou=
t()
> > > > - * against the modified registers here, i.e. LCR.
> > > > + * Ensure BUSY is not asserted. If DW UART is configured with
> > > > + * !uart_16550_compatible, the writes to LCR, DLL, and DLH fail wh=
ile
> > > > + * BUSY is asserted.
> > > > + *
> > > > + * Context: port's lock must be held
> > > >   */
> > > > -static void dw8250_force_idle(struct uart_port *p)
> > > > +static int dw8250_idle_enter(struct uart_port *p)
> > > >  {
> > > > +       struct dw8250_data *d =3D to_dw8250_data(p->private_data);
> > > >         struct uart_8250_port *up =3D up_to_u8250p(p);
> > > > -       unsigned int lsr;
> > > > +       u32 lsr;
> > > >
> > > > -       /*
> > > > -        * The following call currently performs serial_out()
> > > > -        * against the FCR register. Because it differs to LCR
> > > > -        * there will be no infinite loop, but if it ever gets
> > > > -        * modified, we might need a new custom version of it
> > > > -        * that avoids infinite recursion.
> > > > -        */
> > > > -       serial8250_clear_and_reinit_fifos(up);
> > > > +       if (d->uart_16550_compatible)
> > > > +               return 0;
> > > > +
> > > > +       d->in_idle =3D 1;
> > > > +
> > > > +       /* Prevent triggering interrupt from RBR filling */
> > > > +       p->serial_out(p, UART_IER, 0);
> > > > +
> > > > +       serial8250_rx_dma_flush(up);
> > > > +       // What about Tx DMA? Should probably pause that too and re=
sume
> > > > +       // afterwards.
> > > > +
> > > > +       p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
> > > > +       if (up->capabilities & UART_CAP_FIFO)
> > > > +               p->serial_out(p, UART_FCR, 0);
> > >
> > > Changing this to repeatedly clear the FIFO turned out to reliably
> > > clear the BUSY bit , also no kernel panic or device stuck in busy
> > > mode.
> > >
> > > On the device I tested the first clear is not always enough, under
> > > high load I saw it cleared on the second iteration. I'm thinking it
> > > might be some particular issue with the device I'm using where the
> > > first FIFO clear might fail. I never encountered more than 2
> > > iterations with a "ndelay(p->frame_time);" in between here to get out
> > > of BUSY state.
> >
> > Hi,
> >
> > I seem to have missed this email until now (I'm sorry about that, thoug=
h
> > to my defence, IIRC, I was quite sick around that timeframe it was sent
> > and clear the email backlog isn't ever fun and may end up missing
> > something).
> >
> > Do you mean changing this to a simple loop or writing something else th=
an
> > just 0 to FCR (or perhaps calling serial8250_clear_fifos())?
> >
> > What is the exact code that you found working?
> >
> Yes, everything worked ok for me after changing the dw8250_idle_enter
> function with the one below. From traces added in the function, it
> sometimes reported iterations_in_busy =3D 2 but never higher than that.
> The function only has the prepended "while(p->serial_in(p,
> d->pdata->usr_reg) & DW_UART_USR_BUSY) {" to iterate forever, although
> it was at most 2 iterations when serial was stressed:
> static int dw8250_idle_enter(struct uart_port *p)
> {
>     struct dw8250_data *d =3D to_dw8250_data(p->private_data);
>     struct uart_8250_port *up =3D up_to_u8250p(p);
>     u32 lsr, iterations_in_busy =3D 0;
>=20
>     if (d->uart_16550_compatible)
>         return 0;
>=20
>     d->in_idle =3D 1;
>=20
>     /* Prevent triggering interrupt from RBR filling */
>     p->serial_out(p, UART_IER, 0);
>=20
>     serial8250_rx_dma_flush(up);
>     // What about Tx DMA? Should probably pause that too and resume
>     // afterwards.
>     p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
>=20
>     while(p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY) {
>         if (up->capabilities & UART_CAP_FIFO) {
>             p->serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO);
>             p->serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO |
>                 UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
>             p->serial_out(p, UART_FCR, 0);

Thanks for the information!

Okay, so this is same as calling serial8250_clear_fifos() which is what=20
I'll do here.

>         }
>         ndelay(p->frame_time);
>         iterations_in_busy++;
>     }
>=20
>     trace_printk("Not busy got after %d\n", iterations_in_busy);
>     lsr =3D serial_lsr_in(up);
>     if (lsr & UART_LSR_DR) {
>         p->serial_in(p, UART_RX);
>         up->lsr_saved_flags =3D 0;
>     }
>=20
>         /*
>      * BUSY might still be frozen to asserted, try to de-freeze it by
>      * sending a character over the loopback and receiving it.
>          */
>     if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY) {
>         trace_printk("Serial USR still busy\n");
>         p->serial_out(p, UART_TX, 0);
>         ndelay(1000);
>         lsr =3D serial_lsr_in(up);
>=20
>         if (lsr & UART_LSR_DR) {
>             p->serial_in(p, UART_RX);
>             up->lsr_saved_flags =3D 0;
>         }
>         }

So I think this entire tx+rx de-freezing wasn't required at all? Adding=20
this was based on my guess how the driver could try to force BUSY=20
deassertion but if the FIFOs were the real culprit to the BUSY remaining=20
asserted, I'd prefer to remove this block entirely to not add random=20
complexity just for the sake of doing everything imaginable.

>      /* Now guaranteed to have BUSY deasserted? Just sanity check */
>     if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY) {
>         trace_printk("BUSY\n");
>         return -EBUSY;
>     }
>=20
>     return 0;
> }
> > So when you fixed this FIFO clearing thing, everything seemed to work o=
kay
> > after that?
> >
> > In the meantime, this issue has once again been reported to me by someb=
ody
> > else, and I've done improvements to shutdown code as well to address a
> > few BUSY related problems (I'll be posting a series that solved that
> > case soon but I suppose this patch needs amendments based on input from
> > your case).
> >
> > --
> >  i.
> >
> > > > +       if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY)
> > > > +               ndelay(p->frame_time);
> > > > +
> > > > +       lsr =3D serial_lsr_in(up);
> > > > +       if (lsr & UART_LSR_DR) {
> > > > +               p->serial_in(p, UART_RX);
> > > > +               up->lsr_saved_flags =3D 0;
> > > > +       }
> > > >
> > > >         /*
> > > > -        * With PSLVERR_RESP_EN parameter set to 1, the device gene=
rates an
> > > > -        * error response when an attempt to read an empty RBR with=
 FIFO
> > > > -        * enabled.
> > > > +        * BUSY might still be frozen to asserted, try to de-freeze=
 it by
> > > > +        * sending a character over the loopback and receiving it.
> > > >          */
> > > > -       if (up->fcr & UART_FCR_ENABLE_FIFO) {
> > > > -               lsr =3D serial_port_in(p, UART_LSR);
> > > > -               if (!(lsr & UART_LSR_DR))
> > > > -                       return;
> > > > +       if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY) =
{
> > > > +               p->serial_out(p, UART_TX, 0);
> > > > +               ndelay(p->frame_time);
> > > > +               lsr =3D serial_lsr_in(up);
> > > > +               if (lsr & UART_LSR_DR) {
> > > > +                       p->serial_in(p, UART_RX);
> > > > +                       up->lsr_saved_flags =3D 0;
> > > > +               }
> > > >         }
> > > >
> > > > -       serial_port_in(p, UART_RX);
> > > > +       /* Now guaranteed to have BUSY deasserted? Just sanity chec=
k */
> > > > +       if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY)
> > > > +               return -EBUSY;
> > > > +
> > > > +       return 0;
> > > > +}


--=20
 i.

--8323328-846950400-1769087908=:1059--
