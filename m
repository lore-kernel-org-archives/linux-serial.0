Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F82A48
	for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611400; cv=none; b=SFWcnuvmwii9de9b72+2H1eXgKa2OX4I1PnCs+QBKNEtJTI7aHSC0Agb8+U6BuGctmRcBQdhClx5RLH7UOqm97KDwKn3lP1AbtpSNDzD0Gaz2IKt/yNvqB0j8cAOJtcZurREgYo4nnx4ClQ5NmUUIYr7ogeO2nd6vx2vHtwzn5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611400; c=relaxed/simple;
	bh=qP2c8SI7c8LR+At+5MSM/4ZIzSxkMD7apY0IYjLrXGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/O7MJn8jf+769SEDlgD/lG22tGNt/Dl971yeddEA88pscAvc3jGuQVMMSmX5qLHPDvbYGMglxShzVyjkHRWl6P1aAFiyG//qWIxn6yIfQpQSnU5iItn78NSeek0jtlVN9kvxxA5kESo0Gi/8z/hE4OY7dHAwlKhBHuuuaJXKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U5wHCExs; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U5wHCExs"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6f51660223so235374666b.0
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 01:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718611397; x=1719216197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RiRNeXTNLkPeYnOsXqevm4dREEioiq1cUZc3k0Sc504=;
        b=U5wHCExsDw4t9fbecOpMzS3lP527aheiPXXCoz6uwZ3ccGd9CQWhmi/AY3wnFLHawp
         f190J2peabReJ/PaKRkDn4ztzl08kRunkz6XHn/Zx6eKtPXx1PcLXrB9EgLaQ64iEBE+
         ETrVB9dH+K8J4aFdFfyN4VZjBeC5SNir00lnr+670nsP8K9vqfnEMc4tOP/sCY6fhq6h
         L2jU0FrTfFSvP0AFgpUo0niKzjLR7WHcR8fEyLjj/DaNpkp8scrazuiAevqn4PuqalBr
         BV/PGayvO2tGOn0slTnX2OSNqRumFUXUMNHLfTAJCL7KB8gMEzz55fc91ZHSXr0zP4d8
         MXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718611397; x=1719216197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiRNeXTNLkPeYnOsXqevm4dREEioiq1cUZc3k0Sc504=;
        b=lIO4bPvmAuzpngu1nMZMpiVYBwTOURf25lRbM7uXmEX0zk3bG6p385Tcz+M7CINf8C
         2uIUUxA4lQjxloOxYDUyAVZj1vrtwBQR6XVgm62OgiLGF9/TN2iXynhDngza3K18TiiA
         cL82kgun1MZNBKwIu73+x3r/ArEmCTdJOBl6G0uvaGtPwmgRPd8rvfaVLwV4toft8r6U
         ysUnK6xu/X1KTuUA0ZOxyJJo6TdQhycSoFFCE9rbsoP4+ZUNu9GmPZQhvtEHhwF3YrOg
         9liiuJyPgwJ4hbFFENtvtK1Y6UX+P3ubJLUBqcpDQpHmXxLsQqYwRP8op+MuKWaswY3J
         sMdg==
X-Forwarded-Encrypted: i=1; AJvYcCUFww3gdZsqkzYMOuMGbZYZOTXQZtfiS5jvgilpwO5BtNa6lfcPeotKyx/0alSEdpVrzXvN+ZoEIfrd3Jt9TLmxCpUeIDts5VRIg+hz
X-Gm-Message-State: AOJu0YwnKBTVIO3JXSmEZfHyuBmIc8kY0L5LAL+A07mtMI3IANAiV3R9
	c918ywwcKfh7AWeObwH+R/tBeGwSEmkC338yBs0KocnfAqEZ+rseC7+z1vfM6B0=
X-Google-Smtp-Source: AGHT+IFSpUQt6d/6ildUpfUWV+522s+T+z60M3/a+FlFj8a7tqsP/iWZSODumewUHkkMrpN8DgzmeA==
X-Received: by 2002:a50:d759:0:b0:57c:5874:4f5c with SMTP id 4fb4d7f45d1cf-57cbd6c7561mr7237780a12.32.1718611396832;
        Mon, 17 Jun 2024 01:03:16 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cd245c408sm2743993a12.79.2024.06.17.01.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 01:03:16 -0700 (PDT)
Date: Mon, 17 Jun 2024 10:03:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] printk: Add update_preferred_console()
Message-ID: <Zm_tdcWDEQjQns_G@pathway.suse.cz>
References: <20240613125113.219700-1-tony.lindgren@linux.intel.com>
 <20240613125113.219700-3-tony.lindgren@linux.intel.com>
 <Zmx7IPQX4FVdSe1J@pathway.suse.cz>
 <Zm_j2eq3QcaA-g-e@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm_j2eq3QcaA-g-e@tlindgre-MOBL1>

On Mon 2024-06-17 10:20:57, Tony Lindgren wrote:
> On Fri, Jun 14, 2024 at 07:17:20PM +0200, Petr Mladek wrote:
> > On Thu 2024-06-13 15:51:08, Tony Lindgren wrote:
> > > The earlier attempt on doing this caused a regression with the kernel
> > > command line console order as it added calling __add_preferred_console()
> > > again later on during init. A better approach was suggested by Petr where
> > > we add the deferred console to the console_cmdline[] and update it later
> > > on when the console is ready.
> > 
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -2486,8 +2495,8 @@ __setup("console_msg_format=", console_msg_format_setup);
> > >   */
> > >  static int __init console_setup(char *str)
> > >  {
> > > -	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
> > > -	char *s, *options, *brl_options = NULL;
> > 
> > I would add
> > 
> > 	static_assert(sizeof(console_cmdline[0].devname) >= sizeof(console_cmdline[0].name));
> 
> That check should still be >= sizeof(console_cmdline[0].name) + 4, right?
> For the "number only" consoles we add the "ttyS" prefix.

Right. Great catch!

Best Regards,
Petr
