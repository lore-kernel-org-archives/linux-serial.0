Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD2B248F63
	for <linux-serial@vger.kernel.org>; Mon, 12 May 2025 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747019192; cv=none; b=s4lMkuQ5EFWhcArSTnBpGupKt/02XxzZFU29nDIu2cjtyUBo1XnO5kMWzvzO72FUZuNBxoTLFZljPa3HlFDiPBrnPmyHWChQZCifl/1KEBRaRVh1az+5LvptNOEhJzrU4D/q2Dr6eLTzHxzBWmlLmpaxZiIF89wp5Deavo8YLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747019192; c=relaxed/simple;
	bh=DDvoLkisV+Nn0NQ3YyHugyHFbkEhVlG+mk1zvy66cgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKGX7GPmvJo/LdSYZqbG1il4sClzZHl6LQ3OvaYQS9/bsI+VkUM+MhCRUIl6b0TsjJssSnpdSbH+SLOL6OkYsJa+9ScPMycASyvpcWX9hmdkJIEBV0TI0uLaW44UkzpdaGggCpY1VxWc/fUvJoL8H3+iFwIrl6kUQ7G6t87SIUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HTpuX3Vy; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HTpuX3Vy"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2da73155e91so1681423fac.0
        for <linux-serial@vger.kernel.org>; Sun, 11 May 2025 20:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747019190; x=1747623990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPwBZW6C48sHTTDmr4xAf4I3boWVh8wXX9GgHadHb/o=;
        b=HTpuX3Vy7/KD2JO54pVW+Zkta+9ebrXTxOl9KKOBho9kfaRFIDcwbLVGgTmA5OedFi
         tTdUtP4g8TLRvyCIiOzJk2rdxXGxUakisaAzDcX1C2tdWaPDm9xf6UpDrTHyMKte9pot
         SnaC1jA6JbI0Vtba30bKNvUAT12bIb9CUpqJypCguvuGu+q1h8Jw5npbIbkzZ+ex6oSt
         ZOzbOnQBxG08Cvk30DUyH5569b1sovnN04CsPnfLyiZAEiJ0FRN/RLhNH6crXO/73NKm
         Ss4M1hh6eY1JAm98vy8rFNZVAz3x6L/OVJ9ee1LkWgQTk+WDVzGHWyht9uPdVGCxrOQ5
         YiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747019190; x=1747623990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPwBZW6C48sHTTDmr4xAf4I3boWVh8wXX9GgHadHb/o=;
        b=urg2l+clxN/f1WiXAQhn4ezRh+8EyqmZTAG9p1ol5U+dwpiHaivowE+cSQRKzUHR1E
         RtDi7v4MgGJSCBewmubhvsKIVu85WcMR4YIqamT8keomwgy2IDxr9DX8VO4fXeeZ5zKk
         dM81BEo5zpkMIHAw9cp6GYgI5APqnzdlWs1irWmUVNO4OoaVO92F0JFV7TWVGw2VT92J
         z6HL8jP3Fl2DzeEeOstgyQgReXRMDu/W19X03jtD39eOjvZP8/+VUESZG03Ae6sGMWDl
         /rezUNep/M5NI3f4JCzdzgdIlvM3qmLjYxxBp+TSL6UWXd9RugKJUIPc40Xgagm8fa57
         BxKw==
X-Forwarded-Encrypted: i=1; AJvYcCXv1UKVUHznR4wqvqwwFWEVAewKfHevtwAGAc+OWN1s9aJz8jOEDek3Zo/y9knnVNsH3bfuKIQpHbrZZ1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi0v8ylM4dIE7Kwz9pMngjJsmX1/+1VprQpQQsAAhrPydCowN2
	e0WoT9HCVOw/2HxgRGuo/FXwxaaS+okIh0BrYwH9GyR8u1cFMfLgomdDbXtfC8QBUWnRwD7tfqX
	Oj1iqx+pQXtwzHhPWlavyCN8LDSyFb7KzOJCbaA==
X-Gm-Gg: ASbGncuANc7xghaLAPwoAncWFjITrnQWMtPQMASfaA20jmTZSzudaL3sG+DFBgVyU7F
	PhkPZnNNDmQ8+O57WmbPO+v0HdZhA/nzMWCM/xna9s6rl13Ip0uXUnHLMwHGj07niyQj174M7nA
	rM06H9Anb2XvkyNhwjMD/BTNLUiKbSf2a1CIvM0b11QqpOJC8YIw==
X-Google-Smtp-Source: AGHT+IG++O0rtzqvVYxYmDGSFo4KSV/BmaSI1CyUbigKozAVVDi+c1G0GeeVixgP+LXAaX3FHtbEJ4XjV/WmikpcoIg=
X-Received: by 2002:a05:6870:e985:b0:2c1:650b:fc86 with SMTP id
 586e51a60fabf-2dba4214053mr6238155fac.1.1747019189869; Sun, 11 May 2025
 20:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506112321.61710-1-cuiyunhui@bytedance.com> <49865b06-c7c5-220b-aa01-0f1898d189f2@linux.intel.com>
In-Reply-To: <49865b06-c7c5-220b-aa01-0f1898d189f2@linux.intel.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 12 May 2025 11:06:19 +0800
X-Gm-Features: AX0GCFtZtQKq2P7W692gR0sXA5U91EVQ8Ng_2b_4-aqsvPFwtQOb7NsaSxCMEx8
Message-ID: <CAEEQ3wkVubuObJ8AoMmRb++54JybnHk8jC8k72=Qyq6vQoDwHg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 1/4] serial: 8250: fix panic due to PSLVERR
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

On Tue, May 6, 2025 at 8:35=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 6 May 2025, Yunhui Cui wrote:
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
>
> Where is dont_test_tx_en label?

Oh, I'll rebase the latest code of linux-next.

>
> > ...
> > serial_port_in(port, UART_RX);
> > This satisfies the PSLVERR trigger condition.
> >
> > Because another CPU(e.g., using printk()) is accessing the UART (UART
>
> Because -> When ?
>
> missing space before (
>
> > is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) =3D=
=3D
> > (lcr & ~UART_LCR_SPAR)
>
> Add:
>
> ... in dw8250_check_lcr()

Okay, it will be updated in the next version.

>
> >, causing it to enter dw8250_force_idle().
> >
> > Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->loc=
k
> > to fix this issue.
> >
> > Panic backtrace:
> > [    0.442336] Oops - unknown exception [#1]
> > [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> > [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> > ...
> > [    0.442416] console_on_rootfs+0x26/0x70
> >
> > Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaroun=
d")
> > Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/=
T/
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 3f256e96c722..a913135d5217 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2380,9 +2380,10 @@ int serial8250_do_startup(struct uart_port *port=
)
> >       /*
> >        * Now, initialize the UART
> >        */
> > -     serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> >
> >       uart_port_lock_irqsave(port, &flags);
> > +     serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> > +
> >       if (up->port.flags & UPF_FOURPORT) {
> >               if (!up->port.irq)
> >                       up->port.mctrl |=3D TIOCM_OUT1;
> >
>
> --
>  i.
>

Thanks,
Yunhui
