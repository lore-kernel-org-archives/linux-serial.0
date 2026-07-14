Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E9E380FF2;
	Tue, 14 Jul 2026 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041337; cv=none; b=BToqyATxdj0toEDtIjXp0m/lx34/ARQudRQZlxLqnl/Xq/UGCsBFIxyRQjnP7m+KTiKeOv0SKfi0nfWjlsrBsbD3UesxtwjyYhBxduM6BWJ32I6lQtaBJQ6+7yME5B9Gp8NEUIqB5O3Rr3DPtJ6OBYgrD/BohYm89Kz4ykC7/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041337; c=relaxed/simple;
	bh=BEKsbsLAOwmNxkDDE4aVw2wI4IyerJnhix+2yLfRPDU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p2XTnTkS5SxokmYmziuelkvNyGeLPu9e73PlBtt+1pUxWWa4l9YJs0AZrm71sIF7wmX8RjqqsMbcVjA8ADqIFaX9dAmwhoTwXajHozXaEgSTyla8uNbMEd4r4Nzm7kKm77EGg5WFyyWfDVZoNmWPWgoBGJGAWTd61OiUsQfNGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=uP3aiFxJ; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="uP3aiFxJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=cOu3ZsLRWYid57IltA6DNEFci+B6koNdxPm7VjkzXZs=; b=uP3aiFxJAOMNaE0LEaY+9Wt69g
	VLKyQK31xPekTEkJhobsRtp2qhIFGdStWcF4d6Uj5Z9sH56MNhBEfDKof0Bq8F0kt2BR4OfC9v245
	cxiDWrLxR5o0y5f86au+80kSF9EPZ78aZptMKNu8VnjWqfDxNvGs4PpaeNlooBTA/Omo=;
Received: from [184.161.19.61] (helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wjeeB-000000007eC-1ztB;
	Tue, 14 Jul 2026 11:02:11 -0400
Date: Tue, 14 Jul 2026 11:02:10 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 04/10] serial: uniformize serial port I/O infos
 display
Message-Id: <20260714110210.aa73569b8b89b42a8f5a3344@hugovil.com>
In-Reply-To: <CAMuHMdUw3baj6Lv_dFSZDjeosyncU0L1NNjUKD2CbqFJDoa-yg@mail.gmail.com>
References: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
	<20260521-tty-upio-v3-4-bf74567994a0@dimonoff.com>
	<CAMuHMdXBA=e13WqmVPZEas1eS34xSY3N79pf90N71HZPU9oAkA@mail.gmail.com>
	<20260714104032.98fc3477994d681ecb644870@hugovil.com>
	<CAMuHMdUw3baj6Lv_dFSZDjeosyncU0L1NNjUKD2CbqFJDoa-yg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Geert,

On Tue, 14 Jul 2026 16:57:45 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hugo,
> 
> On Tue, 14 Jul 2026 at 16:40, Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Tue, 14 Jul 2026 11:59:54 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, 21 May 2026 at 20:23, Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > >
> > > > Uniformize serial port I/O infos display from three different functions
> > > > that display mostly the same information, but with some variations, by
> > > > adding a common function.
> > > >
> > > > This make use of new functions uart_iotype_mmio() and
> > > > uart_iotype_legacy_io() to simplify and improve code readability.
> > > > This will prevent displaying irrelevant information for future IO types
> > > > (ex: UPIO_BUS), while also addressing the (eventually) invalid check for
> > > > "iotype >= UPIO_MEM".
> > > >
> > > > This also allows us to remove the confusing cast to (unsigned long long)
> > > > for iobase which is defined as an unsigned long, and use %pa to display the
> > > > mapbase pointer, as it is done in earlycon_print_info().
> > > >
> > > > Replace snprintf with more robust scnprintf so we could perhaps one day get
> > > > rid of snprintf() entirely.
> > > >
> > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >
> > > Thanks for your patch, which is now commit 86305190f307c05b ("serial:
> > > uniformize serial port I/O infos display") in tty/tty-next.
> > >
> > > > Maybe the width information could be dropped entirely?
> > >
> > > Perhaps...
> >
> > I didn't receive any feedback about that during review...
> >
> > >
> > > > --- a/drivers/tty/serial/earlycon.c
> > > > +++ b/drivers/tty/serial/earlycon.c
> > > > @@ -75,19 +75,12 @@ static void __init earlycon_print_info(struct earlycon_device *device)
> > > >  {
> > > >         struct console *earlycon = device->con;
> > > >         struct uart_port *port = &device->port;
> > > > +       char ioinfos[64];
> > > >
> > > > -       if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM16 ||
> > > > -           port->iotype == UPIO_MEM32 || port->iotype == UPIO_MEM32BE)
> > > > -               pr_info("%s%d at MMIO%s %pa (options '%s')\n",
> > > > -                       earlycon->name, earlycon->index,
> > > > -                       (port->iotype == UPIO_MEM) ? "" :
> > > > -                       (port->iotype == UPIO_MEM16) ? "16" :
> > > > -                       (port->iotype == UPIO_MEM32) ? "32" : "32be",
> > >
> > > This handled 32 vs 32be...
> >
> > See answer below...
> >
> > >
> > > > -                       &port->mapbase, device->options);
> > > > -       else
> > > > -               pr_info("%s%d at I/O port 0x%lx (options '%s')\n",
> > > > -                       earlycon->name, earlycon->index,
> > > > -                       port->iobase, device->options);
> > > > +       uart_get_ioinfos(port, ioinfos, sizeof(ioinfos));
> > > > +
> > > > +       pr_info("%s%d%s (options '%s')\n", earlycon->name, earlycon->index,
> > > > +               ioinfos, device->options);
> > > >  }
> > > >
> > > >  static int __init parse_options(struct earlycon_device *device, char *options)
> > >
> > > > @@ -2476,38 +2473,47 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
> > > >  }
> > > >  EXPORT_SYMBOL(uart_resume_port);
> > > >
> > > > +static const char *uart_get_mmio_width(struct uart_port *port)
> > > > +{
> > > > +       switch (port->iotype) {
> > > > +       case UPIO_MEM16:
> > > > +               return "16";
> > > > +       case UPIO_MEM32:
> > >
> > > Missing
> > >
> > >     return "32";
> > >
> > > > +       case UPIO_MEM32BE:
> > > > +               return "32be";
> >
> > I fact, this could probably be simplified as:
> >
> >     case UPIO_MEM32:
> >     case UPIO_MEM32BE:
> >         return "32";
> 
> That would be better, as "32be" is definitely wrong for UPIO_MEM32.

Ok, I will send a patch for this.

> 
> >
> > > > +       case UPIO_AU:
> > > > +       case UPIO_MEM:
> > > > +       default:
> > > > +               return "";
> > > > +       }
> > > > +}
> > >
> > > >  static inline void
> > > >  uart_report_port(struct uart_driver *drv, struct uart_port *port)
> > > >  {
> > > > -       char address[64];
> > > > +       char ioinfos[64];
> > > >
> > > > -       switch (port->iotype) {
> > > > -       case UPIO_PORT:
> > > > -               snprintf(address, sizeof(address), "I/O 0x%lx", port->iobase);
> > > > -               break;
> > > > -       case UPIO_HUB6:
> > > > -               snprintf(address, sizeof(address),
> > > > -                        "I/O 0x%lx offset 0x%x", port->iobase, port->hub6);
> > > > -               break;
> > > > -       case UPIO_MEM:
> > > > -       case UPIO_MEM16:
> > > > -       case UPIO_MEM32:
> > > > -       case UPIO_MEM32BE:
> > > > -       case UPIO_AU:
> > > > -       case UPIO_TSI:
> > > > -               snprintf(address, sizeof(address),
> > > > -                        "MMIO 0x%llx", (unsigned long long)port->mapbase);
> > > > -               break;
> > > > -       default:
> > > > -               strscpy(address, "*unknown*", sizeof(address));
> > > > -               break;
> > > > -       }
> > > > +       uart_get_ioinfos(port, ioinfos, sizeof(ioinfos));
> > > >
> > > > -       pr_info("%s%s%s at %s (irq = %u, base_baud = %u) is a %s\n",
> > > > -              port->dev ? dev_name(port->dev) : "",
> > > > -              port->dev ? ": " : "",
> > > > -              port->name,
> > > > -              address, port->irq, port->uartclk / 16, uart_type(port));
> > > > +       pr_info("%s%s%s%s (irq = %u, base_baud = %u) is a %s\n",
> > > > +               port->dev ? dev_name(port->dev) : "",
> > > > +               port->dev ? ": " : "",
> > > > +               port->name, ioinfos, port->irq, port->uartclk / 16, uart_type(port));
> > > >
> > > >         /* The magic multiplier feature is a bit obscure, so report it too.  */
> > > >         if (port->flags & UPF_MAGIC_MULTIPLIER)
> > >
> > > I am also wondering if the ", base_baud = %u" should be dropped if
> > > port->uartclk is zero.  But that is a pre-existing issue.
> >
> > Ok, but I'm wondering which is better, to drop it entirely, or to have
> > a "base_baud = 0" displayed if port->uartclk is zero? I think I would
> > prefer the latter, or maybe "base_baud = N/A"?
> 
> Up to the serial maintainers.
> I may be biassed, as I am usually working on systems where it prints zero ;-)

So what would be your personal preference, to drop it entirely?

-- 
Hugo Villeneuve
