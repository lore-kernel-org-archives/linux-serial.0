Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE019F11F;
	Wed, 26 Feb 2025 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577169; cv=none; b=P81Z169egvL/tR3MlpB586IzGQtjIk+rtTAtSLQIiaMLCxnWhgS4UzIQuNfkpEr57/mvZnNYA22vh/Z/vAJso9Ge82JGEKts1S0wxHPQ3Ro4vPWLsc3LhYLcANaWK5+DeT0s5bPAjlw6SnpIPqDM8mLA3HNSIdfl+RnlCREMRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577169; c=relaxed/simple;
	bh=cAQAcszhH6FocbK8W5esJUgYZn7PJfF6QqVUeYk5/n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2UF0uWetTHqRBm47CtwA1A2roAwoEEPu+t9/6bahB+YkyBK3E0bAosSBMTE9pNd7Cbz/JXm0Y+XDVTkhA4fweB5R1fa5fOMsKPzPeq9sUUfB/f2xtZC6LO3BcmDcVDE2eAiKq2S8qG834nhMBc5xGyqSji98/XQl87js09MHEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PALTg1fU; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PALTg1fU"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471f4909650so62176991cf.2;
        Wed, 26 Feb 2025 05:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740577166; x=1741181966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j103PTOlCxkknU2zFxBu9rXxUZEdK1JJlNLLxcvq/s0=;
        b=PALTg1fUP3QVCwJnlA1lhu6hJ7KdgTerSf428VouNcHPKN/jSZQKE9vAZ9HWcBCkTL
         YICJDyOydgGHLGLXQPbqU6N61rcY/8wKVt7iWTJVXpdmAE1XyYOQf68zd46Xanp1uKHA
         R0jPMIWfw9yhO/DTnWCmr1xS3auNRy+wx9vcfokuobM8/OEzXnKivxrXGY7QaCPvGWn/
         C5lZtUN4qjxr4QdErJVmnQHLZjeKWrpvKHzyl4+HhzwfdpJBWfOXFoIRGe35pFQlP+Vh
         fDyEoHbg3JCe/WDBr1Wczv5IhMDifqVQhJdOt3jpvQxUW4SiXqYG5obwJMTsFiAFHbd3
         1buA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740577166; x=1741181966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j103PTOlCxkknU2zFxBu9rXxUZEdK1JJlNLLxcvq/s0=;
        b=deh+y04JhOEYgSl3G8jYVIvRdmctnTOIbTSdsZ7rQL8fy1kmf13SyMJASfNORLUfXa
         0sM0+0LI//q0LOQOdTO8XXF45bYMQEgiUO85WHwBm9cL9sn/kEM0/5oxnH4i4GLYOFu3
         vXWOcryHFuQMYQalXQp0RKBDXp0W9c4fjn8OEVtBBp1qBXZLiOFfB9thoPv3NYVzax4c
         73opAEJhFMnaPAro0bvIZUQ4ylJQHBzg71B10Sx6Ned7IdXzwuszh6NM9tna/lUiGbjC
         lJVsxIllATQwqR89abrH7QWLjbquJVsZLdHoCDm4iGNHqgZEvbQBb5gmuzII7IVQozcr
         19fA==
X-Forwarded-Encrypted: i=1; AJvYcCVt2TLnCh+7FZvkbe2uVUtbTTWs3/HpraGVqD6+JaPz2967LmxxV6L3KwKFzPomnUxosY25R1n7qVsZDx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2D6y3i6Ojcl3J/eiW9uJCeR+xRQ/MYK12I+d0GrmlZKlZI+Z4
	fjHOy36BxlXxZo3hs71ZzuyDGo58sj4U9PzvI009zEntUopcGERV
X-Gm-Gg: ASbGncvWW0NjQzveMg9h0ukGQ7GhWQnWOFfXyP9YL2TQ1OYfAEqqLNtP5mbd0enfAwi
	HjVkP4ez2U5KuPEe/+Qbb5EPGA3tMpd67pll/y9fdMpOh5CygZr4k/8RZwpTsRx15BGBgq8Z8On
	/RgFiS+wgl5cpg3yeHfoLbaws1+OFkhu1OIElBtwC8RaQ49Z+IZCP9GzJCujfbiCUrDNz6UgQrS
	p3NeqKldskkPmnPuw5VFXb1kvP1X+kSPMnIFmnTIpxIoBZfiO2zEbZD/91YmB8DUVmxoLQUAcHO
	Cd/jRYuuC67CLq2111niNQHHmsfkodUKV0so5zlURDpGE1M=
X-Google-Smtp-Source: AGHT+IHxl1BF2M3dXSaGQWS2yqSTomErlVurzc2yGx9v478CoPTAFX5T0xEqFU3mb19PBvqv3w2bmg==
X-Received: by 2002:a05:622a:1a91:b0:472:12f1:ba4a with SMTP id d75a77b69052e-47377116f84mr88973971cf.4.1740577166031;
        Wed, 26 Feb 2025 05:39:26 -0800 (PST)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:8167:32bd:108d:a7a4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47378084493sm23728211cf.70.2025.02.26.05.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:39:24 -0800 (PST)
From: Adam Simonelli <adamsimonelli@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject:
 Re: [PATCH v5 1/2] ttynull: Add an option to allow ttynull to be used as a
 console device
Date: Wed, 26 Feb 2025 08:39:23 -0500
Message-ID: <10194425.EvYhyI6sBW@nerdopolis2>
In-Reply-To: <Z73teICMWNx7BiHT@pathway.suse.cz>
References:
 <20250224123915.2859682-1-adamsimonelli@gmail.com>
 <20250224123915.2859682-2-adamsimonelli@gmail.com>
 <Z73teICMWNx7BiHT@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, February 25, 2025 11:19:04 AM EST Petr Mladek wrote:
> Hi Adam,
> 
> please add printk maintainers into Cc as already suggested by Andy
> at https://lore.kernel.org/r/CAHp75VeBaetiQBykfLk_weBHdzZF1nWp=k8BJu+OKNp6iYRRTg@mail.gmail.com
> 
OK, I have added the other printk maintainers in this thread, and will update
my git send email script.
> The motivation is that the console registration code is in
> kernel/printk/printk.c. It is historically pretty tricky.
> Some ordering is defined rather by chance than by design.
> And we should be careful when adding new rules and hacks.
> 
> On Mon 2025-02-24 07:39:14, adamsimonelli@gmail.com wrote:
> > From: Adam Simonelli <adamsimonelli@gmail.com>
> > 
> > The new config option, CONFIG_NULL_TTY_CONSOLE will allow ttynull to be
> > initialized by console_initcall() and selected as a possible console
> > device.
> > 
> > Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
> > ---
> >  drivers/tty/Kconfig   | 15 ++++++++++++++-
> >  drivers/tty/ttynull.c | 20 +++++++++++++++++++-
> >  2 files changed, 33 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > index 63a494d36a1f..b4afae8b0e74 100644
> > --- a/drivers/tty/Kconfig
> > +++ b/drivers/tty/Kconfig
> > @@ -383,7 +383,20 @@ config NULL_TTY
> >  	  available or desired.
> >  
> >  	  In order to use this driver, you should redirect the console to this
> > -	  TTY, or boot the kernel with console=ttynull.
> > +	  TTY, boot the kernel with console=ttynull, or enable
> > +	  CONFIG_NULL_TTY_CONSOLE.
> > +
> > +	  If unsure, say N.
> > +
> > +config NULL_TTY_CONSOLE
> 
> It makes sense to enable this behavior by a CONFIG_ setting
> but the name is misleading.
> 
> > +
> > +        bool "Support for console on ttynull"
> > +        depends on NULL_TTY=y && !VT_CONSOLE
> > +	help
> > +	  Say Y here if you want the NULL TTY to be used as a /dev/console
> > +	  device.
> > +
> > +	  This is similar to CONFIG_VT_CONSOLE, but without the dependency on
> > +	  CONFIG_VT. It uses the ttynull driver as the system console.
> 
> It is true that CONFIG_VT_CONSOLE causes that the virtual terminal
> will get associated with /dev/console. But it works only "by chance".
> 
> It works because "register_console(&vt_console_driver)" in
> con_init() is the first register_console() call. And it also
> works only by chance because of the linking order.
> 
> Anyway, there are more similar CONFIG_ options, for example,
> CONFIG_LP_CONSOLE, or CONFIG_VIRTIO_CONSOLE. And they are not
> default when CONFIG_VT_CONSOLE is enabled. They are registered only
> when the related console= option is defined on the command line.
> 
> I want to say that CONFIG_<BLA>_CONSOLE does not mean
> that the BLA console will be registered by default.
> And we should us a better descriptive name, for example,
> 
>   NULL_TTY_DEFAULT_CONSOLE
>   NULL_TTY_DEV_CONSOLE
> 
OK. I can change the option name.
> >  	  If unsure, say N.
> >  
> > diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> > index 6b2f7208b564..ec3dd3fd41c0 100644
> > --- a/drivers/tty/ttynull.c
> > +++ b/drivers/tty/ttynull.c
> > @@ -57,6 +57,13 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
> >  static struct console ttynull_console = {
> >  	.name = "ttynull",
> >  	.device = ttynull_device,
> > +
> > +	/*
> > +	 * Match the index and flags from other boot consoles when CONFIG_NULL_TTY_CONSOLE is
> > +	 * enabled, otherwise, use the default values for the index and flags.
> > +	*/
> > +	.index = IS_ENABLED(CONFIG_NULL_TTY_CONSOLE) ? -1 : 0,
> 
> This should not be needed. "con->index" is always initialized to "0"
> for the default console, see:
> 
OK, I had this in an #ifdef before, it was the cleanest way to set it to -1
that I could think of, other than the ifdef... If I still need this, I will try
to think of something else to set it to -1 when the option is enabled
> static void try_enable_default_console(struct console *newcon)
> {
> 	if (newcon->index < 0)
> 		newcon->index = 0;
> [...]
> }
> 
> > +	.flags = IS_ENABLED(CONFIG_NULL_TTY_CONSOLE) ? CON_PRINTBUFFER : 0,
> 
> This does not make much sense to me.
> 
> CON_PRINTBUFFER prevents duplicated output when the same device has
> already been registered as a boot console. But ttynull does not have
> a boot console variant. Also it is a "null" device. It never prints
> anything. The output could never be duplicated by definition.
> 
OK, I was duplicating what I saw in other consoles. I can try to remove it
> >  };
> >  
> >  static int __init ttynull_init(void)
> > @@ -90,11 +97,22 @@ static int __init ttynull_init(void)
> >  	}
> >  
> >  	ttynull_driver = driver;
> > -	register_console(&ttynull_console);
> > +	if (!console_is_registered(&ttynull_console))
> > +		register_console(&ttynull_console);
> >  
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_NULL_TTY_CONSOLE
> > +static int __init ttynull_register(void)
> > +{
> > +	if (!console_is_registered(&ttynull_console))
> > +		register_console(&ttynull_console);
> > +	return 0;
> > +}
> > +console_initcall(ttynull_register);
> > +#endif
> 
> This looks strange. I guess that you needed to move this into
> console_initcall() because it is called earlier together
> with the other console_initcall() calls for serial ports.
> Otherwise, the hack with the linking order (2nd patch) did
> not work.
> 
> But you needed to keep it in ttynull_init() so that ttynull
> did not get registered prematurely when CONFIG_NULL_TTY_CONSOLE
> was not enabled.
> 
> Sigh, it looks like a dirty hack which works rather by chance
> than by design.
> 
> 
> Thinking loudly:
> 
> The register_console() code is a historic mess. I dream about
> having time to clean it up. Anyway, there are basically two
> modes:
> 
> 1. try_enable_default_console(newcon) is called only when
>    there is no @preferred_console and there is no registered
>    console with tty binding (valid con->device).
> 
>    The first register_console() caller wins. The order is defined
>    by the __con_initcall section. Which is defined by the linking
>    order.
> 
>    IMHO, it is quite fragile and non-intuitive.
> 
> 
> 2. try_enable_preferred_console() is called when some
>    console is preferred via console_cmdline[]. The entries
>    are added by __add_preferred_console() calls.
> 
>    This approach was created to handle console= command line
>    parameters. But it was later used to define default consoles
>    also via SPCR and device tree, see add_preferred_console()
>    callers.
> 
>    It is also a bit tricky because the last added entry
>    is preferred. Plus the .user_specified entries are
>    preferred over the entries added via SPCR or device tree.
> 
>    Anyway, I think that the preference and ordering defined
>    by console_cmdline[] array is a more intuitive approach.
> 
> 
> My proposal is to call:
> 
> #ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
> 	add_preferred_console("ttynull", 0, NULL);
> #endif
> 
> somewhere in the kernel code. The question is where.
> I wonder if the following would work:
> 

> #ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
> static int __init ttynull_default_console(void)
> {
> 	add_preferred_console("ttynull", 0, NULL);
> 	return 0;
> }
> console_initcall(ttynull_register);
> #endif
> 
> Best Regards,
> Petr
> 
OK, actually in earlier revisions locally, I did actually have



diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dddb15f48d59..c1554a789de8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3712,6 +3712,11 @@ void __init console_init(void)
 	initcall_t call;
 	initcall_entry_t *ce;
 
+#ifdef CONFIG_NULL_TTY_CONSOLE
+       if (!strstr(boot_command_line, "console="))
+               add_preferred_console("ttynull", 0, NULL);
+#endif
+
 	/* Setup the default TTY line discipline. */
 	n_tty_init();
 


Which worked as far as I could tell, at least on x86. Not sure if that was the
right place, and yeah, I was trying to better copy how CONFIG_VT_CONSOLE worked
because I thought that was more correct.


