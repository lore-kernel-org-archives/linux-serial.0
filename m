Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000614BF97;
	Sat, 18 Apr 2026 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776523184; cv=none; b=EtJfGmZd2DXiNi60wKfmg5s4wa1r5OjSjW4bcT8BO8CLb+TIsNO+xy1Z87I83Ld7ANHjF8EYCDuWaqhewH8IL022A/eKgF11qYEZT3E4nYW3HGFsmjooPtP9cbVhx6RQnYpc73fLXzobdL1TzzreUXrHa5U3ldNJxRBOKbPqUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776523184; c=relaxed/simple;
	bh=4ube6dYtAJ3qFtEYRPWU26g0AgYVcaH96zgx5YHP1DE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UnYvKWueWiXRd65hrI+v5OBuXmZzMeIHPF9LrVM/MDqx1grVpxiZKe6/sH7RvInMGQHshuAmzRsM73TevC53JQ+kfKBKxZu5LwQgpwZVPiUubQdVj1CLO6SVGkstGSLlp2SYAq6vsvZKkf/uTbo1foZmq2xYY4YGfsdQe7FBDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ENrG6NF3; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ENrG6NF3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=xm6KiDTIf200c7IEeA83LLsAMJlhRwRIpZZm2IgxSSA=; b=ENrG6NF3H8Z45WroVMMw7RBCfY
	TuNBOXf93tbvhpvNKSJdTMhd/FI4IEPMFl1atd+HRDbt5MdzK36xJm9Zu7UyywA/4P+Nibvel6d3E
	a0LgJQDBZJ8bhjNTpNA68upYSZ9RdVBLramvlQybTre0XnUc20q/ebEHHQeC3twNWGLs=;
Received: from [70.80.174.168] (helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wE6pc-0000000004u-3B2A;
	Sat, 18 Apr 2026 10:39:37 -0400
Date: Sat, 18 Apr 2026 10:39:36 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: sh-sci: optimize max_freq determination
Message-Id: <20260418103936.a3651d1606db7178fa7ff854@hugovil.com>
In-Reply-To: <TY3PR01MB1134667FC9A3920ADC444C21A86212@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260417193603.3906568-1-hugo@hugovil.com>
	<TY3PR01MB1134667FC9A3920ADC444C21A86212@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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

Hi Biju,

On Sat, 18 Apr 2026 07:12:57 +0000
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Hi Hugo,
> 
> > -----Original Message-----
> > From: Hugo Villeneuve <hugo@hugovil.com>
> > Sent: 17 April 2026 20:36
> > Subject: [PATCH] serial: sh-sci: optimize max_freq determination
> > 
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Follow example of rsci driver to avoid code duplication and useless max_freq search when port->uartclk
> > is set to zero.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> > Cc: biju.das.jz@bp.renesas.com
> > 
> > Biju: if you want, feel free to pickup this patch when you resubmit your serie for "sh-sci/rsci: Fix
> > divide by zero and clean up baud rate logic".
> > ---
> >  drivers/tty/serial/sh-sci.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c index
> > 6c819b6b24258..dcee8b69adab2 100644
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -2711,14 +2711,15 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
> >  	 * setup the baud rate generator hardware for us already.
> >  	 */
> >  	if (!port->uartclk) {
> > -		baud = uart_get_baud_rate(port, termios, old, 0, 115200);
> > -		goto done;
> > +		max_freq = 115200;
> 
> I have thought about this change. but the below comment made me not to do this change.
> 
> <snippet from Geert>
> IIRC, baud == 0 can (only?) happen when using earlyprintk on a non-DT
> system, where the serial console should just keep on using the settings
> programmed by the firmware.  So any config register writes should
> be skipped.
> </snippet>

I think Geert comments referred to the clock (port->uartclk) being zero,
not the baud (the baud rate cannot be zero)...

But I am not sure how it is relevant here because the modification is
not changing the behavior of the existing code, it is an optimization
and a simplification. In fact, it is exactly the change I proposed [1]
when you submitted the rsci driver (and yoyu accepted), unless I am
missing something?

[1]
https://lore.kernel.org/all/20251028112236.c832fb48ad9fafcd2cf34b57@hugovil.com/

The goal of this patch is to have both rsci and sh-sci code to be the
same for this specific section at least. If you modify it to take into
account Geert's comments, then It think you need to do it both for rsci
and sh-sci drivers, no?


> 
> Cheers,
> Biju
> 
> > +	} else {
> > +		for (i = 0; i < SCI_NUM_CLKS; i++)
> > +			max_freq = max(max_freq, s->clk_rates[i]);
> > +
> > +		max_freq /= min_sr(s);
> >  	}
> > 
> > -	for (i = 0; i < SCI_NUM_CLKS; i++)
> > -		max_freq = max(max_freq, s->clk_rates[i]);
> > -
> > -	baud = uart_get_baud_rate(port, termios, old, 0, max_freq / min_sr(s));
> > +	baud = uart_get_baud_rate(port, termios, old, 0, max_freq);
> >  	if (!baud)
> >  		goto done;
> > 
> > 
> > base-commit: a1a81aef99e853dec84241d701fbf587d713eb5b
> > --
> > 2.47.3
> 
> 


-- 
Hugo Villeneuve
