Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4E53DC87A;
	Mon, 29 Jun 2026 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754802; cv=none; b=XW6usXvGXIXrlIOyGFI/xiw/IfNw6ovNMYJFTnePi/v1Wbr7qgVO2Q3krqK4ALVjblc93LRWGeroLw+Zzz2eO54YwB+uGffZoLA46BrdVbae4gsCp4oSwfJ4Bc9aYZl2p0GBL/ATu9RDSMJdkAg2DD76EGV6ZNWvjkoy7eXQKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754802; c=relaxed/simple;
	bh=t/aGxPjf/yxck7dxs7ciEjw4oVBgeDJj1ki9pJvPjRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esdqKgHMw9FXF1xPA7FLUhYvP9XWpK0Gqedq3quPWV6q0sGilSTSlfMVGzAC5LNRJTT3i8y0p6HYRXWSlyYQvb5vT2NSh0NAVeyF0dENtE1w8FhHXU2c7cEJWOrGRqHH7PoeGYk2T0boc1d4eZN9niI/haK2czNBY29RdE9Hpfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1weFd2-0005iR-00; Mon, 29 Jun 2026 19:18:40 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 0B423C00E8; Mon, 29 Jun 2026 19:12:02 +0200 (CEST)
Date: Mon, 29 Jun 2026 19:12:02 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-mips@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 10/10] MIPS: DEC: Ensure RTC platform device
 deregistration upon failure
Message-ID: <akKnYgr_oc67Tttp@alpha.franken.de>
References: <alpine.DEB.2.21.2605062240290.46195@angie.orcam.me.uk>
 <alpine.DEB.2.21.2605062333190.46195@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2605062333190.46195@angie.orcam.me.uk>

On Wed, May 06, 2026 at 11:43:00PM +0100, Maciej W. Rozycki wrote:
> Switch RTC platform device registration from platform_device_register() 
> to platform_add_devices() so as to make sure any failure will result in 
> automatic device unregistration.
> 
> Fixes: fae67ad43114 ("arch/mips/dec: switch DECstation systems to rtc-cmos")
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> Change from v2,
> <https://lore.kernel.org/r/alpine.DEB.2.21.2605012105320.11074@angie.orcam.me.uk/>:
> 
> - Fix a minor style issue in the commit description.
> 
> No change from v1 (8/8),
> <https://lore.kernel.org/r/alpine.DEB.2.21.2604110042130.29980@angie.orcam.me.uk/>.
> ---
>  arch/mips/dec/platform.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> linux-mips-dec-platform-rtc-unregister.diff
> Index: linux-macro/arch/mips/dec/platform.c
> ===================================================================
> --- linux-macro.orig/arch/mips/dec/platform.c
> +++ linux-macro/arch/mips/dec/platform.c
> @@ -38,6 +38,10 @@ static struct platform_device dec_rtc_de
>  	.num_resources = ARRAY_SIZE(dec_rtc_resources),
>  };
>  
> +static struct platform_device *dec_rtc_devices[] __initdata = {
> +	&dec_rtc_device,
> +};
> +
>  static struct resource dec_dz_resources[] = {
>  	{ .name = "dz", .flags = IORESOURCE_MEM, },
>  	{ .name = "dz", .flags = IORESOURCE_IRQ, },
> @@ -137,7 +141,7 @@ static int __init dec_add_devices(void)
>  	}
>  	num_zs = i;
>  
> -	ret1 = platform_device_register(&dec_rtc_device);
> +	ret1 = platform_add_devices(dec_rtc_devices, 1);
>  	ret2 = IS_ENABLED(CONFIG_32BIT) ?
>  	       platform_add_devices(dec_dz_devices, num_dz) : 0;
>  	ret3 = platform_add_devices(dec_zs_devices, num_zs);

applied to mips-fixes

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
