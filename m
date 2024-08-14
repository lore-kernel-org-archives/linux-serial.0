Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F261AC427
	for <linux-serial@vger.kernel.org>; Wed, 14 Aug 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637948; cv=none; b=KmEnvuz3fGdlJL67xjI/EycDk/D3eSL31CwxerhkyeLlD95Zv22XwY1NEpOHAjORIemkXvW7R4U2DIVFREnBi8iq5C4Ty0em1y5xjITq6XMhgdLIRbBylo8dsVf/pTrmqvJHnJjLDoqy2s3GkbsPagPZP4ZGEN6ZBsC+W68yX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637948; c=relaxed/simple;
	bh=i0Tg4p47BN7aquPosNjUnPC3DF7o8lYYr4SPlV6dRHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUtgGT8zryJNtxWH6SqRORhiL2A9ASP2U90EnNBgHl0DK070AlthUV4EZPd9qghVDHBYTrufzWvjICjfyoh9bDg/bb07Q0BwgacQx+0ooTkJnxr07vUJ5wXlCJ4bbnvU/CUzadJf/r9BNaSaV9JLqHQerUV5e8ooysPrbmIOUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qyKM256q; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qyKM256q"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e115ee08372so433965276.3
        for <linux-serial@vger.kernel.org>; Wed, 14 Aug 2024 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723637946; x=1724242746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GkO7BE2UO9+ru7pUnpn1jnINQAT3cICAUmPfXNrgDqo=;
        b=qyKM256qCXzkM4FSGq/uaAk1f4SfvZegBNqva2URXVXpy+BqbLP1x2Ujy+5ww2kDog
         LHD3FlHcz7YOZJlkvbcNsbZNQIZ9VheFnib9WP3rnLFSsgC8sgofiSIsdlNgllnto2ye
         ws1z5H6ihR8RkH0Z2b63tv+32G4cl0z2kHOLrRsaCvIqh/jh+rOgbOEjxxIQbwxc0PWj
         0J4J+VYzrH/V2Ymzvl1vJlSVi3iQr0x6WT6SZ/S8r4L9Si9RXRrCFM9VgaOwGqCCm/QM
         C8ZpAkXviMDUhsQdkkUkvMOlC1QUXYmOcVFOuSxwR4xGdnvOk/eDGekU8lRcijJOG2Ax
         xuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637946; x=1724242746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkO7BE2UO9+ru7pUnpn1jnINQAT3cICAUmPfXNrgDqo=;
        b=Dwbvd+SApDjHIvz/lZCfRvP+nmzZZpRGlz+r82LlJQyHKDZRSJjK110YSAPp3QBVn2
         +X7abbYyAqtIZfNDU7ze8JCmOW90PcjmQcgqcTVCir9reV48PGBtXTRuBTj7a/iZQEa5
         tUlA4uHd5+8FCaUT456TRszNuFLdBgLIXyRlQKBcCCYhUatgM0PQD4+/92Y5NrTT77tH
         +r0Ogn0VSBEe59xBMI4lGEIOwBWoFGv0Za1Jed/X7NDmWbY8xqnvuERuY5VxvvMcCJCM
         3u+A9WVV39lh2ANufQijlJWxFnVtDuZn7iDLYNXVq16DGHN5dZENfTXkEoRszvKzzrnn
         1PFA==
X-Forwarded-Encrypted: i=1; AJvYcCXVcVLyLfRG2jGNtSJjSW9awGrS4TniV4M2OTrJe+/zc3DiYdbUw8ilKUcnyPKFJNCm87pJL1ojVIFdgjTbTUCHvOFUBEfyMluvEWqF
X-Gm-Message-State: AOJu0YxrMrRv/YNEq9kL91p+QB/9c1GR+k0G0BawutH4cm/1bdd416nN
	aJDaEoHYyJ5usdF9FplBA9yVR3NUY9fRAlcSmcrPms8lZW+p7APX3YFM5MFX7DaZkGukx9lYZme
	SqvDGTwqC9G20AEUd8C8gAOuOXC7BRIDZ7neWpA==
X-Google-Smtp-Source: AGHT+IGjt5Gtd47+v4F9si1piYkQh5EGe0K9dfdnK1s/935m+Ubkmif2Bq5NIc2x2lXYaVSpzgpxhQW9gwzCUMfPSuo=
X-Received: by 2002:a05:6902:1895:b0:e03:a6b3:9f28 with SMTP id
 3f1490d57ef6-e1155a38eb4mr3847917276.10.1723637945672; Wed, 14 Aug 2024
 05:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728114200.75559-1-wahrenst@gmx.net> <20240728130029.78279-1-wahrenst@gmx.net>
 <20240728130029.78279-7-wahrenst@gmx.net>
In-Reply-To: <20240728130029.78279-7-wahrenst@gmx.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Aug 2024 14:18:29 +0200
Message-ID: <CAPDyKFoJh3j8xSeXZ9o031YZLTCDYVA+dgvURuwozjDpU_aauA@mail.gmail.com>
Subject: Re: [PATCH V2 15/16] serial: 8250_bcm2835aux: add PM suspend/resume support
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Maxime Ripard <mripard@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Minas Harutyunyan <hminas@synopsys.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, 
	Artur Petrosyan <Arthur.Petrosyan@synopsys.com>, Peter Robinson <pbrobinson@gmail.com>, 
	dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel-list@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jul 2024 at 15:07, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> This adds suspend/resume support for the 8250_bcm2835aux
> driver to provide power management support on attached
> devices.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/tty/serial/8250/8250_bcm2835aux.c | 37 +++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
> index 121a5ce86050..36e2bb34d82b 100644
> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -13,6 +13,7 @@
>   */
>
>  #include <linux/clk.h>
> +#include <linux/console.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -213,11 +214,47 @@ static const struct acpi_device_id bcm2835aux_serial_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, bcm2835aux_serial_acpi_match);
>
> +static int bcm2835aux_suspend(struct device *dev)
> +{
> +       struct bcm2835aux_data *data = dev_get_drvdata(dev);
> +       struct uart_8250_port *up = serial8250_get_port(data->line);
> +
> +       serial8250_suspend_port(data->line);
> +
> +       if (device_may_wakeup(dev))
> +               return 0;
> +
> +       if (uart_console(&up->port) && !console_suspend_enabled)
> +               return 0;
> +
> +       clk_disable_unprepare(data->clk);
> +       return 0;
> +}
> +
> +static int bcm2835aux_resume(struct device *dev)
> +{
> +       struct bcm2835aux_data *data = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = clk_prepare_enable(data->clk);

Doesn't this create clk prepare/enable - unprepare/disable imbalance
problem when the uart is configured for system wakeup?

> +       if (ret)
> +               return ret;
> +
> +       serial8250_resume_port(data->line);
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops bcm2835aux_dev_pm_ops = {
> +       SYSTEM_SLEEP_PM_OPS(bcm2835aux_suspend, bcm2835aux_resume)
> +};
> +
>  static struct platform_driver bcm2835aux_serial_driver = {
>         .driver = {
>                 .name = "bcm2835-aux-uart",
>                 .of_match_table = bcm2835aux_serial_match,
>                 .acpi_match_table = bcm2835aux_serial_acpi_match,
> +               .pm = pm_ptr(&bcm2835aux_dev_pm_ops),
>         },
>         .probe  = bcm2835aux_serial_probe,
>         .remove_new = bcm2835aux_serial_remove,
> --
> 2.34.1
>

Kind regards
Uffe
