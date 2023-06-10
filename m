Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0703BC7EE2F
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jun 2023 10:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjFJKp7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 10 Jun 2023 06:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjFJKp7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 10 Jun 2023 06:45:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6551B35B8
        for <linux-serial@vger.kernel.org>; Sat, 10 Jun 2023 03:45:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-973bf581759so459514166b.0
        for <linux-serial@vger.kernel.org>; Sat, 10 Jun 2023 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686393956; x=1688985956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1LaTb7IRBsiBRAwbYmjK10xmwfQeiAbbyjzsoHkO+VA=;
        b=GkqBClImyWom1VH+TSEdCIwsV0sUVIO77EO//nMDnICJaSUrrw8OCMioHFzfZO7722
         U69zcii6U50Oa7vFE57feiUXsDU28aHWILJshAx4QCkpJNdUxuzOX1nmg1JahmGtsfEX
         3SsmZpUZ2VdIyHgQw9lee9l37jyE8rJRgxieeyS5PGqlKb8Z8zHJfKvMK5nvPN9XuG73
         7H/D8RBVqv/91Ln/++kCHAdVaNd29h+I+4yaE8CleAz86aChenT7aWRyXQCNPZhDXZyz
         mphjlMMQtdEIXP5jzZXfl12KCduLXXiaq7AmkiDRxtYx22KPAIIghCVpwc3k5nCij/L1
         nV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686393956; x=1688985956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LaTb7IRBsiBRAwbYmjK10xmwfQeiAbbyjzsoHkO+VA=;
        b=Xdyx73bWFDSWDb6odHjDpGYWx3Buy0rALfdsI7sx6coA9vSe/nQVVm7h0pdXMXY8lf
         vfR8emypliuJUAmtcyPH6Y7H/VLrqHQ3M1awxAguhQqf57vAWYWFkCQ1oq3QEUOFAIKh
         BF+zWQO0lg5w8IPeHfZjyDLf0n+I2D73uVng7YPvJJJosyCesb5MPTsRto3zEFFSUcPq
         0OMsISkFozfGWBO1xpXmwGQnp7gCdoSpdE1Rm4Jh5IFkFM/SzjlyTLuOmNiQsMe8j1Rw
         qKD435v8CZ//4xuOrPQfjmnlBxN5U9rrEvFwK5omQo0VHTP78qt2XbE3xFrlrkP4EKS/
         c3Vw==
X-Gm-Message-State: AC+VfDyIpnghmdk/PGgXybEnVSacIxhp9c+CPqXtDTDcGz40nyfLjjaK
        i7zGsVEQ4yce0+XUmxQ9mYCpqg==
X-Google-Smtp-Source: ACHHUZ5eqVHmQLyBpqFQRRPJI3XqVCPp7uGWNmJoXDK0Wc32tAm6CBS01HtR7+YKKBHkdtSxL5EKBQ==
X-Received: by 2002:a17:907:320e:b0:974:b15:fce5 with SMTP id xg14-20020a170907320e00b009740b15fce5mr4690577ejb.38.1686393955821;
        Sat, 10 Jun 2023 03:45:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906684b00b0096a91ab434fsm2407900ejs.40.2023.06.10.03.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 03:45:55 -0700 (PDT)
Message-ID: <d86a0c13-f2c1-2595-adac-71c8c6452a89@linaro.org>
Date:   Sat, 10 Jun 2023 12:45:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() when iterating clk
Content-Language: en-US
To:     Andi Shyti <andi.shyti@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
 <93bf8f574310256fcea50e5c5a62b5c37e20bb14.1686285892.git.christophe.jaillet@wanadoo.fr>
 <20230610103958.jwfe45zm52ehiovn@intel.intel>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230610103958.jwfe45zm52ehiovn@intel.intel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/06/2023 12:39, Andi Shyti wrote:
> Hi Christophe,
> 
> On Fri, Jun 09, 2023 at 06:45:39AM +0200, Christophe JAILLET wrote:
>> When the best clk is searched, we iterate over all possible clk.
>>
>> If we find a better match, the previous one, if any, needs to be freed.
>> If a better match has already been found, we still need to free the new
>> one, otherwise it leaks.
>>
>> Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> This patch is speculative. Review with care.
>>
>> I think that some clk_put() are also missing somewhere else in the driver
>> but won't be able to investigate further.
>> ---
>>  drivers/tty/serial/samsung_tty.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>> index dd751e7010e3..c07877dd25fa 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -1488,10 +1488,18 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>>  			calc_deviation = -calc_deviation;
>>  
>>  		if (calc_deviation < deviation) {
>> +			/*
>> +			 * If we find a better clk, release the previous one, if
>> +			 * any.
>> +			 */
>> +			if (!IS_ERR(*best_clk))
> 
> what is the case when *best_clk has an error in it?

The initial one? Open the place where the function is being called.

Best regards,
Krzysztof

