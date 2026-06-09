Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99D383C77
	for <linux-serial@vger.kernel.org>; Tue,  9 Jun 2026 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988008; cv=none; b=QLZp6s2WiMdaHf7euoScuhvfyaHhinCtCyso/uGFDUYuP+OO73LpTpB5gbq7Ua3QdlQslNjBWTLimSxv1JGgT03eV7aBjJIwOK0DhCpHWJuiUtUy2yAhCmgvJDUXPeFgtx9fO8B0iC8EvYQbXdmTpoh205qKFOXlfDBYvR3TO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988008; c=relaxed/simple;
	bh=USxDlh+cTOmctRbVLXUwHBHqPmHhLde8bvmv+bZmeZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sn65TrR2eS2nlqSbNtLVIeYDEsaiinwW2J3yMDk/OtfNHBjXE93cgEieqUJzDbFxbyzIshnWsomZkSAFDelC42JV9rEBEsmE62qv+iLbbAO8WVNK//zTh6LLavvVWk5gwNTunRtWL6J8BDRAxJ2sHO7WesgTbZVRC/WVWBCLZZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6c7e8c9f612so1843075137.0
        for <linux-serial@vger.kernel.org>; Mon, 08 Jun 2026 23:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988004; x=1781592804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfrTmKBa/6XQOKTJVCGFPY/9uy59Ow4t/P5iBf4xoKk=;
        b=R0b0hE45/fjZ3rHTk5y2iHH95/BHuIeHHsoHNlW91f1eRPpP0k5v92RoVVXJ/IZFHQ
         ZThLQmI2YggmVlEnx/GhzhFmzvbnitrwUjVNtzST1rkKwBh8MfqHs2YygYMAaTo01i0q
         ChmXarEhehECSnTqcfvb2CkZ0rtfwyahwbGv1nmlSGxsz3pl7iQNCno0o85UrgK0uFd2
         iP/T56DwfU2Rs+2MkFDULpMOQlRY50rcGod5+1qoeH5rqtjVX0IDzgIiCX6CRgP40Xrd
         DGZW/Rx5xD/cGCupTXVTyyUNNQv7NDBy5cK/nMcsXySh6NEI3Y1jRSCniYDiIBoWjnHn
         n9Rw==
X-Forwarded-Encrypted: i=1; AFNElJ9FirSydsy9zpDP50l+r5oo6J/WnunL9l0CoMvi6P+1bjo7Is0TTdDVVoL9ZLgFPF6rzcFuyAqhPsEkQEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKpumv+VgWRACqcBP6I/69GDgpqtFuzq61j9RH19GFWAE4Qi6
	7ZNmHOxFCesEqMrYiQKDLhg9Wc5frHbWtFQ5/94v+cENh21anADpawQeuhhhoDCV
X-Gm-Gg: Acq92OHd0KpaKFnZdYAYttVf0HpNKAdQGpzRnBz7g0AyYLVgsfSU48vq0qIlOuHDSZ6
	muR9kZGf0JyjEKb6cvl0JTj6LkVwxaLU0dd//dpnnC1kBZlccuUG/m7ronLzfuRCkniCI0ll9Yl
	qROHo7Nkc0HXBc5IxSrLXcoTCTPqHv2E4FMIHNT9WlF6pdWNS+3uHmhujymsKNJrd1owd6HlRKk
	EJwY/L7VUL2tPD3xntH/L9Or3t8ANrONk0dk75PzCb4EPBathSBuPQOxlbLOINdCyo47GxrrHZb
	sZ8JStLWB3Hv+J8jckMDn3gm4tmwPPEUyCqlfxLSFJ601suS2z1g1Is9VgiL/wIA8sIaBaf2Ze/
	agueHYp06Z6ysYeTswBMB7hpexi8U9PhWK71Fda/1EO3vpDpNl9S8RIbxdFoHgmM+nDMuIPfkl0
	Jgce3wGBQ68YXrC7EzYTktZiY5rC+O0FtNwjGdEYA4iJ34CMibP3/K5vfu14Frs21bVzI4MMM=
X-Received: by 2002:a05:6102:f98:b0:6a2:cf9a:9221 with SMTP id ada2fe7eead31-6ff04530fdfmr9894247137.20.1780988004253;
        Mon, 08 Jun 2026 23:53:24 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6eb66965b7fsm16080103137.11.2026.06.08.23.53.23
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 23:53:23 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9639b1ef167so1790811241.2
        for <linux-serial@vger.kernel.org>; Mon, 08 Jun 2026 23:53:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/c2NtXTbq/4ndeS1wvAVNzOhNPZ6cjhva025JqsThTzMWLKcZQrTPRzXkX89+HZvyyc2pqZOxV2ZtD7aY=@vger.kernel.org
X-Received: by 2002:a05:6102:94c:b0:6cb:d562:b96a with SMTP id
 ada2fe7eead31-6ff02387516mr9986946137.14.1780988002958; Mon, 08 Jun 2026
 23:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-acpi_spcr-v2-0-3cd9a3bda727@posteo.de> <20260609-acpi_spcr-v2-1-3cd9a3bda727@posteo.de>
In-Reply-To: <20260609-acpi_spcr-v2-1-3cd9a3bda727@posteo.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jun 2026 08:53:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXH0mR9Sr+ze2_m94uc46_7gubApzWOkf+vUO+w=DmNoQ@mail.gmail.com>
X-Gm-Features: AVVi8Cemo9bnqwwW5sau-L6wcH5-zrPfob50Y8WSYUrCMRB7OtaTQ6EIMHl5BFg
Message-ID: <CAMuHMdXH0mR9Sr+ze2_m94uc46_7gubApzWOkf+vUO+w=DmNoQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] serial: earlycon: add uart_clk_freq parameter
To: Markus Probst <markus.probst@posteo.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

On Tue, 9 Jun 2026 at 00:40, Markus Probst <markus.probst@posteo.de> wrote:
> Add `uart_clk_freq` parameter to `setup_earlycon`. This allows the
> options string to be reused with `add_preferred_console`, while still
> allowing to set the uart clock frequency. This will be used in the
> following commit ("ACPI: SPCR: Support UART clock frequency field").
>
> No logical change intended.
>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -135,11 +135,14 @@ static int __init parse_options(struct earlycon_device *device, char *options)
>         return 0;
>  }
>
> -static int __init register_earlycon(char *buf, const struct earlycon_id *match)
> +static int __init register_earlycon(char *buf, unsigned int uart_clk_freq,
> +                                   const struct earlycon_id *match)
>  {
>         int err;
>         struct uart_port *port = &early_console_dev.port;
>
> +       port->uartclk = uart_clk_freq;

Who is actually consuming this value?
Earlycon typically works with the serial console, as configured before
Linux boot by the firmware.
The Microsoft doc referenced in patch 2 seem to agree with that:

   "On a system where the BIOS or system firmware uses the serial
    port for console input/output, this table should be used to convey
    information about the settings, to ensure a seamless transition
    between the firmware console output and Windows EMS output."

> +
>         /* On parsing error, pass the options buf to the setup function */
>         if (buf && !parse_options(&early_console_dev, buf))
>                 buf = NULL;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
