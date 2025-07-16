Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE071531E8;
	Wed, 16 Jul 2025 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693422; cv=none; b=dfrmZTHhjvXSxe63j0cDdYdfCoenZxSUwns1W/FTxdiZ2/+GUADItELq6oxsbotEFd5uq0YeAXmcXW6eNo2lDN90EmibSwJdclDs1ri4tr3oRaspjHHk9BLSGK4m5JOV9V1GQflzf1X3S2NygHrMKJpTomKj5AuzZudE712gJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693422; c=relaxed/simple;
	bh=Hzb1t+TmWWOfLRa8+ziWIU06vPGMdgiGAmm7vZmrhuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uU8Heq0vp9MCj/5EpOuJrNQBoxEPKrhRSm1Gk0/6Fbkjiog8PghZJW0tndGxreUD3qWXezlEqtpNfQkta2XPW0wMIVdWTBTib/etMCO4EddOBoWjSYDdRY+z3cIvB9yc5V9+n2OwDuPsNupQPPe3Q8/Kkkm8PaOWPFg0kdzaMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MjsRwwgy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MjsRwwgy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ka9LDPdXiKFUk3mtrWNI4vQa1z6M+gCPFWsh9TUXj2s=; b=MjsRwwgy6bAQQceCDNZf6YYTh7
	2s/g3JjKzpCcWSXXC4ou/Jp5CTzwRhOkNRtt5567ZCUDYwALzUue1igWMdOZS0jq53fd5Kreph6ft
	4V55ttQLFba7IML5RhRYlYAbvVdLr83IctycGEfJDJUUhFfFUlnEsmK5Nrrrly57XDe9AJwMd9r74
	Vsb7lEV2texPKlzjXJIUcEMgv47StjvcwXivjZDke5VMxd092F9MMc5gprxJ17KLT6L5bIiojWmw1
	RPaG9K4ZIUX3xmeNMIa3QxKbZJSL+uOI3Lc3/bzkd+vTfp6R+Vt1hzsHmpwNCAiTcXJfoiNioUQUx
	t9pgZHbw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc7ci-00000008Tft-2NOr;
	Wed, 16 Jul 2025 19:17:00 +0000
Message-ID: <1edd39a3-c5ef-41f6-ba7a-57fe24da7376@infradead.org>
Date: Wed, 16 Jul 2025 12:16:59 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] serial: 8250_ce4100: Fix CONFIG_SERIAL_8250=n
 build
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
References: <20250716142412.1667927-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250716142412.1667927-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/25 7:23 AM, Andy Shevchenko wrote:
> On i386, when
> 
>   CONFIG_X86_INTEL_CE=y
>   # CONFIG_SERIAL_8250 is not set
> 
> it will try to compile the driver and use the stub simultaneously.
> This breaks the build. Fix it by making sure that the driver
> compiles only when CONFIG_SERIAL_8250 is also enabled.
> 
> On top of that ensure that CONFIG_SERIAL_8250 is actually set to 'y'
> and not 'm' as the later makes no sense for this platform. The hook
> may only be applied during early boot.
> 
> Fixes: acc902de05b2 ("serial: 8250: Move CE4100 quirks to a module under 8250 driver")
> Fixes: 5ec6960f6f0c ("ce4100: Add errata fixes for UART on CE4100")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/r/cdf4ee46-7bf8-4379-9245-fed9db72e7e8@infradead.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This solution works but it seems quite hidden to me. I would rather see
a Kconfig solution, like Jiri mentioned.

Anyway,
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>


Thanks.

> ---
> 
> v2: made the fix more readable (Jiri)
> 
>  drivers/tty/serial/8250/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index e61dc3f4ca50..513a0941c284 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -24,7 +24,9 @@ obj-$(CONFIG_SERIAL_8250_ASPEED_VUART)	+= 8250_aspeed_vuart.o
>  obj-$(CONFIG_SERIAL_8250_BCM2835AUX)	+= 8250_bcm2835aux.o
>  obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
>  obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
> +ifeq ($(CONFIG_SERIAL_8250),y)
>  obj-$(CONFIG_X86_INTEL_CE)		+= 8250_ce4100.o
> +endif
>  obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
>  obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
>  obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o

-- 
~Randy
