Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E61F3FE2
	for <linux-serial@vger.kernel.org>; Thu,  6 Nov 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447901; cv=none; b=SrDo+YGtIUtFnsIvcn4Hp7mj4fZ/h9CPMrxh38/cPtGHvZhIhmegQOIKrqyPtFD9oYbjvI/ZB6Rn1HyasgLdZkmAAejOjJGwhd0gd/YmJvzgZW5JPwoGZ9cO1BYTQBAHgxa+ga8NcxsyvK6suOM118fIAKuQGB0nOxZ7jZkUOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447901; c=relaxed/simple;
	bh=D2ZR6G6YZxccCdiqKPZyO6q0gMcscv+IoBGces3watg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYk5+XQ5S+uMczuvoo/qXYJE5PvEOuSAKCLoDGf/TwxjOclbKx/NXzoTA4uel1btspMmWZtbk4JAvoLUSI/omVnjBfzaoHcPIh6r4hj5LhjoANqriFTBmSbTHTXmkSsw0+EZ1qtmd/x4FiG/Tmxlhn6FV94+vS32nNZVPsyvTQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b70bee93dc4so159864966b.3
        for <linux-serial@vger.kernel.org>; Thu, 06 Nov 2025 08:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447894; x=1763052694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fIROfk4M31jFA5apdExc9xs5jzKKy4c00+TA02caho=;
        b=bxdymw/VxQeeedPC6qa5jbQKDHxBLNhLsR1S45bvbN/vwh3s1deJ9yIFawTRMXSAdO
         XCEHPd61NPbq44pGVwNt2DmO8OVRkdFM32pJiWiyc0OyBXkG/Zj8pWWb5Ivl8NJmOEQ3
         iOgw9F9YO7nGcxf13wUslFscjT09NvVBC/lO9F4JyfsYnU4ZJypo/GCY2SvMkrUAlvJO
         FSXXsheHTcRxub1BisU3bOPVgC8jzEeOdLsPCwCHOdjpdIzrWnKvmkjizM0jf7Z5u7V3
         4ElUWsj1wDjXXYi+0Ms4tGPTxz7iivzAVYhsGyE2IBZtiPqO+91olavgu0ck2LerTyvx
         P38w==
X-Forwarded-Encrypted: i=1; AJvYcCV1W4QvZPjzJLuxmejg1bvUv96FQflR/xqASsq4j4FldLWlwPOxpWxskMDKevopFEV3xbpyL+feedrnjJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNgwZxwc6CiaUyWd3vfS7KBWUx5Dzm2FiqotqytwrM+gsxwFUc
	o0RCnfySvys5mD8VNDw1nH1hSGglOsUMLuCl2uAoSLPUX5INZSKZOg1ioRgOwC+z9Z0=
X-Gm-Gg: ASbGncshwX++V3rIbD/bKZoWRw/uE5gmyzmhCgBql8mFZphHKAFSRkfU8Jb/bymkw/M
	X0X3WKs7raVcyPkHf+tOuRqVCOvvrhqrVnSNQVx2NvWIc8PxCuTHc8HRmtYoYiES2XTaDmsXDwM
	aPAXGMTNKNv2q++WBQgS1veLQUmw/Zr8eRKrwJbRiTg0AU+mpo+Ke3FFqdVF0nPX7KBEZraWy7R
	HfQqul5IkPWE4HHI0ICFeu3gWaTLQqnnnBDpp7pWT3EJMphvfj28ugyU7qIVEIUDHd63g+iQxQ4
	LH3H+qUYlQKvxgM9yzjSquS24m5DbZIG16f+oM8UZpBdugzlmvJhmkMjCfVEiG5AAJATim5RQ5J
	LRSAAGInBmezC/RfTujpSnowM4qxTIKoVtGV/EJpYOIZqjZG3RSY8l0rObCq7yQipMRRhpD5pgN
	mlUYj3DrcqWBjDc52e9dbEx1JDU7TvrFxZn0oc2zNyCqldSzQa
X-Google-Smtp-Source: AGHT+IHX+CIkRku+UTwA25TVoyRKrmPefYTIKHVg1G1UtwTSFurkVm3yQL8/sWyCeEK5JZI22iw3jw==
X-Received: by 2002:a17:906:dc93:b0:b41:f729:77b0 with SMTP id a640c23a62f3a-b726529f302mr846888366b.21.1762447893493;
        Thu, 06 Nov 2025 08:51:33 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa11333sm1142566b.69.2025.11.06.08.51.31
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:51:32 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso1924452a12.3
        for <linux-serial@vger.kernel.org>; Thu, 06 Nov 2025 08:51:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnhnkUaKATUyFDrnhhTu5PO2Cfr+GVUzt5NWrS6U8g1BUzl39pYg8nDKgFxxkZRpNxoKoL4hudPoXS4Rk=@vger.kernel.org
X-Received: by 2002:a05:6402:35c9:b0:640:fb1f:e934 with SMTP id
 4fb4d7f45d1cf-6413f0834a2mr20615a12.32.1762447891499; Thu, 06 Nov 2025
 08:51:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029082101.92156-1-biju.das.jz@bp.renesas.com> <20251029082101.92156-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251029082101.92156-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 17:51:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUXimjkB_Cz=ac43RhOGF2Lf1ypLK1sLwk=ONXf7kdhQQ@mail.gmail.com>
X-Gm-Features: AWmQ_bk5DY6m4c8xO-kYacWAOBZuK7yTJexfPP1B_4jehepe727_WwaTWXgMpQg
Message-ID: <CAMuHMdUXimjkB_Cz=ac43RhOGF2Lf1ypLK1sLwk=ONXf7kdhQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: sh-sci: Fix deadlock during RSCI FIFO
 overrun error
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Nam Cao <namcao@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Wed, 29 Oct 2025 at 09:21, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> On RSCI IP, a deadlock occurs during a FIFO overrun error, as it uses a
> different register to clear the FIFO overrun error status.
>
> Cc: stable@kernel.org
> Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/tty/serial/rsci.c
> +++ b/drivers/tty/serial/rsci.c
> @@ -414,6 +414,7 @@ static const struct sci_port_params_bits rsci_port_param_bits = {
>         .rxtx_enable = CCR0_RE | CCR0_TE,
>         .te_clear = CCR0_TE | CCR0_TEIE,
>         .poll_sent_bits = CSR_TDRE | CSR_TEND,
> +       .overrun_clr = CFCLR_ORERC,
>  };
>
>  static const struct sci_port_params rsci_port_params = {
> diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
> index e3c028df14f1..bcdb41ddc15d 100644
> --- a/drivers/tty/serial/sh-sci-common.h
> +++ b/drivers/tty/serial/sh-sci-common.h
> @@ -51,6 +51,7 @@ struct sci_port_params_bits {
>         unsigned int rxtx_enable;
>         unsigned int te_clear;
>         unsigned int poll_sent_bits;
> +       unsigned int overrun_clr;

I don't really see a need to add this field, as there are two alternatives...

>  };
>
>  struct sci_common_regs {
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 62bb62b82cbe..b33894d0273b 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1024,8 +1024,12 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
>
>         status = s->ops->read_reg(port, s->params->overrun_reg);
>         if (status & s->params->overrun_mask) {
> -               status &= ~s->params->overrun_mask;
> -               s->ops->write_reg(port, s->params->overrun_reg, status);
> +               if (s->type == SCI_PORT_RSCI) {
> +                       s->ops->clear_SCxSR(port, s->params->param_bits->overrun_clr);

1. You can just use CFCLR_ORERC directly here,
2. All of the CFCLR_*C clearing bits match the corresponding CSR_*
   status bits, so you could do without the former, and thus use
   params->overrun_mask here, too.

> +               } else {
> +                       status &= ~s->params->overrun_mask;
> +                       s->ops->write_reg(port, s->params->overrun_reg, status);
> +               }
>
>                 port->icount.overrun++;
>

BTW, how is this related to "[PATCH] tty: serial: sh-sci: fix RSCI
FIFO overrun handling" [1], which is already applied (and which I
still don't fully understand the big picture behind. I'll reply there)?

[1] https://lore.kernel.org/20250923154707.1089900-1-cosmin-gabriel.tanislav.xa@renesas.com
    commit ef8fef45c74b5a00 ("tty: serial: sh-sci: fix RSCI FIFO
    overrun handling") in v6.18-rc3.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
