Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8749CC38142
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 07:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjBAHJM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 02:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjBAHJL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 02:09:11 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276EE7AA6
        for <linux-serial@vger.kernel.org>; Tue, 31 Jan 2023 23:09:07 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o18so6854829wrj.3
        for <linux-serial@vger.kernel.org>; Tue, 31 Jan 2023 23:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AG203x/uKQJsIwhObu5QUpAihpZS37VrG6M7sV+EOHQ=;
        b=td8ozKEtyub8HUecu01AxE++XpWb6erclPFizSlD5n0kKKUmqmnrsdsSk1JfmtwM6X
         M6GGtGi/KAMAou57dCdfUbw7fnl5OyS0y0hcSvtPNbR/xPgPIgqj14yIcTDEuNzSz7p6
         WGxpWjpeF2oYwqkGIKV9XORfvf7t3dgisgwSezw3GCzGCa/uS8YB8/A0td8eikGmsXBX
         jsbS7OU0HPApmpMb4QexjYrEuMy30961OPEkr46ITH0cA07QeaCJzNj9+R6/USvB9mgX
         LJNVsfurwou1gKGpzocZTXIKtva/6cpQFqPn9VC7Rbj0X01uduRw3ooWvumiXNX+3QX/
         Scnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AG203x/uKQJsIwhObu5QUpAihpZS37VrG6M7sV+EOHQ=;
        b=cPqs0ewjsJShzwDZH5hw/Sr91TrhBB2WfmBYlFJPYhRs9whAO01pDVh0YGzCHkd3s6
         Dkjgp3p0vaxhplc23lXaFHmewD9vNb1AqhPuRt+dUAPUdOaCV9er9Ras9K3pOyHzSC+0
         HgjimwIb7PL8cdZlThgX24PxHLz9nQkG5B76nep7fREVHdAHCXcwpKkc9/0z3q58pk5t
         hkP6LW77mmJhgaiFKfUmB4thTp/ry8jbmuzhNmuXgNKCN0vxLCss9sPqXz3WT5MpWU/B
         SYoYzbe22Wsini/rmbSZdbWnIzAkvuFVdVoT0vX4NIR2+nOpr5KdRgAy+JF209MX52g0
         5aiw==
X-Gm-Message-State: AO0yUKUpNpf1mJMzCyLacBOhzOg09i+Fp+f0fOPHtuV+v/Otexc1tzjy
        bfTG1P/HY9JLRyff/8Spv7CBZGT3SQVXPR2K
X-Google-Smtp-Source: AK7set/p11ubEqSrtB7a9mTly8krn3N6vc2HKyLQLtylmc0YmLRn32psEZg0nOrSKfM+qMGRwBRTMQ==
X-Received: by 2002:a05:6000:1f98:b0:2bf:affa:c83a with SMTP id bw24-20020a0560001f9800b002bfaffac83amr4796260wrb.65.1675235345599;
        Tue, 31 Jan 2023 23:09:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d610c000000b0028965dc7c6bsm16261945wrt.73.2023.01.31.23.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 23:09:05 -0800 (PST)
Message-ID: <149edeac-3a5c-4157-b63a-678016c22369@linaro.org>
Date:   Wed, 1 Feb 2023 08:09:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] serial: samsung: fix buffer size for clk_name
To:     "Alexey V. Vissarionov" <gremlin@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20230116141658.GC8107@altlinux.org> <Y8lZNi9pYVFkYvh9@kroah.com>
 <20230201024457.GD446@altlinux.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201024457.GD446@altlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 01/02/2023 03:44, Alexey V. Vissarionov wrote:
> serial: samsung: fix buffer size for clk_name

This does not belong here.

> 
> Although very unlikely, the 'clk_num' value may be as big as
> 2**32 - 1 (uint32_max), so the buffer should have enough
> space for storing "clk_uart_baud4294967295\0".
> Also, the numbers in clk_name are expected to be unsigned.
> 
> Found by ALT Linux Team (altlinux.org) and Linux Verification
> Center (linuxtesting.org) using SVACE.
> 
> Signed-off-by: Alexey V. Vissarionov <gremlin@altlinux.org>
> Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")

How did you address my comments? the clk_num cannot be beig as 2^32-1.
It's not possible, if I understand correctly.
> 
> ---
> 
> On 2023-01-19 15:52:38 +0100, Greg Kroah-Hartman wrote:
> 
>  >> Fixes: 5f5a7a5578c58852 ("serial: samsung: switch to clkdev
>  >> based clock lookup")
>  > Please fix your scripts to use the proper number of SHA1 digits
>  > in a Fixes: line as the documentation asks for.
> 
> Done. Also added the comment to the source regarding the buffer size.
> 
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 0fce856434dafd80..2c701dc7c6a37191 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1407,7 +1407,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
>   *
>   */
>  
> -#define MAX_CLK_NAME_LENGTH 15
> +#define MAX_CLK_NAME_LENGTH 24		/* "clk_uart_baud4294967295\0" */

NAK. It's just waste of space.

Best regards,
Krzysztof

