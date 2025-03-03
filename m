Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9784212FBC
	for <linux-serial@vger.kernel.org>; Mon,  3 Mar 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008018; cv=none; b=t6MG8RVxZjn0fHjXm/LbbvrAV6Pkvih/ndoISYU65w4ns8WTaynC4Ge1PCPQBtb6XdUYwBfV4AHvAFPDnfWqswBgDkjNzuxLcPdVC8l3CZsQy5KmxJJDompI9jT502dcB2LLOPrn71uUXtOIbMa6UW/REwwzbDkDEF+UMAhr694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008018; c=relaxed/simple;
	bh=g1Mk7++lMzi5BhWhRQ0mI4VU7qIIoTtTzWPyu4ewP/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJnZFZUJnSlLrYoxhnkbBm1g5HQ8ccqTwR+cOUGRqojxKS28H3GC0GjjeV/Z8xH95DYkbyqcolACiD168lZWv7VABNQlCBLNSmcV1BLQ9NmEHqNTLVCQcpvTfanbsRnsaAgdp1ZMs32HiUY3eOmmm8SX4xP4nt0FaC+CknUft2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vs2sYrjl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vs2sYrjl"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so7918156a12.0
        for <linux-serial@vger.kernel.org>; Mon, 03 Mar 2025 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741008014; x=1741612814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buy3wk70royQ8307to+vzbeizq6mjCuF24A5cvto0gc=;
        b=Vs2sYrjlJawxQd4FvBDK6XiKs/VaRPhdFokmVKi24zo85FkMpZ+55S3oiNZk/EbsYy
         44o+omfNUuipkN4wktChXO6ztaDC2b3ypVHSXSXzcbKlRk/NyHoaxARgSlaHvz9b8QvQ
         6+++8lifEucHC48y3lOOHkgp9dBaoqFA98xWSAaIXPprKuTlTgTd+i7OlxdxY2YiEiF1
         6tjFO7bP85P0ClJtCypsJKy0Ke0+3eRY/9yUfvEun6hoAgFVR+Zf6qG7yBLoP+v7lWQo
         1ugumPdouAZknS3cCIePiOX7Zo+pOKVsf133wB687IsaFLxgpknXd94PoyB1Ieala0Dm
         EGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741008014; x=1741612814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buy3wk70royQ8307to+vzbeizq6mjCuF24A5cvto0gc=;
        b=Df7MxALH1OkrN49m+AnVN3aGIZxy1XiylyoNmyqLRTO+YahKlWITN3d8Rb7PZhTXJM
         4WeanKX8yv2DE6uEJJWCJcHv3LGBgw5pfnlc2gNhOhuTFEJRh4DlLDYXJEHY30L1TmYQ
         ucTbjbUnunD37fs4qhR1+WDRQfSFxAd9FmF+PuNnDY7xFstoWOSOUPyLrjc3kBjYAcID
         2OARdoJkT7aFB56pHi/Cmy6wknaRn5OWnsGMhBEsV5igfro2gO8hXG6AGg3wdhlI2Z/q
         rjCQlde9W5EwNlXFDFaL8hQWKBiY6aaNvj/Iwkv/QZ1ulNyX6882q7ljZ0NjRsQMMv7/
         aD0A==
X-Gm-Message-State: AOJu0YwefQM1YrTze67TMoMc3ZmloImb9ZQ5JXbaNP9C4wIf6mTE4Bco
	Bf0RWEsNUnLOtNRJuOGfCD6SXcn14fq2hfg+Z7pawWO0w9WBJjqJ0GtLPyKDMtI=
X-Gm-Gg: ASbGnctqWxQ/Y/rp3yzzs7gQzLCuoGvi+jAMHd9CZo59QneVz4uJh926VWmUUgUtchh
	P9LnWtVF9GWuZGJ9a02lcthLszVHKvAgsdidvPFyyJrPu9eBta4gKd9pPvqstIZL4BBEjgxiE57
	2zAu8C4furhcK7/CgcOVBLXKtN6IWTsDxnynf7AEhgKzToJE7jwzZm5/KgS2dtflI7OyRxWwm0s
	L/n5/xbLKt+x2kWtBk6cFZFOPy4ck0zL/FDqQRKnmA+M5AUM4IudhDLlNQegnWFdXCkAVSCb94Z
	RD6ICZ+zKKp69CXO0BIqjdDA0VFVEGp+99PHegWPuyLwI4U=
X-Google-Smtp-Source: AGHT+IH5n8bI3ZS3M5y3W5N3e3xxt6uVhe0uizHPAWP+Q1afwPQdKMYyQt3RYC/9kGpiqtndOCo8Zw==
X-Received: by 2002:a17:907:c2a:b0:abf:6b30:7a94 with SMTP id a640c23a62f3a-abf6b58f60cmr708647066b.45.1741008013748;
        Mon, 03 Mar 2025 05:20:13 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf5d0bcb77sm381986366b.49.2025.03.03.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:20:13 -0800 (PST)
Date: Mon, 3 Mar 2025 14:20:11 +0100
From: Petr Mladek <pmladek@suse.com>
To: Adam Simonelli <adamsimonelli@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v5 1/2] ttynull: Add an option to allow ttynull to be
 used as a console device
Message-ID: <Z8Wsi7_rvk346Snr@pathway.suse.cz>
References: <20250224123915.2859682-1-adamsimonelli@gmail.com>
 <20250224123915.2859682-2-adamsimonelli@gmail.com>
 <Z73teICMWNx7BiHT@pathway.suse.cz>
 <10194425.EvYhyI6sBW@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10194425.EvYhyI6sBW@nerdopolis2>

On Wed 2025-02-26 08:39:23, Adam Simonelli wrote:
> On Tuesday, February 25, 2025 11:19:04 AM EST Petr Mladek wrote:
> > On Mon 2025-02-24 07:39:14, adamsimonelli@gmail.com wrote:
> > > From: Adam Simonelli <adamsimonelli@gmail.com>
> > > 
> > > The new config option, CONFIG_NULL_TTY_CONSOLE will allow ttynull to be
> > > initialized by console_initcall() and selected as a possible console
> > > device.
> > > 
> > > diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> > > index 6b2f7208b564..ec3dd3fd41c0 100644
> > > --- a/drivers/tty/ttynull.c
> > > +++ b/drivers/tty/ttynull.c
> > > @@ -57,6 +57,13 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
> > >  static struct console ttynull_console = {
> > >  	.name = "ttynull",
> > >  	.device = ttynull_device,
> > > +
> > > +	/*
> > > +	 * Match the index and flags from other boot consoles when CONFIG_NULL_TTY_CONSOLE is
> > > +	 * enabled, otherwise, use the default values for the index and flags.
> > > +	*/
> > > +	.index = IS_ENABLED(CONFIG_NULL_TTY_CONSOLE) ? -1 : 0,
> > 
> > This should not be needed. "con->index" is always initialized to "0"
> > for the default console, see:
> > 
> OK, I had this in an #ifdef before, it was the cleanest way to set it to -1
> that I could think of, other than the ifdef... If I still need this, I will try
> to think of something else to set it to -1 when the option is enabled

Ah, I was not clear enough. It should be perfectly fine to always
statically initialize the value to -1. We should not need any
#ifdef or IS_ENABLED.

I mean to do:

static struct console ttynull_console = {
	.name = "ttynull",
	.device = ttynull_device,
	.index = -1,
};

We might even do this in a separate patch. IMHO, it should have
been done this way since the beginning.

> > static void try_enable_default_console(struct console *newcon)
> > {
> > 	if (newcon->index < 0)
> > 		newcon->index = 0;
> > [...]
> > }
> > 
> > > +	.flags = IS_ENABLED(CONFIG_NULL_TTY_CONSOLE) ? CON_PRINTBUFFER : 0,
> > 
> > This does not make much sense to me.
> > 
> > CON_PRINTBUFFER prevents duplicated output when the same device has
> > already been registered as a boot console. But ttynull does not have
> > a boot console variant. Also it is a "null" device. It never prints
> > anything. The output could never be duplicated by definition.
> > 
> OK, I was duplicating what I saw in other consoles. I can try to remove it

Again, I was not clear enough. My primary concern was that it did not make
much sense to use the IS_ENABLED() check and initialize the value
different way.

Anyway, I would omit the flag. It is a NULL device. It does not matter
whether it prints existing (old) messages during registration or not.

> > >  };
> > >  
> > My proposal is to call:
> > 
> > #ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
> > static int __init ttynull_default_console(void)
> > {
> > 	add_preferred_console("ttynull", 0, NULL);
> > 	return 0;
> > }
> > console_initcall(ttynull_register);
> > #endif
> > 
> OK, actually in earlier revisions locally, I did actually have
> 
> 
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index dddb15f48d59..c1554a789de8 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3712,6 +3712,11 @@ void __init console_init(void)
>  	initcall_t call;
>  	initcall_entry_t *ce;
>  
> +#ifdef CONFIG_NULL_TTY_CONSOLE
> +       if (!strstr(boot_command_line, "console="))
> +               add_preferred_console("ttynull", 0, NULL);

Good point! We should call add_preferred_console() only when
the is no console= command line parameter. Otherwise, it could
not get overridden by the command line.

We could check "console_set_on_cmdline", similar to
xenfb_make_preferred_console().

> +#endif
> +
>  	/* Setup the default TTY line discipline. */
>  	n_tty_init();
> 
> Which worked as far as I could tell, at least on x86. Not sure if that was the
> right place,

I would prefer to keep it in drivers/tty/ttynull.c when possible.
The following might do the trick:

#ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
static int __init ttynull_default_console(void)
{
	if (!console_set_on_cmdline)
		add_preferred_console("ttynull", 0, NULL);

	return 0;
}
console_initcall(ttynull_register);
#endif

Best Regards,
Petr
