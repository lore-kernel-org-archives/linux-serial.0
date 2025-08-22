Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807C1A5BB1
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853577; cv=none; b=NCEZfQV3SFFb69qnkeg2sQ/lHCcLFA1UHJ6f5B0SSe8sEojHHAHMMrnt7pNs0b+annjX9Y7uCvyzqH+MXNj9xgnMy6ZRbH4/J9emHpmBk4dB+xeI9hy2M97soTpSyj9o5Z9ksTlNYKn5fHX4w8yWWNO/czjDeL5FplRJ26ISK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853577; c=relaxed/simple;
	bh=B7QeYBFHIW5pNtPJgpB9T7cbXy6L2F/c/NIrA2hpFxk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VXsLIwbaWQ65yGdeG69+9/6lb2nbCByjmL6JspTLedrNph/mIdGPzVgmvyV8I+0Ulco+AW6fd35+5tz0AwVZe2yz57vsh/3+pVYtN53RZlrHN3UDyn2s26yVucnrFBqH0hakI/zg3TmA2yBZgGaHXE+xl7vTAyBOK45DsPPdioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgCYNzTL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgCYNzTL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755853574; x=1787389574;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=B7QeYBFHIW5pNtPJgpB9T7cbXy6L2F/c/NIrA2hpFxk=;
  b=TgCYNzTL+ZQn0y6si/lRV0cyymdJjFoLYI39cEG9U4x4VGO56Zst0x+R
   UVqgYviad8n890q2BMgl6DGYWZs1dxCtjE1Ka2Ei3JAdEwEynvtwbH7J0
   seMr8vjtoPiYSDUMWaACYnNa2mgN7m+aUZfzqxMgcRVEjNbG6l8Tx6efH
   88KHIAJcTJz1EnPmAJTOY1is0m3dqCBEgVEketjC815DKk6Gom5MTCmLl
   e1a0BI1bXrNM04pMmZjC44XRKeSvpN0kFjZly+y1jqLqhn2zUkLgB1zPI
   aVx7hqNSHH+8GASshRV+fcUcPVmYjTavSylpnt3FWW7Aiho87+8Hpnckp
   w==;
X-CSE-ConnectionGUID: VRfnvWG5TUy6+gFTLGY3rA==
X-CSE-MsgGUID: 95ybw4sETkaniksohbyNvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57359372"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57359372"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:06:13 -0700
X-CSE-ConnectionGUID: 7PY6bXezSYq1gccKX1amkg==
X-CSE-MsgGUID: 5NMZe5dXT8mpmvs/qqZToA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="199540260"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:06:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 22 Aug 2025 12:06:08 +0300 (EEST)
To: Adriana Nicolae <adriana@arista.com>
cc: linux-serial <linux-serial@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, prasad@arista.com
Subject: Re: [PATCH] serial: 8250 dw: clear FIFO before writting LCR
In-Reply-To: <CAERbo5zSPSMyfSDQpw9-js=7kZHaB5mS9uib8RSw-Hqzwn3mGQ@mail.gmail.com>
Message-ID: <c270c73b-cd16-5ce4-1d9b-9aa60ea1e2a9@linux.intel.com>
References: <20250819182322.3451959-1-adriana@arista.com> <945af1e4-1d43-bd4b-6b07-733c06d18b17@linux.intel.com> <CAERbo5zSPSMyfSDQpw9-js=7kZHaB5mS9uib8RSw-Hqzwn3mGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-83200775-1755852379=:937"
Content-ID: <0bc0ff33-190a-d977-cd4a-3f08175564fb@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-83200775-1755852379=:937
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <72009618-0e37-fab8-68e0-bf89429eba4d@linux.intel.com>

On Fri, 22 Aug 2025, Adriana Nicolae wrote:

> On Wed, Aug 20, 2025 at 1:02=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Tue, 19 Aug 2025, adriana@arista.com wrote:
> >
> > > This patch is proposing a custom configuration for Synopsys DesignWar=
e
> >
> > Please try to avoid starting sentences in the changelog with "This patc=
h"
> > or other wordings with similar meaning. Write imperatively instead.
> >
> > Preferrable, describe the problem first, then the solution.
> >
> > > serial to be used by products with associated compatible string in th=
e
> > > device tree.
> > >
> > > The PORT_DWAPB config will be used instead of the default PORT_16550A
> > > which does not include the UART_FCR_CLEAR_RCVR and UART_FCR_CLEAR_XMI=
T
> > > bits for the FIFO configuration register. Having those flags is neces=
sary
> > > to clear FIFO when the serial port is reconfigured with do_set_termio=
s.
> > >
> > > Additionally, inside the do_set_termios we use the LCR (Line Control
> > > Register) to enable DLAB bit in order to access DLL/DLM (Divisor Latc=
h
> > > Low/High) registers for baud rate setting. These 2 registers are shar=
ing
> > > the same address space with UART_TX/UART_RX and UART_IER. The sequenc=
e is:
> > >
> > > (1) enable DLAB -> (2) set baud -> (3) disable DLAB -> (4) reset FCR
> > >
> > > When there is a TX or RX flow on the serial while we attempt to set/c=
lear
> > > DLAB, the LCR write will be ignored and we will get a IIR_BUSY interr=
upt
> > > afterwards which is cleared by only reading the USR (UART status regi=
ster).
> > >
> > > The sequence above can leave the serial in an unstable state in two c=
ases:
> > >
> > > - if UART is busy while (1), then LCR is still pointing to the normal=
 set of
> > > registers, which means the code setting DLL/DLM is actually writing i=
nto TX or
> > > modifying interrupts in UART_IER which may end with either a garbage =
character
> > > on the console or with serial interrupts disabled.
> > >
> > > - if UART is busy while (3), then LCR remains pointing to DLL/DLM ins=
tead of
> > > moving back to RX/TX. The first transfer on the serial will be stuck =
because
> > > the transmit/receive registers are not accessible unless the DLAB bit
> > > is cleared.
> > >
> > > The changes in this patch include a specific serial_out function for =
this UART
> > > type similar to the one for Armada-38x devices in commit
> > > b7639b0b15ddd1a4686b0142e70dfb122eefc88f with some changes in the tx_=
wait_empty
> > > function to check the UART status by looking at the USR register and =
actively
> > > try to clear FIFO to reduce time before a LCR write since the charact=
ers will
> > > be lost otherwise after baud rate change.
> > >
> > > The USR register may report that UART is busy even if TX/TX FIFO is a=
lready
> > > empty so we will loop until all USR[0] (UART busy status) is cleared =
and USR[1]
> > > TX FIFO is empty (RX FIFO bits should be 0 in this case).
> > > Keeping the same timeout of 20ms as measurements with the 9600 baud w=
hen
> > > the console was busy it took max 1.9ms to get the UART free state.
> > >
> > > Signed-off-by: Adriana Nicolae <adriana@arista.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_dw.c   |   52 +++++++++++++++++++++++++=
++++++++++
> > >  drivers/tty/serial/8250/8250_port.c |    8 +++++
> > >  include/uapi/linux/serial_core.h    |    3 ++
> > >  3 files changed, 63 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8=
250/8250_dw.c
> > > index a53ba04d9770..985a2650f3f3 100644
> > > --- a/drivers/tty/serial/8250/8250_dw.c
> > > +++ b/drivers/tty/serial/8250/8250_dw.c
> > > @@ -33,6 +33,9 @@
> > >  /* Offsets for the DesignWare specific registers */
> > >  #define DW_UART_USR  0x1f /* UART Status Register */
> > >  #define DW_UART_DMASA        0xa8 /* DMA Software Ack */
> > > +#define DW_UART_USR_BUSY 0x1 /* UART Busy status */
> > > +#define DW_UART_USR_TFNF 0x2 /* UART TX FIFO not full */
> > > +#define DW_UART_USR_TFE  0x4 /* UART TX FIFO empty */
> > >
> > >  #define OCTEON_UART_USR      0x27 /* UART Status Register */
> > >
> > > @@ -56,6 +59,10 @@
> > >  #define DW_UART_QUIRK_IS_DMA_FC              BIT(3)
> > >  #define DW_UART_QUIRK_APMC0D08               BIT(4)
> > >  #define DW_UART_QUIRK_CPR_VALUE              BIT(5)
> > > +#define DW_UART_QUIRK_APB            BIT(6)
> > > +
> > > +#define DW8250_REG( p, reg ) \
> > > +     ((void __iomem *)(p->membase + ((reg) << p->regshift)))
> >
> > What's wrong with dw8250_readl_ext() and dw8250_writel_ext()?
> >
> > >  struct dw8250_platform_data {
> > >       u8 usr_reg;
> > > @@ -220,6 +227,47 @@ static void dw8250_serial_out38x(struct uart_por=
t *p, unsigned int offset, u32 v
> > >       dw8250_serial_out(p, offset, value);
> > >  }
> > >
> > > +/* Drain FIFO and wait for USR to be not busy and TX/RX FIFO empty *=
/
> > > +static void dw8250_tx_wait_empty_apb(struct uart_port *p)
> > > +{
> > > +     unsigned int tries =3D 20000;
> > > +     unsigned int delay_threshold =3D tries - 1000;
> > > +     unsigned int usr;
> > > +
> > > +     while (tries--) {
> > > +             usr =3D readl(DW8250_REG(p, DW_UART_USR));
> > > +
> > > +             /* Check UART free and TX/RX FIFO empty */
> > > +             if ((usr & ~DW_UART_USR_TFNF) =3D=3D DW_UART_USR_TFE)
> > > +                     break;
> > > +
> > > +             /* FIFO is still not empty, try to clear it */
> > > +             if (tries < delay_threshold) {
> > > +                     writel(UART_FCR_ENABLE_FIFO, DW8250_REG(p, UART=
_FCR));
> > > +                     writel(UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RC=
VR |
> > > +                     UART_FCR_CLEAR_XMIT, DW8250_REG(p, UART_FCR));
> >
> > Please indent any continuation lines properly, in this case to the char
> > after the opening parenthesis.
> >
> > > +                     writel(0, DW8250_REG(p, UART_FCR));
> > > +                     udelay (1);
> > > +             }
> > > +     }
> >
> > This seems to be just rehashing the same non-robust algorithm. There's =
no
> > way to ensure UART wouldn't become BUSY again because of Rx at any time=
=2E
> > Thus, any amount of clearing FIFOs is just never going be fully safe.
> >
> > Long time ago, I attempted to create a more robust solution to this BUS=
Y
> > problem by temporarily enabling loopback which should prevent any new R=
x
> > from reaching the UART.
> >
> > Could you please try my patch that is attached to:
> >
> > https://lore.kernel.org/linux-serial/079c8fe6-9ce4-fa59-4b44-93e27dd376=
d6@linux.intel.com/
>
> Thanks! I've applied this patch on the device I'm using and ran the
> test that attempts
> to write a large buffer while do_set_termios is called. I don't see
> any softlockup
> anymore, but during one test iteration the console hangs.

Can't think of anything obvious, idle enter and exit seem to always pair=20
and idle exit should restore everything, AFAICT.

Maybe add an asserts using lockdep to ensure that the port lock is held.
While it looks ->in_idle should never remain set forever in case of a=20
race, I'm not sure how DW UART takes two racing idle enter and/or exit=20
calls.

With console, DMA shouldn't be relevant as DMA is not used for consoles.
If there are non-console UARTs involved, then Tx DMA might come into the=20
picture if something is written to UART. Pausing DMA Tx is bit problematic=
=20
though as (IIRC) pausing DMA was not always supported so the entire Tx=20
would have to be terminated which obviously is going to lose characters=20
(potentially quite many).

> I could ssh to the host, `stty -F /dev/ttyS0 sane` hangs and same if I tr=
y to
> write anything `echo test > /dev/ttyS0`. There are no errors in dmesg, an=
d
> tty interrupts are not triggered anymore. I have kernel watchdog enabled =
but
> it didn't trigger.  I'm going to add some traces in dw8250_idle_enter and
> dw8250_idle_exit and update this thread.

If IER doesn't get messed up by something it looks a bit odd, checking LSR=
=20
in dw8250_idle_exit() might provide some clues though that feels long=20
shot to me. If DR is set, maybe try to read one char inside=20
dw8250_idle_exit(), I'd think the best place for that is before IER is=20
written but I'm not sure.

> It takes a while to reproduce, sorry for the delayed response.

Don't worry :-), your help is really appreciated.

--=20
 i.

> Thanks,
> Adriana
>=20
>=20
> >
> > (I haven't found a way to reproduce this myself and so far all the
> > reporters of this problem have gone oddly quiet when asked to test this
> > patch so it's hasn't moved forward for fea years.)
> >
> > There are small Tx DMA related bits to add to the patch from robustness
> > perspective (but a sane communication pattern shouldn't need those
> > anyway, ie., no application should be sending something while trying to
> > change these registers).
> >
> > > +}
> > > +
> > > +static void dw8250_serial_outapb(struct uart_port *p, int offset, in=
t value)
> > > +{
> > > +       struct dw8250_data *d =3D to_dw8250_data(p->private_data);
> > > +
> > > +     if(offset =3D=3D UART_LCR && !d->uart_16550_compatible)
> > > +             dw8250_tx_wait_empty_apb(p);
> > > +
> > > +     writel(value, DW8250_REG(p, offset));
> > > +
> > > +     if (offset =3D=3D UART_LCR && !d->uart_16550_compatible) {
> > > +             /* Check FIFO is left enabled and LCR was written */
> > > +             writel(UART_FCR_ENABLE_FIFO, DW8250_REG(p, UART_FCR));
> > > +             dw8250_check_lcr(p, value);
> > > +     }
> > > +}
> > > +
> > >  static u32 dw8250_serial_in(struct uart_port *p, unsigned int offset=
)
> > >  {
> > >       u32 value =3D readb(p->membase + (offset << p->regshift));
> > > @@ -520,6 +568,12 @@ static void dw8250_quirks(struct uart_port *p, s=
truct dw8250_data *data)
> > >               p->serial_in =3D dw8250_serial_in32;
> > >               data->uart_16550_compatible =3D true;
> > >       }
> > > +     if (quirks & DW_UART_QUIRK_DWAPB) {
> > > +             p->type =3D PORT_DWAPB;
> > > +             p->flags |=3D UPF_FIXED_TYPE;
> > > +             p->serial_out =3D dw8250_serial_outapb;
> > > +             data->skip_autocfg =3D true;
> > > +     }
> > >  }
> > >
> > >  static void dw8250_reset_control_assert(void *data)
> > > @@ -755,6 +809,7 @@ static const struct dev_pm_ops dw8250_pm_ops =3D =
{
> > >
> > >  static const struct dw8250_platform_data dw8250_dw_apb =3D {
> > >       .usr_reg =3D DW_UART_USR,
> > > +     .quirks =3D DW_UART_QUIRK_APB,
> > >  };
> > >
> > >  static const struct dw8250_platform_data dw8250_octeon_3860_data =3D=
 {
> > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial=
/8250/8250_port.c
> > > index 2da9db960d09..3882a71920f6 100644
> > > --- a/drivers/tty/serial/8250/8250_port.c
> > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > @@ -310,6 +310,14 @@ static const struct serial8250_config uart_confi=
g[] =3D {
> > >               .rxtrig_bytes   =3D {1, 8, 16, 30},
> > >               .flags          =3D UART_CAP_FIFO | UART_CAP_AFE,
> > >       },
> > > +     [PORT_DWAPB] =3D {
> > > +             .name           =3D "Synopsys DesignWare",
> > > +             .fifo_size      =3D 16,
> > > +             .tx_loadsz      =3D 16,
> > > +             .fcr            =3D UART_FCR_ENABLE_FIFO |
> > > +                               UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_=
XMIT,
> > > +             .flags          =3D UART_CAP_FIFO | UART_CAP_AFE | UART=
_CAP_IRDA,
> > > +     },
> > >  };
> > >
> > >  /* Uart divisor latch read */
> > > diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/se=
rial_core.h
> > > index 9c007a106330..8386436b813f 100644
> > > --- a/include/uapi/linux/serial_core.h
> > > +++ b/include/uapi/linux/serial_core.h
> > > @@ -231,6 +231,9 @@
> > >  /* Sunplus UART */
> > >  #define PORT_SUNPLUS 123
> > >
> > > +/* Synopsys DesignWare */
> > > +#define PORT_DWAPB           124
> > > +
> > >  /* Generic type identifier for ports which type is not important to =
userspace. */
> > >  #define PORT_GENERIC (-1)
> > >
> > >
> >
> > --
> >  i.
> >
>=20
--8323328-83200775-1755852379=:937--
