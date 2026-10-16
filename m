Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362D55C1B7;
	Fri, 16 Oct 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171025; cv=none; b=KmwWHuaFvQw0oNyx+x1z7FoiNnUJi6IeYtVj7wuSU0WlfWicHzh5Qu+IUVbNqAl3/rlhn0+lxQz6uU6vNeFKVgBUISaXIkWDPXw/9IMUumuNujgb8Om7ruoB6OaBXKQlKU5BR73UAO2Ee9aFX3gY3p3W0s4RBeFCZ5oYNHRT4DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171025; c=relaxed/simple;
	bh=nNGa9TvDgrAMBdKEfvIUXfA4nRo0oRAC/z1sorIw6w0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OzUwqtzGfEWhiC5YiLKflMAGOO/Ggb2gdYoEwPyoRohmpe3UnCuyFByPnmdEDTOdr2u/IBSUpLkuRgCsWYnYvIMHt8d521vXXg3gdDU+z1d30gu1F7a2WsF2JF9EWXSKlQEPXYTxR8MhKqqYQwE/F+xZrX574oUOGkXeGLJPjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Y5jyN7+6; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Y5jyN7+6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=4ZUoUIhvbfC88KaoKHqYu/qRtIDZmc0/E3twtrLwIIw=; b=Y5jyN7+6fkrqvRGCCNcN/Vv9PN
	/YKyPjNLZhH3ACLt6EV0NMevlYRKfyhgXmwj+071FePYm88/hsCj3z6hvDwiysuu27EKKu27xroek
	WeC+SSVAzvq/W9ZPJD+AMVMNx4PyQG5hR+/WKB1L/Ox3ZVDxFkTouOOE4/KnOwAV8s0s=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xHlYF-000000006as-28rg;
	Fri, 16 Oct 2026 13:17:01 -0400
Date: Fri, 16 Oct 2026 13:17:00 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 "Hugo Villeneuve" <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
Subject: Re: [PATCH 1/2] tty: serial: remove hub6 multiport support
Message-Id: <20261016131700.b93fa4f7e31f3d2355d4a132@hugovil.com>
In-Reply-To: <5743b352-ffa2-4d38-9abb-a06085dea56d@app.fastmail.com>
References: <20261016130328.1037616-1-arnd@kernel.org>
	<20261016115604.a89ef44986bb3620c327feaf@hugovil.com>
	<5743b352-ffa2-4d38-9abb-a06085dea56d@app.fastmail.com>
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

Hi Arnd,

On Fri, 16 Oct 2026 18:16:20 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Fri, Oct 16, 2026, at 17:56, Hugo Villeneuve wrote:
> > On Fri, 16 Oct 2026 14:59:47 +0200
> 
> >>  	retinfo->custom_divisor  = uport->custom_divisor;
> >> -	retinfo->hub6	    = uport->hub6;
> >> +	retinfo->hub6		 = 0;
> >
> > Would a comment here help?
> >
> > 	retinfo->hub6		 = 0; /* No longer supported */
> 
> Good idea, added.
> 
> >> @@ -924,7 +921,6 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
> >>  	change_port = !(uport->flags & UPF_FIXED_PORT)
> >>  		&& (new_port != uport->iobase ||
> >>  		    (unsigned long)new_info->iomem_base != uport->mapbase ||
> >> -		    new_info->hub6 != uport->hub6 ||
> >
> > Maybe keep this so that change_port is true if someone sets hub6 to a
> > value other than zero (see below)?
> 
> Right, this would be fairly harmless as nothing looks at the field
> afterwards but it makes sense for consistency.
> 
> I've moved the hub6 check up before change_port now to behave the
> same way for regular users and root:

Yes that works too.

Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>


> 
> @@ -935,6 +935,11 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
>                 if (uartclk == 0)
>                         return -EINVAL;
>         }
> +
> +       /* hub6 is no longer supported */
> +       if (new_info->hub6 != 0)
> +               return -EINVAL;
> +
>         if (!capable(CAP_SYS_ADMIN)) {
>                 if (change_irq || change_port ||
>                     (new_info->baud_base != uport->uartclk / 16) ||
> @@ -950,10 +955,6 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
>                 goto check_and_exit;
>         }
>  
> -       /* hub6 is no longer supported */
> -       if (new_info->hub6 != 0)
> -               return -EINVAL;
> -
>         if (change_irq || change_port) {
>                 retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
>                 if (retval)
> 
> Thanks for taking a look!
> 
>      Arnd
> 


-- 
Hugo Villeneuve
