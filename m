Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDB4367B8B
	for <linux-serial@vger.kernel.org>; Fri, 17 Jul 2026 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274096; cv=none; b=D+/ts4S6pIEYC8C8ZkntpMrxp1SqCHu/PnaZGo1GJ0etwWVz7zzEZu439ravUjWUTyOT+hjhnB0DzaYxTu4Auk7IKX+KuIo7atu8mNit9B9nYyvIkG5hwsXAeBoTSpX7Ngu+cQ20Kzx87cwhMw0MDftEd5EwpOvGI5RZhUedOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274096; c=relaxed/simple;
	bh=Gbt8AAEZ2+OoVkZqGOUFGJ1glUjuYYPOXFOlTCeRvWo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQVFRPgkE4lQORWR0qi2OWZsYn/HpiPw2w9w52t2TcfPfeH86fC7Ce8sq9ZMUVtm6r0Odt3xNqDsO7OV/ez4bO4r0k9AWHCR9bYz48NyuLEYdJwdd81eHIK6BaRI1xAaLaQFYasw9HtEfy0ggvsgFzIuJJ+R06pa+TKPSfedkhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVyzCtYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVyzCtYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359D11F000E9
	for <linux-serial@vger.kernel.org>; Fri, 17 Jul 2026 07:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784274087;
	bh=O33LBv121cI3446+fALTqMiAlHo2my8xGCUrTRDo3IU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=hVyzCtYV9JqTXNNpFq+jErtvzBxrCe2Ksf43XnR1uOuqeQPOmP9Wryi08bdo5onB9
	 ELs3Cqnf4IwU+QTz1VO3MV4szlREK+I7lmiheW63Rz9NFkLlAHHQu0hEMjqZYZ7AqX
	 bVZ6MswMH1R6R99jFRFXXc+f5cUPb8uZWmo2p2SDPao+m74ZT4HP8f54Wz9Ygx76L2
	 nvymIvhhJt/KYIt5tRyNc4m8/Q+ED+qTDXkAtvRhRAFsZmmgeKt24APj+rd+kzav4n
	 Id/A+TyIn7Z+ZVE/Wm5RL5cUow0hGAPC/fsCo+hulIZEcbXqzL6N1Wl4Ceht2SpeoJ
	 6B6SBtdRDC1HQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b159850b16so3835076e87.3
        for <linux-serial@vger.kernel.org>; Fri, 17 Jul 2026 00:41:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrmL5v259WjBS6Q/WwRv8TOhmwW5fUoTIVhTFv/gVGOZTmHT0ZfsgssjA+dyj1hbQQiPH39IiJvt5ZC5oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3FNfcODu+1hqROshI3jxUHEXilvJZOY3+2d48YNStEk5fAJt
	ndnThIsXu1aabQ7yyXCRNcuSqksSWJeSAZeIMaSfCmCJwgM8aal1JXq4JEzno4QBJEPs6c/A5ON
	/Vekm2HqU4u6iPZ+vP/kOXVmA+NFnYzPwwC4/SBDpMw==
X-Received: by 2002:a05:6512:63d1:10b0:5ae:b0aa:8f07 with SMTP id
 2adb3069b0e04-5b28f8742cdmr256639e87.16.1784274081030; Fri, 17 Jul 2026
 00:41:21 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 02:41:19 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 02:41:19 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260716210813.2582826-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716210813.2582826-1-hugo@hugovil.com>
Date: Fri, 17 Jul 2026 02:41:19 -0500
X-Gmail-Original-Message-ID: <CAMRc=MerwHnK5sdw7JRyzkhrRZF_2vSjcpOJ6R=Lz9rbKGE5JQ@mail.gmail.com>
X-Gm-Features: AUfX_mwRwl5xhGKjVcL6rRS5fp6CK4RLwoUeOyI0kRluQd6smz7Yf4G_2u2wFj0
Message-ID: <CAMRc=MerwHnK5sdw7JRyzkhrRZF_2vSjcpOJ6R=Lz9rbKGE5JQ@mail.gmail.com>
Subject: Re: [PATCH] serial: sc16is7xx: implement gpio get_direction() callback
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jon Ringle <jringle@gridpoint.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 23:08:09 +0200, Hugo Villeneuve <hugo@hugovil.com> said:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> It's strongly recommended for GPIO drivers to always implement the
> .get_direction() callback - even when the direction is tracked in
> software. The GPIO core emits a warning when the callback is missing
> and a user reads the direction of a line, e.g. via
> /sys/kernel/debug/gpio.
>
> Fixes: dfeae619d781 ("serial: sc16is7xx")
> Cc: stable@kernel.org
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
> Inspired by a similar patch for max310x: commit a483b1a91b33
> ("serial: max310x: implement gpio_chip::get_direction()").
> ---
>  drivers/tty/serial/sc16is7xx.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 2498f9da2bf77..943be318de410 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1273,6 +1273,17 @@ static int sc16is7xx_gpio_set(struct gpio_chip *chip, unsigned int offset,
>  	return 0;
>  }
>
> +static int sc16is7xx_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct sc16is7xx_port *s = gpiochip_get_data(chip);
> +	struct uart_port *port = &s->p[0].port;
> +	unsigned int val;
> +
> +	val = sc16is7xx_port_read(port, SC16IS7XX_IODIR_REG);
> +
> +	return val & BIT(offset) ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
> +}
> +
>  static int sc16is7xx_gpio_direction_input(struct gpio_chip *chip,
>  					  unsigned offset)
>  {
> @@ -1350,6 +1361,7 @@ static int sc16is7xx_setup_gpio_chip(struct sc16is7xx_port *s)
>  	s->gpio.parent		 = dev;
>  	s->gpio.label		 = dev_name(dev);
>  	s->gpio.init_valid_mask	 = sc16is7xx_gpio_init_valid_mask;
> +	s->gpio.get_direction	 = sc16is7xx_gpio_get_direction;
>  	s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
>  	s->gpio.get		 = sc16is7xx_gpio_get;
>  	s->gpio.direction_output = sc16is7xx_gpio_direction_output;
>
> base-commit: da7b5fd4e17f8e44c5590f2d603c01d499f056e6
> --
> 2.47.3
>
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
