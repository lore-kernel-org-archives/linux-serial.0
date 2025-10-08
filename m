Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1BA242D69
	for <linux-serial@vger.kernel.org>; Wed,  8 Oct 2025 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919955; cv=none; b=OdXJumLas/pD6unCBMQsEcqN7N0KcO5jA2/IFObOVb8GT4Ob0LjbWLcxAsCIireMXC2Gpls1SAkl5tJ3WAPLwE7wO8BemmvkO7TRR0WWgQqbORqcuEvDaJ27W4USRIsf+7PenPzZQpU/zUFKV/oI6h+KcwuLVJt9osNILg3E9M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919955; c=relaxed/simple;
	bh=EKNjbmP6cVMRwwmla5NmvthqhpQak/7/+gY04zfUTVc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q3yVbX6pe1HiTSDB1cdnw33iPMpcWEEXR/5TsAF++G6mL5gI1atTWf6JwzMkEVWzG1FtZugQ+x3iq1I0mGD8NOq9SJsT400u7LfOdas2CETya96DrEoaoWy3Wq7x15I/1xmzkHinTrNF16zljUmEkxznOS9nsD8aglTqp5aCS3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZF3feyF1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZF3feyF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759919954; x=1791455954;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EKNjbmP6cVMRwwmla5NmvthqhpQak/7/+gY04zfUTVc=;
  b=ZF3feyF1PeONwnnf6RAd8AbsWTF89lT0jTRU/w82biGHZGSs+hDBaeE4
   veyOOCi/tM/RzXnqkuG8Mh1Q2rVh0rAFMrqpjzglcLioiCkeod+yurTP7
   DsOU85c6yYKX6y7O1PH9y4O82FDu0bWYFLBgctYyxCzTEf8bI00NhjCB6
   se+4sDvOms5IfARu34OFrBp4wfhpi5L/r1jQXr3GDyniCVyMg0V4X5izI
   BONdIihJ2Oyl8a3NGUIvwaIavGxozjFuMF9ayKNPoDUmB6ldyk+SMxMoK
   XMP6jCNzijV4jKSTydX8aM4b4+fkfnj8lVNuBCPfMxmydrj2S0a4pknHy
   Q==;
X-CSE-ConnectionGUID: vOOVCzxUTMOfz1Y8FnwxWQ==
X-CSE-MsgGUID: i1vIis+USRGXCxxV2usJgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="84727695"
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="84727695"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 03:39:14 -0700
X-CSE-ConnectionGUID: N1u2byrJTGOXJQtsXMYhaA==
X-CSE-MsgGUID: xw2q14/6Q9eEZY2a89eGPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="180827565"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 03:39:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 Oct 2025 13:39:07 +0300 (EEST)
To: Adriana Nicolae <adriana@arista.com>
cc: linux-serial <linux-serial@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, prasad@arista.com
Subject: Re: [PATCH] serial: 8250 dw: clear FIFO before writting LCR
In-Reply-To: <CAERbo5zSPSMyfSDQpw9-js=7kZHaB5mS9uib8RSw-Hqzwn3mGQ@mail.gmail.com>
Message-ID: <6ab9afb2-e308-6231-e938-d28d05d62a9a@linux.intel.com>
References: <20250819182322.3451959-1-adriana@arista.com> <945af1e4-1d43-bd4b-6b07-733c06d18b17@linux.intel.com> <CAERbo5zSPSMyfSDQpw9-js=7kZHaB5mS9uib8RSw-Hqzwn3mGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1457764756-1759919947=:950"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1457764756-1759919947=:950
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

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
> Thanks! I've applied this patch on the device I'm using and ran the
> test that attempts
> to write a large buffer while do_set_termios is called. I don't see
> any softlockup
> anymore, but during one test iteration the console hangs.
>=20
> I could ssh to the host, `stty -F /dev/ttyS0 sane` hangs and same if I tr=
y to
> write anything `echo test > /dev/ttyS0`. There are no errors in dmesg, an=
d
> tty interrupts are not triggered anymore. I have kernel watchdog enabled =
but
> it didn't trigger.  I'm going to add some traces in dw8250_idle_enter and
> dw8250_idle_exit and update this thread. It takes a while to reproduce,
> sorry for the delayed response.

Hi Adriana,

Did you ever manage to figure out what goes wrong with the idle enter/exit=
=20
patch?

--=20
 i.

--8323328-1457764756-1759919947=:950--
