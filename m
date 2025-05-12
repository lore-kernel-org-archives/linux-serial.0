Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7BE256C82
	for <linux-serial@vger.kernel.org>; Mon, 12 May 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050413; cv=none; b=XZnjph1U02enL/04AzC0e2b2RntlRNPenjFbBXPp3n8EbbvKq1iT0xQPfuVGsgUyWyeqxiKebn8Lkeh3sDvV35Ri6MdpSypPHYMCjM4Tojyktn5Y/bocirKyANYi2mKbo+esFYsZoV8oUsE/e6vU/XZkZ51kJnG6yow6zUPWYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050413; c=relaxed/simple;
	bh=LxdgLa1PmyqwrZxBR80SVpmi6aR3ykrHClmBUaRmBbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/Axq2TuCk446mfDp+Wsk7fq0RBOFPgFBYEvpzyqFWX9CLsH7iHuJNgCrHRF21aU9f3z7aLbn771qw24kKf0eVOtsXPl3/5/1Z9UHIazPq35CMlFdLwBP2fZz+4PFe6wSB6V1I0uhdVd5JgoB5c4Qd6mPDAz9pHWWD7ju3dgH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=k6a3d0uV; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k6a3d0uV"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-606648c3f9eso1108020eaf.3
        for <linux-serial@vger.kernel.org>; Mon, 12 May 2025 04:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747050410; x=1747655210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0BtKs+KyENo9zQ4Jk0EOAFn3PtdxXJ7nAnMlqJvcbo=;
        b=k6a3d0uVZCK/5ZzjRiRvyaIDNhMdy2pcZ4ittOTyrT7mOV9ZUH8jtBgCQW6l0Xq5yI
         rh0Tf+cP7eOh5W4xWipz74qz5b9fnzm7fpf2QxVzSHrdr20hehiSc7Az0vReS1Vhmiwq
         65lH8nPNAHZ+Udi0fKSBRG7nrSoVF0QSmAU3YkcKeFJT0Q04w3atYfLgtd5dfwZOiE1v
         fkIHSBdTrU8EQKzyWuMnRJ3p6MwzPZR9ij6r69G6Bfg+6ByrTw48goffj5Ow9luMYZ73
         fUUAaxz2LjeaZ6ELEMzrygfUsCaVeElUv/Sn3foyQ1kOeUXhMcJPrgKXUX3rPiQZKD4E
         UxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747050410; x=1747655210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0BtKs+KyENo9zQ4Jk0EOAFn3PtdxXJ7nAnMlqJvcbo=;
        b=PgdeW0HaJIO2iV/BDRobWwYTJT1IGZykw8zb2t7Pci0qeveLV4r24G/Qjs3b6PSuTd
         sODcud6XuBpDhZgEr7OY1bIn0Rw2xoQhNkm/pk4vi6XsBjkiUh7zZfBqLF1DUw4XEDU9
         eBFYRprES6Pk7EmuyYgAZ/1kWR7KRTAZzPQRtIYgVNXj0fdrgoj8sORa6V2W6rukF1As
         OyXKRt+BQpfPMAUQTZRPtgmG5g+fzM9dUNkc1sc4J4fAp3sJMHVEr/DNGS2YGTv4+YxL
         5ZORHmkNuHyhe0EaBggNlhtuEc293k1hRD4xcW+FQp/BR+yt5Yj6A22uBEVHb6K9Q7jS
         UqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVfuu36RoFVgaFlBy4IkLeRVXbEJ0ApnTfJl4dLXe5yg9n33+uCRo3lqYXvU5C4YNaPx2JrX2h8XwgSuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFn6grzw8wf/ZeZZmg02tl6KjDdVDIH3gQa1Fx/Ko5d7p7HCGW
	XYm9Vf3Ae7xfSplr+91B4gN683X3KwK1w+HuTQjAlCYzuUet0/Rp1c/eDxSzzI5J15GvldZOUh1
	7g30hh05yYVWjglhL7pR4JEzcmsIwjdlLyFGaxA==
X-Gm-Gg: ASbGncvFPtOW2SsObn44slEzEbaQ/8dumQtlRsKB7LNduBCi4yAalzbEb0rMWZASbrH
	3UinAgyvY1u+lKvQVSS/W4YSI/AaZOtIiKny9B5+iZ4s+T0NTnFGLV6OFT+/7hf1dOlC6oBF5oG
	famTgDjv+lLLmKb48OVswP0bXhSGaT8KkxRS8hF0gJu58TlkBVsQ==
X-Google-Smtp-Source: AGHT+IFPthmib6/M9suogdKo4/Vf/th9B3UhkbFWXThr8JfSQi1+bY8tuuhCQaWNOmmuP1bH1LfjSu16O/FiH2Y8/JI=
X-Received: by 2002:a05:6820:1b09:b0:607:cc1a:572f with SMTP id
 006d021491bc7-6084c0e419fmr7391418eaf.6.1747050410098; Mon, 12 May 2025
 04:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506112321.61710-1-cuiyunhui@bytedance.com>
 <20250506112321.61710-2-cuiyunhui@bytedance.com> <6801686d-a0b3-7093-1293-cdac6ad055e4@linux.intel.com>
 <CAEEQ3wnouWbVvkvhV1oB8MrOADNhN6BQB4-epUXa6cLYkKFRiw@mail.gmail.com> <41066f2f-a690-83ef-5fbb-0bc1d956a19d@linux.intel.com>
In-Reply-To: <41066f2f-a690-83ef-5fbb-0bc1d956a19d@linux.intel.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 12 May 2025 19:46:39 +0800
X-Gm-Features: AX0GCFv2sEIMCMQ4oo-3CxQ8tK55U_wVYWQte3NiC6cUBxr4tsP5Yi2ekK3c6xI
Message-ID: <CAEEQ3w=xPmbyaCHLPtCBgFOzz7TzDYMkOnKt=EvpdknQqot=cA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 2/4] serial: 8250: avoid potential
 PSLVERR issue
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: arnd@arndb.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	benjamin.larsson@genexis.eu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	heikki.krogerus@linux.intel.com, Jiri Slaby <jirislaby@kernel.org>, 
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de, 
	LKML <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Mon, May 12, 2025 at 6:27=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 12 May 2025, yunhui cui wrote:
>
> > Hi Ilpo,
> >
> > On Tue, May 6, 2025 at 8:00=E2=80=AFPM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Tue, 6 May 2025, Yunhui Cui wrote:
> > >
> > > > Failure to check the UART_LSR_DR before reading UART_RX, or the
> > > > non-atomic nature of clearing the FIFO and reading UART_RX, poses
> > > > potential risks that could lead to PSLVERR.
> > >
> > > Don't expect reader to know the condition how PSLVERR is triggered. I=
 know
> > > it's worded out in the other patch but also explain it here.
> > >
> > > You're only explaining problem and missing what this patch does to so=
lve
> > > the problem.
> > >
> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > ---
> > > >  drivers/tty/serial/8250/8250.h      | 13 +++++++++
> > > >  drivers/tty/serial/8250/8250_port.c | 43 +++++++++++++++----------=
----
> > > >  2 files changed, 35 insertions(+), 21 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/82=
50/8250.h
> > > > index b861585ca02a..6f97ff3a197d 100644
> > > > --- a/drivers/tty/serial/8250/8250.h
> > > > +++ b/drivers/tty/serial/8250/8250.h
> > > > @@ -162,6 +162,19 @@ static inline u16 serial_lsr_in(struct uart_82=
50_port *up)
> > > >       return lsr;
> > > >  }
> > > >
> > > > +/*
> > > > + * To avoid PSLVERR, check UART_LSR_DR in UART_LSR before
> > > > + * reading UART_RX.
> > > > + */
> > > > +static inline void serial8250_discard_data(struct uart_8250_port *=
up)
> > > > +{
> > > > +     u16 lsr;
> > > > +
> > > > +     lsr =3D serial_in(up, UART_LSR);
> > > > +     if (lsr & UART_LSR_DR)
> > > > +             serial_in(up, UART_RX);
> > > > +}
> > > > +
> > > >  /*
> > > >   * For the 16C950
> > > >   */
> > > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/seri=
al/8250/8250_port.c
> > > > index a913135d5217..1666b965f6a0 100644
> > > > --- a/drivers/tty/serial/8250/8250_port.c
> > > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > > @@ -1357,9 +1357,8 @@ static void autoconfig_irq(struct uart_8250_p=
ort *up)
> > > >       /* Synchronize UART_IER access against the console. */
> > > >       uart_port_lock_irq(port);
> > > >       serial_out(up, UART_IER, UART_IER_ALL_INTR);
> > > > +     serial8250_discard_data(up);
> > > >       uart_port_unlock_irq(port);
> > > > -     serial_in(up, UART_LSR);
> > > > -     serial_in(up, UART_RX);
> > > >       serial_in(up, UART_IIR);
> > > >       serial_in(up, UART_MSR);
> > > >       serial_out(up, UART_TX, 0xFF);
> > > > @@ -2137,25 +2136,22 @@ static void wait_for_xmitr(struct uart_8250=
_port *up, int bits)
> > > >  static int serial8250_get_poll_char(struct uart_port *port)
> > > >  {
> > > >       struct uart_8250_port *up =3D up_to_u8250p(port);
> > > > -     int status;
> > > > +     int status =3D NO_POLL_CHAR;
> > > >       u16 lsr;
> > > > +     unsigned long flags;
> > > >
> > > >       serial8250_rpm_get(up);
> > > >
> > > > +     uart_port_lock_irqsave(port, &flags);
> > > >       lsr =3D serial_port_in(port, UART_LSR);
> > > > +     if (lsr & UART_LSR_DR)
> > > > +             status =3D serial_port_in(port, UART_RX);
> > > > +     uart_port_unlock_irqrestore(port, flags);
> > > >
> > > > -     if (!(lsr & UART_LSR_DR)) {
> > > > -             status =3D NO_POLL_CHAR;
> > > > -             goto out;
> > > > -     }
> > > > -
> > > > -     status =3D serial_port_in(port, UART_RX);
> > > > -out:
> > > >       serial8250_rpm_put(up);
> > > >       return status;
> > >
> > > Not a problem that originates from you, but IMO calling this variable
> > > "status" is quite misleading when it is the character (or NO_POLL_CHA=
R
> > > is no character is present).
> > >
> > > >  }
> > > >
> > > > -
> > > >  static void serial8250_put_poll_char(struct uart_port *port,
> > > >                        unsigned char c)
> > > >  {
> > > > @@ -2264,13 +2260,17 @@ int serial8250_do_startup(struct uart_port =
*port)
> > > >        * Clear the FIFO buffers and disable them.
> > > >        * (they will be reenabled in set_termios())
> > > >        */
> > > > +     uart_port_lock_irqsave(port, &flags);
> > > >       serial8250_clear_fifos(up);
> > > >
> > > >       /*
> > > > -      * Clear the interrupt registers.
> > > > +      * Read UART_RX to clear interrupts (e.g., Character Timeout)=
.
> > > > +      * No data on UART_IIR_RX_TIMEOUT, UART_LSR_DR won't set.
> > > > +      * FIFO disabled, read UART_RX without LSR check, no PSLVERR.
> > >
> > > I don't understand what the last two lines mean and I don't see the
> > > connection to the code that is below the comment either, could you tr=
y to
> > > rephrase the comment.
> >
> > The original intention was to check UART_LSR_DR first when reading
> > UART_RX. However, the purpose of serial_port_in(port, UART_RX) here is
> > to clear the interrupt, such as the interrupt caused by RX_TIMEOUT.
>
> I understood the first sentence in the comment but the rest of it is very
> cryptic and has many grammar issues too. Also, the extent of passive voic=
e
> there makes it hard to know who does what (UART / kernel).
>
> > The logic for clearing the interrupt in the interrupt handling
> > function of RX_TIMEOUT is !UART_LSR_DR. And to avoid PSLVERR, we need
> > to check UART_LSR_DR first. To meet the requirements of both, the FIFO
> > needs to be disabled.
>
> The grammar is so broken, it failed to convey that message.

The purpose of serial_port_in(port, UART_RX) is to clear interrupts
such as rx_timeout. In dw8250_handle_irq(), serial_port_in(p, UART_RX)
is called when the LSR does not have the UART_LSR_DR bit set.

To avoid PSLVERR when the FIFO is enabled, serial_in(up, UART_RX)
should be called only when the LSR has the UART_LSR_DR bit set.

These two logics are clearly contradictory. Therefore, both
serial8250_clear_fifos() and serial_port_in(port, UART_RX) are placed
under the protection of port->lock.

If you believe this is not a potential issue, that's fine. I can
remove this patch in the next patchset version.

>
> > Therefore, we should put serial8250_clear_fifos() and the execution of
> > serial_port_in(port, UART_RX) without checking UART_LSR_DR under the
> > port->lock.
> >
> > >
> > > >        */
> > > >       serial_port_in(port, UART_LSR);
> > > >       serial_port_in(port, UART_RX);
> > > > +     uart_port_unlock_irqrestore(port, flags);
> > > >       serial_port_in(port, UART_IIR);
> > > >       serial_port_in(port, UART_MSR);
> > > >
> > > > @@ -2429,15 +2429,14 @@ int serial8250_do_startup(struct uart_port =
*port)
> > > >       }
> > > >
> > > >  dont_test_tx_en:
> > > > -     uart_port_unlock_irqrestore(port, flags);
> > > >
> > > >       /*
> > > >        * Clear the interrupt registers again for luck, and clear th=
e
> > > >        * saved flags to avoid getting false values from polling
> > > >        * routines or the previous session.
> > > >        */
> > > > -     serial_port_in(port, UART_LSR);
> > > > -     serial_port_in(port, UART_RX);
> > > > +     serial8250_discard_data(up);
> > > > +     uart_port_unlock_irqrestore(port, flags);
> > > >       serial_port_in(port, UART_IIR);
> > > >       serial_port_in(port, UART_MSR);
> > > >       up->lsr_saved_flags =3D 0;
> > > > @@ -2519,7 +2518,6 @@ void serial8250_do_shutdown(struct uart_port =
*port)
> > > >               port->mctrl &=3D ~TIOCM_OUT2;
> > > >
> > > >       serial8250_set_mctrl(port, port->mctrl);
> > > > -     uart_port_unlock_irqrestore(port, flags);
> > > >
> > > >       /*
> > > >        * Disable break condition and FIFOs
> > > > @@ -2527,6 +2525,14 @@ void serial8250_do_shutdown(struct uart_port=
 *port)
> > > >       serial_port_out(port, UART_LCR,
> > > >                       serial_port_in(port, UART_LCR) & ~UART_LCR_SB=
C);
> > > >       serial8250_clear_fifos(up);
> > > > +     /*
> > > > +      * Read data port to reset things, and then unlink from
> > > > +      * the IRQ chain.
> > > > +      * Since reading UART_RX clears interrupts, doing so with
> > > > +      * FIFO disabled won't trigger PSLVERR.
> > > > +      */
> > > > +     serial_port_in(port, UART_RX);
> > > > +     uart_port_unlock_irqrestore(port, flags);
> > > >
> > > >  #ifdef CONFIG_SERIAL_8250_RSA
> > > >       /*
> > > > @@ -2535,11 +2541,6 @@ void serial8250_do_shutdown(struct uart_port=
 *port)
> > > >       disable_rsa(up);
> > > >  #endif
> > > >
> > > > -     /*
> > > > -      * Read data port to reset things, and then unlink from
> > > > -      * the IRQ chain.
> > > > -      */
> > > > -     serial_port_in(port, UART_RX);
> > > >       serial8250_rpm_put(up);
> > > >
> > > >       up->ops->release_irq(up);
> > > >
> > >
> > > --
> > >  i.
> > >
> >
> > Thanks,
> > Yunhui
> >
>
> --
>  i.

Thanks,
Yunhui
