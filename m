Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00EFC74A5B
	for <linux-serial@archiver.kernel.org>; Sat, 18 Mar 2023 14:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCROw2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 18 Mar 2023 10:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCROw2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 18 Mar 2023 10:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65C230193
        for <linux-serial@vger.kernel.org>; Sat, 18 Mar 2023 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679151094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ric6rrq7vGEm9xb0r4Sa8eTDN4DF7YKXYHcMI7FI7XE=;
        b=OO8kmj5J7MzkhevLqNTe0LgYaTh9ceUzKbnXNuY/Lc4s3SdQvtUuaC/LctdebTASz22dw6
        dVF6sNgxpKHRhHsotyWe7+TBaRDWgS2XAYcCKgp/xt9X/RX4drOW0dNtAqYoYNLxUxb1Ks
        0QIAy82O1ybz6MPX79h5sNcbkCRtPFo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-9_Y9KaDmO6icY7WHxCvopg-1; Sat, 18 Mar 2023 10:51:33 -0400
X-MC-Unique: 9_Y9KaDmO6icY7WHxCvopg-1
Received: by mail-qv1-f69.google.com with SMTP id r4-20020ad44044000000b005ad0ce58902so4218864qvp.5
        for <linux-serial@vger.kernel.org>; Sat, 18 Mar 2023 07:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679151092;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ric6rrq7vGEm9xb0r4Sa8eTDN4DF7YKXYHcMI7FI7XE=;
        b=n5nsjEkqpfUB/80L+ZAZMcSNr7Tdco7BhZn2Bem1hBpZ7OyQLfq3gWnLjXbsOczCst
         7eNAaxYE8j+gDrQahxwT6lS8jhPr3rL3EOAUCDO6IXRwjsZ+0XFnXEqOEbYctMOoPoZC
         CmZo9er1RLQXmVStWnf7BVo9SWCW8UK/O1eoPAzUH5Eqxgf+gmxckADca57IbSRwsqKy
         e5YkrkEG8Gg40cprVi0uBJFnD8V1j4dNxkcjyt54X0D3wUoDnzklWc/WL4CU9Rs48q/J
         hqo01oHQLTxEtfyRwC3DUZdgnYUzZvbOiVisffPiORIwkggUSmhKe5dG4nI2WdEWmM9c
         CicA==
X-Gm-Message-State: AO0yUKW6ivKF6cG41kwXjdgNkXx3jHBgz57OqqPpJYR5d1KTc28T00QC
        VkHS+2YAAZKfjHBS46AUPvN6md3MHJs9EZyeWU5jmNpnhuglma8o9EhfikpwfmGUYMEsvjyQwBo
        F6adSNLmdcCxV7MFicuF3BVuD
X-Received: by 2002:ac8:7dc6:0:b0:3bf:e05a:f2f2 with SMTP id c6-20020ac87dc6000000b003bfe05af2f2mr17551028qte.31.1679151092487;
        Sat, 18 Mar 2023 07:51:32 -0700 (PDT)
X-Google-Smtp-Source: AK7set9ZDp5u9lmhVI2qPCcpmBGFzfulEDfgCvtscb10T98V7E/KIdzQazhy7kKih42X2QbSVFfU5g==
X-Received: by 2002:ac8:7dc6:0:b0:3bf:e05a:f2f2 with SMTP id c6-20020ac87dc6000000b003bfe05af2f2mr17551007qte.31.1679151092223;
        Sat, 18 Mar 2023 07:51:32 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id n185-20020a3740c2000000b007402fdda195sm3729155qka.123.2023.03.18.07.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 07:51:31 -0700 (PDT)
Subject: Re: [PATCH] serial: imx: remove unused imx_uart_is_imx* functions
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, nathan@kernel.org,
        ndesaulniers@google.com, llvm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230317205710.1672232-1-trix@redhat.com>
 <20230318143041.n6rymackf6p776rq@pengutronix.de>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b5c61356-02e8-76f1-3e2c-9388aa18462c@redhat.com>
Date:   Sat, 18 Mar 2023 07:51:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230318143041.n6rymackf6p776rq@pengutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 3/18/23 7:30 AM, Uwe Kleine-König wrote:
> On Fri, Mar 17, 2023 at 04:57:10PM -0400, Tom Rix wrote:
>> clang with W=1 reports
>> drivers/tty/serial/imx.c:292:19: error:
>>    unused function 'imx_uart_is_imx21' [-Werror,-Wunused-function]
>> static inline int imx_uart_is_imx21(struct imx_port *sport)
>>                    ^
>> drivers/tty/serial/imx.c:297:19: error:
>>    unused function 'imx_uart_is_imx53' [-Werror,-Wunused-function]
>> static inline int imx_uart_is_imx53(struct imx_port *sport)
>>                    ^
>> drivers/tty/serial/imx.c:302:19: error:
>>    unused function 'imx_uart_is_imx6q' [-Werror,-Wunused-function]
>> static inline int imx_uart_is_imx6q(struct imx_port *sport)
>>                    ^
>> These static functions are not used, so remove them.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> Funny, is_imx6q_uart() was introduced in
> a496e6284c482555db8078190bb689594d129fa9 and never used. Since that
> commit is_imx21_uart() also unused. And the imx53 variant was also never
> used.
>
> Looking at that a bit more, the following cleanup is also possible (only
> compile tested):
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8308a23c55a7..a38ee0ed2210 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -178,8 +178,6 @@
>   enum imx_uart_type {
>   	IMX1_UART,
>   	IMX21_UART,
> -	IMX53_UART,
> -	IMX6Q_UART,
>   };
>   
>   /* device type dependent stuff */
> @@ -241,30 +239,21 @@ struct imx_port_ucrs {
>   	unsigned int	ucr3;
>   };
>   
> -static struct imx_uart_data imx_uart_devdata[] = {
> -	[IMX1_UART] = {
> -		.uts_reg = IMX1_UTS,
> -		.devtype = IMX1_UART,
> -	},
> -	[IMX21_UART] = {
> -		.uts_reg = IMX21_UTS,
> -		.devtype = IMX21_UART,
> -	},
> -	[IMX53_UART] = {
> -		.uts_reg = IMX21_UTS,
> -		.devtype = IMX53_UART,
> -	},
> -	[IMX6Q_UART] = {
> -		.uts_reg = IMX21_UTS,
> -		.devtype = IMX6Q_UART,
> -	},
> +static const struct imx_uart_data imx_uart_imx1_devdata = {
> +	.uts_reg = IMX1_UTS,
> +	.devtype = IMX1_UART,
> +};
> +
> +static const struct imx_uart_data imx_uart_imx21_devdata = {
> +	.uts_reg = IMX21_UTS,
> +	.devtype = IMX21_UART,
>   };
>   
>   static const struct of_device_id imx_uart_dt_ids[] = {
> -	{ .compatible = "fsl,imx6q-uart", .data = &imx_uart_devdata[IMX6Q_UART], },
> -	{ .compatible = "fsl,imx53-uart", .data = &imx_uart_devdata[IMX53_UART], },
> -	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
> -	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX21_UART], },
> +	{ .compatible = "fsl,imx6q-uart", .data = &imx_uart_imx21_devdata, },
> +	{ .compatible = "fsl,imx53-uart", .data = &imx_uart_imx21_devdata, },
> +	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_imx1_devdata, },
> +	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_imx21_devdata, },
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, imx_uart_dt_ids);
>
> If you feel like squashing that into your commit or put it into a
> separate commit with a nice commit log (after convincing yourself that
> the change is fine), feel free to do so.
>
> If you don't:

My interest is not in imx specifically, but rather cleaning up all the 
unused functions.

I _think_ I can get the list of around 70 down to around 10 but it will 
take a while.

Tom


>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> Best regards
> Uwe
>

