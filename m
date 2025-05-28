Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05241E833D
	for <linux-serial@vger.kernel.org>; Wed, 28 May 2025 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748403010; cv=none; b=MJTpQK31JYgQGHchgfaeNEBYDKQqOLW/HWWdulPWdQsl3dJQU2Df5qo/ujLwebRErmJHBH6G53o8h06fT/WIkRHekv/OaGgcdkoNagVnCbkFqh14jbPZivsrXRdQ6nAFn/EFSk1V+0F68HFHCKRfm2rjJYRiEe3JtysYFX5hWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748403010; c=relaxed/simple;
	bh=lp59MG/v0MEjnyPw9NAqaEU+qnQ/CI3UyhnltWOSdD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9T5v+Ay4KtPXfNJdy8uFsWM1JPTBI1CqcqoTh9yAFTGjxWqmoC52VjYIhtHwnAbxCjL5+KJHncuiTt4Zd82eQWXcjrROjgT8zGwyelfY2jkrr49hg1UzSWIEkSgFOLJtG6Yp5uLO6IMRsK9Yv6QsAQxqVAZYKSbWznjf1rpUHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IneiC2An; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IneiC2An"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-40356cb3352so298352b6e.1
        for <linux-serial@vger.kernel.org>; Tue, 27 May 2025 20:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748403008; x=1749007808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrpEuuXYvnSuwWGsniVnX2YpkMWl6dVwsPZNUsHfWF0=;
        b=IneiC2AnaH9l+bH9QnSyFBFORZxwRCR34xeHjAKi77lDEuL1t78exhV737N5mOZTNS
         f3DfCXpQYy+EVTvie0m2KMKX+8irttOXGAyKt/WQ/f5cbJN6Kx2j7a6zkrGvfqZH7zu/
         qMk/zP3+cOsxjPs2SU5jjIn3XqP5s0M1PGSafo4r7ZE6qTo+kR2bGIAQLMFY6vZc5Lqo
         U07qsCtsixz+okq5uJoeCqb85FV/uXOxyj4nOKRWN1qje3HxxyVyKZfhSLVwP9KCU1U0
         S+B0UhVdDwpmFVTT+53b5CrskZBR4ATuzDyMHUqyg+SHtcf53TCFfNK5+qSo9ATyg+yd
         tnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748403008; x=1749007808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrpEuuXYvnSuwWGsniVnX2YpkMWl6dVwsPZNUsHfWF0=;
        b=H+4RRbpXxT+IxO0VquYXLFoCuGgB+ixkETr66RivJ38Y3RKP6OMJAYpLOONa+0kJry
         Mtn9h8H84AqkihXk3/+xTW5KMeSoBWphnLkayB2TuG/ncFw8c4Cx9+4221nIdljT1Vdd
         Oz9JwrK0782T5VdM/IdGF14olV8BzlOOkmyJoH0StolgN98NjlKk0aozt3MaIOrtndsZ
         OIaWukh+Q9aTUoLHuUf7Z3lYFq2TpLLZbDgMhilqkZ+lQLoGrdIf64FyfZKEUCLBwd74
         vTwTqU0RqChRUxwn7UP4YI3l/tdy5v75mfkpLvL43Vlu+ZcRlH5raoPABUWhiDpW6kF6
         8TXA==
X-Forwarded-Encrypted: i=1; AJvYcCXIO2oX5p+GE6ZiAeopNa38Ofr17P870GW+80CrIizndMl4HvkGpUEfJWiLSQdG3+VB9oiYh1YzrycQ8/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/vFYEibZQsHJUkvh9FRiHdF0kxPlcQ/Zm0UjrhdihGV+vbIJ
	vH6C21czspCGZYntvPHDYciHn6ozADnO3x7Uwmya1JhOBOCU6HYktStL/oIE6fziZSEDGOjm2Zz
	2+sGkQKXHoGUFNA4L1gbpjzs9Qf90Zt5KGtr99GUbUA==
X-Gm-Gg: ASbGncta/jlOg632hsrkbz4+CTrSXeflms35MEUJ7DG6SrhBJ12AvyyXgJdSCLbyaaK
	xOCQgEmQBpC4Aah/ycouUSPq9+VotguzJ23RpV2WmbAIMK95QqdiNlbCgwA2m9k2BAUEIhzvUq4
	3uNAA9cc7oyqfCXzhDShjtp0wxvlGyi5tptYY=
X-Google-Smtp-Source: AGHT+IHM257O3Htv6+WIrvCz49XVMrZHrN3aXMi+LHiIEKQzjeEjAt/Co+wbNNhuDh0ENQfvDtdU1wumurlo0vJP6vw=
X-Received: by 2002:a05:6808:1b87:b0:406:4e0c:9aab with SMTP id
 5614622812f47-406603dcfb4mr1959266b6e.11.1748403007652; Tue, 27 May 2025
 20:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513024212.74658-1-cuiyunhui@bytedance.com>
 <20250513024212.74658-2-cuiyunhui@bytedance.com> <84y0uq9z0o.fsf@jogness.linutronix.de>
In-Reply-To: <84y0uq9z0o.fsf@jogness.linutronix.de>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 28 May 2025 11:29:55 +0800
X-Gm-Features: AX0GCFtY48YUUoKYOkevJvcVSQCY_T7dJuR9Fc4nQmnT8dJb_3-42tZKJL-37Ck
Message-ID: <CAEEQ3wn6tY7QQppTScBMQTeAZDTXdEY1CJYxvGHhE9FNm_4a7g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 2/4] serial: 8250: avoid potential
 PSLVERR issue
To: John Ogness <john.ogness@linutronix.de>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, gregkh@linuxfoundation.org, 
	heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	jirislaby@kernel.org, jkeeping@inmusicbrands.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John Ogness,

On Wed, May 21, 2025 at 3:57=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> On 2025-05-13, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 07fe818dffa34..9a04f24b0c762 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2133,25 +2132,22 @@ static void wait_for_xmitr(struct uart_8250_por=
t *up, int bits)
> >  static int serial8250_get_poll_char(struct uart_port *port)
> >  {
> >       struct uart_8250_port *up =3D up_to_u8250p(port);
> > -     int status;
> > +     int status =3D NO_POLL_CHAR;
> >       u16 lsr;
> > +     unsigned long flags;
> >
> >       serial8250_rpm_get(up);
> >
> > +     uart_port_lock_irqsave(port, &flags);
> >       lsr =3D serial_port_in(port, UART_LSR);
> > +     if (lsr & UART_LSR_DR)
> > +             status =3D serial_port_in(port, UART_RX);
> > +     uart_port_unlock_irqrestore(port, flags);
>
> I realize I previously made a comment saying it was OK to add the spin
> locking here. But I have changed my mind. Please remove this spin
> locking. It is not necessary because with kgdb all the other CPUs are
> quiesced, so there is no need to synchronize with the console. Also, it
> will deadlock if kgdb took over while the port was locked.
>

Okay.


> > @@ -2513,7 +2514,6 @@ void serial8250_do_shutdown(struct uart_port *por=
t)
> >               port->mctrl &=3D ~TIOCM_OUT2;
> >
> >       serial8250_set_mctrl(port, port->mctrl);
> > -     uart_port_unlock_irqrestore(port, flags);
> >
> >       /*
> >        * Disable break condition and FIFOs
> > @@ -2521,6 +2521,14 @@ void serial8250_do_shutdown(struct uart_port *po=
rt)
> >       serial_port_out(port, UART_LCR,
> >                       serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
> >       serial8250_clear_fifos(up);
> > +     /*
> > +      * Read data port to reset things, and then unlink from
> > +      * the IRQ chain.
> > +      * Since reading UART_RX clears interrupts, doing so with
> > +      * FIFO disabled won't trigger PSLVERR.
> > +      */
> > +     serial_port_in(port, UART_RX);
> > +     uart_port_unlock_irqrestore(port, flags);
> >
> >  #ifdef CONFIG_SERIAL_8250_RSA
> >       /*
> > @@ -2529,11 +2537,6 @@ void serial8250_do_shutdown(struct uart_port *po=
rt)
> >       disable_rsa(up);
> >  #endif
> >
> > -     /*
> > -      * Read data port to reset things, and then unlink from
> > -      * the IRQ chain.
> > -      */
> > -     serial_port_in(port, UART_RX);
>
> I am thinking you should keep the read here and instead move the unlock
> below the read. This would mean the lock/unlock in disable_rsa() need to
> be removed. (The function comments for disable_rsa() aready say that the
> caller needs to hold the port lock.)
>
> I am thinking something like the below (untested) diff instead of the
> above 2 hunks.

Reasonable. disable_rsa() has only one caller currently, to be updated
in the next version.

>
> John Ogness
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 22b3f7a193070..51467383aaf5a 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -781,8 +781,6 @@ static void disable_rsa(struct uart_8250_port *up)
>
>         if (up->port.type =3D=3D PORT_RSA &&
>             up->port.uartclk =3D=3D SERIAL_RSA_BAUD_BASE * 16) {
> -               uart_port_lock_irq(&up->port);
> -
>                 mode =3D serial_in(up, UART_RSA_MSR);
>                 result =3D !(mode & UART_RSA_MSR_FIFO);
>
> @@ -794,7 +792,6 @@ static void disable_rsa(struct uart_8250_port *up)
>
>                 if (result)
>                         up->port.uartclk =3D SERIAL_RSA_BAUD_BASE_LO * 16=
;
> -               uart_port_unlock_irq(&up->port);
>         }
>  }
>  #endif /* CONFIG_SERIAL_8250_RSA */
> @@ -2536,7 +2533,6 @@ void serial8250_do_shutdown(struct uart_port *port)
>                 port->mctrl &=3D ~TIOCM_OUT2;
>
>         serial8250_set_mctrl(port, port->mctrl);
> -       uart_port_unlock_irqrestore(port, flags);
>
>         /*
>          * Disable break condition and FIFOs
> @@ -2555,8 +2551,12 @@ void serial8250_do_shutdown(struct uart_port *port=
)
>         /*
>          * Read data port to reset things, and then unlink from
>          * the IRQ chain.
> +        *
> +        * Since reading UART_RX clears interrupts, doing so with
> +        * FIFO disabled won't trigger PSLVERR.
>          */
>         serial_port_in(port, UART_RX);
> +       uart_port_unlock_irqrestore(port, flags);
>         serial8250_rpm_put(up);
>
>         up->ops->release_irq(up);

Thanks,
Yunhui
