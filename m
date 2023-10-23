Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E64BC25B45
	for <linux-serial@archiver.kernel.org>; Mon, 23 Oct 2023 21:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjJWVbw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Oct 2023 17:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJWVbw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Oct 2023 17:31:52 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A67ABD
        for <linux-serial@vger.kernel.org>; Mon, 23 Oct 2023 14:31:50 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-27cefb5ae1fso2455362a91.3
        for <linux-serial@vger.kernel.org>; Mon, 23 Oct 2023 14:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698096709; x=1698701509;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wG6sO/IsCd3y0zJDWWQFvNIIql0UCn1hV1GB1fm/8pA=;
        b=l+OPEkixp+MXK/VzGOxoh/Bzj759LKzdMBd63YwLQHD8GSkdCeoj/7CxBx1FWX4zcH
         u3XhoNL8dV1caSlOkm1iBQE3EDdDNBdnM7D6RW+mYTWn05byeNQbswI+XY51/WO01Kjb
         cuFQNqXmO09Xh0vPrO2PnnqrJbelUkDscSAstGTEPivBZ1e3PhtATnkF//Qvnkj5o8NL
         b1yAVq2b5YuLePSlgrMeI8OBou8iBC4fShdo/2kP+hmfx75YoHXCzJMNMejBaxgUdYJM
         8vbDSo1mmdPqOiRk/YhWIqlC6jTdojoCEpYrQpq5Jy9Q9+pc+UU3wUZrT1nUdcZ+GDOQ
         TH8g==
X-Gm-Message-State: AOJu0YzfcXz6NuWWYPWj3BroChw84eMm+3+50PAxJeUnmyuUAJel2G25
        ZstnePtQWVXOFBQh9/BBK+0xhxhAaH0LvR8cr1Tfqw==
X-Google-Smtp-Source: AGHT+IE72DNgkOPUjRTMNTIzntz14KLEtOtzLCAtRYxd4ab4gXjeXs9JPC7ZL9hdHz2eXVBMwiulXQ==
X-Received: by 2002:a17:90a:1602:b0:279:1367:b9a3 with SMTP id n2-20020a17090a160200b002791367b9a3mr7663670pja.4.1698096709458;
        Mon, 23 Oct 2023 14:31:49 -0700 (PDT)
Received: from localhost (97-113-50-134.tukw.qwest.net. [97.113.50.134])
        by smtp.gmail.com with ESMTPSA id oj3-20020a17090b4d8300b0027ced921e80sm7725525pjb.38.2023.10.23.14.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:31:49 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Thomas Richard <thomas.richard@bootlin.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, tony@atomide.com
Cc:     linux-serial@vger.kernel.org, gregory.clement@bootlin.com,
        u-kumar1@ti.com, d-gole@ti.com, thomas.petazzoni@bootlin.com,
        Thomas Richard <thomas.richard@bootlin.com>
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if
 no console suspend
In-Reply-To: <20231017130540.1149721-1-thomas.richard@bootlin.com>
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
Date:   Mon, 23 Oct 2023 14:31:48 -0700
Message-ID: <7hfs213u0r.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thomas Richard <thomas.richard@bootlin.com> writes:

> If the console suspend is disabled, the genpd of the console shall not
> be powered-off during suspend.
> Set the flag GENPD_FLAG_ALWAYS_ON to the corresponding genpd during
> suspend, and restore the original value during the resume.
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
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
> +		}
> +	}

This is not the right approach IMO.

Instead, what should be happening is that when `no_console_suspend` is
set, there should be an extra pm_runtime_get() which increases the
device usecount such that the device never runtime suspends, and thus
the domain will not get powered off.

Kevin
