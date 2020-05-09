Return-Path: <SRS0=wdWf=6X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D11C28CBC
	for <linux-serial@archiver.kernel.org>; Sat,  9 May 2020 12:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F672208CA
	for <linux-serial@archiver.kernel.org>; Sat,  9 May 2020 12:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgEIMmO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 9 May 2020 08:42:14 -0400
Received: from fieber.vanmierlo.com ([84.243.197.177]:35951 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbgEIMmN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 9 May 2020 08:42:13 -0400
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.2.12 patch 1) with ESMTPA;
        Sat, 9 May 2020 14:41:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 09 May 2020 14:41:38 +0200
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Daniel Mack <daniel@zonque.org>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        pascal.huerst@gmail.com, linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH 3/4] sc16is7xx: Always use falling edge IRQ
In-Reply-To: <20200508143757.2609740-4-daniel@zonque.org>
References: <20200508143757.2609740-1-daniel@zonque.org>
 <20200508143757.2609740-4-daniel@zonque.org>
Message-ID: <d36a13cdeafd5fe35f662644b1c285c0@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-05-08 16:37, Daniel Mack wrote:
> The driver currently only uses IRQF_TRIGGER_FALLING if the probing
> happened without a device-tree setup. The device however will always
> generate falling edges on its IRQ line, so let's use that flag in
> all cases.

Would it not be wise to also select IRQF_SHARED?

Which leads me to a more generic question: Is there a general method to 
tell
in the device tree that an interrupt line is shared?

> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  drivers/tty/serial/sc16is7xx.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c 
> b/drivers/tty/serial/sc16is7xx.c
> index e4025b8566a4..0997a5cac02a 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1185,7 +1185,7 @@ static int
> sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
> 
>  static int sc16is7xx_probe(struct device *dev,
>  			   const struct sc16is7xx_devtype *devtype,
> -			   struct regmap *regmap, int irq, unsigned long flags)
> +			   struct regmap *regmap, int irq)
>  {
>  	struct sched_param sched_param = { .sched_priority = MAX_RT_PRIO / 2 
> };
>  	unsigned long freq = 0, *pfreq = dev_get_platdata(dev);
> @@ -1318,7 +1318,7 @@ static int sc16is7xx_probe(struct device *dev,
> 
>  	/* Setup interrupt */
>  	ret = devm_request_irq(dev, irq, sc16is7xx_irq,
> -			       flags, dev_name(dev), s);
> +			       IRQF_TRIGGER_FALLING, dev_name(dev), s);
>  	if (!ret)
>  		return 0;
> 
> @@ -1392,7 +1392,6 @@ static struct regmap_config regcfg = {
>  static int sc16is7xx_spi_probe(struct spi_device *spi)
>  {
>  	const struct sc16is7xx_devtype *devtype;
> -	unsigned long flags = 0;
>  	struct regmap *regmap;
>  	int ret;
> 
> @@ -1413,14 +1412,13 @@ static int sc16is7xx_spi_probe(struct 
> spi_device *spi)
>  		const struct spi_device_id *id_entry = spi_get_device_id(spi);
> 
>  		devtype = (struct sc16is7xx_devtype *)id_entry->driver_data;
> -		flags = IRQF_TRIGGER_FALLING;
>  	}
> 
>  	regcfg.max_register = (0xf << SC16IS7XX_REG_SHIFT) |
>  			      (devtype->nr_uart - 1);
>  	regmap = devm_regmap_init_spi(spi, &regcfg);
> 
> -	return sc16is7xx_probe(&spi->dev, devtype, regmap, spi->irq, flags);
> +	return sc16is7xx_probe(&spi->dev, devtype, regmap, spi->irq);
>  }
> 
>  static int sc16is7xx_spi_remove(struct spi_device *spi)
> @@ -1459,7 +1457,6 @@ static int sc16is7xx_i2c_probe(struct i2c_client 
> *i2c,
>  			       const struct i2c_device_id *id)
>  {
>  	const struct sc16is7xx_devtype *devtype;
> -	unsigned long flags = 0;
>  	struct regmap *regmap;
> 
>  	if (i2c->dev.of_node) {
> @@ -1468,14 +1465,13 @@ static int sc16is7xx_i2c_probe(struct 
> i2c_client *i2c,
>  			return -ENODEV;
>  	} else {
>  		devtype = (struct sc16is7xx_devtype *)id->driver_data;
> -		flags = IRQF_TRIGGER_FALLING;
>  	}
> 
>  	regcfg.max_register = (0xf << SC16IS7XX_REG_SHIFT) |
>  			      (devtype->nr_uart - 1);
>  	regmap = devm_regmap_init_i2c(i2c, &regcfg);
> 
> -	return sc16is7xx_probe(&i2c->dev, devtype, regmap, i2c->irq, flags);
> +	return sc16is7xx_probe(&i2c->dev, devtype, regmap, i2c->irq);
>  }
> 
>  static int sc16is7xx_i2c_remove(struct i2c_client *client)

