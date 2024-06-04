Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B51350FD;
	Tue,  4 Jun 2024 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511030; cv=none; b=VIhJXQ8HyPySg3JVaj9wMTtYsZ/wkTBSvdCkmJTonGwZoDIyFEBchOAnMw2Qq8pUmzDFLT0b0uqdMbUgZSbVC6QIYeUKQBwcu1FpaV0uw+7P718mezqsg7eExpOgRNpisQtE9Y5PMK5EQddJ2Y/8DgFlnz73W8s59k6ZdorTZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511030; c=relaxed/simple;
	bh=pCQY+N6l4H18wxaw5gxmOhVyJDkVn+Ebkn9kvwlJUs4=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=nGUG4mY7fnYmXfzGEQLg4vtOaPkn71JIqZbsrRZajPXfV2OWclTniS+kyGuEF3U7pDA8+800ZiYZIZeM5YOyQ5v/a5sVxrpyRUlXo5ejwpZyc3mIavzCWINYJ19/P4JDrcZ3aToPxEJ3LDL066fkyqWv/kT3/Daes2tQpEAvVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=B51ss2se; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="B51ss2se"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=FmX0YSshk1XRwqALGyf3/5Mk84vKqfV3CkydSmmClhc=; b=B51ss2seQgH3Ofby5e4Gm/S2qk
	mIv5B9/kYJODDzGVzTojm72qxrZrxvu+54a7kSb1Kcd4xV5+fxdR0f51Z5u+SwcwIIJbggazruG++
	c+oRumZVGkViGW8ilH80PcEFDbH1lpVzk+qv4zzU92s0PzToEe/LCSOn0Fv/SeNbdI20=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:42510 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sEV4e-0005J5-4K; Tue, 04 Jun 2024 10:23:40 -0400
Date: Tue, 4 Jun 2024 10:23:23 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 lech.perczak@camlingroup.com
Message-Id: <20240604102323.b2a305fa03161df3c2eec16c@hugovil.com>
In-Reply-To: <20240604132726.1272475-2-hui.wang@canonical.com>
References: <20240604132726.1272475-1-hui.wang@canonical.com>
	<20240604132726.1272475-2-hui.wang@canonical.com>
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
Subject: Re: [PATCH v2 2/2] serial: sc16is7xx: hard reset the chip if
 reset-gpios is defined in dt
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue,  4 Jun 2024 21:27:26 +0800
Hui Wang <hui.wang@canonical.com> wrote:

Hi Hui,

> Certain designs connect a gpio to the reset pin, and the reset pin
> needs to be setup correctly before accessing the chip.
> 
> Here adding a function to handle the chip reset. If the reset-gpios is
> defined in the dt, do the hard reset through this gpio, othwerwise do
> the soft reset as before.
> 
> Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

I never gave you permission to add this tag, remove it. Make sure you
fully understand the meaning of tags by reading patches submission
guidelines.


> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> In the v2:
>  - move the soft reset and hard reset into one fucntion
>  - move the reset function to sc16is7xx.c and call it in _probe()
>  - add udelay(5) before deasserting the gpio reset pin
> 
>  drivers/tty/serial/sc16is7xx.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index bf0065d1c8e9..119abfb4607c 100644
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
> @@ -1467,6 +1468,25 @@ static const struct serial_rs485 sc16is7xx_rs485_supported = {
>  	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
>  };
>  

Add function description from original comment "Reset device,
purging any pending irq / data", since the comment applies to both
hardware and software reset,

> +static int sc16is7xx_reset(struct device *dev, struct regmap *regmaps[])

Simply pass "struct regmap *regmap" as the second argument. See
sc16is7xx_setup_mctrl_ports() for example.

> +{
> +	struct gpio_desc *reset_gpiod;

reset_gpiod -> reset_gpio

> +
> +	reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (!reset_gpiod)

Follow Andy's suggestion here.

> +		/* soft reset device, purging any pending irq / data */

"Software reset".

> +		regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
> +			     SC16IS7XX_IOCONTROL_SRESET_BIT);
> +	else if (!IS_ERR(reset_gpiod)) {
> +		/* delay 5 us (at least 3 us) and deassert the gpio to exit the hard reset */

You can omit the "delay 5 us" since it is obvious from the code. Maybe
add that "The minimum reset pulse width is 3 us" as stated in the
datasheet.

As a general note for your comments: capitalize the first letter,
ex: "Deassert GPIO" and not "deassert GPIO".


> +		udelay(5);
> +		gpiod_set_value_cansleep(reset_gpiod, 0);

Move the comment "deassert the gpio to exit the hard reset" here. You
could also simplify it as "Deassert GPIO.".


> +	} else
> +		return PTR_ERR(reset_gpiod);

return dev_err_probe(dev, PTR_ERR(reset_gpiod), "Failed to get reset
GPIO\n");

> +
> +	return 0;
> +}
> +
>  int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  		    struct regmap *regmaps[], int irq)
>  {
> @@ -1527,6 +1547,10 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  	s->devtype = devtype;
>  	dev_set_drvdata(dev, s);
>  
> +	ret = sc16is7xx_reset(dev, regmaps);
> +	if (ret)
> +		goto out_clk;
> +
>  	kthread_init_worker(&s->kworker);
>  	s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
>  				      "sc16is7xx");
> @@ -1536,10 +1560,6 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
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
> 
> 
> 


-- 
Hugo Villeneuve
