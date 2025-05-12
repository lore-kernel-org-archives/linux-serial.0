Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D207E51022
	for <linux-serial@vger.kernel.org>; Mon, 12 May 2025 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058444; cv=none; b=eMsG5rqto3raLpF1fF07MMyQiZWM65sVL3jDZF1jybc6kyqQTnl1KewTVyXqkjNG/Md5usGS5IjNxDURhCgGOYlb8gkYgtQFMbykw3nssDapxpGk4oMtgXV0lzkBuxI+KLRxstr71DTw07Fd+cGppt90T4b/m8YREHrpww3vJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058444; c=relaxed/simple;
	bh=FpSOrFTBA3zPhR8xzcPPZckD+36feXezDwiD5X0jZ7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e81c2JcuxogUzrsW2Eoh1oPOFn2KDLReTXfTGRoX4ngG69c1nWLdWQ6ehabaKZrYCZx5aU1YPDgvSpOYWHZxDDzs7q+1/seNECEoQbR4R82yhQ/wfYstC6sZLODgFntFZ8xwn/RGTtmEOR6UtrskvLMu7SM/nr37zvUfGlYKt7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jDBET9ag; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jDBET9ag"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-60638c07cabso2520054eaf.3
        for <linux-serial@vger.kernel.org>; Mon, 12 May 2025 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747058442; x=1747663242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oY5MPOFskIW58U8yakui/ToG+SoS5dGhSlJd4Y0itw4=;
        b=jDBET9agE4STi0F9psBnCjrM4hNXKr+ppVeCJXO1ubEZ41ztJBGs6h0uEClH9heDCy
         km22pjYc5dpeJM9so6U6tx6+sM1fumO2Lp3o9QB5nP041c3n3m7+n7055Rt1xfCqfqde
         UY4/Gva/8FL8XOHTSqpvKaGB6fPG+w+82KYY6IExEHHCOAQ4dS+CbHCnDPBj4Es0TEg0
         OdbSPPnhyIsRqnF8I5Wt+0/NSDvwqfZRXltFJnZqtOIBnRa8w7ZSz5u37RMETeQJnC5T
         RsLd82SmKoc6Vve26RvEMmj2nXXW0eYQBOzt4WXnNjVOiPvfWeqGQYUs9hrMxMD6ICBp
         pajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747058442; x=1747663242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oY5MPOFskIW58U8yakui/ToG+SoS5dGhSlJd4Y0itw4=;
        b=UUBIFpAmQEv5KzcyAi8pRfsmoSIjfykqhiURF6aJYco33Sy9Pqhj/fZ6ZLgg115aen
         LSyiU18Qe7jJ5DgzN1GamdbNn4xziRBAVbSQR98TCeZL9zxusaO8L6DomUXzncvkoTWa
         BsceQNYnnG9vcYalCHcVgScdrrlkScBlecdu3/rFGnETjWMynyJi4gBHyXaAOkhM4hq0
         i7GfVSwYQCNXasH0qMmE2u1tIkg0nBwYUwGO3rfxkeJYVCDbrkLixV1A//09c+ANHfIW
         1wiVbgd6ZiJi+3xXsC6ABOP6nCk/bEUpF+a61wSbgPwM9MBnqtRSqhN12qAPPmNh/As/
         UoFw==
X-Forwarded-Encrypted: i=1; AJvYcCV902GWv+Do/5r6UvqI5GfLgIilG3swvIhkbbtzJuFZJmqwvR32V/1an+NkXV+GCOZ75J04b6oxkHs7c6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNg0+nt/pzlA27PqLrgoaHsNQI1HIVZ5x49cpEPFMvmZKIW5rX
	/jJXiaONNFas55oGSbM0ODagfQOdtJT3FgBKSL6sAR1H1NS60Pb3IuLLjbvMASnUCuuVrltDYKt
	1H5oKiKt7EsJGOxaegm4begooLuzTEp+OFBV9Pg==
X-Gm-Gg: ASbGncvWzWpBrwHXpptMI0+2SjdFTvMM27zYhgYT8+6AhvYwyW/CVTCS1odtMAQ9z8E
	jJzDEPMhtynGiBedBr6DnO12f0r9iu0tUZoEi8ZZln7luxzfvcXx0Z6jHYBIPXblmMUbJzziyqE
	tYy5w9tmEC0Ug8kFcwD/C7HWwf/+MLfIw/nnH6iFo8o9K/ltYIjw==
X-Google-Smtp-Source: AGHT+IHsSG6LFf5PiDFFo3ewFAedI003xvd4xJxMeRbQ3MH6DeQs3j9PCwinE182BXoCfinBuy0Ea+M9rZ1PRL74+a4=
X-Received: by 2002:a05:6820:450a:b0:606:8579:4c5e with SMTP id
 006d021491bc7-6083ff1566bmr6867317eaf.1.1747058441567; Mon, 12 May 2025
 07:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506112321.61710-1-cuiyunhui@bytedance.com>
 <20250506112321.61710-2-cuiyunhui@bytedance.com> <6801686d-a0b3-7093-1293-cdac6ad055e4@linux.intel.com>
 <CAEEQ3wnouWbVvkvhV1oB8MrOADNhN6BQB4-epUXa6cLYkKFRiw@mail.gmail.com>
 <41066f2f-a690-83ef-5fbb-0bc1d956a19d@linux.intel.com> <CAEEQ3w=xPmbyaCHLPtCBgFOzz7TzDYMkOnKt=EvpdknQqot=cA@mail.gmail.com>
 <34f3c38c-b224-8a4d-3235-c1df04ac1d04@linux.intel.com>
In-Reply-To: <34f3c38c-b224-8a4d-3235-c1df04ac1d04@linux.intel.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 12 May 2025 22:00:30 +0800
X-Gm-Features: AX0GCFtQnMyMmbX6QGe3uzimLWaCVKqkrdfQH7AzCtz4fE2y6kAPg4G42xunhNw
Message-ID: <CAEEQ3wn8Q04ne7nqq+MTtx=ocbi16FuCR-ptZpmYx_23Xwt60Q@mail.gmail.com>
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

On Mon, May 12, 2025 at 8:03=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 12 May 2025, yunhui cui wrote:
>
> > Hi Ilpo,
> >
> > On Mon, May 12, 2025 at 6:27=E2=80=AFPM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Mon, 12 May 2025, yunhui cui wrote:
> > >
> > > > Hi Ilpo,
> > > >
> > > > On Tue, May 6, 2025 at 8:00=E2=80=AFPM Ilpo J=C3=A4rvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > >
> > > > > On Tue, 6 May 2025, Yunhui Cui wrote:
> > > > >
> > > > > > Failure to check the UART_LSR_DR before reading UART_RX, or the
> > > > > > non-atomic nature of clearing the FIFO and reading UART_RX, pos=
es
> > > > > > potential risks that could lead to PSLVERR.
> > > > >
> > > > > Don't expect reader to know the condition how PSLVERR is triggere=
d. I know
> > > > > it's worded out in the other patch but also explain it here.
> > > > >
> > > > > You're only explaining problem and missing what this patch does t=
o solve
> > > > > the problem.
> > > > >
> > > > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > > > ---
> > > > > >  drivers/tty/serial/8250/8250.h      | 13 +++++++++
> > > > > >  drivers/tty/serial/8250/8250_port.c | 43 +++++++++++++++------=
--------
> > > > > >  2 files changed, 35 insertions(+), 21 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/seria=
l/8250/8250.h
> > > > > > index b861585ca02a..6f97ff3a197d 100644
> > > > > > --- a/drivers/tty/serial/8250/8250.h
> > > > > > +++ b/drivers/tty/serial/8250/8250.h
> > > > > > @@ -162,6 +162,19 @@ static inline u16 serial_lsr_in(struct uar=
t_8250_port *up)
> > > > > >       return lsr;
> > > > > >  }
> > > > > >
> > > > > > +/*
> > > > > > + * To avoid PSLVERR, check UART_LSR_DR in UART_LSR before
> > > > > > + * reading UART_RX.
> > > > > > + */
> > > > > > +static inline void serial8250_discard_data(struct uart_8250_po=
rt *up)
> > > > > > +{
> > > > > > +     u16 lsr;
> > > > > > +
> > > > > > +     lsr =3D serial_in(up, UART_LSR);
> > > > > > +     if (lsr & UART_LSR_DR)
> > > > > > +             serial_in(up, UART_RX);
> > > > > > +}
> > > > > > +
> > > > > >  /*
> > > > > >   * For the 16C950
> > > > > >   */
> > > > > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/=
serial/8250/8250_port.c
> > > > > > index a913135d5217..1666b965f6a0 100644
> > > > > > --- a/drivers/tty/serial/8250/8250_port.c
> > > > > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > > > > @@ -1357,9 +1357,8 @@ static void autoconfig_irq(struct uart_82=
50_port *up)
> > > > > >       /* Synchronize UART_IER access against the console. */
> > > > > >       uart_port_lock_irq(port);
> > > > > >       serial_out(up, UART_IER, UART_IER_ALL_INTR);
> > > > > > +     serial8250_discard_data(up);
> > > > > >       uart_port_unlock_irq(port);
> > > > > > -     serial_in(up, UART_LSR);
> > > > > > -     serial_in(up, UART_RX);
> > > > > >       serial_in(up, UART_IIR);
> > > > > >       serial_in(up, UART_MSR);
> > > > > >       serial_out(up, UART_TX, 0xFF);
> > > > > > @@ -2137,25 +2136,22 @@ static void wait_for_xmitr(struct uart_=
8250_port *up, int bits)
> > > > > >  static int serial8250_get_poll_char(struct uart_port *port)
> > > > > >  {
> > > > > >       struct uart_8250_port *up =3D up_to_u8250p(port);
> > > > > > -     int status;
> > > > > > +     int status =3D NO_POLL_CHAR;
> > > > > >       u16 lsr;
> > > > > > +     unsigned long flags;
> > > > > >
> > > > > >       serial8250_rpm_get(up);
> > > > > >
> > > > > > +     uart_port_lock_irqsave(port, &flags);
> > > > > >       lsr =3D serial_port_in(port, UART_LSR);
> > > > > > +     if (lsr & UART_LSR_DR)
> > > > > > +             status =3D serial_port_in(port, UART_RX);
> > > > > > +     uart_port_unlock_irqrestore(port, flags);
> > > > > >
> > > > > > -     if (!(lsr & UART_LSR_DR)) {
> > > > > > -             status =3D NO_POLL_CHAR;
> > > > > > -             goto out;
> > > > > > -     }
> > > > > > -
> > > > > > -     status =3D serial_port_in(port, UART_RX);
> > > > > > -out:
> > > > > >       serial8250_rpm_put(up);
> > > > > >       return status;
> > > > >
> > > > > Not a problem that originates from you, but IMO calling this vari=
able
> > > > > "status" is quite misleading when it is the character (or NO_POLL=
_CHAR
> > > > > is no character is present).
> > > > >
> > > > > >  }
> > > > > >
> > > > > > -
> > > > > >  static void serial8250_put_poll_char(struct uart_port *port,
> > > > > >                        unsigned char c)
> > > > > >  {
> > > > > > @@ -2264,13 +2260,17 @@ int serial8250_do_startup(struct uart_p=
ort *port)
> > > > > >        * Clear the FIFO buffers and disable them.
> > > > > >        * (they will be reenabled in set_termios())
> > > > > >        */
> > > > > > +     uart_port_lock_irqsave(port, &flags);
> > > > > >       serial8250_clear_fifos(up);
> > > > > >
> > > > > >       /*
> > > > > > -      * Clear the interrupt registers.
> > > > > > +      * Read UART_RX to clear interrupts (e.g., Character Time=
out).
> > > > > > +      * No data on UART_IIR_RX_TIMEOUT, UART_LSR_DR won't set.
> > > > > > +      * FIFO disabled, read UART_RX without LSR check, no PSLV=
ERR.
> > > > >
> > > > > I don't understand what the last two lines mean and I don't see t=
he
> > > > > connection to the code that is below the comment either, could yo=
u try to
> > > > > rephrase the comment.
> > > >
> > > > The original intention was to check UART_LSR_DR first when reading
> > > > UART_RX. However, the purpose of serial_port_in(port, UART_RX) here=
 is
> > > > to clear the interrupt, such as the interrupt caused by RX_TIMEOUT.
> > >
> > > I understood the first sentence in the comment but the rest of it is =
very
> > > cryptic and has many grammar issues too. Also, the extent of passive =
voice
> > > there makes it hard to know who does what (UART / kernel).
> > >
> > > > The logic for clearing the interrupt in the interrupt handling
> > > > function of RX_TIMEOUT is !UART_LSR_DR. And to avoid PSLVERR, we ne=
ed
> > > > to check UART_LSR_DR first. To meet the requirements of both, the F=
IFO
> > > > needs to be disabled.
> > >
> > > The grammar is so broken, it failed to convey that message.
> >
> > The purpose of serial_port_in(port, UART_RX) is to clear interrupts
> > such as rx_timeout. In dw8250_handle_irq(), serial_port_in(p, UART_RX)
> > is called when the LSR does not have the UART_LSR_DR bit set.
> >
> > To avoid PSLVERR when the FIFO is enabled, serial_in(up, UART_RX)
> > should be called only when the LSR has the UART_LSR_DR bit set.
> >
> > These two logics are clearly contradictory. Therefore, both
> > serial8250_clear_fifos() and serial_port_in(port, UART_RX) are placed
> > under the protection of port->lock.
> >
> > If you believe this is not a potential issue, that's fine. I can
> > remove this patch in the next patchset version.
>
> No, my goal is not to get this removed from the patch series.
>
> I meant that the comment wording needs to be fixed for the next version
> such that it is understandable for those that are not deeply familiar wit=
h
> what is related to PSLVERR. Currently even I struggle to follow what's
> written into that comment (unless I read heavily between lines and base
> guesses on the extra knowledge I've about how this entire patchset relate=
s
> to PSLVERR).
>

I plan to change the commit message as follows:
When the PSLVERR_RESP_EN parameter is set to 1, reading UART_RX while
the FIFO is enabled and UART_LSR_DR is not set will generate a PSLVERR
error.
Failure to check the UART_LSR_DR before reading UART_RX, or the non -
atomic nature of clearing the FIFO and reading UART_RX, poses
potential risks that could lead to PSLVERR.
PSLVERR is addressed through two methods. One is to introduce
serial8250_discard_data() to check whether UART_LSR_DR is set before
reading UART_RX, thus solving the PSLVERR issue when the FIFO is
enabled. The other is to place FIFO clearing and reading of UART_RX
under port->lock.


The comment here will be changed as follows:
To prevent PSLVERR, we can either disable the FIFO before reading
UART_RX or read UART_RX only when UART_LSR_DR is set while the FIFO
remains enabled. If using the latter approach to avoid PSLVERR, it
creates a contradiction with the interrupt - clearing (see the
rx_timeout handling in dw8250_handle_irq()).

What do you think?

> > > > Therefore, we should put serial8250_clear_fifos() and the execution=
 of
> > > > serial_port_in(port, UART_RX) without checking UART_LSR_DR under th=
e
> > > > port->lock.
> > > >
> > > > >
> > > > > >        */
> > > > > >       serial_port_in(port, UART_LSR);
> > > > > >       serial_port_in(port, UART_RX);
> > > > > > +     uart_port_unlock_irqrestore(port, flags);
> > > > > >       serial_port_in(port, UART_IIR);
> > > > > >       serial_port_in(port, UART_MSR);
> > > > > >
> > > > > > @@ -2429,15 +2429,14 @@ int serial8250_do_startup(struct uart_p=
ort *port)
> > > > > >       }
> > > > > >
> > > > > >  dont_test_tx_en:
> > > > > > -     uart_port_unlock_irqrestore(port, flags);
> > > > > >
> > > > > >       /*
> > > > > >        * Clear the interrupt registers again for luck, and clea=
r the
> > > > > >        * saved flags to avoid getting false values from polling
> > > > > >        * routines or the previous session.
> > > > > >        */
> > > > > > -     serial_port_in(port, UART_LSR);
> > > > > > -     serial_port_in(port, UART_RX);
> > > > > > +     serial8250_discard_data(up);
> > > > > > +     uart_port_unlock_irqrestore(port, flags);
> > > > > >       serial_port_in(port, UART_IIR);
> > > > > >       serial_port_in(port, UART_MSR);
> > > > > >       up->lsr_saved_flags =3D 0;
> > > > > > @@ -2519,7 +2518,6 @@ void serial8250_do_shutdown(struct uart_p=
ort *port)
> > > > > >               port->mctrl &=3D ~TIOCM_OUT2;
> > > > > >
> > > > > >       serial8250_set_mctrl(port, port->mctrl);
> > > > > > -     uart_port_unlock_irqrestore(port, flags);
> > > > > >
> > > > > >       /*
> > > > > >        * Disable break condition and FIFOs
> > > > > > @@ -2527,6 +2525,14 @@ void serial8250_do_shutdown(struct uart_=
port *port)
> > > > > >       serial_port_out(port, UART_LCR,
> > > > > >                       serial_port_in(port, UART_LCR) & ~UART_LC=
R_SBC);
> > > > > >       serial8250_clear_fifos(up);
> > > > > > +     /*
> > > > > > +      * Read data port to reset things, and then unlink from
> > > > > > +      * the IRQ chain.
> > > > > > +      * Since reading UART_RX clears interrupts, doing so with
> > > > > > +      * FIFO disabled won't trigger PSLVERR.
> > > > > > +      */
> > > > > > +     serial_port_in(port, UART_RX);
> > > > > > +     uart_port_unlock_irqrestore(port, flags);
> > > > > >
> > > > > >  #ifdef CONFIG_SERIAL_8250_RSA
> > > > > >       /*
> > > > > > @@ -2535,11 +2541,6 @@ void serial8250_do_shutdown(struct uart_=
port *port)
> > > > > >       disable_rsa(up);
> > > > > >  #endif
> > > > > >
> > > > > > -     /*
> > > > > > -      * Read data port to reset things, and then unlink from
> > > > > > -      * the IRQ chain.
> > > > > > -      */
> > > > > > -     serial_port_in(port, UART_RX);
> > > > > >       serial8250_rpm_put(up);
> > > > > >
> > > > > >       up->ops->release_irq(up);
> > > > > >
> > > > >
> > > > > --
> > > > >  i.
> > > > >
> > > >
> > > > Thanks,
> > > > Yunhui
> > > >
> > >
> > > --
> > >  i.
> >
> > Thanks,
> > Yunhui
> >
>
> --
>  i.

Thanks,
Yunhui
