Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED549253B
	for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041084; cv=none; b=ASZ2v0zBcCq4Rzf1EMfO8B/X2luOQRQHa01wTI8w22xUWUnD+GLm2rvdwQNDvpq6J5nJwFX/IQHfKJlmDmZSrun5ZYPv4VUM/dFANloBwykWcqfqslQtSWmwwn3u9LLyN65n6juMB5wP0rnQj7XhFu0x0o6Xbb7u5p2kOyru8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041084; c=relaxed/simple;
	bh=EQOCkD3auq0aCh7DDicigHlQaGw9QKDs0vD0513KB/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEcy76leVZQSzhzKlTwMobwFlDbj2SG44NHVWDzPEALHAc2Vv79czdmioe4A5b82IReHHsFE0hsaBMDuoHU3oK4EexZPu/W2cQumIj2WT45q5lmKw8OMylgGNH3lsug0KM7LQWqMscPAAlKrkinlFNDfNTpWLXhJlcmq6fJwzDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5c106c38e99so863583e0c.0
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 07:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784041078; x=1784645878;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1M4GIQR2gREMfge07266GH4QEp7x7Z1Z7kE8VtuO4Xs=;
        b=RZizfoDyVJM+bCu4TQ4tJQQgiPg25ygUvHFdJMBzMAtYoA6R2vCIcoyCwIFTg1PzGO
         d0AP9iCqLC8/ImgLRloDJb2yHUokB/k1pTSj9PboKAIXfIyP73wovLi/TkgVZ8Pv7LsS
         GJbgF6d24CPHAdPT0DFtDadz6qQOrTGg81J3a+MUItIuupZasICx0yPmDn1DcIgqqJwZ
         0po/u6qmaD4JsHesplVsFrCpB8g70scKzAacDSu+1hwa12lAekRWEXFlwRW5DkSlNPgK
         n0cNMNyvTUn5B/7SX0hJEcMd03QlR6C7jvVkrJHismrRRB6EuO/EPjYkb3dOMbdPfaDv
         BuSQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTgDcx30Piaj6NyaGVXYLeFdwdi4HxVvLFJCZ7si/uX6AC7UGsreV7EXraW3Ct00SIpdsX7W5VozAMlBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVO3Tx0mr1ku4WPO5tA1BZT3m2Cn4gx/4PM+geYkBQXFLD69TK
	djSrkqoAzYO7J9v2RxAMqatEby7ugMjUBDBXW97Kqj5SExHV/GcP7WvI29VzpTwJ+hg=
X-Gm-Gg: AfdE7cniqkjMquzGRnb4S/GYdXu+EX33BYj8WsutCkPfwoYkByNNRSpd7vXlBjiWYm9
	tLctxpoG9nJprFQKqxb2LNSXNCxtFuERg9ZFg/MQZIQyykELAdWvO348geXI6b0CxI5LLsuSdt5
	t2Vu9w2MYy/Cw26TvSFbZK4z2u/gePjSc8spRFkKsno9wLJt40X6rry6dMH9IKqmdL4KdfUs8ti
	/E/fjXwCJpYNwjWWPtYJ/7GKBnTP1XHSZJ7t8aSE5zmDT3g67VzLFbc5EdJL4eWIMZNV1K+/3/b
	ETwnIsCx6PiQEx8uoD8yczk/HUlbtMW3SUjzNmAbyF1RexZFwzkedUew8RfVW4wKcECtyu0gSLi
	YL9MEWAfaAmqDWo09tpAhVVJ4G1cDYWmUml+hMuzxdbIWI4Yqlo9Wf0SMgYWfSfAJnCim0Sv65X
	Vk6wPhq1zMGh7nb7ngzTIuFhTUTKyLRhrMJRBIBt3uVDIx1BcXzV/Zlg==
X-Received: by 2002:a05:6102:26cb:b0:729:affa:70fd with SMTP id ada2fe7eead31-74533bd8d76mr9144834137.8.1784041078150;
        Tue, 14 Jul 2026 07:57:58 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed5d4d40esm8569811241.9.2026.07.14.07.57.57
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 07:57:57 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5c106c38e99so863561e0c.0
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 07:57:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoNQCZOUXV3nx7yLOGHfM6sK1vQR6fuchRrWakHhCZGSlk2YMZ+2nlkVJhw+2w9FyKIY3GU9zmDpHjJBUU=@vger.kernel.org
X-Received: by 2002:a05:6102:15ac:b0:740:31a4:f9a1 with SMTP id
 ada2fe7eead31-74533e9c487mr8745976137.27.1784041077472; Tue, 14 Jul 2026
 07:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
 <20260521-tty-upio-v3-4-bf74567994a0@dimonoff.com> <CAMuHMdXBA=e13WqmVPZEas1eS34xSY3N79pf90N71HZPU9oAkA@mail.gmail.com>
 <20260714104032.98fc3477994d681ecb644870@hugovil.com>
In-Reply-To: <20260714104032.98fc3477994d681ecb644870@hugovil.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jul 2026 16:57:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUw3baj6Lv_dFSZDjeosyncU0L1NNjUKD2CbqFJDoa-yg@mail.gmail.com>
X-Gm-Features: AUfX_myy39kU1k7_ybQIctziP8VltUo1wM17L9dJzkT3Hov5Aor5nfiwBkdLOdg
Message-ID: <CAMuHMdUw3baj6Lv_dFSZDjeosyncU0L1NNjUKD2CbqFJDoa-yg@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] serial: uniformize serial port I/O infos display
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"

Hi Hugo,

On Tue, 14 Jul 2026 at 16:40, Hugo Villeneuve <hugo@hugovil.com> wrote:
> On Tue, 14 Jul 2026 11:59:54 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, 21 May 2026 at 20:23, Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >
> > > Uniformize serial port I/O infos display from three different functions
> > > that display mostly the same information, but with some variations, by
> > > adding a common function.
> > >
> > > This make use of new functions uart_iotype_mmio() and
> > > uart_iotype_legacy_io() to simplify and improve code readability.
> > > This will prevent displaying irrelevant information for future IO types
> > > (ex: UPIO_BUS), while also addressing the (eventually) invalid check for
> > > "iotype >= UPIO_MEM".
> > >
> > > This also allows us to remove the confusing cast to (unsigned long long)
> > > for iobase which is defined as an unsigned long, and use %pa to display the
> > > mapbase pointer, as it is done in earlycon_print_info().
> > >
> > > Replace snprintf with more robust scnprintf so we could perhaps one day get
> > > rid of snprintf() entirely.
> > >
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Thanks for your patch, which is now commit 86305190f307c05b ("serial:
> > uniformize serial port I/O infos display") in tty/tty-next.
> >
> > > Maybe the width information could be dropped entirely?
> >
> > Perhaps...
>
> I didn't receive any feedback about that during review...
>
> >
> > > --- a/drivers/tty/serial/earlycon.c
> > > +++ b/drivers/tty/serial/earlycon.c
> > > @@ -75,19 +75,12 @@ static void __init earlycon_print_info(struct earlycon_device *device)
> > >  {
> > >         struct console *earlycon = device->con;
> > >         struct uart_port *port = &device->port;
> > > +       char ioinfos[64];
> > >
> > > -       if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM16 ||
> > > -           port->iotype == UPIO_MEM32 || port->iotype == UPIO_MEM32BE)
> > > -               pr_info("%s%d at MMIO%s %pa (options '%s')\n",
> > > -                       earlycon->name, earlycon->index,
> > > -                       (port->iotype == UPIO_MEM) ? "" :
> > > -                       (port->iotype == UPIO_MEM16) ? "16" :
> > > -                       (port->iotype == UPIO_MEM32) ? "32" : "32be",
> >
> > This handled 32 vs 32be...
>
> See answer below...
>
> >
> > > -                       &port->mapbase, device->options);
> > > -       else
> > > -               pr_info("%s%d at I/O port 0x%lx (options '%s')\n",
> > > -                       earlycon->name, earlycon->index,
> > > -                       port->iobase, device->options);
> > > +       uart_get_ioinfos(port, ioinfos, sizeof(ioinfos));
> > > +
> > > +       pr_info("%s%d%s (options '%s')\n", earlycon->name, earlycon->index,
> > > +               ioinfos, device->options);
> > >  }
> > >
> > >  static int __init parse_options(struct earlycon_device *device, char *options)
> >
> > > @@ -2476,38 +2473,47 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
> > >  }
> > >  EXPORT_SYMBOL(uart_resume_port);
> > >
> > > +static const char *uart_get_mmio_width(struct uart_port *port)
> > > +{
> > > +       switch (port->iotype) {
> > > +       case UPIO_MEM16:
> > > +               return "16";
> > > +       case UPIO_MEM32:
> >
> > Missing
> >
> >     return "32";
> >
> > > +       case UPIO_MEM32BE:
> > > +               return "32be";
>
> I fact, this could probably be simplified as:
>
>     case UPIO_MEM32:
>     case UPIO_MEM32BE:
>         return "32";

That would be better, as "32be" is definitely wrong for UPIO_MEM32.

>
> > > +       case UPIO_AU:
> > > +       case UPIO_MEM:
> > > +       default:
> > > +               return "";
> > > +       }
> > > +}
> >
> > >  static inline void
> > >  uart_report_port(struct uart_driver *drv, struct uart_port *port)
> > >  {
> > > -       char address[64];
> > > +       char ioinfos[64];
> > >
> > > -       switch (port->iotype) {
> > > -       case UPIO_PORT:
> > > -               snprintf(address, sizeof(address), "I/O 0x%lx", port->iobase);
> > > -               break;
> > > -       case UPIO_HUB6:
> > > -               snprintf(address, sizeof(address),
> > > -                        "I/O 0x%lx offset 0x%x", port->iobase, port->hub6);
> > > -               break;
> > > -       case UPIO_MEM:
> > > -       case UPIO_MEM16:
> > > -       case UPIO_MEM32:
> > > -       case UPIO_MEM32BE:
> > > -       case UPIO_AU:
> > > -       case UPIO_TSI:
> > > -               snprintf(address, sizeof(address),
> > > -                        "MMIO 0x%llx", (unsigned long long)port->mapbase);
> > > -               break;
> > > -       default:
> > > -               strscpy(address, "*unknown*", sizeof(address));
> > > -               break;
> > > -       }
> > > +       uart_get_ioinfos(port, ioinfos, sizeof(ioinfos));
> > >
> > > -       pr_info("%s%s%s at %s (irq = %u, base_baud = %u) is a %s\n",
> > > -              port->dev ? dev_name(port->dev) : "",
> > > -              port->dev ? ": " : "",
> > > -              port->name,
> > > -              address, port->irq, port->uartclk / 16, uart_type(port));
> > > +       pr_info("%s%s%s%s (irq = %u, base_baud = %u) is a %s\n",
> > > +               port->dev ? dev_name(port->dev) : "",
> > > +               port->dev ? ": " : "",
> > > +               port->name, ioinfos, port->irq, port->uartclk / 16, uart_type(port));
> > >
> > >         /* The magic multiplier feature is a bit obscure, so report it too.  */
> > >         if (port->flags & UPF_MAGIC_MULTIPLIER)
> >
> > I am also wondering if the ", base_baud = %u" should be dropped if
> > port->uartclk is zero.  But that is a pre-existing issue.
>
> Ok, but I'm wondering which is better, to drop it entirely, or to have
> a "base_baud = 0" displayed if port->uartclk is zero? I think I would
> prefer the latter, or maybe "base_baud = N/A"?

Up to the serial maintainers.
I may be biassed, as I am usually working on systems where it prints zero ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
