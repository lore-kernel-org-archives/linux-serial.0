Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818BDDC5;
	Mon, 17 Jun 2024 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640254; cv=none; b=h9DHUWH8K9FRLDosCh77FC+lrua8iPkFQEv1uCsr6j48En0v9bpKLDuTG1VwWUCIP7GLXtFmLCH7MMy6DDSJr+YCrYzcyN1102wTwEoXvh/sMV1+AqoWSeR7FIMNLfuswiUg7LazqDEqVnHVAH2PYJKmy8hWM4ZbrknmJxDwBGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640254; c=relaxed/simple;
	bh=GmmYM7vNNaeCHG1jEj+OorYsbTxJScrKvbDrY/K4AkU=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=b0vQnQUgerZdhpQSWTimqE6aDsk/EzeaUBKu5+Upy9hX3vUxhn9FXwxD/q3nmCLHTBzsVu+xAaCDFDcX7RvaTZJdye3WNt971wuhp6S33U0a3ZAIBO3m0iJVWZox+fw8KwY2pM1IuOCAhPsUAC40qmFW179rNCMuGcC2DS8HW3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=BjVjdL1r; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="BjVjdL1r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=j2pmUlpI2u+AjQgIsNfOJvPybGVS23JJGLDfX9a99p8=; b=BjVjdL1rpX88mnMasOOJimovNf
	3lZglu2V8vrDbHOm8JdnytgEhydBsoRJwnwGviSSKGj/VTDTrnd5KCtj7Q3h3B1VcB5D9KyDdvoRb
	GPsRxn5IP5TIyYfDNlH92H4fm4h+T/fyFyg4L4nSaVW/Uralvv+ANnq3PvcSS1B83UI8=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:42184 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sJEq0-0007Bw-T8; Mon, 17 Jun 2024 12:04:09 -0400
Date: Mon, 17 Jun 2024 12:03:47 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 lech.perczak@camlingroup.com, Maarten.Brock@sttls.nl
Message-Id: <20240617120347.907e8e1e8eae5824930dcc48@hugovil.com>
In-Reply-To: <20240614102952.679806-2-hui.wang@canonical.com>
References: <20240614102952.679806-1-hui.wang@canonical.com>
	<20240614102952.679806-2-hui.wang@canonical.com>
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
	* -1.4 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v5 2/2] serial: sc16is7xx: hardware reset chip if
 reset-gpios is defined in DT
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Fri, 14 Jun 2024 18:29:52 +0800
Hui Wang <hui.wang@canonical.com> wrote:

Hi Hui,

> Some boards connect a GPIO to the reset pin, and the reset pin needs
> to be set up correctly before accessing the chip.
> 
> Add a function to handle the chip reset. If the reset-gpios is defined
> in the DT, do hardware reset through this GPIO, otherwise do software
> reset as before.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> in the V5:
>  - change setup to set up in the commit header
>  - change othwerwise to otherwise in the commit header
>  - change usleep_range(5, 10) to fsleep(5)
> 
> drivers/tty/serial/sc16is7xx.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index bf0065d1c8e9..eefa40006c71 100644
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
> @@ -1467,6 +1468,32 @@ static const struct serial_rs485 sc16is7xx_rs485_supported = {
>  	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
>  };
>  
> +/* Reset device, purging any pending irq / data */
> +static int sc16is7xx_reset(struct device *dev, struct regmap *regmap)
> +{
> +	struct gpio_desc *reset_gpio;
> +
> +	/*
> +	 * The reset input is active low, and flag GPIOD_OUT_HIGH ensures the
> +	 * GPIO is low once devm_gpiod_get_optional returns a valid gpio_desc.
> +	 */

I would replace all the above comments with:

  /* Assert reset GPIO if defined and valid. */

The correct polarity is already defined by the device
tree reset-gpios entry, and can be high or low depending on the design
(ex: there can be an inverter between the CPU and the chip reset input,
etc).


> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(reset_gpio), "Failed to get reset GPIO\n");
> +
> +	if (reset_gpio) {
> +		/* The minimum reset pulse width is 3 us. */
> +		fsleep(5);
> +		gpiod_set_value_cansleep(reset_gpio, 0); /* Deassert GPIO */
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
> @@ -1536,9 +1563,9 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  	}
>  	sched_set_fifo(s->kworker_task);
>  
> -	/* reset device, purging any pending irq / data */
> -	regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
> -		     SC16IS7XX_IOCONTROL_SRESET_BIT);
> +	ret = sc16is7xx_reset(dev, regmaps[0]);
> +	if (ret)
> +		goto out_kthread;
>  
>  	/* Mark each port line and status as uninitialised. */
>  	for (i = 0; i < devtype->nr_uart; ++i) {
> @@ -1663,6 +1690,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
>  	}
>  
> +out_kthread:
>  	kthread_stop(s->kworker_task);
>  
>  out_clk:
> -- 
> 2.34.1
> 

I could not test the validity of the 3us delay since I do not have an
oscilloscope, but testing with a 10s delay instead and a
multimeter showed that it works ok. You can add my Tested-by tag:

Tested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

And if you modify the comment as I suggested above, then you can add my
R-b tag:

Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>


-- 
Hugo Villeneuve
