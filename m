Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB2176ACE;
	Wed, 12 Jun 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200257; cv=none; b=K6aE2PSz5EIYsOQlTSwiW1ano+ooR0ZnCzLqO5VAHzZ86F1UqbXWvPOiT/fHOHeazeuTk5GD6uqdF1Hw3zq1n4O7AIpoCVH4RdAUvbDrLQek51VAN5BW3XPaGuPPRyhY5aP5HGnxpYEvpBksGYxNzriVwpZ2uiVM994avmUey7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200257; c=relaxed/simple;
	bh=UC7647RDCtTIWhBFEBcjvrpuMqG1qyvU5D3QlhdgvwY=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=DPpoeUNp+fMd6WUGh9vEkEM+m+rfFxDqaYowHp3e4X11G5KAdWXQ5NoPF3J64HLMSkANhUOrCqT4yl3j8fVPjmndwXul8oQIIpuyXuusfpSMSEOjMPLG8i1SoXqssgQdeZpP6mWxZ6HxXBN03lRDnXTh669/pIx3vC3cM11l3mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=glClZLY2; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="glClZLY2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=VbFDZPH5MzHyCgFyYR92b3OqxCJLflFP20uE8YGsh3Y=; b=glClZLY2JoOOu/KWCg3V69Efut
	VuFG7tYxcl5zuA65qHYSa5o3RxVM29Ar3llHyA1plr5oM2t+4N1yKwF+qMzSdmBl+OVb+gvTNf3se
	fy0KTq0nNMg6e8h+aPusiNs4krGuUBqid6RLOcfTXIRTN7qYqx4CPsqLQawKzZdoa7LY=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:49618 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sHONA-00065E-Ac; Wed, 12 Jun 2024 09:50:45 -0400
Date: Wed, 12 Jun 2024 09:50:23 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 lech.perczak@camlingroup.com, Maarten.Brock@sttls.nl
Message-Id: <20240612095023.946d77e6c30f7ecc4cdad672@hugovil.com>
In-Reply-To: <20240612131454.49671-2-hui.wang@canonical.com>
References: <20240612131454.49671-1-hui.wang@canonical.com>
	<20240612131454.49671-2-hui.wang@canonical.com>
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
	* -1.0 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v3 2/2] serial: sc16is7xx: hardware reset chip if
 reset-gpios is defined in DT
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 12 Jun 2024 21:14:54 +0800
Hui Wang <hui.wang@canonical.com> wrote:

Hi Hui,

> Some boards connect a GPIO to the reset pin, and the reset pin needs
> to be setup correctly before accessing the chip.
> 
> Add a function to handle the chip reset. If the reset-gpios is defined
> in the DT, do hardware reset through this GPIO, othwerwise do software
> reset as before.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> In the v3:
>  - drop Reviewed-by
>  - adjust the sequence of if, else if and else
>  - replace PTR_ERR(reset_gpiod) with dev_err_probe
>  - change GPIOD_OUT_LOW to GPIOD_OUT_HIGH, this will assert the reset pin after requesting the GPIO
>  - change the 2nd parameter struct regmap *regmap[] to struct regmap *regmap
>  - address all spelling and description issues in the v2
>  
>  drivers/tty/serial/sc16is7xx.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index bf0065d1c8e9..8c7e0fe76049 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/idr.h>
>  #include <linux/kthread.h>
> @@ -1467,6 +1468,30 @@ static const struct serial_rs485 sc16is7xx_rs485_supported = {
>  	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
>  };
>  
> +/* Reset device, purging any pending irq / data */
> +static int sc16is7xx_reset(struct device *dev, struct regmap *regmap)
> +{
> +	struct gpio_desc *reset_gpio;
> +
> +	/* The reset GPIO is ACTIVE_LOW, flag GPIOD_OUT_HIGH asserts the reset GPIO */
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(reset_gpio), "Failed to get reset GPIO\n");
> +
> +	if (reset_gpio) {
> +		/* The minimum reset pulse width is 3 us. */
> +		udelay(5);
> +		gpiod_set_value_cansleep(reset_gpio, 0);
> +		/* Deassert GPIO */

Move this comment after its corresponding statement:
    gpiod_set_value_cansleep(reset_gpio, 0); /* Deassert GPIO */


> +	} else {
> +		/* Software reset */
> +		regmap_write(regmap, SC16IS7XX_IOCONTROL_REG,
> +			     SC16IS7XX_IOCONTROL_SRESET_BIT);
> +	}
> +
> +	return 0;
> +}
> +
>  int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  		    struct regmap *regmaps[], int irq)
>  {
> @@ -1527,6 +1552,10 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  	s->devtype = devtype;
>  	dev_set_drvdata(dev, s);
>  
> +	ret = sc16is7xx_reset(dev, regmaps[0]);
> +	if (ret)
> +		goto out_clk;
> +

You could move this block where the original software reset was
located, unless you have a good reason to move it here? This will make
the review (diff) easier...

>  	kthread_init_worker(&s->kworker);
>  	s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
>  				      "sc16is7xx");
> @@ -1536,10 +1565,6 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  	}
>  	sched_set_fifo(s->kworker_task);
>  
> -	/* reset device, purging any pending irq / data */
> -	regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
> -		     SC16IS7XX_IOCONTROL_SRESET_BIT);
> -
>  	/* Mark each port line and status as uninitialised. */
>  	for (i = 0; i < devtype->nr_uart; ++i) {
>  		s->p[i].port.line = SC16IS7XX_MAX_DEVS;
> -- 
> 2.34.1


-- 
Hugo Villeneuve
