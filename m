Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C08FC07E9C
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jul 2021 15:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBD461CC3
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jul 2021 15:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhGGP6d (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Jul 2021 11:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231533AbhGGP6c (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Jul 2021 11:58:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 737E961CC2;
        Wed,  7 Jul 2021 15:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625673352;
        bh=yA2T6Ajlz9ePfRZThDw90HuzdId+jf7AX43qfgOKHTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b1VgVbYfP1P8zPrj7ztAaO7xEBFuprX8wUVfKMvPuqxMlFaYpFJxn3RXJJs5EaXEc
         Ofss8SqqrkMTjndLvpp/JRbty2Meg3qv+t/jf/BevrRsqvakGH0VIg/foSdzQwWa/L
         JtG1Y6hVooYntuhL4mxfV7e1ouQEA7bbQ483akv/ZAfUtF0onbgZm85of5GV+ylB6g
         QWLBpJ2v3TXdw8vF/gATvIk+zz2vWxXoPd1OfYbXbBiFEOYJk8XKbvGvZkfo4QQJhV
         RtzaVvz3/0uzw3oegVA53KgjYA3TxdJ7LlQeXX/UZaRpT8ApWfUi+YlPu1PYmwK6aT
         qy4cHmZgjGLAA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1m19tn-0000vy-4v; Wed, 07 Jul 2021 17:55:43 +0200
Date:   Wed, 7 Jul 2021 17:55:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tamseel Shams <m.shams@samsung.com>
Cc:     krzysztof.kozlowski@canonical.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com
Subject: Re: [PATCH v3] serial: samsung: Checks the return value of function
Message-ID: <YOXOfyPa6aoy5mC8@hovoldconsulting.com>
References: <CGME20210706061710epcas5p2c11d1bf5afb14774c4d4db93f2b83b33@epcas5p2.samsung.com>
 <20210706061909.17555-1-m.shams@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706061909.17555-1-m.shams@samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 06, 2021 at 11:49:09AM +0530, Tamseel Shams wrote:

Please provide a better commit summary; "Checks the return value of
function" is too vague.

> "uart_add_one_port" function call may fail and return
> some error code, so adding a check for return value.
> If it is returning some error code, then displaying the
> result, unregistering the driver and then returning from
> probe function with error code.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> ---
> Changes since v1:
> 1. Added support to unregister driver on failure of "uart_add_one_port"
> function call.
> 2. Commit message updated.
> 
> Changes since v2:
> 1. Added support to unwind clocks on failure of "uart_add_one_port"
> function call.
> 
>  drivers/tty/serial/samsung_tty.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 9fbc61151c2e..a3f3a17fb54b 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2253,7 +2253,11 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  	}
>  
>  	dev_dbg(&pdev->dev, "%s: adding port\n", __func__);
> -	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
> +	ret = uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to add uart port, err %d\n", ret);
> +		goto add_port_error;
> +	}
>  	platform_set_drvdata(pdev, &ourport->port);
>  
>  	/*
> @@ -2272,6 +2276,17 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  	probe_index++;
>  
>  	return 0;
> +
> +add_port_error:

Name error labels after what they do, not where jump from (e.g.
"err_disable_clk").

> +	ourport->port.mapbase = 0;
> +	clk_disable_unprepare(ourport->clk);
> +	clk_put(ourport->clk);
> +	if (!IS_ERR(ourport->baudclk)) {
> +		clk_disable_unprepare(ourport->baudclk);
> +		clk_put(ourport->baudclk);
> +	}
> +	uart_unregister_driver(&s3c24xx_uart_drv);

You can't just deregister the serial driver if probe of a single port
fails. What if there are more than one port?

Looks like the driver has the same bug in remove(). What a mess... Added
by 6f134c3c7703 ("serial: samsung: Move uart_register_driver call to
device probe") in 2014.

And the clocks are never disabled and released in case
uart_register_driver() fails above either.

> +	return ret;
>  }
>  
>  static int s3c24xx_serial_remove(struct platform_device *dev)

Johan
