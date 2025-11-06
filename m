Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCFA340DA6
	for <linux-serial@vger.kernel.org>; Thu,  6 Nov 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448091; cv=none; b=KEfQQqWdxbuHj+txWuERiTMOk5S3Q0DIqIC/gaokZWsCj3/I+5kPrHwA+WpXGjyjT9Y8SLxTTwAcTeDmFNWI8pqWNhc6HWabIKUMh3I02U1CAz3rBP3LuKTNTlzLrtEUkCPBwUJcYrzZ3KeOQvHBOnab7+iX4o6cx6K0P+HaxR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448091; c=relaxed/simple;
	bh=0f45Jhy3vyneeuTWj7fqcWoBCV5Ykzs4Vow1o8J9vUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KId4Rfo1FU2jHpzm+qeMUE/Ifd+lfpLKRwxPXcmZqxYafeJ5i+2P0buiG8S+Jky9H/Ci1EZ/SBDg1tDdI+SFNoRKDkudmgT8ar8SCJBCzrZsFZMO5ab5SyEk9DDEc2JX92OvQhX0tOMkdR/a7PjLES/kfKNtQjP/F1iw5+X5R0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64034284521so1880797a12.1
        for <linux-serial@vger.kernel.org>; Thu, 06 Nov 2025 08:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448086; x=1763052886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHEPbBF5p6FHfbwI0jMq/NClHsHl36pINBGK1avEHfY=;
        b=vo//tHiTMnMtW83QP97kTGbGytOXoelgvIlSAvVOAP5eps2+DoYeSo41PYVotdZjnK
         JLoY1TjPFncqhBZAAPV2euUNNf8s60escBsrTHJcWVPo7lgc2YsIIX0U4XuwasmhuNMD
         jNNXs1XLxwbdwpoNWJwmeQ4pe8QLViOzM0kilgXKeMBrKZYEERtwxu8fhUY6umnG1aGW
         NZyGFR8eOg/aKzMFc6MtzG3nMiky+YmcK521L7fX3KOpFEXWSTwWoW6v3xOon6Tt/FUo
         kElDxkYD2cjrK8ybQmPGWAUHVl1neX7zxDcVQzfIUw5xQ3c4LoMxw38WZF2cEPCAA6P6
         RrfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQx0lro7p0g2H+bYql75FrNfneNZLAJuj2qRJYh3P+3Oh8rOJFcsPjxMCF6cg1Az8Y7J3JC/Ft89MHOtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0A6LCXh5MACTdmA5OFRN4YEBqtvnt5q+xi2Pc+GzmI6glfNcx
	a5nfER2joR/kobYaiSPEFXAXyi8jRYwM16izeDPG/WPlP0+3STYXbwBxKjt+q8AvYjg=
X-Gm-Gg: ASbGncvCVKG36qv+CfZscdvYqojOEZXCxswn+fDU1XtOURD1GDKvBNSLHcdHnj4PPNE
	JUR8/bTdWogU4XKqWqN1Lm6a+fP92OlHx8TgEEdx3Ovo1+il+UgZghPz8mYXg1Pvx0z/JhFsBOm
	Qc3wdZCE6J1K2T0fOBAWXyFZmIs1vUoS9NIQTGDhUDGoyoth5nxCsjK1hlC/dfFj0qBIY1/Ftc7
	jcE5qIbqMWitgVV9xS8ksM3Pe+MUfb8mTcdyzRe8lacDXJp1XbkQMy35ICFbrfKKA7z4tlo0XES
	EKKCjH8Chil0XmvmIPz1Our86OQDvTTIOHHLx6TEDof6/2dHxcaOvwB8DQvTLd2x2rQvty2arT3
	YHVR7Jo+koP8HUlXbtuj5NIM0i6ldbKGP66vdjnvWEOlIjBwlJ0/gWRxXz3bmN7mzdG1UBprC2j
	8+lY1NubqhrMXfduTlW1AS4ejJe7NXudsv0DjP3FP7AV1UekZc
X-Google-Smtp-Source: AGHT+IFD5fVkxjaUWofe3S4/xC7gBffIuAs1BZs/SH/ee4tCNk+gKHtQ6T8tz/b/9TAk7fXBISzeCw==
X-Received: by 2002:a05:6402:146f:b0:640:f974:7629 with SMTP id 4fb4d7f45d1cf-6413eee0f72mr63546a12.15.1762448085857;
        Thu, 06 Nov 2025 08:54:45 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f862b98sm2488500a12.29.2025.11.06.08.54.43
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:54:43 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640ace5f283so1520478a12.2
        for <linux-serial@vger.kernel.org>; Thu, 06 Nov 2025 08:54:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbkXstwNJeK+dwwafZtr2NWsXZQSSKG58Bj7Lg2/Jd+swYWpTs0uKhxroPF7vBR0F93YSGzntTGv6Txb0=@vger.kernel.org
X-Received: by 2002:a05:6402:460f:20b0:640:a7bc:30c5 with SMTP id
 4fb4d7f45d1cf-6413f070166mr36081a12.28.1762448083616; Thu, 06 Nov 2025
 08:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923154707.1089900-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20250923154707.1089900-1-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 17:54:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWRCGYLRK_WBmbB0cRP7PHiGPSi3U1jdWSVKaTSweruUw@mail.gmail.com>
X-Gm-Features: AWmQ_bmQmsHt_92KjlOBxlqZCgcBwWXwdvX6xOc66LuFHB1pYmrIKPozpRSE9Ro
Message-ID: <CAMuHMdWRCGYLRK_WBmbB0cRP7PHiGPSi3U1jdWSVKaTSweruUw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: sh-sci: fix RSCI FIFO overrun handling
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Nam Cao <namcao@linutronix.de>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Tue, 23 Sept 2025 at 17:47, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The receive error handling code is shared between RSCI and all other
> SCIF port types, but the RSCI overrun_reg is specified as a memory
> offset, while for other SCIF types it is an enum value used to index
> into the sci_port_params->regs array, as mentioned above the
> sci_serial_in() function.
>
> For RSCI, the overrun_reg is CSR (0x48), causing the sci_getreg() call
> inside the sci_handle_fifo_overrun() function to index outside the
> bounds of the regs array, which currently has a size of 20, as specified
> by SCI_NR_REGS.
>
> Because of this, we end up accessing memory outside of RSCI's
> rsci_port_params structure, which, when interpreted as a plat_sci_reg,
> happens to have a non-zero size, causing the following WARN when
> sci_serial_in() is called, as the accidental size does not match the
> supported register sizes.
>
> The existence of the overrun_reg needs to be checked because
> SCIx_SH3_SCIF_REGTYPE has overrun_reg set to SCLSR, but SCLSR is not
> present in the regs array.
>
> Avoid calling sci_getreg() for port types which don't use standard
> register handling.
>
> Use the ops->read_reg() and ops->write_reg() functions to properly read
> and write registers for RSCI, and change the type of the status variable
> to accommodate the 32-bit CSR register.
>
> sci_getreg() and sci_serial_in() are also called with overrun_reg in the
> sci_mpxed_interrupt() interrupt handler, but that code path is not used
> for RSCI, as it does not have a muxed interrupt.
>
> ------------[ cut here ]------------
> Invalid register access
> WARNING: CPU: 0 PID: 0 at drivers/tty/serial/sh-sci.c:522 sci_serial_in+0x38/0xac
> Modules linked in: renesas_usbhs at24 rzt2h_adc industrialio_adc sha256 cfg80211 bluetooth ecdh_generic ecc rfkill fuse drm backlight ipv6
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc1+ #30 PREEMPT
> Hardware name: Renesas RZ/T2H EVK Board based on r9a09g077m44 (DT)
> pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : sci_serial_in+0x38/0xac
> lr : sci_serial_in+0x38/0xac
> sp : ffff800080003e80
> x29: ffff800080003e80 x28: ffff800082195b80 x27: 000000000000000d
> x26: ffff8000821956d0 x25: 0000000000000000 x24: ffff800082195b80
> x23: ffff000180e0d800 x22: 0000000000000010 x21: 0000000000000000
> x20: 0000000000000010 x19: ffff000180e72000 x18: 000000000000000a
> x17: ffff8002bcee7000 x16: ffff800080000000 x15: 0720072007200720
> x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
> x11: 0000000000000058 x10: 0000000000000018 x9 : ffff8000821a6a48
> x8 : 0000000000057fa8 x7 : 0000000000000406 x6 : ffff8000821fea48
> x5 : ffff00033ef88408 x4 : ffff8002bcee7000 x3 : ffff800082195b80
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff800082195b80
> Call trace:
>  sci_serial_in+0x38/0xac (P)
>  sci_handle_fifo_overrun.isra.0+0x70/0x134
>  sci_er_interrupt+0x50/0x39c
>  __handle_irq_event_percpu+0x48/0x140
>  handle_irq_event+0x44/0xb0
>  handle_fasteoi_irq+0xf4/0x1a0
>  handle_irq_desc+0x34/0x58
>  generic_handle_domain_irq+0x1c/0x28
>  gic_handle_irq+0x4c/0x140
>  call_on_irq_stack+0x30/0x48
>  do_interrupt_handler+0x80/0x84
>  el1_interrupt+0x34/0x68
>  el1h_64_irq_handler+0x18/0x24
>  el1h_64_irq+0x6c/0x70
>  default_idle_call+0x28/0x58 (P)
>  do_idle+0x1f8/0x250
>  cpu_startup_entry+0x34/0x3c
>  rest_init+0xd8/0xe0
>  console_on_rootfs+0x0/0x6c
>  __primary_switched+0x88/0x90
> ---[ end trace 0000000000000000 ]---
>
> Cc: stable@vger.kernel.org
> Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch, which is now commit ef8fef45c74b5a00 ("tty:
serial: sh-sci: fix RSCI FIFO overrun handling") in v6.18-rc3.

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1014,16 +1014,18 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
>         struct sci_port *s = to_sci_port(port);
>         const struct plat_sci_reg *reg;
>         int copied = 0;
> -       u16 status;
> +       u32 status;
>
> -       reg = sci_getreg(port, s->params->overrun_reg);
> -       if (!reg->size)
> -               return 0;
> +       if (s->type != SCI_PORT_RSCI) {
> +               reg = sci_getreg(port, s->params->overrun_reg);
> +               if (!reg->size)
> +                       return 0;
> +       }
>
> -       status = sci_serial_in(port, s->params->overrun_reg);
> +       status = s->ops->read_reg(port, s->params->overrun_reg);
>         if (status & s->params->overrun_mask) {
>                 status &= ~s->params->overrun_mask;
> -               sci_serial_out(port, s->params->overrun_reg, status);
> +               s->ops->write_reg(port, s->params->overrun_reg, status);
>
>                 port->icount.overrun++;
>

Ouch, this is really becoming fragile, and thus hard to maintain.
See also "[PATCH v2 2/2] serial: sh-sci: Fix deadlock during RSCI FIFO
overrun error".
Are you sure this is the only place where that can happen?
sci_getreg() and sci_serial_{in,out}() are used all over the place.

[1] https://lore.kernel.org/20251029082101.92156-3-biju.das.jz@bp.renesas.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
