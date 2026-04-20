Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C0333445;
	Mon, 20 Apr 2026 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701530; cv=none; b=q+05wKUp4jCAo+PBobmsTf7CfDXmezq4z7KAlQOEnpaxSS+VbbW50R5n82ntXx8qdA6VKFvXo3q7tZiCiKYl9UXX/f7gZyGbFhCqZPL91hrOuqLEZDn0BTHPTr9ee8LI7h4VlWjXR2HO+BhQo75omZEArcE+o83I1ADtZ9/ZXuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701530; c=relaxed/simple;
	bh=lCZ/mtYqaroMK+YUP2FH/1iL/fNOkr/T66Am0MLpmzw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=otWZ5Jp2jWkjXnnmRCrTuyn/GdXIDTwz6KtXhxEYLp+87tMCjf71TzQBNROJY2xXB1i2oaXso5nteXldRu5iSkZBcNRmDrpwxcMXCZjqHwbvwf7jIKmiKYxGOleZhQFkp1ne2UzGaWk4r7+SYPTecVhXVK1VuNFtJXEzJzP2hT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Ky3ficHD; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Ky3ficHD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=2whMbmP9eKFLCWHF5JrcnKElRCKnHcd5/C5WnKBfNn0=; b=Ky3ficHDJHAJ1Sgb62652OQUgk
	+rM3I1ZACGM9qtC+sELRJjcD9PehiOD3uGbcMBQxwByZYWJymBV701VZkml3qWFFo6ln7y1avKKZ5
	NCPhyv+YVuXuBqpkyTDz6R/TGhRo8+CD40l6vcH/HzefUd+tfyjEa12Gyreyiez87Bh8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wErED-0000000052l-1rfk;
	Mon, 20 Apr 2026 12:12:05 -0400
Date: Mon, 20 Apr 2026 12:12:05 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 biju.das.jz@bp.renesas.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: sh-sci: optimize max_freq determination
Message-Id: <20260420121205.f52ae2515cb9ff093c19c6e2@hugovil.com>
In-Reply-To: <CAMuHMdXpZjVctirMuH=n_PrK4nnEnWqjuCzRjc4y6kC1--99kQ@mail.gmail.com>
References: <20260417193603.3906568-1-hugo@hugovil.com>
	<CAMuHMdXpZjVctirMuH=n_PrK4nnEnWqjuCzRjc4y6kC1--99kQ@mail.gmail.com>
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

On Mon, 20 Apr 2026 09:23:55 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hugo,
> 
> On Sat, 18 Apr 2026 at 07:24, Hugo Villeneuve <hugo@hugovil.com> wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Follow example of rsci driver to avoid code duplication and useless
> > max_freq search when port->uartclk is set to zero.
> >
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -2711,14 +2711,15 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
> >          * setup the baud rate generator hardware for us already.
> >          */
> >         if (!port->uartclk) {
> > -               baud = uart_get_baud_rate(port, termios, old, 0, 115200);
> > -               goto done;
> 
> There was no "useless max_freq search", due to this goto?

You are right, this part of the comment is wrong.

> 
> > +               max_freq = 115200;
> > +       } else {
> > +               for (i = 0; i < SCI_NUM_CLKS; i++)
> > +                       max_freq = max(max_freq, s->clk_rates[i]);
> > +
> > +               max_freq /= min_sr(s);
> >         }
> >
> > -       for (i = 0; i < SCI_NUM_CLKS; i++)
> > -               max_freq = max(max_freq, s->clk_rates[i]);
> > -
> > -       baud = uart_get_baud_rate(port, termios, old, 0, max_freq / min_sr(s));
> > +       baud = uart_get_baud_rate(port, termios, old, 0, max_freq);
> >         if (!baud)
> >                 goto done;
> >
> 
> Due to removing the goto above (for the casual reader: this is the
> earlyprintk case, when port->uartclk is zero), the code will now
> continue here, calculating transmission parameters and setting best_clk,
> and overwriting the register configuration done by the bootloader.

Yes, I see it now for sh-sci where we have "if (best_clk >= 0) {"... to
not configure the registers.

However, for the rsci driver, I think that, even after Biju's cleanup
serie V3, we still overwrite the register configuration done by the
bootloader?

Maybe configure only "if (!port->uartclk) {" ?

Hugo.



> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


-- 
Hugo Villeneuve
