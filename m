Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315862C327C
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850169; cv=none; b=us/NhX9EfopBpfTfA/Y4e8j5pCyteO2EbExNaxwdCI4TXx77qwPK9ftnAP91PszNV3dCKfJB/yWHOA7QfnHDhDhXsgZUV9unsdhflThO43WO37xeEClipxWQHGShzNcOYc1uFYX8N9tdPuosKqmbXxK2nZQJbImXb8KZFs9DEGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850169; c=relaxed/simple;
	bh=Ooiq9AB/uQuf/J6mU1X22vVKBwSdPeZd09eJQboCpkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIdl4/3at7MLZLV33YTVuRHh5xgwTvFZCWbGSK73PCzvkQwhoSZDKR32w9Ctf37W3mBk7DpFnwQGPgqliATxPGoxaLxzttuws90eRm5ngFOdCoYtbbeh6riKQli6CHlMB7MROk6pVQF598Jn0ZOrIlwJ0+vtMmXt6uchtliaR5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=ExAYFi4F; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ExAYFi4F"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61bd4cf6117so40145eaf.1
        for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 01:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1755850166; x=1756454966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpBSyWMN6KaCBm38FuNiawdvlfQwHGs5Vvfq21WaFLw=;
        b=ExAYFi4FRK4sETTh/u3vWVIVQQGUvsrjkK6HuG37vlVaOliGZHQihli2MUG1jtWvKJ
         CElI3p0iRAiv0uSypEjHskdfc7DpUz2lmof7yuACeenBCrOnSoPfQ0LCzKvK4LBCGFpT
         b6SXrbvK2qeIn1vo3hd6EsjcgGJ37tq/ZJyt8DPDR5CW1PaH0ZGfy2lEsSrKvN5O/XEg
         kFOW30chKe9t5DHjjTngkI+FQpUYDLwfhRtQW1vA/OME4kvB2ITbY61k4q0PS1WEaBvT
         KLHBkrYGbX9XyWW/ze/YpjMsm8F0SIYKzb2JlPjZADjl5A4Pe32wsFmZN+GZ8+q7o7Lg
         lmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755850166; x=1756454966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpBSyWMN6KaCBm38FuNiawdvlfQwHGs5Vvfq21WaFLw=;
        b=WRKA0yOUnKtaY2LiU/+UTV6apoyb2Q2QGaplmbWJnv682UCpj6hLdejyYzrCH2nwHn
         sHX7YejpP5FkpJhTFA5zGtvXydnVDHIHC4w3yix1RgITgHUPZvzQFfQI5gfHsZbx2OGW
         EW8tBtkaO5wexhBF/zFbe/wrc1SXNGncxrluHtMLrk6vD8+rG9PcFEzPahVAg3+oaiLc
         Pno0NbQ0/r3PxxVqOdLpG208AaJ0mdAPD840pYKnodUZf8eVgwkO66b9Zh4fFxs6g3PA
         COGerP8w8DBtcVdBTHRa/Dty4xz21cDPoTvHzpu33WHo9Mt9jUByvhIaHDjoskEIz8v7
         ZUEw==
X-Gm-Message-State: AOJu0YwXcxE3QbPceUR6j6ujLF0IK70bEmZkqi946/mgYKgrs0zrZIIR
	2Dk/AoDDF7/Piy/XWul+t1EP3Vzolj4qa5yajfcz/Y0C7tZJ6Ju76ifpX5+nTPyDzE+NwnoO6xu
	kDR3RuvBPhb/qxhc9JgLJtvp2mZKVjAX5ysL6Y8Nm
X-Gm-Gg: ASbGncvb0/aRJrV282uPp6PbU+MAPDCHhx+q9ws0B6ZaGSRtsqH9hfbCMV1LZ5gQBgq
	KZSxTd4QzpIOxLcQubw99J2tvJhm7OLUAo4XiZkcmaP7w/hAZAQgOdhYBmtpyJp8fhW+Ml39XrX
	gc2/2d7bw8rxpWfW4gP05EPIVvJvh6TZ6eUdDXe6ahZPkjYN2+MkTrU6YNxZnxdlN7V9xqF3PZb
	May9mN9
X-Google-Smtp-Source: AGHT+IFum9KffqidviAv6IxYPPh0QsgqM1MT2XoiwmDJg35SKkbeyaWhe7eSxADdRebRB7nsko3/vwUtOOEsh78iolk=
X-Received: by 2002:a05:6820:4a09:b0:61b:ae0c:d334 with SMTP id
 006d021491bc7-61db9b4afdamr406350eaf.2.1755850165946; Fri, 22 Aug 2025
 01:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819182322.3451959-1-adriana@arista.com> <945af1e4-1d43-bd4b-6b07-733c06d18b17@linux.intel.com>
In-Reply-To: <945af1e4-1d43-bd4b-6b07-733c06d18b17@linux.intel.com>
From: Adriana Nicolae <adriana@arista.com>
Date: Fri, 22 Aug 2025 11:09:14 +0300
X-Gm-Features: Ac12FXzvWMlY-zoKyKGZD6DgFvLeXnGHzILIETNTg7STkg4uJpSYD36T8tkYomc
Message-ID: <CAERbo5zSPSMyfSDQpw9-js=7kZHaB5mS9uib8RSw-Hqzwn3mGQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250 dw: clear FIFO before writting LCR
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-serial <linux-serial@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, prasad@arista.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 1:02=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 19 Aug 2025, adriana@arista.com wrote:
>
> > This patch is proposing a custom configuration for Synopsys DesignWare
>
> Please try to avoid starting sentences in the changelog with "This patch"
> or other wordings with similar meaning. Write imperatively instead.
>
> Preferrable, describe the problem first, then the solution.
>
> > serial to be used by products with associated compatible string in the
> > device tree.
> >
> > The PORT_DWAPB config will be used instead of the default PORT_16550A
> > which does not include the UART_FCR_CLEAR_RCVR and UART_FCR_CLEAR_XMIT
> > bits for the FIFO configuration register. Having those flags is necessa=
ry
> > to clear FIFO when the serial port is reconfigured with do_set_termios.
> >
> > Additionally, inside the do_set_termios we use the LCR (Line Control
> > Register) to enable DLAB bit in order to access DLL/DLM (Divisor Latch
> > Low/High) registers for baud rate setting. These 2 registers are sharin=
g
> > the same address space with UART_TX/UART_RX and UART_IER. The sequence =
is:
> >
> > (1) enable DLAB -> (2) set baud -> (3) disable DLAB -> (4) reset FCR
> >
> > When there is a TX or RX flow on the serial while we attempt to set/cle=
ar
> > DLAB, the LCR write will be ignored and we will get a IIR_BUSY interrup=
t
> > afterwards which is cleared by only reading the USR (UART status regist=
er).
> >
> > The sequence above can leave the serial in an unstable state in two cas=
es:
> >
> > - if UART is busy while (1), then LCR is still pointing to the normal s=
et of
> > registers, which means the code setting DLL/DLM is actually writing int=
o TX or
> > modifying interrupts in UART_IER which may end with either a garbage ch=
aracter
> > on the console or with serial interrupts disabled.
> >
> > - if UART is busy while (3), then LCR remains pointing to DLL/DLM inste=
ad of
> > moving back to RX/TX. The first transfer on the serial will be stuck be=
cause
> > the transmit/receive registers are not accessible unless the DLAB bit
> > is cleared.
> >
> > The changes in this patch include a specific serial_out function for th=
is UART
> > type similar to the one for Armada-38x devices in commit
> > b7639b0b15ddd1a4686b0142e70dfb122eefc88f with some changes in the tx_wa=
it_empty
> > function to check the UART status by looking at the USR register and ac=
tively
> > try to clear FIFO to reduce time before a LCR write since the character=
s will
> > be lost otherwise after baud rate change.
> >
> > The USR register may report that UART is busy even if TX/TX FIFO is alr=
eady
> > empty so we will loop until all USR[0] (UART busy status) is cleared an=
d USR[1]
> > TX FIFO is empty (RX FIFO bits should be 0 in this case).
> > Keeping the same timeout of 20ms as measurements with the 9600 baud whe=
n
> > the console was busy it took max 1.9ms to get the UART free state.
> >
> > Signed-off-by: Adriana Nicolae <adriana@arista.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c   |   52 +++++++++++++++++++++++++++=
++++++++
> >  drivers/tty/serial/8250/8250_port.c |    8 +++++
> >  include/uapi/linux/serial_core.h    |    3 ++
> >  3 files changed, 63 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
> > index a53ba04d9770..985a2650f3f3 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -33,6 +33,9 @@
> >  /* Offsets for the DesignWare specific registers */
> >  #define DW_UART_USR  0x1f /* UART Status Register */
> >  #define DW_UART_DMASA        0xa8 /* DMA Software Ack */
> > +#define DW_UART_USR_BUSY 0x1 /* UART Busy status */
> > +#define DW_UART_USR_TFNF 0x2 /* UART TX FIFO not full */
> > +#define DW_UART_USR_TFE  0x4 /* UART TX FIFO empty */
> >
> >  #define OCTEON_UART_USR      0x27 /* UART Status Register */
> >
> > @@ -56,6 +59,10 @@
> >  #define DW_UART_QUIRK_IS_DMA_FC              BIT(3)
> >  #define DW_UART_QUIRK_APMC0D08               BIT(4)
> >  #define DW_UART_QUIRK_CPR_VALUE              BIT(5)
> > +#define DW_UART_QUIRK_APB            BIT(6)
> > +
> > +#define DW8250_REG( p, reg ) \
> > +     ((void __iomem *)(p->membase + ((reg) << p->regshift)))
>
> What's wrong with dw8250_readl_ext() and dw8250_writel_ext()?
>
> >  struct dw8250_platform_data {
> >       u8 usr_reg;
> > @@ -220,6 +227,47 @@ static void dw8250_serial_out38x(struct uart_port =
*p, unsigned int offset, u32 v
> >       dw8250_serial_out(p, offset, value);
> >  }
> >
> > +/* Drain FIFO and wait for USR to be not busy and TX/RX FIFO empty */
> > +static void dw8250_tx_wait_empty_apb(struct uart_port *p)
> > +{
> > +     unsigned int tries =3D 20000;
> > +     unsigned int delay_threshold =3D tries - 1000;
> > +     unsigned int usr;
> > +
> > +     while (tries--) {
> > +             usr =3D readl(DW8250_REG(p, DW_UART_USR));
> > +
> > +             /* Check UART free and TX/RX FIFO empty */
> > +             if ((usr & ~DW_UART_USR_TFNF) =3D=3D DW_UART_USR_TFE)
> > +                     break;
> > +
> > +             /* FIFO is still not empty, try to clear it */
> > +             if (tries < delay_threshold) {
> > +                     writel(UART_FCR_ENABLE_FIFO, DW8250_REG(p, UART_F=
CR));
> > +                     writel(UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR=
 |
> > +                     UART_FCR_CLEAR_XMIT, DW8250_REG(p, UART_FCR));
>
> Please indent any continuation lines properly, in this case to the char
> after the opening parenthesis.
>
> > +                     writel(0, DW8250_REG(p, UART_FCR));
> > +                     udelay (1);
> > +             }
> > +     }
>
> This seems to be just rehashing the same non-robust algorithm. There's no
> way to ensure UART wouldn't become BUSY again because of Rx at any time.
> Thus, any amount of clearing FIFOs is just never going be fully safe.
>
> Long time ago, I attempted to create a more robust solution to this BUSY
> problem by temporarily enabling loopback which should prevent any new Rx
> from reaching the UART.
>
> Could you please try my patch that is attached to:
>
> https://lore.kernel.org/linux-serial/079c8fe6-9ce4-fa59-4b44-93e27dd376d6=
@linux.intel.com/
Thanks! I've applied this patch on the device I'm using and ran the
test that attempts
to write a large buffer while do_set_termios is called. I don't see
any softlockup
anymore, but during one test iteration the console hangs.

I could ssh to the host, `stty -F /dev/ttyS0 sane` hangs and same if I try =
to
write anything `echo test > /dev/ttyS0`. There are no errors in dmesg, and
tty interrupts are not triggered anymore. I have kernel watchdog enabled bu=
t
it didn't trigger.  I'm going to add some traces in dw8250_idle_enter and
dw8250_idle_exit and update this thread. It takes a while to reproduce,
sorry for the delayed response.

Thanks,
Adriana


>
> (I haven't found a way to reproduce this myself and so far all the
> reporters of this problem have gone oddly quiet when asked to test this
> patch so it's hasn't moved forward for fea years.)
>
> There are small Tx DMA related bits to add to the patch from robustness
> perspective (but a sane communication pattern shouldn't need those
> anyway, ie., no application should be sending something while trying to
> change these registers).
>
> > +}
> > +
> > +static void dw8250_serial_outapb(struct uart_port *p, int offset, int =
value)
> > +{
> > +       struct dw8250_data *d =3D to_dw8250_data(p->private_data);
> > +
> > +     if(offset =3D=3D UART_LCR && !d->uart_16550_compatible)
> > +             dw8250_tx_wait_empty_apb(p);
> > +
> > +     writel(value, DW8250_REG(p, offset));
> > +
> > +     if (offset =3D=3D UART_LCR && !d->uart_16550_compatible) {
> > +             /* Check FIFO is left enabled and LCR was written */
> > +             writel(UART_FCR_ENABLE_FIFO, DW8250_REG(p, UART_FCR));
> > +             dw8250_check_lcr(p, value);
> > +     }
> > +}
> > +
> >  static u32 dw8250_serial_in(struct uart_port *p, unsigned int offset)
> >  {
> >       u32 value =3D readb(p->membase + (offset << p->regshift));
> > @@ -520,6 +568,12 @@ static void dw8250_quirks(struct uart_port *p, str=
uct dw8250_data *data)
> >               p->serial_in =3D dw8250_serial_in32;
> >               data->uart_16550_compatible =3D true;
> >       }
> > +     if (quirks & DW_UART_QUIRK_DWAPB) {
> > +             p->type =3D PORT_DWAPB;
> > +             p->flags |=3D UPF_FIXED_TYPE;
> > +             p->serial_out =3D dw8250_serial_outapb;
> > +             data->skip_autocfg =3D true;
> > +     }
> >  }
> >
> >  static void dw8250_reset_control_assert(void *data)
> > @@ -755,6 +809,7 @@ static const struct dev_pm_ops dw8250_pm_ops =3D {
> >
> >  static const struct dw8250_platform_data dw8250_dw_apb =3D {
> >       .usr_reg =3D DW_UART_USR,
> > +     .quirks =3D DW_UART_QUIRK_APB,
> >  };
> >
> >  static const struct dw8250_platform_data dw8250_octeon_3860_data =3D {
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 2da9db960d09..3882a71920f6 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -310,6 +310,14 @@ static const struct serial8250_config uart_config[=
] =3D {
> >               .rxtrig_bytes   =3D {1, 8, 16, 30},
> >               .flags          =3D UART_CAP_FIFO | UART_CAP_AFE,
> >       },
> > +     [PORT_DWAPB] =3D {
> > +             .name           =3D "Synopsys DesignWare",
> > +             .fifo_size      =3D 16,
> > +             .tx_loadsz      =3D 16,
> > +             .fcr            =3D UART_FCR_ENABLE_FIFO |
> > +                               UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XM=
IT,
> > +             .flags          =3D UART_CAP_FIFO | UART_CAP_AFE | UART_C=
AP_IRDA,
> > +     },
> >  };
> >
> >  /* Uart divisor latch read */
> > diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/seri=
al_core.h
> > index 9c007a106330..8386436b813f 100644
> > --- a/include/uapi/linux/serial_core.h
> > +++ b/include/uapi/linux/serial_core.h
> > @@ -231,6 +231,9 @@
> >  /* Sunplus UART */
> >  #define PORT_SUNPLUS 123
> >
> > +/* Synopsys DesignWare */
> > +#define PORT_DWAPB           124
> > +
> >  /* Generic type identifier for ports which type is not important to us=
erspace. */
> >  #define PORT_GENERIC (-1)
> >
> >
>
> --
>  i.
>
