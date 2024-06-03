Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F355F1877;
	Mon,  3 Jun 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422381; cv=none; b=rJck61TIlIYQ7dSo6y0d8vl7eLzt8ZThqUwKVklrbjhUyIjIqdA1ny0Lema2YxOXnoI6bRE9yLocw3qAuAZ3rlnvItXEOSJadcv/4STjTKwyBbsSZYtJKZSS7v7weaQn7qZXX+krIlJ8+uGoRQQEvlVE+Tyuw0uELIhV4CCCfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422381; c=relaxed/simple;
	bh=d4eJmzKz2SNxrPcPd+qatcbZ80D3Ow31WgkU36pFokc=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=lRW4ULSIO6a5FKOe58VEXjHI7X32uXbFcuW1MQO6QMQ/KItkVXjqVDLV4gcWdvCSLoaCceru5fKZNsf7ZRJH/qoOdNitQKySQ8pXiIFupMMva4jjpLQkgrzOZuIqVmUuoHvIejGffxnouO5mEEzmUuoJafpEOMfEZScF1ApW+vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=evTuihQp; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="evTuihQp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=pGQW7Y124egT0UTndX/Fi1ujBEUpNQr3uL1t6F5bA8g=; b=evTuihQpzdJg8Tu7cz5wVn0Lg0
	N2LuNEyfM661tSgJvGQgyM0gPYorWCcjZyzHONXEyyKbRCI2atdy4cKO8QLelrmb4OuDkZrz1FgdJ
	EdVxmrVI0jxkM5xcM20hCNLv/OfEA4sb1Ryg+Ys3hKu0zh63uehlmO/Qx/haIvjkezHU=;
Received: from [184.161.19.61] (port=58820 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sE7TE-0008M2-Dz; Mon, 03 Jun 2024 09:11:28 -0400
Date: Mon, 3 Jun 2024 09:11:12 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com
Message-Id: <20240603091112.d3491b3be00830126580662e@hugovil.com>
In-Reply-To: <20240603123710.649549-2-hui.wang@canonical.com>
References: <20240603123710.649549-1-hui.wang@canonical.com>
	<20240603123710.649549-2-hui.wang@canonical.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -2.5 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 2/2] serial: sc16is7xx: setup reset pin if it is defined
 in device tree
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Mon,  3 Jun 2024 20:37:10 +0800
Hui Wang <hui.wang@canonical.com> wrote:

Hi Hui,

> Certain designs connect a gpio to the reset pin, and the reset pin
> needs to be setup correctly before accessing the chip.
> 
> Here adding a function to handle the reset pin. This change has no
> impact if there is no reset_gpios defined in the device tree.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  drivers/tty/serial/sc16is7xx.c     | 22 ++++++++++++++++++++++
>  drivers/tty/serial/sc16is7xx.h     |  2 ++
>  drivers/tty/serial/sc16is7xx_i2c.c |  2 ++
>  drivers/tty/serial/sc16is7xx_spi.c |  2 ++
>  4 files changed, 28 insertions(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index bf0065d1c8e9..53bfb603b03c 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -19,6 +19,7 @@
>  #include <linux/kthread.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/of_gpio.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/sched.h>
> @@ -1467,6 +1468,27 @@ static const struct serial_rs485 sc16is7xx_rs485_supported = {
>  	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
>  };
>  
> +void sc16is7xx_setup_reset_pin(struct device *dev)

Potentially rename to sc16is7xx_reset() based on my comments below
about software reset.

> +{
> +	struct device_node *np = dev->of_node;
> +	int reset_gpio, err;
> +
> +	reset_gpio = of_get_named_gpio(np, "reset-gpios", 0);

Maybe use devm_gpiod_get_optional() to simplify and avoid OF-specific
code.

> +	if (!gpio_is_valid(reset_gpio))
> +		return;
> +
> +	err = devm_gpio_request_one(dev, reset_gpio, GPIOF_OUT_INIT_LOW,
> +				    "sc16is7xx-reset");
> +	if (err) {
> +		dev_err(dev, "failed to request sc16is7xx-reset-gpios: %d\n", err);
> +		return;

When this error happens, you return no error to the calling function,
why? If you specify a reset GPIO in your device tree, and you cannot use
it, seems like an error worth reporting.

> +	}
> +
> +	/* Deassert the reset pin */

Do you respect the manufacturer's minimum reset pulse width? The
datasheet states that its 3 us, so maybe add a delay before deassertion.

> +	gpio_set_value_cansleep(reset_gpio, 1);
> +}
> +EXPORT_SYMBOL_GPL(sc16is7xx_setup_reset_pin);
> +
>  int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  		    struct regmap *regmaps[], int irq)
>  {
> diff --git a/drivers/tty/serial/sc16is7xx.h b/drivers/tty/serial/sc16is7xx.h
> index afb784eaee45..f4ae114cc41a 100644
> --- a/drivers/tty/serial/sc16is7xx.h
> +++ b/drivers/tty/serial/sc16is7xx.h
> @@ -33,6 +33,8 @@ const char *sc16is7xx_regmap_name(u8 port_id);
>  
>  unsigned int sc16is7xx_regmap_port_mask(unsigned int port_id);
>  
> +void sc16is7xx_setup_reset_pin(struct device *dev);
> +
>  int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  		    struct regmap *regmaps[], int irq);
>  
> diff --git a/drivers/tty/serial/sc16is7xx_i2c.c b/drivers/tty/serial/sc16is7xx_i2c.c
> index 3ed47c306d85..9833c3b935c2 100644
> --- a/drivers/tty/serial/sc16is7xx_i2c.c
> +++ b/drivers/tty/serial/sc16is7xx_i2c.c
> @@ -21,6 +21,8 @@ static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
>  	if (!devtype)
>  		return dev_err_probe(&i2c->dev, -ENODEV, "Failed to match device\n");
>  
> +	sc16is7xx_setup_reset_pin(&i2c->dev);

Move this call inside sc16is7xx_probe() function, since it is common to
both i2c and spi interfaces. Also, you will see in sc16is7xx_probe()
that we already issue a software reset. If you
specify a hardware reset pin, then you shouldn't issue the software
reset.

> +
>  	memcpy(&regcfg, &sc16is7xx_regcfg, sizeof(struct regmap_config));
>  
>  	for (i = 0; i < devtype->nr_uart; i++) {
> diff --git a/drivers/tty/serial/sc16is7xx_spi.c b/drivers/tty/serial/sc16is7xx_spi.c
> index 73df36f8a7fd..ce38561faaf0 100644
> --- a/drivers/tty/serial/sc16is7xx_spi.c
> +++ b/drivers/tty/serial/sc16is7xx_spi.c
> @@ -38,6 +38,8 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
>  	if (!devtype)
>  		return dev_err_probe(&spi->dev, -ENODEV, "Failed to match device\n");
>  
> +	sc16is7xx_setup_reset_pin(&spi->dev);
> +
>  	memcpy(&regcfg, &sc16is7xx_regcfg, sizeof(struct regmap_config));
>  
>  	for (i = 0; i < devtype->nr_uart; i++) {
> -- 
> 2.34.1
> 
> 
> 


-- 
Hugo Villeneuve
