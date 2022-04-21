Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0139C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 21 Apr 2022 08:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386916AbiDUIwT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Apr 2022 04:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386899AbiDUIwO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Apr 2022 04:52:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC52140DD
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 01:49:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so3300884wmb.1
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 01:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=aqSPW9x18iap7VEqnzBaFCwvwC9XWVLp+mVcr+cF4XU=;
        b=sVQrimJBLCXmLbM375kfAud906Dx8MUr3UWI3gePbVIosyLCjwJ+wV3rGV4lFcJXo1
         1lSq9f8z1TFWEw9edZllTJ3NOhv5VycjBt43cAcM/TrPwgvUl9+7uc+eYFc1Hkk+TDPr
         bMjavqPKtpYICG8KvxnSjVbCYkovadQH6N3rCQXk7EBh4V15hzAzWV3Or9vDkOvtEP5g
         KJw/4nsk6vEFEA9WddRyyRnXnI1Clue8JLCQcHiWsoEBQC+LUwuFq8lyVLslq9lU9Mhx
         /ZRDg87iM64NODjWq9JGGVgVmSEDpmAMikiVoxWhcw9OBsSFX3nt59A7FyESVJjNTLdi
         OlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=aqSPW9x18iap7VEqnzBaFCwvwC9XWVLp+mVcr+cF4XU=;
        b=FVuuObWll28bn6i0+q0GgA40RSq06cgawLd2msfHyeWUYNOwCeu38VTOfUe5E535ve
         oCQfsE8Sln/1w5C9IQENgW275+ppHjfwkROZXFtXRSvzY7xyq4eGgRqLN3ZivQbo5HSS
         0xQPibYwYhR0AIgR6iBMd0TBTRLwikxjkjujySANNg7MmEvYYAfZ4sPu/NCY2SHAk466
         kANq0KLK2SjyzQJ/TAcC01ixwNiulo3kRUgRo/Od2Z1Glo9cdoBZsqeQUd95z/6kEmAf
         eruG+LU3VLmQI83xi8ye7dYeOXGbIF13yX75FBSBcn5OX2wif8/GlKyhN2tCb2dQLsC7
         Jc6w==
X-Gm-Message-State: AOAM531l+iW0B4I5bKQEib1W6qnt2JixicMNyGaNO/LzN4hoTSq5b30k
        tivY1kAQXQgT2ImpjLuEvxPjSg==
X-Google-Smtp-Source: ABdhPJzriyI1Ddu4GZCWUIbVECnu8piDZLNnSlQ/iUsewg5ps2kg0Tk6ePdstsZTppKMCwkIC+JBSA==
X-Received: by 2002:a05:600c:1c9b:b0:391:6287:b7a3 with SMTP id k27-20020a05600c1c9b00b003916287b7a3mr7507911wms.188.1650530964122;
        Thu, 21 Apr 2022 01:49:24 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:35ba:2677:956:980d? ([2001:861:44c0:66c0:35ba:2677:956:980d])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d4888000000b00207a49fa6a1sm2028679wrq.81.2022.04.21.01.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 01:49:23 -0700 (PDT)
Message-ID: <3f5df9df-7699-7210-6253-4dd03f4444a0@baylibre.com>
Date:   Thu, 21 Apr 2022 10:49:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 2/2] tty: serial: meson: Added S4 SOC compatibility
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220418053202.24528-1-yu.tu@amlogic.com>
 <20220418053202.24528-3-yu.tu@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220418053202.24528-3-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18/04/2022 07:32, Yu Tu wrote:
> Make UART driver compatible with S4 SOC UART. Meanwhile, the S4 SOC
> UART uses 12MHz as the clock source for baud rate calculations.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>   drivers/tty/serial/meson_uart.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 58bd2723c004..43941f21735f 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -790,11 +790,19 @@ static int meson_uart_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static struct meson_uart_data s4_uart_date = {

Should be s4_uart_data instead of s4_uart_date

> +	.has_xtal_div2 = true,
> +};
> +
>   static const struct of_device_id meson_uart_dt_match[] = {
>   	{ .compatible = "amlogic,meson6-uart" },
>   	{ .compatible = "amlogic,meson8-uart" },
>   	{ .compatible = "amlogic,meson8b-uart" },
>   	{ .compatible = "amlogic,meson-gx-uart" },
> +	{
> +		.compatible = "amlogic,meson-s4-uart",
> +		.data = (void *)&s4_uart_date,

Here same

> +	},
>   	{ /* sentinel */ },
>   };
>   MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
With this change, it's fine for me.

Neil
