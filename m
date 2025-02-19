Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789171EDA3C;
	Wed, 19 Feb 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973611; cv=none; b=j1gsY6cWejYJ0ky94blXMReXnZX6d2nbktbkDlogxTumKF7Dt1jE2XrlezTBNSUereYDQo72Y3Bp6+m6qMzIUSMo+v+rdUH/jHprjinMqBJKstxnZMG+rkr1pIf2Z8lCBuLeP4EfTTw5wBshMLHRk/au2LHmlz9ii7/ZLk0DMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973611; c=relaxed/simple;
	bh=EY09SFdHtRPeZXAlbD6hFzotyh8FFxTZ+cq5uNKGjmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMMcfHdkiZBGq+I/W+rjCGbrqKNne8u+tJKGEo1HkHHpaPgrQPuEAOreRR/8zfU+3hTSRzdmpEu35qOh9xov/EWOuae6R5ORH2Nl3KL8j/95SvirXhZVwJu9bVWg8d8A1jgRrQglM1ZbXOLzVknJd3qQWdcsw8xg6f5fhTydcAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f7vKqKd9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f7vKqKd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810B6C4CED1;
	Wed, 19 Feb 2025 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739973609;
	bh=EY09SFdHtRPeZXAlbD6hFzotyh8FFxTZ+cq5uNKGjmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7vKqKd9crmk6J/X1lgZNe9GrTEwfUdDsSd+YEISVB3HlKRbmwWWmm6uJmYXdSWZK
	 CTBvqoNYHBhQSWhFQW2uWqiHc904G50ret2XU742tpzFVY+9sl02fLMMPJNj2aFrPP
	 8W+clV9WLQQV3Jfqd/8LLEr9aPAXiiSPH9sYptA4=
Date: Wed, 19 Feb 2025 15:00:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/2] ttynull: Add an option to allow ttynull to be
 used as a console device
Message-ID: <2025021920-uproot-antsy-e2c7@gregkh>
References: <20250217040748.2017975-1-adamsimonelli@gmail.com>
 <20250217040748.2017975-2-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217040748.2017975-2-adamsimonelli@gmail.com>

On Sun, Feb 16, 2025 at 11:07:47PM -0500, adamsimonelli@gmail.com wrote:
> From: Adam Simonelli <adamsimonelli@gmail.com>
> 
> Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
> initialized by console_initcall() and selected as a possible console
> device.
> 
> Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
> ---
>  drivers/tty/Kconfig   | 18 +++++++++++++++++-
>  drivers/tty/ttynull.c | 16 +++++++++++++++-
>  2 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index 63a494d36a1f..afe4e7722d4c 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -383,7 +383,23 @@ config NULL_TTY
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
> +        bool "Supports /dev/ttynull as a console automatically"
> +        depends on NULL_TTY=y && !VT_CONSOLE
> +	help
> +	  Say Y here if you want the NULL TTY to be used as a /dev/console
> +	  device.
> +
> +	  This is useful for userspace applications that expect a working
> +	  console device, without changing the kernel boot options, such as a
> +	  distribuition or environment that historically had CONFIG_VT_CONSOLE
> +	  enabled, and have now disabled it, but still need /dev/console to be
> +	  working for userspace applications.
>  
>  	  If unsure, say N.
>  
> diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> index 6b2f7208b564..8ba629ae426b 100644
> --- a/drivers/tty/ttynull.c
> +++ b/drivers/tty/ttynull.c
> @@ -57,6 +57,10 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
>  static struct console ttynull_console = {
>  	.name = "ttynull",
>  	.device = ttynull_device,
> +#ifdef CONFIG_NULL_TTY_CONSOLE
> +	.index = -1,
> +	.flags = CON_PRINTBUFFER,
> +#endif

There's no way to do this without #ifdef in the .c files?

>  };
>  
>  static int __init ttynull_init(void)
> @@ -90,10 +94,20 @@ static int __init ttynull_init(void)
>  	}
>  
>  	ttynull_driver = driver;
> -	register_console(&ttynull_console);
> +	if (!console_is_registered(&ttynull_console))
> +		register_console(&ttynull_console);
> +

Why do you register this twice?

> +	return 0;
> +}
>  
> +#ifdef CONFIG_NULL_TTY_CONSOLE
> +static int __init ttynull_register(void)
> +{
> +	register_console(&ttynull_console);

Here, why is this registered again?

You should only have to do this once, and not need to check before
trying again, right?

thanks,

greg k-h
