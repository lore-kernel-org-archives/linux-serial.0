Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7174165F1A;
	Tue,  4 Mar 2025 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741060355; cv=none; b=UkrB3fhy+4K04pBQ5vCiVAMTgXN7qnbkK4k+sKX+8f3YK6RMawibkGX6I+xCelfaoGuqrCQVgWBqCyPIFRbW3EzuLY2LmjbSt6/JnjHe2UXqrgsgMXfqAay9aiUElTfw0yF51vHnj7Gx19Qb+tq0pMFQhJpXQroGWuB3RFp8Ryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741060355; c=relaxed/simple;
	bh=f2NZwAfovmlmr+FYK23G+2UKFQo41AzBEeiyZFVgCPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YypQIX4dTQLk49PSd9M0J7be4mT9n1YH5usY3TavHTeJau4cBBOYpMzAiF6eGPE41w36HoYXxRKNww7QVVt2ywbSiWj6TN0nSAH0g+ZEmmBDLC9ePtlhSyKUkrNQIHi745pGhPjHd2V3ttLyUCr4WnZDaY0/159g3e3qykB0axM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkfnL5qr; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkfnL5qr"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e89ccbbaa9so35654816d6.2;
        Mon, 03 Mar 2025 19:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741060352; x=1741665152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE860M7wHaUDq0Jcbf2ninl7lZPjd4TL9wH24dx53eU=;
        b=dkfnL5qrtK15yVA+HOqBcMxd1q+pNaT2EndsrMt5O0kO6hjTCXG2aS2XjZF1lTmv5h
         8een1Xvq6mXdilYpAW0wK8VAkD5U44hk/lLadiH1f6M0+UpQvDZ9bG8FfHNYuFDncWxI
         I3M2ROdE3LGRKbfXvE0m0uKAK32sfTrd72YQETHVwEDYMFkg+orA7OO+DkMFv578Ghie
         ftcn06zDdDEhTPEeacNa7il22HUD7eaUT+fAdFRqMj0WAnv0/fl6WwI3wp4sdheveLDD
         PotArZeRo/d3kG0SRUY6amguemqKx2JHr9kjQRLzBa4dq7pJDTOFVtzvEJEfVuBgmlWi
         d5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741060352; x=1741665152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE860M7wHaUDq0Jcbf2ninl7lZPjd4TL9wH24dx53eU=;
        b=pKX2fA4JMyMBjCWrZkXheCYhEH3BQjdAxeRp7JpQt4CqF7TyD43HZXZqQm+b+bszLg
         DrML9LaDYpPbqAqFNeVcv3+WG/XpC8utRf+raaLK3zOJZ/gWCDMVGWTdFzbS4MR/2VQh
         JqhWmsvp4SLUZbI1m5JJA8F8c31yUkRP5y6oj6ttCRiDO+NHsX11UG5MsMIYJT8sRfCj
         F92MWleRgXavQYuw/ydvtwjBBTrmgj79g8igyysK+hB4keGhFESY/BmGnjZOhYD/rqAt
         z9vCzka44xUcyp3EYSmS149KMNqIZxyeSLGDOV0qf5CQrbZwmk7sxMWk1xvbmk9l01Up
         HaVA==
X-Forwarded-Encrypted: i=1; AJvYcCX0TziO/MvKczGoIw7GU5SnNeXaoE0EBjlBM9OofqGj9fbAn+vKBDcDEk4Oi9OOw1CbNA7hwt1k9ELSt+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzry+IRlx+n2fPHASyVoJoiG/SjR8yrMUy+mNwnwBB0KIpC+gdh
	nlfFr3vGvCl58BoQYj3kz5yrsi/NAy2UJE8sjQbN/vtoD5gIwAyI
X-Gm-Gg: ASbGncvqawcOENccHzD1z4FuiM9H797zkcX/26VRRMBbNh5Q8pnpCC3BuE4ArxfJYM/
	LnY3t7MZ7bMgSvvIfttUpA+IpyDTac7wl2ljVeQP6NqN+VAd+Z5/tz5Cm18owjPZfG1PHwvtPra
	yM0Ze8r1F6N4QptZkexywTq+uoV7cuMuSq7mOInEOeH1vuko8z2JVeBhKbbbHCbFDUQwOWr9M7j
	6neTiKHPQJeMdDxjm1WFEdRnmSkH9TWnHXidVaVjDaJHzUm1Y9/vPzIxTqnqwsIot9YZm/EhAg+
	qNUwFIAFkmKzIlNnpoCKHTRAasR1HLFB+rezcet/M5pptkZ8mfDio9sUWGkc0aHyDA==
X-Google-Smtp-Source: AGHT+IHWT1hfGKX56Kt4db3ezUP403uEPEpr02m0jZsUqWw6e8S71Qk+wlIO9UKis0MZO7kIJg3R/A==
X-Received: by 2002:a05:6214:21e7:b0:6e6:6252:ad1d with SMTP id 6a1803df08f44-6e8a0d2ab91mr217122886d6.20.1741060352322;
        Mon, 03 Mar 2025 19:52:32 -0800 (PST)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:745f:1ed4:1113:4077])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897653722sm61498246d6.36.2025.03.03.19.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 19:52:31 -0800 (PST)
From: Adam Simonelli <adamsimonelli@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject:
 Re: [PATCH v5 1/2] ttynull: Add an option to allow ttynull to be used as a
 console device
Date: Mon, 03 Mar 2025 22:52:29 -0500
Message-ID: <4647568.Icojqenx9y@nerdopolis2>
In-Reply-To: <Z8Wsi7_rvk346Snr@pathway.suse.cz>
References:
 <20250224123915.2859682-1-adamsimonelli@gmail.com>
 <10194425.EvYhyI6sBW@nerdopolis2> <Z8Wsi7_rvk346Snr@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, March 3, 2025 8:20:11 AM EST Petr Mladek wrote:
> On Wed 2025-02-26 08:39:23, Adam Simonelli wrote:
> > On Tuesday, February 25, 2025 11:19:04 AM EST Petr Mladek wrote:
> > > On Mon 2025-02-24 07:39:14, adamsimonelli@gmail.com wrote:
> > > > From: Adam Simonelli <adamsimonelli@gmail.com>
> > > > 
> > > > The new config option, CONFIG_NULL_TTY_CONSOLE will allow ttynull to be
> > > > initialized by console_initcall() and selected as a possible console
> > > > device.
> > > > 
> > > > diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> > > > index 6b2f7208b564..ec3dd3fd41c0 100644
> > > > --- a/drivers/tty/ttynull.c
> > > > +++ b/drivers/tty/ttynull.c
> > > > @@ -57,6 +57,13 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
> > > >  static struct console ttynull_console = {
> > > >  	.name = "ttynull",
> > > >  	.device = ttynull_device,
> > > > +
> > > > +	/*
> > > > +	 * Match the index and flags from other boot consoles when CONFIG_NULL_TTY_CONSOLE is
> > > > +	 * enabled, otherwise, use the default values for the index and flags.
> > > > +	*/
> > > > +	.index = IS_ENABLED(CONFIG_NULL_TTY_CONSOLE) ? -1 : 0,
> > > 
> > > This should not be needed. "con->index" is always initialized to "0"
> > > for the default console, see:
> > > 
> > OK, I had this in an #ifdef before, it was the cleanest way to set it to -1
> > that I could think of, other than the ifdef... If I still need this, I will try
> > to think of something else to set it to -1 when the option is enabled
> 
> Ah, I was not clear enough. It should be perfectly fine to always
> statically initialize the value to -1. We should not need any
> #ifdef or IS_ENABLED.
> 
> I mean to do:
> 
> static struct console ttynull_console = {
> 	.name = "ttynull",
> 	.device = ttynull_device,
> 	.index = -1,
> };
> 
> We might even do this in a separate patch. IMHO, it should have
> been done this way since the beginning.
> 
OK, will do. This makes sense.
> > > static void try_enable_default_console(struct console *newcon)
> > > {
> > > 	if (newcon->index < 0)
> > > 		newcon->index = 0;
> > > [...]
> > > }
> > > 
> > > > +	.flags = IS_ENABLED(CONFIG_NULL_TTY_CONSOLE) ? CON_PRINTBUFFER : 0,
> > > 
> > > This does not make much sense to me.
> > > 
> > > CON_PRINTBUFFER prevents duplicated output when the same device has
> > > already been registered as a boot console. But ttynull does not have
> > > a boot console variant. Also it is a "null" device. It never prints
> > > anything. The output could never be duplicated by definition.
> > > 
> > OK, I was duplicating what I saw in other consoles. I can try to remove it
> 
> Again, I was not clear enough. My primary concern was that it did not make
> much sense to use the IS_ENABLED() check and initialize the value
> different way.
> 
> Anyway, I would omit the flag. It is a NULL device. It does not matter
> whether it prints existing (old) messages during registration or not.
> 
Understood, this makes sense.
> > > >  };
> > > >  
> > > My proposal is to call:
> > > 
> > > #ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
> > > static int __init ttynull_default_console(void)
> > > {
> > > 	add_preferred_console("ttynull", 0, NULL);
> > > 	return 0;
> > > }
> > > console_initcall(ttynull_register);
> > > #endif
> > > 
> > OK, actually in earlier revisions locally, I did actually have
> > 
> > 
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index dddb15f48d59..c1554a789de8 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> >  	initcall_t call;
> >  	initcall_entry_t *ce;
> >  
> > +#ifdef CONFIG_NULL_TTY_CONSOLE
> > +       if (!strstr(boot_command_line, "console="))
> > +               add_preferred_console("ttynull", 0, NULL);
> 
> Good point! We should call add_preferred_console() only when
> the is no console= command line parameter. Otherwise, it could
> not get overridden by the command line.
> 
> We could check "console_set_on_cmdline", similar to
> xenfb_make_preferred_console().
> 
> > +#endif
> > +
> >  	/* Setup the default TTY line discipline. */
> >  	n_tty_init();
> > 
> > Which worked as far as I could tell, at least on x86. Not sure if that was the
> > right place,
> 
> I would prefer to keep it in drivers/tty/ttynull.c when possible.
> The following might do the trick:
> 
> #ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
> static int __init ttynull_default_console(void)
> {
> 	if (!console_set_on_cmdline)
> 		add_preferred_console("ttynull", 0, NULL);
> 
> 	return 0;
> }
> console_initcall(ttynull_register);
> #endif
> 
> Best Regards,
> Petr
> 
Thanks for that, that works.



