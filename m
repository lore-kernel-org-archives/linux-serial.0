Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B428126C3B0;
	Mon, 25 May 2026 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779731025; cv=none; b=R9ZhRgmVY4l3cXktjjCneFD2ESEaCaN3b8uuFYZ7PF1n2wiWIdmkxXONTLm9cdclwQtTBTCFkFGodrFItJ3uYro6E42amBkezgtp8m8fGYkmXmoCRiwbmt6EJw8+zDopJtWS6wnIhqwqgxb8Rnrx7vHIolHIKqlXzCIuttMa/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779731025; c=relaxed/simple;
	bh=wyuLldObIe7j86uN9+nM7oAYqM0hr0zn36O/h7Rfo9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJHXxkePVO+/up+j9YTZqXQVXCy9vpFDRg18XefpV2fAz2DeO/dsnEe0eX2iEKkExNKxJE4u5KW7gSSwBHTA0L7f7MDwdG630EzsN5V+te8dYYGCEmw3idLBuYnVWcnoxsiK99R80EnqRL5NE90vkQs0KOHvEjdKUbZmNgebMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EyxydJ3v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EyxydJ3v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=J6kheHhVe+3yc05oiwS6l9oclvT5+WX7gJAAx+9BArM=; b=EyxydJ3vK2i9gr4FIlCepu1xst
	GtQBCcRLCgiGawol99+DsmixUQbU2llRk2UtzOF/OQmknpWyWcGKrV1PDCjry3M818G2WYor0ZRgk
	jcnWXrb9wC4SDIK2RbRifPmirdpCRfbvJDZRvvCU0AhMOUP/CnzuaBKKLeJvdM8SEWJW4RA6UM8dN
	3UznH2KBbFhYZDYw5+hBf+lvyIxfpFlYnCG/fBjWUpIi18V4DPVp8qkHfIfx4FirrkfFLXkbD7d3Q
	M1PBCpdSJJodlPYpqaljVAlkbN+ol+Y3iVdsLgqhQGaHxZhllGrY40nUeEv2+0KyjadxSdbVeaqKr
	D6Q9QE3w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRZL3-000000009vA-2GKN;
	Mon, 25 May 2026 17:43:41 +0000
Message-ID: <48b0e694-e75c-4d0a-8698-b0848ccaefeb@infradead.org>
Date: Mon, 25 May 2026 10:43:40 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] serial: max310x: fix compile errors if
 CONFIG_SPI_MASTER is disabled
To: Hugo Villeneuve <hugo@hugovil.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20260521153333.2336642-1-hugo@hugovil.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260521153333.2336642-1-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/21/26 8:33 AM, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Since commit 20ffe4b3330a8 ("serial: max310x: allow driver to be built with
> SPI or I2C"), if I2C is enabled and SPI_MASTER is disabled, we have these
> compile errors:
> 
>   drivers/tty/serial/max310x.c: In function 'max310x_uart_init':
>   drivers/tty/serial/max310x.c: error: 'max310x_spi_driver' undeclared...
>   drivers/tty/serial/max310x.c: In function ‘max310x_uart_init’:
>   drivers/tty/serial/max310x.c: error: label ‘err_spi_register’
>   defined but not used...
>   drivers/tty/serial/max310x.c: error: ‘regcfg’ defined but not used
> 
> Fix by properly encapsulating i2c/spi code/variables in their respective
> context with IS_ENABLED() macros for CONFIG_I2C and CONFIG_SPI_MASTER.
> 
> Also fix link failure with SERIAL_MAX310X=y and I2C=m by modifying Kconfig
> depends.
> 
> Fixes: 20ffe4b3330a8 ("serial: max310x: allow driver to be built with SPI or I2C")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605121847.N9DVLNg2-lkp@intel.com/
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
> note: not Cc-ing stable as the commit is still in tty-next, and even if the
> errors originate from original commit that added I2C support, they were not
> trigerred because the driver could not be selected/compiled if
> CONFIG_SPI_MASTER was disabled.
> 
> Changes for v3:
> - Fix link failure with SERIAL_MAX310X=y and I2C=m (Arnd Bergmann)
> 
> Changes for v2:
> - replace #ifdef with #if IS_ENABLED() to suppoirt both built-in and modules
>   options
> ---
>  drivers/tty/serial/Kconfig   |  2 +-
>  drivers/tty/serial/max310x.c | 48 +++++++++++++++++++-----------------
>  2 files changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index f834e5d292fd7..4accbfa75074c 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -321,7 +321,7 @@ config SERIAL_MAX3100
>  
>  config SERIAL_MAX310X
>  	tristate "MAX310X support"
> -	depends on SPI_MASTER || I2C
> +	depends on (SPI_MASTER && !I2C) || I2C
>  	select SERIAL_CORE
>  	select REGMAP_SPI if SPI_MASTER
>  	select REGMAP_I2C if I2C

Other than preferring Arnd's Kconfig dependencies (easier to
read/understand IMO), this is all good.
Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

-- 
~Randy
