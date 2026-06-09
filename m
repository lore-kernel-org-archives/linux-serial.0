Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD2A331ED8;
	Tue,  9 Jun 2026 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034477; cv=none; b=qAbUKMTNo9qJenjSH7lGbblwuZR9INwEnWX2CDcM6LviBtkljR0dCor2rFN6NHll9gl1FTjlSdxSc75iOFme/0h6NZZcegnSKnSWuGrjhG5H9jqeSlyPCnYwlcB2608+Xy4wDudQ8AikBuxuYX7blL6lb8Ed+VVgyLgM0e0LvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034477; c=relaxed/simple;
	bh=nYyS3RzSJGOfPRHnTA2wHTvE7bU6gPvkZGl3I/1xt9U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T933RjZOW3kIx77ofFEMIUeDETRBZ3+63P4tDocNh4026AEXyS09Cq6jIlxFjkoJoYAoBZnC2rZ4azM6fEy/9N/im0N/zXtOjHPH2c2qrFDQ8Ieo4Q6GNH+JVFmWGqu5t29ajBmnshd88u/r7JCPcHDZWhHtO3hNXu2bk8SKacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Gmw6wZ/w; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Gmw6wZ/w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=Hf/rB+HgY4vWBr3NANOYB5hatqPMTZsXKlQZXX83OzE=; b=Gmw6wZ/wqz/7dWb2R3qD3hMX7e
	vTLOa/0OFe9D9ZAFSpnQZahV3PWOtU3vlPKv7X71AhpvQXgmZ//KgIu7EYLxaZl7TyGzaCsZhZvMp
	KUiMXut3n04WtRqnmQQALF6UiJpmxZu4Syza8EBLUguyKZZYYt3xgj7EJrPPjaSVUHZw=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wX2QH-000000000uj-3e2I;
	Tue, 09 Jun 2026 15:47:42 -0400
Date: Tue, 9 Jun 2026 15:47:41 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Alexander Shiyan <shc_work@mail.ru>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH] serial: max310x: implement gpio_chip::get_direction()
Message-Id: <20260609154741.b7a6f7517c74046a6acfe711@hugovil.com>
In-Reply-To: <20260602-b4-serial-max310x-gpio-get-direction-v1-1-23bf84e8ee14@vaisala.com>
References: <20260602-b4-serial-max310x-gpio-get-direction-v1-1-23bf84e8ee14@vaisala.com>
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

Hi Tapio,

On Tue, 02 Jun 2026 10:02:35 +0000
Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:

> It's strongly recommended for GPIO drivers to always implement the
> .get_direction() callback - even when the direction is tracked in
> software. The GPIO core emits a warning when the callback is missing
> and a user reads the direction of a line, e.g. via
> /sys/kernel/debug/gpio.
> 
> The MAX310X keeps the GPIO direction in the GPIOCFG register (a set bit
> selects output), which the existing direction_input/output callbacks
> already program, so the current direction can be read back directly.
> 
> Fixes: f65444187a66 ("serial: New serial driver MAX310X")
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
> Found and HW-tested on an i.MX6 SoloX board with a MAX14830 over SPI:
> without this, "cat /sys/kernel/debug/gpio" triggers the gpiolib.c:429
> WARNING (tainting the kernel W) on each queried MAX14830 line; with it
> applied the lines report their in/out direction and the WARNING is gone.
> ---
>  drivers/tty/serial/max310x.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index ac7d3f197c3a5ce3531d5607f48e21a807314021..96df54a90b009d1b547f7a639b0b9a4281daf073 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -1212,6 +1212,18 @@ static int max310x_gpio_set(struct gpio_chip *chip, unsigned int offset,
>  	return 0;
>  }
>  
> +static int max310x_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct max310x_port *s = gpiochip_get_data(chip);
> +	struct uart_port *port = &s->p[offset / 4].port;
> +	unsigned int val;
> +
> +	val = max310x_port_read(port, MAX310X_GPIOCFG_REG);
> +
> +	return (val & (1 << (offset % 4))) ? GPIO_LINE_DIRECTION_OUT
> +					   : GPIO_LINE_DIRECTION_IN;

Small nit to improve readability:

... val & BIT(offset % 4) ...

you could also put this return statement on a single line (less than
100 columns).


> +}
> +
>  static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
>  {
>  	struct max310x_port *s = gpiochip_get_data(chip);
> @@ -1421,6 +1433,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
>  	s->gpio.owner		= THIS_MODULE;
>  	s->gpio.parent		= dev;
>  	s->gpio.label		= devtype->name;
> +	s->gpio.get_direction	= max310x_gpio_get_direction;
>  	s->gpio.direction_input	= max310x_gpio_direction_input;
>  	s->gpio.get		= max310x_gpio_get;
>  	s->gpio.direction_output= max310x_gpio_direction_output;
> 
> ---
> base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
> change-id: 20260602-b4-serial-max310x-gpio-get-direction-b10ee5be4f24
> 
> Best regards,
> -- 
> Tapio Reijonen <tapio.reijonen@vaisala.com>
> 
> 


-- 
Hugo Villeneuve
