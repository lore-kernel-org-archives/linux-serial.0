Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46327C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbjKJSvp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbjKJSv0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:51:26 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AB6BD2C2
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 10:10:05 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d122e0c85so13767296d6.3
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 10:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699639798; x=1700244598; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uBGjD9Baza/GRKpnHbvo9bFT85edeTEQFkIvyH/n+SU=;
        b=QjVzw7eXbcLG3kavv8B4oOlhRWjV7VuXondYsfrI/lgs33Aw//5eoAsBQSTQOLe6+N
         PhHm2fjrDMbwcCYQZrKJewaUCA3UvG06Hahi6RKxEfHmOaXk0aR67JVmA2ZbShq1E75U
         zD6ysLVHO0WYw9ArYUu53lZ0s2ncHT7owyMJWKjQj57m62GhgxwyMkbJynsxMTAoM5Og
         p1m2OhpijKPq3rpvAKdjMqazvmHmHwMvsODSGqEyAMZ9HHjPj+uIcH3nCgNB6DbngY0Q
         1lgbG56pJSjyTLnVUrtu04+moKPUBI4tBA0X97hZFzrJmfuLE8UgC1mUnsULSA+Fjowm
         hJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699639798; x=1700244598;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBGjD9Baza/GRKpnHbvo9bFT85edeTEQFkIvyH/n+SU=;
        b=B+tSDewR3hM5M16aWT0DchJnVZ+5JfjLAddIOcTkm9ISaZLJqKDHPjPI4XjIAWdQFf
         lyeTBPBnLKUSUXda6RbkOg+Xgq+FcMkTnGKrci2dT2d3+ccCFhRC4wV4501+vweFHpwn
         hHejXP9mITCf2rZtwsi4C/0njuQ2kc3N4FXVK7urRJaOEucW6X7+nJp56V9U83DVSa/Z
         qq6WDaJ5RYGgPgzC3rhCk/fJXgTg0sgt8Ub3dOzFwizhDg10eD5r0WFe+ZHKe+6X30q1
         00Vm6R02T2wf/qk8GNfwepBqeZTGJb1NS9/k4TeL77SBfKv+aD4pk35QYAeTlCCM+Fwm
         3s0w==
X-Gm-Message-State: AOJu0YxA9Fv41WhvH7F1/OUAUpfH0BULb2ZfFynuNjdXM+boDpLWg5K7
        qUCqq+G/2+xBLyqdFAN4mGg=
X-Google-Smtp-Source: AGHT+IFGglEBXzsA5OFptUb4vitlMnayTEU6eWkoiV3Dixu/VB7ZyKPYv7qW5nKWH5LCKHixTTqJTQ==
X-Received: by 2002:a05:6214:2509:b0:66d:5dec:6099 with SMTP id gf9-20020a056214250900b0066d5dec6099mr9609179qvb.41.1699639798198;
        Fri, 10 Nov 2023 10:09:58 -0800 (PST)
Received: from errol.ini.cmu.edu ([72.95.245.133])
        by smtp.gmail.com with ESMTPSA id bd12-20020ad4568c000000b00670a8921170sm11222qvb.112.2023.11.10.10.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 10:09:57 -0800 (PST)
Date:   Fri, 10 Nov 2023 13:09:55 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 19/52] serial: liteuart: Convert to platform remove
 callback returning void
Message-ID: <ZU5x80fullMsHHGI@errol.ini.cmu.edu>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
 <20231110152927.70601-20-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231110152927.70601-20-u.kleine-koenig@pengutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 10, 2023 at 04:29:47PM +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks!

Acked-by: Gabriel Somlo <gsomlo@gmail.com>

> ---
>  drivers/tty/serial/liteuart.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index a25ab1efe38f..3ce369f76349 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -336,15 +336,13 @@ static int liteuart_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int liteuart_remove(struct platform_device *pdev)
> +static void liteuart_remove(struct platform_device *pdev)
>  {
>  	struct uart_port *port = platform_get_drvdata(pdev);
>  	unsigned int line = port->line;
>  
>  	uart_remove_one_port(&liteuart_driver, port);
>  	xa_erase(&liteuart_array, line);
> -
> -	return 0;
>  }
>  
>  static const struct of_device_id liteuart_of_match[] = {
> @@ -355,7 +353,7 @@ MODULE_DEVICE_TABLE(of, liteuart_of_match);
>  
>  static struct platform_driver liteuart_platform_driver = {
>  	.probe = liteuart_probe,
> -	.remove = liteuart_remove,
> +	.remove_new = liteuart_remove,
>  	.driver = {
>  		.name = KBUILD_MODNAME,
>  		.of_match_table = liteuart_of_match,
> -- 
> 2.42.0
> 
