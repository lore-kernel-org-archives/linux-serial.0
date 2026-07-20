Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E96434E36;
	Mon, 20 Jul 2026 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562514; cv=none; b=NpBezRBdgZO0O7C2V4Kcz3bQhplFDFrQZ0Acc5SDhZIkvGBjh693d3Ku+Z++NnUuqM+E6eKbherkfgRJzrg1p4wLQ4GkfvvG/bl0bLyOfu3HB4WwI59dkqjWW0wzkeglb2dFKB8cND4Ja7IX33w6fiHCAaFuOQ+Pq+gV/PAxBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562514; c=relaxed/simple;
	bh=CAhMSRdVQsu/O4ZNYpTI8yq0RFAJM9sQStU/01864fc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ms02HwBNCTz++wdfJGWHcnft+DFDooaiOYiiky0Sf1jR84G8JujwQ7qHeHjt5lNV1i35VmRH1YssRF6ANHBIWquYEXDYKZAkMMeDlRDOMMjrcelsuM3NtB3X408ACj1T/nInpPVKfoinyeB4qXE0tn+lbKyTf5rpOasx7b2iirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=oDT0WCuU; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="oDT0WCuU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=cPgnGTrVquqF75emqExWO0AgcYGPQLGqwHZ2HaypURw=; b=oDT0WCuUbBRh+l2FJQo0z8o+Dd
	14CH/GflUjGavoQDFSCDJXXoY6CXhp3ET7VZX4m3UuIVydfxhvC+1dG7HCcyY6wgzGA6nAtXbtMAA
	HES5RfbTE0VhWs6FPtOWUN4hsBGKs79q4cPbKmfq1sitixJzljyDz2jjhXLFwQ7k9ERo=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wlqEH-000000001cV-2XRe;
	Mon, 20 Jul 2026 11:48:29 -0400
Date: Mon, 20 Jul 2026 11:48:29 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Biju Das
 <biju.das.jz@bp.renesas.com>, "biju.das.au" <biju.das.au@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Thierry Bultel
 <thierry.bultel.yh@bp.renesas.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] serial: sh-sci: Drop check for zero baud rate
 from uart_get_baud_rate()
Message-Id: <20260720114829.14dee9de11975bb46f3126cc@hugovil.com>
In-Reply-To: <20260422100538.25c6a279ec46defecd8d9a4f@hugovil.com>
References: <20260420140426.237865-1-biju.das.jz@bp.renesas.com>
	<20260420140426.237865-3-biju.das.jz@bp.renesas.com>
	<CAMuHMdXQi7eSZg71=01dYjpmgHRXS+L9hXZMN_dR-mtM6sLKNw@mail.gmail.com>
	<TY3PR01MB113464AE43A23A0B69BCC5675862D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	<CAMuHMdUfGY6VwW09zQX8T3_JkRHwKGRUyNGRXvQaD4e58OV8qA@mail.gmail.com>
	<20260422100538.25c6a279ec46defecd8d9a4f@hugovil.com>
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

On Wed, 22 Apr 2026 10:05:38 -0400
Hugo Villeneuve <hugo@hugovil.com> wrote:

> Hi,
> 
> On Wed, 22 Apr 2026 10:59:23 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> > Hi Biju,
> > 
> > On Wed, 22 Apr 2026 at 09:26, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > On Mon, 20 Apr 2026 at 16:04, Biju <biju.das.au@gmail.com> wrote:
> > > > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > > >
> > > > > On DT systems, a zero baud rate from uart_get_baud_rate() is not
> 
> The fact that uart_get_baud_rate() cannot return zero is not related
> to the system using DT or not, so I would drop this "On DT systems, "
> from the commit message.
> 
> > > > > possible even earlycon derives its bit rate from chosen/stdout-path.
> > > > > The zero baud guard and its associated done label are therefore dead code. So remove it.
> > > > >
> > > > > Also drop the unused done label from rsci_set_termios().
> > > > >
> > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > >
> > > > > --- a/drivers/tty/serial/sh-sci.c
> > > > > +++ b/drivers/tty/serial/sh-sci.c
> > > > > @@ -2719,8 +2719,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
> > > > >                 max_freq = max(max_freq, s->clk_rates[i]);
> > > > >
> > > > >         baud = uart_get_baud_rate(port, termios, old, 0, max_freq / min_sr(s));
> > > > > -       if (!baud)
> > > > > -               goto done;
> > > > >
> > > > >         /*
> > > > >          * There can be multiple sources for the sampling clock.  Find
> > > > > the one
> > > >
> > > > I am afraid you are missing that sh-sci is also used on SH, without DT?
> > >
> > > Ok, please share your thoughts to handle divide_by_zero fault for
> > > SH platforms on the code path after done label??
> > 
> > Someone has to check on an SH platform (or qemu rts7751r2d) if
> > this can happen. It might have been broken along the road, as people
> > only use earlyprintk when debugging a problem that requires it.
> 
> Geert: this "goto done" is not related to the earlyprintk block, which
> is untouched by this patch?

Hi Biju,
I cannot see any follow-up for these patches. My series for "serial:
core: improve safety of uart_get_baud_rate()" has been accepted and
integrated, so now the renesas sh-sci and rsci are the only drivers
still checking (for nothing) the zero return value of
uart_get_baud_rate().

I plan on sending two patches to address only that for sh-sci and rsci,
unless you are preparing a new serie that includes it?

Hugo.
