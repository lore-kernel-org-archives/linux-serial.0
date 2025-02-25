Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC6715383D
	for <linux-serial@vger.kernel.org>; Tue, 25 Feb 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500350; cv=none; b=dVtD72vmF2XSTAGgBdrd/brMhmuufwuXtFOArnSVM3Hy04sUdgG2SSNCzStUc3BNwpfCzVEzAO9g+H8jg5vx6vsEhJ8CaUIU6+Rd1d5D2rtt4SvNGPXwXybt3/ZN3ZPzuWnNwMcYrB5tQZ7//HvEIbdre9pXcwHDIdSf6JNPZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500350; c=relaxed/simple;
	bh=qo6kgn/yZiVe472RuMq0aS+qIRtuihNeXVuViyHkxYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXGex1+Ds2dU/OtDtdMPMFvkM2Lgax73anX5n4OC4gnuIQYIF7DI5KXWg19KXk7AY9+nf5AdoiMT545+VzUd09mLMuGkNbfRIPYLudTdqccbEEr8Vhg6zGWdiwWy26aFxR+bGFF/PwW1cL1VsL6NMscYEe3i9X4wgKvCvWgEZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eimrVkML; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eimrVkML"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-438a39e659cso38618755e9.2
        for <linux-serial@vger.kernel.org>; Tue, 25 Feb 2025 08:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740500346; x=1741105146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3gF/nGV9ptGR7aq0NclC/gkRD6WxdI9GiS/1pNOvww=;
        b=eimrVkMLkOmH2mPw51QgP+dPu7oi9csGZLIIEIgXCwcYLvxl1GmeUldxnlHpg/+Wya
         YJC3RC0nePOqcPgbyPFF2AbRMP2BMGPSyZFzLC4ASdgf1uLL86/eHVPC95f1MHtJK8xG
         OlCg53HaiB6aImbMft+QbwreMxOtBM4K6s4NsEeG8q9UDMDOHdzXKsjxSGhBq1nkJQnH
         3xzmZes28ib1JnggQjTi4vlez+WM+val3RCx2zwpAX3G5VAlRxulWx5Xq3/qFrVuXbiS
         pZLFy3JxgP/LV+CywfR8Bc5bGnU6umwcdgn6S4s5ZcZFvWq0W6CoHeCkYruRPf/4+9/H
         cOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740500346; x=1741105146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3gF/nGV9ptGR7aq0NclC/gkRD6WxdI9GiS/1pNOvww=;
        b=N+dWNA8IFNBKUP02Ng39Z6o0m1GtbJJ7yOGbSQD/vcC5cWyN7g9ZeSB46scrSGpRyB
         0dT60rT2UFHeFvbXSUnRklyg6P6nFCYTmJoUo1MCOM41fsgbJ+juMmDY6nHBEsHpei71
         SGRs8LWiRJ3Pc47TSQQnpbGBiIqhGIBa0fAGWXYT39oWxzE0Blm1PkkEEcCyPn9x14rg
         2S8iu2BmODAqPQa2e04zkJtfuf41XLTgKxExrcOPiVcsPN40P4TfHSeb2aXxCIJKYBY4
         sMRDJ6WIbsHIbxqqhMP6J+Uzz46Q9Y0NyeCSvU3gL0M4JX/HHxboeQVxSQ4iXi9jjQ4I
         8xhg==
X-Gm-Message-State: AOJu0YxJUDSI/otD4bnWVWQENOtHivL2TE8QdA+yeadrUxb8HDjJZFiR
	C6bKldesDCPa616Lxpz1eLn3h5ri0x9wYYXnMy9+A8RWO1hLheIYLAfglriNk5M=
X-Gm-Gg: ASbGnctLRm+IBhk/aesNaRzfq9MyJ73quCcByWQdR4N0sDTGWk6PwOoERIfVEiSJ8qD
	fkTV6fHGwx7dpyQElqyE3EMTwsBtY941EApdkr/BV7ByU31hsUKbjRC8D3nbLJaDt3C5VagOZwm
	00zYBLHJZKixXLycpEq/TE4tKvWzdCBmJygav+MqEkLPQqaOYlRPC7GBTFvdzml9jC/T3gComth
	q7QGqDlc+WKjAMI9Hbdc5rO2zIVPra2JvvzzKvZmRX7/dGH9OymGysp8/Dn0vmT+OW0/ed2rb3p
	XmFucNvjUSyUlHziBMwsiWdfGg==
X-Google-Smtp-Source: AGHT+IFW9344/pShY8ZC3tty3kkbDF+k1Jqy9d5E/PPC0jnhKN/fSE4jPjst9Dbp5Q2wQj7MsDlkIQ==
X-Received: by 2002:a05:600c:4ece:b0:439:9a40:aa03 with SMTP id 5b1f17b1804b1-439aeae06b3mr155125105e9.2.1740500346420;
        Tue, 25 Feb 2025 08:19:06 -0800 (PST)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02d8859sm143823615e9.16.2025.02.25.08.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:19:06 -0800 (PST)
Date: Tue, 25 Feb 2025 17:19:04 +0100
From: Petr Mladek <pmladek@suse.com>
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 1/2] ttynull: Add an option to allow ttynull to be
 used as a console device
Message-ID: <Z73teICMWNx7BiHT@pathway.suse.cz>
References: <20250224123915.2859682-1-adamsimonelli@gmail.com>
 <20250224123915.2859682-2-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224123915.2859682-2-adamsimonelli@gmail.com>

Hi Adam,

please add printk maintainers into Cc as already suggested by Andy
at https://lore.kernel.org/r/CAHp75VeBaetiQBykfLk_weBHdzZF1nWp=k8BJu+OKNp6iYRRTg@mail.gmail.com

The motivation is that the console registration code is in
kernel/printk/printk.c. It is historically pretty tricky.
Some ordering is defined rather by chance than by design.
And we should be careful when adding new rules and hacks.

On Mon 2025-02-24 07:39:14, adamsimonelli@gmail.com wrote:
> From: Adam Simonelli <adamsimonelli@gmail.com>
> 
> The new config option, CONFIG_NULL_TTY_CONSOLE will allow ttynull to be
> initialized by console_initcall() and selected as a possible console
> device.
> 
> Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
> ---
>  drivers/tty/Kconfig   | 15 ++++++++++++++-
>  drivers/tty/ttynull.c | 20 +++++++++++++++++++-
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index 63a494d36a1f..b4afae8b0e74 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -383,7 +383,20 @@ config NULL_TTY
>  	  available or desired.
>  
>  	  In order to use this driver, you should redirect the console to this
> -	  TTY, or boot the kernel with console=ttynull.
> +	  TTY, boot the kernel with console=ttynull, or enable
> +	  CONFIG_NULL_TTY_CONSOLE.
> +
> +	  If unsure, say N.
> +
> +config NULL_TTY_CONSOLE

It makes sense to enable this behavior by a CONFIG_ setting
but the name is misleading.

> +
> +        bool "Support for console on ttynull"
> +        depends on NULL_TTY=y && !VT_CONSOLE
> +	help
> +	  Say Y here if you want the NULL TTY to be used as a /dev/console
> +	  device.
> +
> +	  This is similar to CONFIG_VT_CONSOLE, but without the dependency on
> +	  CONFIG_VT. It uses the ttynull driver as the system console.

It is true that CONFIG_VT_CONSOLE causes that the virtual terminal
will get associated with /dev/console. But it works only "by chance".

It works because "register_console(&vt_console_driver)" in
con_init() is the first register_console() call. And it also
works only by chance because of the linking order.

Anyway, there are more similar CONFIG_ options, for example,
CONFIG_LP_CONSOLE, or CONFIG_VIRTIO_CONSOLE. And they are not
default when CONFIG_VT_CONSOLE is enabled. They are registered only
when the related console= option is defined on the command line.

I want to say that CONFIG_<BLA>_CONSOLE does not mean
that the BLA console will be registered by default.
And we should us a better descriptive name, for example,

  NULL_TTY_DEFAULT_CONSOLE
  NULL_TTY_DEV_CONSOLE

>  	  If unsure, say N.
>  
> diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> index 6b2f7208b564..ec3dd3fd41c0 100644
> --- a/drivers/tty/ttynull.c
> +++ b/drivers/tty/ttynull.c
> @@ -57,6 +57,13 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
>  static struct console ttynull_console = {
>  	.name = "ttynull",
>  	.device = ttynull_device,
> +
> +	/*
> +	 * Match the index and flags from other boot consoles when CONFIG_NULL_TTY_CONSOLE is
> +	 * enabled, otherwise, use the default values for the index and flags.
> +	*/
> +	.index = IS_ENABLED(CONFIG_NULL_TTY_CONSOLE) ? -1 : 0,

This should not be needed. "con->index" is always initialized to "0"
for the default console, see:

static void try_enable_default_console(struct console *newcon)
{
	if (newcon->index < 0)
		newcon->index = 0;
[...]
}

> +	.flags = IS_ENABLED(CONFIG_NULL_TTY_CONSOLE) ? CON_PRINTBUFFER : 0,

This does not make much sense to me.

CON_PRINTBUFFER prevents duplicated output when the same device has
already been registered as a boot console. But ttynull does not have
a boot console variant. Also it is a "null" device. It never prints
anything. The output could never be duplicated by definition.

>  };
>  
>  static int __init ttynull_init(void)
> @@ -90,11 +97,22 @@ static int __init ttynull_init(void)
>  	}
>  
>  	ttynull_driver = driver;
> -	register_console(&ttynull_console);
> +	if (!console_is_registered(&ttynull_console))
> +		register_console(&ttynull_console);
>  
>  	return 0;
>  }
>  
> +#ifdef CONFIG_NULL_TTY_CONSOLE
> +static int __init ttynull_register(void)
> +{
> +	if (!console_is_registered(&ttynull_console))
> +		register_console(&ttynull_console);
> +	return 0;
> +}
> +console_initcall(ttynull_register);
> +#endif

This looks strange. I guess that you needed to move this into
console_initcall() because it is called earlier together
with the other console_initcall() calls for serial ports.
Otherwise, the hack with the linking order (2nd patch) did
not work.

But you needed to keep it in ttynull_init() so that ttynull
did not get registered prematurely when CONFIG_NULL_TTY_CONSOLE
was not enabled.

Sigh, it looks like a dirty hack which works rather by chance
than by design.


Thinking loudly:

The register_console() code is a historic mess. I dream about
having time to clean it up. Anyway, there are basically two
modes:

1. try_enable_default_console(newcon) is called only when
   there is no @preferred_console and there is no registered
   console with tty binding (valid con->device).

   The first register_console() caller wins. The order is defined
   by the __con_initcall section. Which is defined by the linking
   order.

   IMHO, it is quite fragile and non-intuitive.


2. try_enable_preferred_console() is called when some
   console is preferred via console_cmdline[]. The entries
   are added by __add_preferred_console() calls.

   This approach was created to handle console= command line
   parameters. But it was later used to define default consoles
   also via SPCR and device tree, see add_preferred_console()
   callers.

   It is also a bit tricky because the last added entry
   is preferred. Plus the .user_specified entries are
   preferred over the entries added via SPCR or device tree.

   Anyway, I think that the preference and ordering defined
   by console_cmdline[] array is a more intuitive approach.


My proposal is to call:

#ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
	add_preferred_console("ttynull", 0, NULL);
#endif

somewhere in the kernel code. The question is where.
I wonder if the following would work:

#ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
static int __init ttynull_default_console(void)
{
	add_preferred_console("ttynull", 0, NULL);
	return 0;
}
console_initcall(ttynull_register);
#endif

Best Regards,
Petr
