Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC429AB1A;
	Thu, 18 Jun 2026 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794619; cv=none; b=N6+1qkyLdEC/2uX8bgNfggcN+OztgQwG57unrpF2VkyLDaAjB/iFpIEWEAnd9ZHvai8b2NxRBINZhxOpKkHIKSu49Af8k9U6vJAzHm5lYlo0eWbpK5BWQjJgcxpAaienJVM6eQvXK/CurQos1X038s50MX4vNCVgnffri55ju1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794619; c=relaxed/simple;
	bh=SE7v8SiyBZABnoZXOdmIMkkUOW5Kkfss8LLCB0b6K7g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=abbiPRPlWV7lBvjDsC+Ah94/1o0Seg6RcO3pfrY0IICdQHtNSVv9ik5Ix3I+HFplxKGTPIcgEuR8KCINBsQHEwWGUg70ZC5B0dJldsMmrdP35JSFWNumW5PEdlXxoFzjm+Ck13xzNaEX6Q8E/lPCeC7IpW4NukPPGyyU/G3Pz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=GezNigp7; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GezNigp7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=Fh1kudYK8zj1d5zm6swhKy85DjK9P4tOG87I7xIQdJY=; b=GezNigp7/wMsDkbbmBPjKzVHz8
	ETxVryMSSeLYw9Pqe5skMOL97SQEnTpZDkXaHHN7KUrujplBJF+Usfd3Qe2Gv96+zgmNGB7PmTeZo
	KU1EIy1loBeyVLLU0sw9nhBJmrjDBrWTO4Kxb+XN7loXZFx0v6yKxkbQQAdP9EkuGSss=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1waEAg-000000004Un-23Na;
	Thu, 18 Jun 2026 10:56:46 -0400
Date: Thu, 18 Jun 2026 10:56:45 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Alexander Shiyan <shc_work@mail.ru>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] serial: max310x: implement
 gpio_chip::get_direction()
Message-Id: <20260618105645.e2a1a4d5243fc6dda0554c1d@hugovil.com>
In-Reply-To: <20260615-b4-serial-max310x-gpio-get-direction-v2-1-4704ba2b181a@vaisala.com>
References: <20260615-b4-serial-max310x-gpio-get-direction-v2-1-4704ba2b181a@vaisala.com>
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

On Mon, 15 Jun 2026 06:38:40 +0000
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
> Changes in v2:
> - Address Hugo Villeneuve's review: use BIT(offset % 4) and put the
>   return statement on a single line.
> - Rebase onto v7.1-rc7.
> - Link to v1: https://lore.kernel.org/r/20260602-b4-serial-max310x-gpio-get-direction-v1-1-23bf84e8ee14@vaisala.com
> ---

Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

>  drivers/tty/serial/max310x.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index ac7d3f197c3a5ce3531d5607f48e21a807314021..09b9ab57d2b4479da90fba178b093008f4b57bb9 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -1212,6 +1212,17 @@ static int max310x_gpio_set(struct gpio_chip *chip, unsigned int offset,
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
> +	return val & BIT(offset % 4) ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
> +}
> +
>  static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
>  {
>  	struct max310x_port *s = gpiochip_get_data(chip);
> @@ -1421,6 +1432,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
>  	s->gpio.owner		= THIS_MODULE;
>  	s->gpio.parent		= dev;
>  	s->gpio.label		= devtype->name;
> +	s->gpio.get_direction	= max310x_gpio_get_direction;
>  	s->gpio.direction_input	= max310x_gpio_direction_input;
>  	s->gpio.get		= max310x_gpio_get;
>  	s->gpio.direction_output= max310x_gpio_direction_output;
> 
> ---
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> change-id: 20260602-b4-serial-max310x-gpio-get-direction-b10ee5be4f24
> 
> Best regards,
> -- 
> Tapio Reijonen <tapio.reijonen@vaisala.com>
> 
> 


-- 
Hugo Villeneuve
