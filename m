Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FDCC433FE
	for <linux-serial@archiver.kernel.org>; Wed, 19 Oct 2022 10:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiJSKBz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Oct 2022 06:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiJSKBX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Oct 2022 06:01:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09099122BE4
        for <linux-serial@vger.kernel.org>; Wed, 19 Oct 2022 02:39:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a10so28083186wrm.12
        for <linux-serial@vger.kernel.org>; Wed, 19 Oct 2022 02:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CAFlOUOSDNnpuoT+qdniJV4n8MjtoOiXZ0ZGelulaWU=;
        b=mxBYSXH83a8R2gqazBpTtCz7VO9xqsgjj2vXwj9nr1M6ylxMyqTveNpscOoPWCYCsA
         eEzTpwgls/8waiWeVGKE1584hYuc3sHvIlMuh2rMc6NtmsDkFxefJBunGnAM739QREkw
         vXDCNujfYlxtUAxITdcNpDx8WcahP+aq6jxtMM/QxXVOmZIJlcj0n/dQfH9gndSAliMu
         vjOeW/8L13HSd457fpcbjtjfs9kPcBAT0NorhP0seOW5+RFoxm0L/GlCHESgl+4gpjmz
         wt7sXgWS/b+c4gxd7/oc+uBTTE5IAjaxt1yE6VrtceXlFZizLGuPFtrtVyfJHf1mBMEE
         wtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAFlOUOSDNnpuoT+qdniJV4n8MjtoOiXZ0ZGelulaWU=;
        b=rzUUQf45DnL7MScgas7wjjKh09BHgTrjw/d4OjbSHD89oEA+XYqzWAGIRefO9OUMn5
         9JQENlQqzwiBYTL4+ThvSsiEM9yoJvf4w5LCGe3Cz/Tp2ym+u8yX3HC1GeO3Sf222E+q
         lpxKuMY8G9gftJksRPnTb9yLKIu0p2F2VOOCET2JuyFlz3hsJ/v/7LYUizcfyfHmuo0i
         dJcZgnczQTJ1R/s4fW0y24f5jNr8OKi6W4KgElvjCxjT5chxjTAhNPqq+SmSQPwIqEHI
         a8Fswb9cRmpdN1OMJBaUP8T76OmNCe2RCxetyLoaATpaDDhjGcPStE3YG/ETEKXhmaZG
         BxCw==
X-Gm-Message-State: ACrzQf2M6+1QL5bISvLaTGGKwws6g/UI5x2xOtedjYHDl/QOJs7WLVl4
        XdPoj86bzlKIx/nLguKcHCh/Jg==
X-Google-Smtp-Source: AMsMyM50f/3OOKH1f22KJUuMMnPFOXKp4tez4aGFwbvdlYy/HHNOVo7/VLqR1PmpIjtixY1NE1R44g==
X-Received: by 2002:a05:6000:12ca:b0:22e:6529:a764 with SMTP id l10-20020a05600012ca00b0022e6529a764mr4484971wrx.153.1666172206880;
        Wed, 19 Oct 2022 02:36:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b15b:4b56:592a:c397? ([2a01:e0a:982:cbb0:b15b:4b56:592a:c397])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d6290000000b0022ae4f8395dsm12834601wru.96.2022.10.19.02.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 02:36:46 -0700 (PDT)
Message-ID: <010ea9e1-4a66-61d4-94c5-2bec20ef928d@linaro.org>
Date:   Wed, 19 Oct 2022 11:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 22/44] serial: meson: Use uart_xmit_advance()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
 <20221019091151.6692-23-ilpo.jarvinen@linux.intel.com>
Organization: Linaro Developer Services
In-Reply-To: <20221019091151.6692-23-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 19/10/2022 11:11, Ilpo Järvinen wrote:
> Take advantage of the new uart_xmit_advance() helper.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/tty/serial/meson_uart.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 056243c12836..74110017988a 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -162,8 +162,7 @@ static void meson_uart_start_tx(struct uart_port *port)
>   
>   		ch = xmit->buf[xmit->tail];
>   		writel(ch, port->membase + AML_UART_WFIFO);
> -		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -		port->icount.tx++;
> +		uart_xmit_advance(port, 1);
>   	}
>   
>   	if (!uart_circ_empty(xmit)) {


Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
