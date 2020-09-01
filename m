Return-Path: <SRS0=lI39=CK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED04C433E6
	for <linux-serial@archiver.kernel.org>; Tue,  1 Sep 2020 16:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC43204EC
	for <linux-serial@archiver.kernel.org>; Tue,  1 Sep 2020 16:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+h+cgcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbgIAQKT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731340AbgIAQKQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Sep 2020 12:10:16 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639DCC061244;
        Tue,  1 Sep 2020 09:10:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f18so1045444pfa.10;
        Tue, 01 Sep 2020 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NsQXaCw31y4r2uMbkl6htgoK/WBIwM078xbS0cXU+7w=;
        b=C+h+cgcvCdrvsyM+XY6TVnknhOFCDL5CwskerXbP75VOQCWFbZN3VDOoKK3mYDE2Ho
         8xjUAX4TZXOr5ocf08At2G3jXdQXJXMFupaCuTuTXAoiKMbK4Vi3Q78rpCYWKBgOwzej
         lV3M/pKI9jlR+vlE1meAo8UfT7hEOtb97EepRRb0Vuk4nA5YMqzjfs6e/QSo8Yy+Mo3R
         y3u1rufk8yt3lNvVzPqtvAsa1UXgPCKr80Q3iKwWX9MMxdWS+YISCPaOk3ghRT/XfZvj
         z9nIlBWyKqiSbwDVHY7XB0jmbZ10rqZRfEL24/Xato3AxOJXYDsx+kYrEz/GtCtS23lW
         I9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NsQXaCw31y4r2uMbkl6htgoK/WBIwM078xbS0cXU+7w=;
        b=bvXtCDnYPQHGlob5b0sYj6Y83fROlJXOEQoTEbdBbBIUfGVhu9jDxiC9dBqpUzOhFA
         9ovTwZNbZv7/ZqIaK7ZWOhvB5lWJcSjugrPKo6i6u5r+VRZZwwhcsXLX1kpP+d93i47H
         CSA1YYjIoOG7Hx1aV6mIjb+b+xwijW2VRq/NpLWk7XIV6Hfeu37kXwUKKcg52ZbKURvT
         hv0L5qBq9hIUkIYc+1kMhYugEGbUcgv/nZEvgarc01D8kGYhz5xxrgXXCer2r/OS+H6i
         A8kgOJTm1JMyboATA2xQQ8Ka4HUsJ4gMGdmLpsfmwhcSog05BuSniSpyLXBqg3dWMUOt
         2+zw==
X-Gm-Message-State: AOAM5325tmgJgSd3gAl5yvtBeZfPeCNCnXLQ/qY/vpZ0n8yzvEskYgMC
        iszmvK5EEClAWczO9pDNxIWENwlidzQ=
X-Google-Smtp-Source: ABdhPJwKtA1KUbqtGdo3afUnY5etbEnRl0rJyDOflcBsCus3lfPEuSBXspRQU1fIzltpiNIbRaOsAQ==
X-Received: by 2002:a63:4e5e:: with SMTP id o30mr2091042pgl.254.1598976615541;
        Tue, 01 Sep 2020 09:10:15 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id c3sm2506092pfo.120.2020.09.01.09.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 09:10:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] serial: 8250: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200901153100.18827-1-krzk@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <04f68fe6-2f92-031d-a96f-e93d7c741d88@gmail.com>
Date:   Tue, 1 Sep 2020 09:10:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200901153100.18827-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 9/1/2020 8:30 AM, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   drivers/tty/serial/8250/8250_bcm2835aux.c | 12 +++---------
>   drivers/tty/serial/8250/8250_ingenic.c    | 20 ++++++--------------
>   2 files changed, 9 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
> index 12d03e678295..fd95860cd661 100644
> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -110,12 +110,8 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
>   
>   	/* get the clock - this also enables the HW */
>   	data->clk = devm_clk_get(&pdev->dev, NULL);
> -	ret = PTR_ERR_OR_ZERO(data->clk);
> -	if (ret) {
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "could not get clk: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(data->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk\n");

For 8250_bcm2835aux.c:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
