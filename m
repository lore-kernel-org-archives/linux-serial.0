Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42E3D16EB;
	Wed, 22 Apr 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776866946; cv=none; b=EfLfBhRa1WqcKmcLsCeqh1HrcAlTI6/IiBQEJOu0cAYm0fhLM3sWFLbtqU/GjfWvM5h3QBK+IJCW+xXE0mdEOXXJfOIFYe1A5lsalyhrBLMLhhEdLBP0fperIkroQYNevmrJ2BE7HwSQuYEtDFR8a78LPF4yCS0Z0wPI3JOKF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776866946; c=relaxed/simple;
	bh=vD/aNbZg4VpPLW+LqvzlkGiqlDibJiNK0l0zvMe2Kws=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UquH7z7W2qKScCG4O6sWJPg7m1d0bFEn2JcvA0+/A+y43RA03w5wGQMQ3qvS3wiiw7TaGSHQZkG040uijuZ8EmZG+PovvS0324lDoqg7aosRcDxnMxw/hiAsqsVhoseWiaFyzRV2w9adLnSkwwGMnPk1O+8XIC2d6iKCGqa05j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=JzG1ETk7; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="JzG1ETk7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=El2siLR+nvzaIrn4iJtf4oIuuKbimmFYgW/9xtj4wJw=; b=JzG1ETk7PUio6vHUsP+LPMpPQr
	4Fr/JETpnhvfzf7Y7ZFlH7dSbj99Mz+X241Rl6N37l6iovi9AtSvjZSoLT14IE9E4z9X+5qFRHA9S
	lJXIgL11G8GmiVA+KqZyM/RS8ocQJDoOTKH3jxExHvaMhyGRyxpcw43nn3FagC6HkLdY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wFYGE-000000002p1-2FVY;
	Wed, 22 Apr 2026 10:09:02 -0400
Date: Wed, 22 Apr 2026 10:09:01 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, biju.das.jz@bp.renesas.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: sh-sci: optimize max_freq determination
Message-Id: <20260422100901.c2168da12af0ec5aa8ed8c0b@hugovil.com>
In-Reply-To: <20260420121205.f52ae2515cb9ff093c19c6e2@hugovil.com>
References: <20260417193603.3906568-1-hugo@hugovil.com>
	<CAMuHMdXpZjVctirMuH=n_PrK4nnEnWqjuCzRjc4y6kC1--99kQ@mail.gmail.com>
	<20260420121205.f52ae2515cb9ff093c19c6e2@hugovil.com>
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

On Mon, 20 Apr 2026 12:12:05 -0400
Hugo Villeneuve <hugo@hugovil.com> wrote:

> Hi Geert,
> 
> On Mon, 20 Apr 2026 09:23:55 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> > Hi Hugo,
> > 
> > On Sat, 18 Apr 2026 at 07:24, Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >
> > > Follow example of rsci driver to avoid code duplication and useless
> > > max_freq search when port->uartclk is set to zero.
> > >
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Thanks for your patch!
> > 
> > > --- a/drivers/tty/serial/sh-sci.c
> > > +++ b/drivers/tty/serial/sh-sci.c
> > > @@ -2711,14 +2711,15 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
> > >          * setup the baud rate generator hardware for us already.
> > >          */
> > >         if (!port->uartclk) {
> > > -               baud = uart_get_baud_rate(port, termios, old, 0, 115200);
> > > -               goto done;
> > 
> > There was no "useless max_freq search", due to this goto?
> 
> You are right, this part of the comment is wrong.
> 
> > 
> > > +               max_freq = 115200;
> > > +       } else {
> > > +               for (i = 0; i < SCI_NUM_CLKS; i++)
> > > +                       max_freq = max(max_freq, s->clk_rates[i]);
> > > +
> > > +               max_freq /= min_sr(s);
> > >         }
> > >
> > > -       for (i = 0; i < SCI_NUM_CLKS; i++)
> > > -               max_freq = max(max_freq, s->clk_rates[i]);
> > > -
> > > -       baud = uart_get_baud_rate(port, termios, old, 0, max_freq / min_sr(s));
> > > +       baud = uart_get_baud_rate(port, termios, old, 0, max_freq);
> > >         if (!baud)
> > >                 goto done;
> > >
> > 
> > Due to removing the goto above (for the casual reader: this is the
> > earlyprintk case, when port->uartclk is zero), the code will now
> > continue here, calculating transmission parameters and setting best_clk,
> > and overwriting the register configuration done by the bootloader.
> 
> Yes, I see it now for sh-sci where we have "if (best_clk >= 0) {"... to
> not configure the registers.
> 
> However, for the rsci driver, I think that, even after Biju's cleanup
> serie V3, we still overwrite the register configuration done by the
> bootloader?
> 
> Maybe configure only "if (!port->uartclk) {" ?

Argh :) I meant configure only "if (port->uartclk) {" ?

Hugo.



-- 
Hugo Villeneuve
