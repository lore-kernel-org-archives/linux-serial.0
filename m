Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1883ECAAD4
	for <linux-serial@archiver.kernel.org>; Mon, 29 Aug 2022 07:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiH2Hog (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Aug 2022 03:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiH2Hof (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Aug 2022 03:44:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D114F1AE
        for <linux-serial@vger.kernel.org>; Mon, 29 Aug 2022 00:44:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e13so8151614wrm.1
        for <linux-serial@vger.kernel.org>; Mon, 29 Aug 2022 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=QjEcd75RqT3WIgUp2pbtkalTMer+nFUQbbPAvaSW25U=;
        b=VUiIlhoZuw+u+tFb6JwkhBtkBhQutnnVLYzhx28QiSHqKDIy073Pl3gg6hbx25hxiU
         NpQbV39LEsHQPIYG5NIjf/zpr2i/EoKjMZR/u4mlHC1gIsH98yxq6j3YA9ro3cl89W75
         VE+9R7XjbrC3t5w3C9txQ9wO/MCDF/7Av2T2alAyhRJkeOC+u+XEv/cB/dLtNpOv/F9P
         XCbetVBFMArzO8UXwsfEn/L1BJYp1177u9GHxccLXiUb4j+WH0fWWrfgoqfZH71We7sK
         Frt6Yb5jjZsGjKVa/BwlHizl5JEqH4ftCYFwMtZ9ls2XAJ2SUOmya77P3Zncwz9KCoWp
         +YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=QjEcd75RqT3WIgUp2pbtkalTMer+nFUQbbPAvaSW25U=;
        b=tKm4V195Wu1Jc28e9vPOgwKO8xl7cX0/l6f6lUjn58PHYYeNAMW6BX1PGWnHbVy49P
         BQ4qO6gPXioQHAPzm40yKQz+msDxtQiE/zkiQHHGPeA9R/Ps4bQgmfv4OPj7kdAeW3UO
         2qGP0UJNneIXO3r0mYvL7k+/IDfk4pqdDauLzt6uosa7I9Jl6/wj2/IDP/V7rENqjav5
         weVFZedTsTHTAzBRiKv0ibRXvrZ8DB1nCy0PS2V2iU+IyznAaXf1GVKfI1AQhulyOIz8
         I1MIzgmou6ok6uhLzXxfj0w/ZRizIst+W52LRQHAjDkYF7WDvP8zbAo4oON0cv5ve6L2
         FeTQ==
X-Gm-Message-State: ACgBeo1YtX2XouOAkWR0OHfxt04/A+M01tDouds0PVP4Szz8AVP156+o
        GnUezv7lUZJtMSjZcsIACM3PpA==
X-Google-Smtp-Source: AA6agR6/W5X5eALXzIWGgg5gZJiu0WA3BEvbZhHKVoGSnQpMk97J1Zsl0Ln0n+YGVwhaoFPX4wTETA==
X-Received: by 2002:a5d:4a01:0:b0:21d:8ce1:8b6d with SMTP id m1-20020a5d4a01000000b0021d8ce18b6dmr5606743wrq.718.1661759069804;
        Mon, 29 Aug 2022 00:44:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6124:6b74:2847:d37b? ([2a01:e0a:982:cbb0:6124:6b74:2847:d37b])
        by smtp.gmail.com with ESMTPSA id i12-20020a1c540c000000b003a2f2bb72d5sm8939722wmb.45.2022.08.29.00.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 00:44:29 -0700 (PDT)
Message-ID: <f14d517b-90c9-3741-6f41-6c82a7521f46@baylibre.com>
Date:   Mon, 29 Aug 2022 09:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] tty: serial: meson: Use devm_clk_get_enabled() helper
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <3f18638cb3cf08ed8817addca1402ed5e3bd3602.1661328361.git.christophe.jaillet@wanadoo.fr>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <3f18638cb3cf08ed8817addca1402ed5e3bd3602.1661328361.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 24/08/2022 10:06, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code, the error handling paths and avoid the need of
> a dedicated function used with devm_add_action_or_reset().
> 
> That said, meson_uart_probe_clock() is now more or less the same as
> devm_clk_get_enabled(), so use this function directly instead.
> 
> This also fixes an (unlikely) unchecked devm_add_action_or_reset() error.
> 
> Based on my test with allyesconfig, this reduces the .o size from:
>     text	   data	    bss	    dec	    hex	filename
>     16350	   5016	    128	  21494	   53f6	drivers/tty/serial/meson_uart.o
> down to:
>     15415	   4784	    128	  20327	   4f67	drivers/tty/serial/meson_uart.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> devm_clk_get_enabled() is new and is part of 6.0-rc1
> 
> If the message "couldn't enable clk\n" is of any use, it could be added
> in meson_uart_probe_clocks() with a dev_err_probe() call. It wouldn't be
> exactly the same meaning, but at least something would be logged.
> ---
>   drivers/tty/serial/meson_uart.c | 29 +++--------------------------
>   1 file changed, 3 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 6c8db19fd572..26de08bf181e 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -667,29 +667,6 @@ static struct uart_driver meson_uart_driver = {
>   	.cons		= MESON_SERIAL_CONSOLE,
>   };
>   
> -static inline struct clk *meson_uart_probe_clock(struct device *dev,
> -						 const char *id)
> -{
> -	struct clk *clk = NULL;
> -	int ret;
> -
> -	clk = devm_clk_get(dev, id);
> -	if (IS_ERR(clk))
> -		return clk;
> -
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(dev, "couldn't enable clk\n");
> -		return ERR_PTR(ret);
> -	}
> -
> -	devm_add_action_or_reset(dev,
> -			(void(*)(void *))clk_disable_unprepare,
> -			clk);
> -
> -	return clk;
> -}
> -
>   static int meson_uart_probe_clocks(struct platform_device *pdev,
>   				   struct uart_port *port)
>   {
> @@ -697,15 +674,15 @@ static int meson_uart_probe_clocks(struct platform_device *pdev,
>   	struct clk *clk_pclk = NULL;
>   	struct clk *clk_baud = NULL;
>   
> -	clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
> +	clk_pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
>   	if (IS_ERR(clk_pclk))
>   		return PTR_ERR(clk_pclk);
>   
> -	clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
> +	clk_xtal = devm_clk_get_enabled(&pdev->dev, "xtal");
>   	if (IS_ERR(clk_xtal))
>   		return PTR_ERR(clk_xtal);
>   
> -	clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
> +	clk_baud = devm_clk_get_enabled(&pdev->dev, "baud");
>   	if (IS_ERR(clk_baud))
>   		return PTR_ERR(clk_baud);
>   

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
