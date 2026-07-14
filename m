Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020743B3CB
	for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023210; cv=none; b=WkUNqKIpWeNRfux1ft9/mlv58FAUB3syT6TW0AvRoZo0t08DR+gJNg3wMw36rT0mcHNOmp9p3fBlGgKVMBxF2Zpx/O2jQUqYy4UK3XzFJFHg21ktNWpffgOaqTT8BnvwQ/z6L46BL6+nWn33ZCHU/Q2au6+EV8rXL3XwvmdSRlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023210; c=relaxed/simple;
	bh=yGS/YDTu7OHIco0QYXX8MIVFQyinXeeCWGxCZ7WhxwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgCt8IU5WpdXZNfG7oU9eMhDErOU47yd4yr4x8HlQhNI1SB3lm0wB0JK45IAfQ/M0g4VOx0xWB4J2BdbKZbFy+1LwO9fF+8gBhjo6L91y8y/V/EzJAaax6O69jdGYnVvqQkz2lVSJ7ai+tNPuuJYUqhWhXfn/YBK7Qmg6aqzFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-737de525d2eso4182043137.2
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 03:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784023207; x=1784628007;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wn0BQQ4/rRQdXWgUn4m2jI/IYLLR83T3wBjDLJzZzGY=;
        b=GGYYQnJG8n4fWS7oKQY8z+6MGZ6FslSyiTiNTHh6RsfqI/prJ8bjuj2vl/xcGYTVpg
         Hy360+n5iRoUh3qQiAYjDFQl4dbvBUuVUagc7Y6mtw92E1COpxV0PEGV0jb30D9u6Gwz
         SDS37zbbCg9FQo0aNhJwlhud4U/CfXDX3VZ9FgS3Furxcdr4ZuKTOlb3urAqMzN40AAI
         cV0g4tJhTliZCvu3zXDG8qAbkD7OQZoOLXklD+qFQYLfL1RkWcRKiakl03ysB5hPkBeW
         gRC6gEH95qnUaZ8r/YVrJyx7B2KiBXcMSxM0DM20AwUdX3YlGYSzsxC4CFmKmwRx5Hcu
         Pb1Q==
X-Forwarded-Encrypted: i=1; AHgh+RpagRWyD+1hwfpI792P5DaZ7LUG6oQxcLcZdQhBQx8ousXSPM9ju3WkGpNb7w+ePLObI8VQRoi8O2BnbXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIHtALhTxJ0R7UI1BTdkFdrWLyEJkxeBwYWbeXJ7q+muWKS69
	BzK45faJLqWBzQCJ3ss/IYTjTbqjnhRGlBv9YnUhCftWaE6VADPI7S/Q2ab0sAmHQsE=
X-Gm-Gg: AfdE7ckgA/eFe5PaeTC22GPIuBF9V8bOUbvPqxFzhlrc61Kr6gaqbkXT455VI25xpjg
	4jQmZ5jajUk6tVLnYiPs2PKPwBzBIh3tFIiaf/M8iug0ORS8SQJlrb8YLziThEqVo3afRVtfQEy
	3V04jGzlShRYeYAReY1RGpi3//YkRLuoKLoKx1RaRsoAYZVG3dQRAXYcIXCdcmAL5t6Yw5eaY7e
	frAmsESjxRCbDc9WQnLL9x7e9fUSojE4qctGe9jVlThNqYH3cDB9YG4KhS8OVV/PEpMxzOHh7Tv
	0fSAwyU5IlgdbcLh1e7EcT352mdaa3gPfoB1Obz+jFTIZzvjM3V4Rpu/XEYxxf6isfBnN1jr0Oh
	dTwkxPSl43zXL/56JT81HpNQ5g0YibVYWpfwyuKpFkyjKFXEtZgLnJB78uSoXOI1VDPhc+VoOZ6
	KDPK+f44gI9zRxVB0IUzwb1kokSy1EDcI6D7ddjdeVxrQuvgHK4d8isbco/jDF
X-Received: by 2002:a05:6102:370b:b0:745:bf3:6c4b with SMTP id ada2fe7eead31-74533eb2324mr8044827137.29.1784023206785;
        Tue, 14 Jul 2026 03:00:06 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6deb1aasm10497722137.7.2026.07.14.03.00.05
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 03:00:06 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-74019ed06aeso3248452137.3
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 03:00:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro6MesV3b5FYrWyBOfgHQ935XeSCTLriimLvqcp9JwSPgX1JS/WK5RiTLpgYbj3AZ2BrauO+PWhrfyQpeA=@vger.kernel.org
X-Received: by 2002:a05:6102:a53:b0:739:5cfb:50f4 with SMTP id
 ada2fe7eead31-74533bf3048mr8548431137.11.1784023205731; Tue, 14 Jul 2026
 03:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com> <20260521-tty-upio-v3-4-bf74567994a0@dimonoff.com>
In-Reply-To: <20260521-tty-upio-v3-4-bf74567994a0@dimonoff.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jul 2026 11:59:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXBA=e13WqmVPZEas1eS34xSY3N79pf90N71HZPU9oAkA@mail.gmail.com>
X-Gm-Features: AUfX_mweztvV3jOOEAYZFG1KJLNaua4I8_PAf8dCRC7NGHuZXl_ibs0BtKWh-YE
Message-ID: <CAMuHMdXBA=e13WqmVPZEas1eS34xSY3N79pf90N71HZPU9oAkA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] serial: uniformize serial port I/O infos display
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"

Hi Hugo,

On Thu, 21 May 2026 at 20:23, Hugo Villeneuve <hugo@hugovil.com> wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Uniformize serial port I/O infos display from three different functions
> that display mostly the same information, but with some variations, by
> adding a common function.
>
> This make use of new functions uart_iotype_mmio() and
> uart_iotype_legacy_io() to simplify and improve code readability.
> This will prevent displaying irrelevant information for future IO types
> (ex: UPIO_BUS), while also addressing the (eventually) invalid check for
> "iotype >= UPIO_MEM".
>
> This also allows us to remove the confusing cast to (unsigned long long)
> for iobase which is defined as an unsigned long, and use %pa to display the
> mapbase pointer, as it is done in earlycon_print_info().
>
> Replace snprintf with more robust scnprintf so we could perhaps one day get
> rid of snprintf() entirely.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Thanks for your patch, which is now commit 86305190f307c05b ("serial:
uniformize serial port I/O infos display") in tty/tty-next.

> Maybe the width information could be dropped entirely?

Perhaps...

> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -75,19 +75,12 @@ static void __init earlycon_print_info(struct earlycon_device *device)
>  {
>         struct console *earlycon = device->con;
>         struct uart_port *port = &device->port;
> +       char ioinfos[64];
>
> -       if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM16 ||
> -           port->iotype == UPIO_MEM32 || port->iotype == UPIO_MEM32BE)
> -               pr_info("%s%d at MMIO%s %pa (options '%s')\n",
> -                       earlycon->name, earlycon->index,
> -                       (port->iotype == UPIO_MEM) ? "" :
> -                       (port->iotype == UPIO_MEM16) ? "16" :
> -                       (port->iotype == UPIO_MEM32) ? "32" : "32be",

This handled 32 vs 32be...

> -                       &port->mapbase, device->options);
> -       else
> -               pr_info("%s%d at I/O port 0x%lx (options '%s')\n",
> -                       earlycon->name, earlycon->index,
> -                       port->iobase, device->options);
> +       uart_get_ioinfos(port, ioinfos, sizeof(ioinfos));
> +
> +       pr_info("%s%d%s (options '%s')\n", earlycon->name, earlycon->index,
> +               ioinfos, device->options);
>  }
>
>  static int __init parse_options(struct earlycon_device *device, char *options)

> @@ -2476,38 +2473,47 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>  }
>  EXPORT_SYMBOL(uart_resume_port);
>
> +static const char *uart_get_mmio_width(struct uart_port *port)
> +{
> +       switch (port->iotype) {
> +       case UPIO_MEM16:
> +               return "16";
> +       case UPIO_MEM32:

Missing

    return "32";

> +       case UPIO_MEM32BE:
> +               return "32be";
> +       case UPIO_AU:
> +       case UPIO_MEM:
> +       default:
> +               return "";
> +       }
> +}

>  static inline void
>  uart_report_port(struct uart_driver *drv, struct uart_port *port)
>  {
> -       char address[64];
> +       char ioinfos[64];
>
> -       switch (port->iotype) {
> -       case UPIO_PORT:
> -               snprintf(address, sizeof(address), "I/O 0x%lx", port->iobase);
> -               break;
> -       case UPIO_HUB6:
> -               snprintf(address, sizeof(address),
> -                        "I/O 0x%lx offset 0x%x", port->iobase, port->hub6);
> -               break;
> -       case UPIO_MEM:
> -       case UPIO_MEM16:
> -       case UPIO_MEM32:
> -       case UPIO_MEM32BE:
> -       case UPIO_AU:
> -       case UPIO_TSI:
> -               snprintf(address, sizeof(address),
> -                        "MMIO 0x%llx", (unsigned long long)port->mapbase);
> -               break;
> -       default:
> -               strscpy(address, "*unknown*", sizeof(address));
> -               break;
> -       }
> +       uart_get_ioinfos(port, ioinfos, sizeof(ioinfos));
>
> -       pr_info("%s%s%s at %s (irq = %u, base_baud = %u) is a %s\n",
> -              port->dev ? dev_name(port->dev) : "",
> -              port->dev ? ": " : "",
> -              port->name,
> -              address, port->irq, port->uartclk / 16, uart_type(port));
> +       pr_info("%s%s%s%s (irq = %u, base_baud = %u) is a %s\n",
> +               port->dev ? dev_name(port->dev) : "",
> +               port->dev ? ": " : "",
> +               port->name, ioinfos, port->irq, port->uartclk / 16, uart_type(port));
>
>         /* The magic multiplier feature is a bit obscure, so report it too.  */
>         if (port->flags & UPF_MAGIC_MULTIPLIER)

I am also wondering if the ", base_baud = %u" should be dropped if
port->uartclk is zero.  But that is a pre-existing issue.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
