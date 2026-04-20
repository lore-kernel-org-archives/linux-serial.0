Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37271BE5E;
	Mon, 20 Apr 2026 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692738; cv=none; b=Lhsml8KQy1pQT8yGgi7e+va3tmDgQRz4PnFMsFUT0F0NskEECTC9Bnw9VExCs8Z4KOqwr0fbqryf/ZybKtGcrd2YB6sPx2FhQ1O+BRXaapue6/4dll/nPw3ymWWfzhYv47jJrl4Itdqbr8AnL+LU34eHQR4/DpoS4yU/Gu3QIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692738; c=relaxed/simple;
	bh=ZrDEyjyrSCFU5cuIsgn7BLxTzC25zoqaZCEGINDSSAQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DkToaSicKrMmuB5t3mR3so/qeDX8f4N2qxG3MvorbMol9his07WWq3h/BTqo4WPO11OH9hH0/zQ1Lb0D8P4tp3IsGYx6dUm1Sae6y0irSi2PALxYQF2kw+qAvPzMn/za+KzECHi4O9MtHjyeRKZiv1SMY1AiiRUhEldbfzPfWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ueHxqujk; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ueHxqujk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=SglhlW/h4d3cAD9x+5DzMycqfYiHe4iQWyOY9AnWZVw=; b=ueHxqujkZJPeNpTgFtXS1AEA8t
	oFu7sGuWoNtDXOeTUlj68YS/mltcTZT1Y4IZ5kBewLTq398vi6uS6ZcPBaEYUraueMdtKogocKyUk
	2uOgN1VFxjyDaxOeFk2fZxsLn93+XgWFhkXmWXmzJ0vl/G1oaMYmBfWXM4lM/2U80r94=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wEowH-000000005AG-3So3;
	Mon, 20 Apr 2026 09:45:26 -0400
Date: Mon, 20 Apr 2026 09:45:25 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: sh-sci: optimize max_freq determination
Message-Id: <20260420094525.f202b3e9a04d81b9049b718a@hugovil.com>
In-Reply-To: <CAMuHMdXGR=YOLqBMSY_syvtYbAU216Q_+xC_f8gUujYhLjRWSQ@mail.gmail.com>
References: <20260417193603.3906568-1-hugo@hugovil.com>
	<TY3PR01MB1134667FC9A3920ADC444C21A86212@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	<20260418103936.a3651d1606db7178fa7ff854@hugovil.com>
	<CAMuHMdXGR=YOLqBMSY_syvtYbAU216Q_+xC_f8gUujYhLjRWSQ@mail.gmail.com>
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

On Mon, 20 Apr 2026 09:13:55 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hugo,
> 
> On Sat, 18 Apr 2026 at 16:39, Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Sat, 18 Apr 2026 07:12:57 +0000
> > Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > From: Hugo Villeneuve <hugo@hugovil.com>
> > > > Follow example of rsci driver to avoid code duplication and useless max_freq search when port->uartclk
> > > > is set to zero.
> > > >
> > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > ---
> > > > Cc: biju.das.jz@bp.renesas.com
> > > >
> > > > Biju: if you want, feel free to pickup this patch when you resubmit your serie for "sh-sci/rsci: Fix
> > > > divide by zero and clean up baud rate logic".
> > > > ---
> > > >  drivers/tty/serial/sh-sci.c | 13 +++++++------
> > > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c index
> > > > 6c819b6b24258..dcee8b69adab2 100644
> > > > --- a/drivers/tty/serial/sh-sci.c
> > > > +++ b/drivers/tty/serial/sh-sci.c
> > > > @@ -2711,14 +2711,15 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
> > > >      * setup the baud rate generator hardware for us already.
> > > >      */
> > > >     if (!port->uartclk) {
> > > > -           baud = uart_get_baud_rate(port, termios, old, 0, 115200);
> > > > -           goto done;
> > > > +           max_freq = 115200;
> > >
> > > I have thought about this change. but the below comment made me not to do this change.
> > >
> > > <snippet from Geert>
> > > IIRC, baud == 0 can (only?) happen when using earlyprintk on a non-DT
> > > system, where the serial console should just keep on using the settings
> > > programmed by the firmware.  So any config register writes should
> > > be skipped.
> > > </snippet>
> >
> > I think Geert comments referred to the clock (port->uartclk) being zero,
> > not the baud (the baud rate cannot be zero)...
> 
> I did mean the baud variable being zero.

uart_get_baud_rate() will not return zero. Even if the baud rate
specified in termios (or the old) is set to 0 (hang up), it will return
9600...

-- 
Hugo Villeneuve
