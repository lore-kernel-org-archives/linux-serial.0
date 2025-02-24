Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750984414;
	Mon, 24 Feb 2025 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740381792; cv=none; b=Ef4O1N4MyHiBGzKL0gQrHHOhmhqxH2F7zHviTHSIMBM65+lBnqn68ex4uUWQC+rcw9CPBm2YlqlYCDKry6ajNGeDaZ8FqU6g6Dd2GOLvozarR5DaJHzIuNZp+nXrQsmCvlXAPsWxUfHcISpojIe5QXxh0nOFTTK4OxAw0ARRPZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740381792; c=relaxed/simple;
	bh=+EWaupg0d1Pte3v7FOuZSIlbDDH5RojNM3LDm1F5cMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuJ8K//qEkcMjeYyp5uONaczlX0vHuxaYlXVey9F6F1lm45scIEb9BXl8RMJDQPcLVMDjVImJeZeFWgqvD7rnWmJ7XMhYmJs48BTkbygk2IU49jhLSXksVS1+nb4A218pp9ZvuMQDlA9OZSo7LGzT8yygu3i4KKXpNjE9/INpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fBl8Jj6L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fBl8Jj6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97D8C4CED6;
	Mon, 24 Feb 2025 07:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740381792;
	bh=+EWaupg0d1Pte3v7FOuZSIlbDDH5RojNM3LDm1F5cMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBl8Jj6LUFwHqvw6djbWYuWfXWPw3yQ90Su9J2HvUOINU7Ao6JzFW58lfFB+94NO9
	 3KUN5hUPiwZobdKfVBKWZvihnfSpJjOAnBGRWc5HU7ykQKiBIQ08mHcDsm6f4EhLYQ
	 VPcfHxOrXgHnhQVL99+Gfa5taiGDWDAYcqtMvBkQ=
Date: Mon, 24 Feb 2025 08:23:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v4 2/2] tty: Change order of ttynull to be linked sooner
 if enabled as a console.
Message-ID: <2025022421-refract-defame-94db@gregkh>
References: <20250223204456.1913392-1-adamsimonelli@gmail.com>
 <20250223204456.1913392-3-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223204456.1913392-3-adamsimonelli@gmail.com>

On Sun, Feb 23, 2025 at 03:44:56PM -0500, adamsimonelli@gmail.com wrote:
> From: Adam Simonelli <adamsimonelli@gmail.com>
> 
> If CONFIG_NULL_TTY_CONSOLE is enabled, and CONFIG_VT is disabled, ttynull
> will become the default primary console device, based on the link order.
> 
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
> false value may skip expected logging to /dev/console
> 
> 2. The hardware issues include the case if a user has a science instrument
> or other device connected to the /dev/ttyS0 port, and they were to upgrade
> to a kernel that is disabling the CONFIG_VT option, kernel logs will then be
> sent to the device connected to /dev/ttyS0 unless they edit their kernel
> command line manually.
> 
> The new CONFIG_NULL_TTY_CONSOLE option will give users and distribution
> maintainers an option to avoid this. Disabling CONFIG_VT and enabling
> CONFIG_NULL_TTY_CONSOLE will ensure the default kernel console behavior
> is not dependant on hardware configuration by default, and avoid
> unexpected new behavior on devices connected to the /dev/ttyS0 serial
> port.
> 
> Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
> ---
>  drivers/tty/Makefile | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> index 07aca5184a55..1a1051ecb1af 100644
> --- a/drivers/tty/Makefile
> +++ b/drivers/tty/Makefile
> @@ -11,6 +11,10 @@ obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
>  obj-$(CONFIG_N_GSM)		+= n_gsm.o
>  
>  obj-y				+= vt/
> +#If ttynull is configured to be a console by default, ensure that it is linked
> +#earlier before a real one is selected.
> +obj-$(CONFIG_NULL_TTY_CONSOLE)	+= ttynull.o
> +
>  obj-$(CONFIG_HVC_DRIVER)	+= hvc/
>  obj-y				+= serial/
>  obj-$(CONFIG_SERIAL_DEV_BUS)	+= serdev/
> @@ -20,7 +24,13 @@ obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
>  obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
>  obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
>  obj-$(CONFIG_NOZOMI)		+= nozomi.o
> +
> +#If ttynull is enabled, but not as a boot console, it is linked and used later
> +#after the real ones.
> +ifneq ($(CONFIG_NULL_TTY_CONSOLE),y)
>  obj-$(CONFIG_NULL_TTY)	        += ttynull.o
> +endif

Nit, a " " needs to be after the "#" character, right?

And ick, this is going to be tricky, changing the link order depending
on the configuration option setting?  This feels wrong, and messy, and
very fragile.

thanks,

greg k-h
