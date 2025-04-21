Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E4BA42
	for <linux-serial@vger.kernel.org>; Mon, 21 Apr 2025 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204119; cv=none; b=Q8S6YTnvdjrJ7W0Xct1SdqI5QcCEIYrTNF537pFAQ9U3b0wLuf8sD1ikQTPl1mXf02v08IrgxAevL0U2/wh3KGxNpdI5s8reP6o7+U0Hz8DxR9ab6FFA2BoGJ57xe89a29PzThOdCt0TCDqiFqxbaz56He+ImVs/bTxyJ22SugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204119; c=relaxed/simple;
	bh=AQb46CQkwv8QeUadsbrclWLA6h/SnySMlq4iBKKvV98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ow9YnbWUgKmKx5Xd/zkQAUYDOOe4oaHj4Z8MsT1Te0c7aPIG+Iz1Zz8R268PkFGl0JTT9nrfeoQxElggmP0clOfz2hALDpiKMTr3bGI0+Kkg1PAME7AVzHQi9b0d0w7Uo5wDYWsClnk4BLWpW0jn4AF5FhTi+2ZxNmz/EBcnVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g3kJj5mP; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g3kJj5mP"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3f9832f798aso2565121b6e.2
        for <linux-serial@vger.kernel.org>; Sun, 20 Apr 2025 19:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1745204116; x=1745808916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24kp0DtFzqPBLQcVjtgOgftKsl0Wykg9m8M9N67arVY=;
        b=g3kJj5mPxaVapP9jB4aB11DG9J77pBj+tI3XHzVR/27Z72oA0pBngGiH/91cP63Qeu
         I9KEI/bB8RMsInXLwIPfBJ5xRjdublLjf1C5aYUDuFd4kMflpTvjFkZhoGOrrOp/Bcm8
         YuK7ZJCuSR4h5Q43uhDDfM80la8x03UM7HK/h0kQ1Sb8YsMhtxA+n9A8te5QINGg25yb
         0aVXgkCTLipafFg4Z7ayoCVr/aIH4YVVlujAptSXx/j8V1I1XfHR8fqaCraOYJ9u8HyY
         wDpp54UucPINavtLhKLSEoa6QTiODBCUCPneKIa7cVcymkujBIXI2j7Eptj8AaMZq8SI
         H7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745204116; x=1745808916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24kp0DtFzqPBLQcVjtgOgftKsl0Wykg9m8M9N67arVY=;
        b=UaS3R2hLe+0GE/tvCfIuJwm+6n9JUnPKAm6jVsh42yNAdf4v5xRFBewwSGyDT+jKbQ
         xAv8a6eBMDtUfYWyzV/7AxaMFjQvBVS7VJX7P3MpPW3ndfMZ9uDzi8aHwu6MTIurlcmX
         L19jPNLSTGpjrdrQ40JQ3oJff/SsyqrlEaQAuJjiux3QMWasMWT0vH1N7nS75HXbplPc
         vRv/D+NY5nyWY0ErUCA22phIF3x+OYeU+j49k716yhDWNmgRD7xm51AwtFUayMVzHPiu
         y8fKOvvVyapktebvCB+PVXgYra8g5+swZDZyeg/EjGBe2JSiRp6xsXs/g1LSyrBupicS
         67OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI5xl8DAET8URTshUFQnzPSUZKkf06pO76Xa/Mnhor0D0WRyPdOOK2NgvJAZprYvJ3bYHAJQAaSF924FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIAx5Lic+Wkbr2dNUAMGqyPvFuwjQA4yOUKNv/48WADenTUAg8
	hSahFTCE1XrfIZ7ZJOlpAxW2oVtsiUkt4VVWcrxr8va8JA7bcPTASLtLOLpY31mR4a61tkzrVnK
	5Wq6R6o4J2bTJlHBxVoKf85k5eIZa3k4fhGO+Ew==
X-Gm-Gg: ASbGncuYRsX9u2SmXfMkorbfckgQxuC9XExH/5fu38F0HvKSVvDoSkSoXitylVsM+eH
	l34OOyEQiUKF0uhpheShKNn0VBGTVqWgHYDeu0iT5MfNecxDre/fWq3tD8je9ApL1eMYO6VZgcD
	uuR/oGlU6bOyw+/I4XBbqSf0P0
X-Google-Smtp-Source: AGHT+IGQ/1pe/rx0vrdN1Mljx1yTkRDFB1HBkKKgbmiaqdr/zlWVkn9kXF032wYtBsFK7PAaKvKtp0o7of3PH+VyeuU=
X-Received: by 2002:a05:6808:6b96:b0:401:188e:caa2 with SMTP id
 5614622812f47-401c0c6c149mr6020709b6e.35.1745204116301; Sun, 20 Apr 2025
 19:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414031450.42237-1-cuiyunhui@bytedance.com> <Z_zLqH1Moavhi52x@smile.fi.intel.com>
In-Reply-To: <Z_zLqH1Moavhi52x@smile.fi.intel.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 21 Apr 2025 10:55:05 +0800
X-Gm-Features: ATxdqUER1LqipBsEUKZFgk1sLE_mXfx3MuJPEsX2epvsl4H0rYMzEmZGhAcjimA
Message-ID: <CAEEQ3wnEu2o+h2RY4rTGYR0yMX2EcX+7SdciqfzV3VLGWFyG3A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] serial: 8250: fix panic due to PSLVERR
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, john.ogness@linutronix.de, pmladek@suse.com, 
	arnd@arndb.de, namcao@linutronix.de, benjamin.larsson@genexis.eu, 
	schnelle@linux.ibm.com, heikki.krogerus@linux.intel.com, 
	markus.mayer@linaro.org, tim.kryger@linaro.org, matt.porter@linaro.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Apr 14, 2025 at 4:47=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Apr 14, 2025 at 11:14:50AM +0800, Yunhui Cui wrote:
>
> You forgot to rebase against latest tty-next or, if there is something
> in the latter (but I don't see right now), even tty-testing.
>
> > When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> > an error response if an attempt is made to read an empty RBR (Receive
> > Buffer Register) while the FIFO is enabled.
> >
> > In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> > UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> > dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> > function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> > Execution proceeds to the dont_test_tx_en label:
> > ...
> > serial_port_in(port, UART_RX);
> > This satisfies the PSLVERR trigger condition.
> >
> > Because another CPU(e.g., using printk()) is accessing the UART (UART
> > is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) =3D=
=3D
> > (lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().
> >
> > To fix this, all calls to serial_out(UART_LCR) and serial_in(UART_RX)
> > should be executed under port->lock. Additionally, checking the readine=
ss
> > via UART_LSR should also be done under port->lock.
> >
> > Panic backtrace:
> > [    0.442336] Oops - unknown exception [#1]
> > [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> > [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> > ...
> > [    0.442416] console_on_rootfs+0x26/0x70
>
> This patch seems need split to three. See below.
>
> ...
>
> First of all, while everything looks better now, there is a chance in the
> future to miss the same issue again. In order to avoid that I suggest to
> introduce a new helper where you made this check _and_ add a comment why.
>
> (Note that currently you have a mixture of serial_in()/serial_port_in() i=
n
>  some cases.)
>
> static inline unsigned int serial8250_discard_data(struct uart_8250_port =
*up)
> {
>         u16 lsr;
>
>         lsr =3D serial_in(up, UART_LSR);
>         if (lsr & UART_LSR_DR)
>                 return serial_in(up, UART_RX);
>
>         return 0;
> }
>
> And this can be one patch (patch 2).
>
> ...
>
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
>
> Changes here deserve the separate patch (patch 1).

Splitting into a patchset is fine. What does "patch 1" refer to here?

>
> ...
>
> > +     /*
> > +      * Serial_in(p, UART_RX) should be under port->lock, but we can't=
 add
>
> serial_in()

Okay.

>
> > +      * it to avoid AA deadlock as we're unsure if serial_out*(...UART=
_LCR)
> > +      * is under port->lock.
> > +      */
> > +     lockdep_assert_held_once(&p->lock);
>
> ...
>
> > +     uart_port_lock_irqsave(port, &flags);
>
> And one patch (patch 3) about locking.

Okay.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Thanks,
Yunhui
