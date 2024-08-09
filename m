Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614215FCEA
	for <linux-serial@vger.kernel.org>; Fri,  9 Aug 2024 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230268; cv=none; b=MvKOzs8cNDTFaR8yw69JHwj7uD4EkgeAjaIZBDTUAMpyMhIi1RzvSJiLFGTMvIyvpNqLnPKVXn2byiYuS359mZY8cW+4YIE0IjQPx/NhY/dJKCoqfih4UfnrJCYUIlKhnbbdMX6SrsWtmC4vrJmV8yqw1NMI1TTCrefACww3CpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230268; c=relaxed/simple;
	bh=DRiB3Nm744mCXm08Wlqg3/ZBQTBUvI35lwzgoRQ38UM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o88NK4qqzTBeLk87fRnLjq3jj+pMmTo4bBsOlhjX5sYFsHdJvXgv4OfiUSIUo0FHFqIvhJ9nOvOw7y4cl1qxDowEUfukIYFWvHaIVrshz+nnoYWewdW1izuv4Zx3R2AvjgN902U3hwIM6YWfTTQ9N5suZC2c4GE67EQOz62ycAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd66cddd4dso23776055ad.2
        for <linux-serial@vger.kernel.org>; Fri, 09 Aug 2024 12:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230266; x=1723835066;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mjPK3pnH6oxVuaMPKM7maYqp5JSjEE0aJrZPDdoldU=;
        b=PXDZIC/hucxtvBzKlEKO72ixoSgItSk7efPMFd6TJB0UmBiFph/L8NHmGr1YmEpH6m
         9r18cIaQlOu3OxmVuFUVOeoy4uqREFhkhsgkz+3VojB6sPiqDnAa2PMo/WTx4SpPJCOM
         MpXxlnyiGm9hiSRiwxGrJzHY1lkPCq4qvBd7jbNnoqiI1EmSKvCugrR6Rs4+I487OSGe
         gEU+WaZw8XDLQTu8fjx6qMsVJM/PLajdXdrY0Hw0pIG5w5zgk2zra/1AvOaaMZjRpZSY
         OQs9e3/iAp4NolTV67odfzRzRLL8y+2j0TugMxayfKL1nphucTx+uUTupInsURACMAU+
         JaHQ==
X-Gm-Message-State: AOJu0Yx+oZMyl5L4u0kNaYDj3rWtHv1sIWTVZJkf1USrLHp+2G0HBIJr
	e0HlUZRlk2/QRQ3hMkhYF8RU0OOR9cMyomwo948lw7t/WFtLh776YfpWWBLMmvY=
X-Google-Smtp-Source: AGHT+IGaT3Fx+A+Mahi3TgEYZctT6qZVbM74kl6OZ8nFXNpAyzQneDL0uKZVm/FRoVi/53xP0QwKfg==
X-Received: by 2002:a17:90a:7448:b0:2ca:5ec8:576c with SMTP id 98e67ed59e1d1-2d1e7f94c15mr2641197a91.5.1723230265647;
        Fri, 09 Aug 2024 12:04:25 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c7bd87sm3387780a91.15.2024.08.09.12.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:04:24 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, tony@atomide.com
Cc: linux-serial@vger.kernel.org, gregory.clement@bootlin.com,
 u-kumar1@ti.com, d-gole@ti.com, thomas.petazzoni@bootlin.com, Thomas
 Richard <thomas.richard@bootlin.com>
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if
 no console suspend
In-Reply-To: <20231017130540.1149721-1-thomas.richard@bootlin.com>
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
Date: Fri, 09 Aug 2024 12:04:23 -0700
Message-ID: <7hzfplplfs.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Richard <thomas.richard@bootlin.com> writes:

> If the console suspend is disabled, the genpd of the console shall not
> be powered-off during suspend.
> Set the flag GENPD_FLAG_ALWAYS_ON to the corresponding genpd during
> suspend, and restore the original value during the resume.
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Hmm, this patch got merged upstream (commit 68e6939ea9ec) even after
disagreements about the approach.

Even worse, it actually causes a crash during suspend on platforms that
don't use PM domains (like AM335x Beaglebone Black.)

Details on why this crashes below.

Thomas, could you please submit a revert for this (with a Fixes: tag)
and then follow up with the approach as discussed later in this thread?

> ---
>  drivers/tty/serial/8250/8250_omap.c | 33 ++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index ca972fd37725..91a483dc460c 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -27,6 +27,7 @@
>  #include <linux/pm_wakeirq.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/sys_soc.h>
> +#include <linux/pm_domain.h>
>  
>  #include "8250.h"
>  
> @@ -114,6 +115,12 @@
>  /* RX FIFO occupancy indicator */
>  #define UART_OMAP_RX_LVL		0x19
>  
> +/*
> + * Copy of the genpd flags for the console.
> + * Only used if console suspend is disabled
> + */
> +static unsigned int genpd_flags_console;
> +
>  struct omap8250_priv {
>  	void __iomem *membase;
>  	int line;
> @@ -1617,6 +1624,7 @@ static int omap8250_suspend(struct device *dev)
>  {
>  	struct omap8250_priv *priv = dev_get_drvdata(dev);
>  	struct uart_8250_port *up = serial8250_get_port(priv->line);
> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);

This genpd ptr will be NULL on am335x, and any other legacy platforms
that don't use PM domains, and then...

>  	int err = 0;
>  
>  	serial8250_suspend_port(priv->line);
> @@ -1627,8 +1635,19 @@ static int omap8250_suspend(struct device *dev)
>  	if (!device_may_wakeup(dev))
>  		priv->wer = 0;
>  	serial_out(up, UART_OMAP_WER, priv->wer);
> -	if (uart_console(&up->port) && console_suspend_enabled)
> -		err = pm_runtime_force_suspend(dev);
> +	if (uart_console(&up->port)) {
> +		if (console_suspend_enabled)
> +			err = pm_runtime_force_suspend(dev);
> +		else {
> +			/*
> +			 * The pd shall not be powered-off (no console suspend).
> +			 * Make copy of genpd flags before to set it always on.
> +			 * The original value is restored during the resume.
> +			 */
> +			genpd_flags_console = genpd->flags;
> +			genpd->flags |= GENPD_FLAG_ALWAYS_ON;

... BOOM.

> +		}
> +	}
>  	flush_work(&priv->qos_work);
>  
>  	return err;

Kevin
