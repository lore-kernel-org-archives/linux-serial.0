Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706D346AFD;
	Tue, 19 May 2026 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225290; cv=none; b=EjWkm2i17OMrjLXwk2ubs5R1+b30oGPRUW4VD4MCPHCSvUGfcUG2iJrANwDip6j0YUyKEg2zvDmsrrAD3lTFQBfSKWxkBd+0RBOEVBirxLgUyvg0r+HtbRUfJsE+0P72DQxtFQrPc1G3W/8+jVJCdShVqtF8HVUEpIQRb4NEkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225290; c=relaxed/simple;
	bh=JRIHdnx+MdBMSjwy6X/vJeNbb3OYXEtue8pTAgk508o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a9aNQulH5bq3EKSALvrNk4lkgvPlRwUi47xQrFdD/jr1265NZ5n8/hrpbyice146Pz6JdRxQNOenbnc4dZAlDHs0TNSDIrcIUQLTVvypi0JfyYqrvZfgqlLKl8jLs4drDSJCTS6X2i2fcmvF1mb4izOXhbxWNo5p+aTwSos24Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=AgyxnfGI; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="AgyxnfGI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=9mYgSGYSU0+tpIInPxoflgvUuvAZvN706QNcO0VMNFo=; b=AgyxnfGIBTDm/6M6CNkuk7QE+y
	GnnOYu6h0T01MV5Pu/PuItQeF5bzz835tcaMwIFXcR9sttZqsVBGGWWkf218F04mDLsBqO0AudSpY
	rlwDg5T/DVuZ08jDFiVmAUVlHC0nHOqtyUF0/CSUxnioIArOBHC7NHTbpnRRDmQNEiCU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wPRlu-000000006qU-0qPn;
	Tue, 19 May 2026 17:14:38 -0400
Date: Tue, 19 May 2026 17:14:37 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Arnd
 Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: max310x: fix I2C-only build
Message-Id: <20260519171437.ff11a24d84c9ac8092348baf@hugovil.com>
In-Reply-To: <20260519203506.1341241-1-arnd@kernel.org>
References: <20260519203506.1341241-1-arnd@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Anrnd,

On Tue, 19 May 2026 22:34:25 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Allowing the driver to be built when CONFIG_SPI_MASTER is turned off
> now causes build failures:

A few days ago i sent v2 of a patch to fix this problem:

https://lore.kernel.org/all/20260515183217.3554037-1-hugo@hugovil.com/raw

Did you saw it?


> 
> drivers/tty/serial/max310x.c: In function 'max310x_uart_init':
> drivers/tty/serial/max310x.c:1737:32: error: 'max310x_spi_driver' undeclared (first use in this function); did you mean 'max310x_i2c_driver'?
>  1737 |         spi_unregister_driver(&max310x_spi_driver);
>       |                                ^~~~~~~~~~~~~~~~~~
>       |                                max310x_i2c_driver
> drivers/tty/serial/max310x.c:1737:32: note: each undeclared identifier is reported only once for each function it appears in
> drivers/tty/serial/max310x.c:1740:1: error: label 'err_spi_register' defined but not used [-Werror=unused-label]
>  1740 | err_spi_register:
>       | ^~~~~~~~~~~~~~~~
> drivers/tty/serial/max310x.c: At top level:
> drivers/tty/serial/max310x.c:1502:29: error: 'regcfg' defined but not used [-Werror=unused-variable]
>  1502 | static struct regmap_config regcfg = {
>       |                             ^~~~~~
> 
> While fixing this, I ran into another problem with I2C=m, which
> previously would just not use I2C support.
> 
> Fix the #ifdef checks to handle all combinations correctly, and
> change the Kconfig dependency to ensure that the driver cannot
> be built-in when I2C=m.
> 
> Fixes: 20ffe4b3330a ("serial: max310x: allow driver to be built with SPI or I2C")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/Kconfig   |  1 +
>  drivers/tty/serial/max310x.c | 40 +++++++++++++++++++-----------------
>  2 files changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 811250bbbd39..b9b40e80ea81 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -323,6 +323,7 @@ config SERIAL_MAX3100
>  config SERIAL_MAX310X
>  	tristate "MAX310X support"
>  	depends on SPI_MASTER || I2C
> +	depends on I2C || !I2C
>  	select SERIAL_CORE
>  	select REGMAP_SPI if SPI_MASTER
>  	select REGMAP_I2C if I2C
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 5168490a1cbb..042ae962c1f6 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -1499,6 +1499,20 @@ static const struct of_device_id __maybe_unused max310x_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, max310x_dt_ids);
>  
> +static const char *max310x_regmap_name(u8 port_id)
> +{
> +	switch (port_id) {
> +	case 0:	return "port0";
> +	case 1:	return "port1";
> +	case 2:	return "port2";
> +	case 3:	return "port3";
> +	default:
> +		WARN_ON(true);
> +		return NULL;
> +	}
> +}
> +
> +#ifdef CONFIG_SPI_MASTER
>  static struct regmap_config regcfg = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> @@ -1514,20 +1528,6 @@ static struct regmap_config regcfg = {
>  	.max_raw_write = MAX310X_FIFO_SIZE,
>  };
>  
> -static const char *max310x_regmap_name(u8 port_id)
> -{
> -	switch (port_id) {
> -	case 0:	return "port0";
> -	case 1:	return "port1";
> -	case 2:	return "port2";
> -	case 3:	return "port3";
> -	default:
> -		WARN_ON(true);
> -		return NULL;
> -	}
> -}
> -
> -#ifdef CONFIG_SPI_MASTER
>  static int max310x_spi_extended_reg_enable(struct device *dev, bool enable)
>  {
>  	struct max310x_port *s = dev_get_drvdata(dev);
> @@ -1598,7 +1598,7 @@ static struct spi_driver max310x_spi_driver = {
>  };
>  #endif
>  
> -#ifdef CONFIG_I2C
> +#if IS_ENABLED(CONFIG_I2C)
>  static int max310x_i2c_extended_reg_enable(struct device *dev, bool enable)
>  {
>  	return 0;
> @@ -1724,7 +1724,7 @@ static int __init max310x_uart_init(void)
>  		goto err_spi_register;
>  #endif
>  
> -#ifdef CONFIG_I2C
> +#if IS_ENABLED(CONFIG_I2C)
>  	ret = i2c_add_driver(&max310x_i2c_driver);
>  	if (ret)
>  		goto err_i2c_register;
> @@ -1732,12 +1732,14 @@ static int __init max310x_uart_init(void)
>  
>  	return 0;
>  
> -#ifdef CONFIG_I2C
> +#if IS_ENABLED(CONFIG_I2C)
>  err_i2c_register:
> +#endif
> +#ifdef CONFIG_SPI_MASTER
>  	spi_unregister_driver(&max310x_spi_driver);
> +err_spi_register:
>  #endif
>  
> -err_spi_register:
>  	uart_unregister_driver(&max310x_uart);
>  
>  	return ret;
> @@ -1746,7 +1748,7 @@ module_init(max310x_uart_init);
>  
>  static void __exit max310x_uart_exit(void)
>  {
> -#ifdef CONFIG_I2C
> +#if IS_ENABLED(CONFIG_I2C)
>  	i2c_del_driver(&max310x_i2c_driver);
>  #endif
>  
> -- 
> 2.39.5
> 
> 
> 


-- 
Hugo Villeneuve
