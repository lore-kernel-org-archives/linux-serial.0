Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C441EF0B7
	for <linux-serial@vger.kernel.org>; Fri, 14 Mar 2025 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945489; cv=none; b=Ofvqn313GPEewsUY2mYbpaRCorRTyYzYozC78pydgOVeR6o0aI+eZhKE65CtUZ5eY2j2ghfvhi1nNgXeZVGFNIJ389b6bKBRmMnteIAcQ0O6Iq+9kORwj9WI0grNPITnl83TOd5RRO2IzRrm8hm7mV3XivaZmltCa5tqMSmDngE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945489; c=relaxed/simple;
	bh=VdVCw/M5HAoDmq183sWDLkgRH8JrQMhGVUGoEq2UxGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3q86RZBanOZqm8d+dRLQUQueMR7Hz6qCm06WThyQbuaEpFO9wHDSXdb9rw9FgxEBFAgaDcWEnmk7+eVQoTBMBpBZugJcA1XUyRLG58w3nEm+WxmWuToIn1hnPDhup22rXC+O+uhpqql1ZnVs3IKs/pXge+Oup4Svh0O+0r2vR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UKsKQAaK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UKsKQAaK"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso12663155e9.0
        for <linux-serial@vger.kernel.org>; Fri, 14 Mar 2025 02:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741945485; x=1742550285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bKs60H+9RBHyzSNlhvZhr5uBt5TPIqP3KyZeHSPjWI=;
        b=UKsKQAaKH0mwLkXvL2TdG63NKpFGYYieQWVdi74qwsyQTRqMZc2BLqpzcosOIVvK2Q
         nv9w4QZZh34o3M1qvVCnv3QmJaRXFzNNRdHtU5v6cVMxnrsL+jqlDf+XAzPHqGwkYFEF
         8nqr3JzciZ2kjCNVXaAH1yDplVNqNYfGhb+LWy4ICF5vsgZgw8yV0VfyDM0hGbMbP+Pt
         gSTl+aHDvHnixnE9rJWMqeOoFmNCqLrYCp7t44gUEOpTFR3PQwyzSiJSdyEpUCWHGmDJ
         E1kLTiNTOabT9ue3Jx3DyNsMuRcvZkXBsFODjzuQYY5TZi2zhkn3avAKlIag6Y7vfh+3
         qBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741945485; x=1742550285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bKs60H+9RBHyzSNlhvZhr5uBt5TPIqP3KyZeHSPjWI=;
        b=MnRaxbWmf2L194Dwmg8UhSY7hMDrB4M3gwMcynoXnq2H0tKeNmzYo9MbhYcSLKG1//
         Xwp7MxXHhC+JCBbVWxr1ieCs7lfDbgbOm3f8QNZVreWXi9tqy7+TFYGh3ghVJs3C7D4X
         C2QKJvreYTr0dNLTrCgIgmIR9u0jPrHdJeGYe6M0TJjiFrfwqTdQxoZsYnrlX0d2tNb3
         0yl4MJUMjmKM6XVmRmHmsTBhhBj4Key8OLZgv9WFffaiHsbabfAXwLoXytWGkzjpIxrC
         w9CDttfYLx/uD70JUwyhnQ7eG+yfR6ASKQVkFWAShRmqDP/7dqTLdmic+Bj34ksMQDmp
         Da/w==
X-Gm-Message-State: AOJu0YxGLEuhF9XZ6XoC+bB1F6/swkQ5iDUdzCiL4HLz6fW8Aiq5aZek
	62QPMm7DbpCCyBMl6QwHeTDtkJwrbQgqEnACJgRARdbUC9Lpi4P8mueWwNPkCDM=
X-Gm-Gg: ASbGnctRvfErn0DYE3EfGomZ2rsETmvOfVdOwkqyC7sxShwyPSz9tUeySqTKVQvFjXJ
	7lmT9w9cTU+XQQNPXDR9yYgueFoWvUCP2/aZ3eCGVmdFwCMfBI6It8mAL3kb3RxIqnntLZ1LV1Z
	AaK3fhVe5hMdOecw/vzUKc1zcn4EHU7HYsZz48sE8NJbQpf59BqLeOmwbeKRL2KtLL/s1JnEbpe
	Za45Q7r+i75vCOt10N9t/7Zhscsd8tFNG7zJmSe99V/Lx2DEixx4QKyY0esIaLsDYaU0iyHckyR
	ZmXpFNiQnbF5AZQdOsAsUso1NSFT/3safsNETOZOy//fF24=
X-Google-Smtp-Source: AGHT+IFcD6y0zoNmCI6iuafzIQCJbBa2vybewNuTIc8dxrnc0nfOB4ktN/T54yOqElWNf8NH1BsiGQ==
X-Received: by 2002:a05:600c:6b09:b0:43c:f680:5c2e with SMTP id 5b1f17b1804b1-43d180cef19mr62732545e9.13.1741945485371;
        Fri, 14 Mar 2025 02:44:45 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975b34sm5035685f8f.55.2025.03.14.02.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:44:44 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:44:43 +0100
From: Petr Mladek <pmladek@suse.com>
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v10 1/1] printk: Add an option to allow ttynull to be a
 default console device
Message-ID: <Z9P6i1Caw9SWEO6t@pathway.suse.cz>
References: <20250314004104.3103656-1-adamsimonelli@gmail.com>
 <20250314004104.3103656-2-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314004104.3103656-2-adamsimonelli@gmail.com>

On Thu 2025-03-13 20:41:04, adamsimonelli@gmail.com wrote:
> From: Adam Simonelli <adamsimonelli@gmail.com>
> 
> The new option is CONFIG_NULL_TTY_DEFAULT_CONSOLE.
> 
> if enabled, and CONFIG_VT is disabled, ttynull will become the default
> primary console device, based on the link order.

The result is not longer based on the link order.

The linking order affected the ordering the console initcalls.
But this patch calls add_preferred_console() directly in console_init()
before processing the init calls...

I would just remove the ", based on the link order".

> ttynull will be the only console device usually with this option enabled.
> Some architectures do call add_preferred_console() which may add another
> console though.

I would add here the following line:

Motivation:

to clearly separate the description of the new behavior from the motivation.

> Many distributions ship with CONFIG_VT enabled. On tested desktop hardware
> if CONFIG_VT is disabled, the default console device falls back to
> /dev/ttyS0 instead of /dev/tty.
> 
> This could cause issues in user space, and hardware problems:
> 
> 1. The user space issues include the case where  /dev/ttyS0 is
> disconnected, and the TCGETS ioctl, which some user space libraries use
> as a probe to determine if a file is a tty, is called on /dev/console and
> fails. Programs that call isatty() on /dev/console and get an incorrect
> false value may skip expected logging to /dev/console.
> 
> 2. The hardware issues include the case if a user has a science instrument
> or other device connected to the /dev/ttyS0 port, and they were to upgrade
> to a kernel that is disabling the CONFIG_VT option, kernel logs will then be
> sent to the device connected to /dev/ttyS0 unless they edit their kernel
> command line manually.
> 
> The new CONFIG_NULL_TTY_DEFAULT_CONSOLE option will give users and
> distribution maintainers an option to avoid this. Disabling CONFIG_VT and
> enabling CONFIG_NULL_TTY_DEFAULT_CONSOLE will ensure the default kernel
> console behavior is not dependant on hardware configuration by default, and

s/dependant/dependent/

> avoid unexpected new behavior on devices connected to the /dev/ttyS0 serial
> port.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 07668433644b..9dd807717cd4 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -4277,6 +4277,11 @@ void __init console_init(void)
>  	initcall_t call;
>  	initcall_entry_t *ce;
>  
> +#ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
> +       if (!console_set_on_cmdline)
> +               add_preferred_console("ttynull", 0, NULL);

checkpatch.pl reports that there are used spaces instead of
tabs in the two lines above. I suggest to use some editor which takes
care of proper indentation, e.g. emacs or vim and run
./scripts/checkpatch.pl before sending pathes ;-)

> +#endif
> +
>  	/* Setup the default TTY line discipline. */
>  	n_tty_init();

With the above changes:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

There is no need to resend this patch unless there are other comments.
I could make the changes when committing the patch.

Best Regards,
Petr
