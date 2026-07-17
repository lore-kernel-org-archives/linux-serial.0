Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A663C0607;
	Fri, 17 Jul 2026 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784272951; cv=none; b=cZbwmcb5mXQ5q2HFQHOCTn81j56AHgM+V7RqwbzygMwFxFIvdDCwNutRH6smTP5Cnu2H+ChWMgZnCERYwW1ABktK1BBtTdJ4lPQGSJ4F6lKj7PnwztAFrmkaSqBopMcYZvICj6/4ye+MOWLpLayk2KETY44+sYye31zTaj/g++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784272951; c=relaxed/simple;
	bh=4GjXoFYM5PMm+XQgNoGcFSHsyQM5mxzd8NnRwBQJmyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbJRRMfgi8UVonua3qGlxe0h5VSmDk8rE0xqD1UjPRYESGfpDcLaQXJlhlgYkY4jUi96fImnpCceviknU0u9WVzwsHKUCGWlVDEQGWjB5nhNc1yiOIpgHMmRlr9MsVtTA6OPMQ4/BiDr//+2UqxIIrIUlPmtFs8bjLGXGhyGLEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cz4qSHMM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cz4qSHMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CBF1F000E9;
	Fri, 17 Jul 2026 07:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784272945;
	bh=Km263qZK4J7sOQ977i1zY53C0oTm2Ho27YGewEty1VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cz4qSHMMA9iPND5tsyFM2ZRoInQyJKYf+cawBYTTN0ghpb+aO6q+CmeWlvIxgNAhF
	 BLQ/aENvu/issUhBwiCXhSiNEOgGRrw29drppsJ1+HlehlJQMcdQQvRFH5pdK3tMv/
	 V6c3p4mn9wwNTmu66/m8/R6sUkO/X0l9olkEAd8Y=
Date: Fri, 17 Jul 2026 09:22:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Nicolas Pitre <nico@fluxnic.net>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64
Message-ID: <2026071743-number-headfirst-bcca@gregkh>
References: <20260717071616.91423-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717071616.91423-1-kmehltretter@gmail.com>

On Fri, Jul 17, 2026 at 09:16:16AM +0200, Karl Mehltretter wrote:
> hvc_dcc drives the JTAG DCC via the ARMv6/v7 CP14 debug registers
> (mrc/mcr p14, 0, rX, c0, c1/c5, 0 in asm/dcc.h). That encoding is
> undefined on older ARM cores, and also on ARMv7-M, but HVC_DCC only
> depends on ARM, so it can be enabled on e.g. ARM926 (ARCH_MULTI_V5),
> where hvc_dcc_console_init() runs __dcc_putchar() at boot and takes an
> undefined-instruction trap before the console is up:
> 
>   Internal error: Oops - undefined instruction: 0 [#1] ARM
>   PC is at hvc_dcc_check+0x50/0x8c
>    hvc_dcc_check from hvc_dcc_console_init+0x18/0x48
>    hvc_dcc_console_init from console_init+0x58/0x170
>   Kernel panic - not syncing: Fatal exception
> 
> Restrict HVC_DCC to the CPUs where that encoding is valid: the
> CPU_V6 || CPU_V6K || CPU_V7 set that arch/arm/include/debug/icedcc.S
> guards it with, plus ARM64.
> 
> Fixes: 16c63f8ea49c ("drivers: char: hvc: add arm JTAG DCC console support")
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/tty/hvc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> index c2a4e88b328f..5866195de26a 100644
> --- a/drivers/tty/hvc/Kconfig
> +++ b/drivers/tty/hvc/Kconfig
> @@ -79,7 +79,7 @@ config HVC_UDBG
>  
>  config HVC_DCC
>  	bool "ARM JTAG DCC console"
> -	depends on ARM || ARM64
> +	depends on (ARM && (CPU_V6 || CPU_V6K || CPU_V7)) || ARM64

What about testing builds?

thanks,

greg k-h
