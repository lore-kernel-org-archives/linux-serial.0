Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BFACDB465
	for <linux-serial@archiver.kernel.org>; Thu, 19 Oct 2023 05:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjJSFCj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Oct 2023 01:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSFCi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Oct 2023 01:02:38 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8950A10F
        for <linux-serial@vger.kernel.org>; Wed, 18 Oct 2023 22:02:36 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-32d9552d765so5865362f8f.2
        for <linux-serial@vger.kernel.org>; Wed, 18 Oct 2023 22:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697691755; x=1698296555;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hBlGeOSMkcjPyqaXk5e7CbP8bv92OVfnReJIExCPP8=;
        b=cxzefHUUv52/qxWuEHPllGo2m6tXuAEc0FiTH9dMGTMuCD2c3/pok/jnr866BWY60i
         Ujr8+TjyfrgFDr+u84CsMVfxp+BXYEnLskCsVgPl2knjS2dh55xzOTRKkycgp8Xxa0eO
         YTEJhHMMtchPJoc1YIyW7YQJlAZTZJ4jS1yFFrvITF79HjTNHZdtq0EvMaZNPo65Da4Z
         K9KL+Z65q58oNxi0SRVrmRzaO6lsGt2GME4GHcVWtURlNyyn/lXdxspcYLSg2DfAZuEY
         XjKVDpyBmECODvOcg7A3pRaErFiyFwOEoPL88Me+MyWGeJvcoYExN9rtP3sPi3QbbXop
         9K7A==
X-Gm-Message-State: AOJu0Yw5sOkzpdg4J2aM/LI2BcQRFXEG0kvY4ur9UfqjBqDWYbts3Ek4
        3bc4K+OqFDjZ0KsJolU3kSM=
X-Google-Smtp-Source: AGHT+IG+e3qIAeUTpt6ygACZRbxeEaRtOwp/sN7VXtmaKsDz5rE+0pvL5//w1nciYR8Dpa+Row1+HA==
X-Received: by 2002:a5d:6583:0:b0:32d:7efc:7e1f with SMTP id q3-20020a5d6583000000b0032d7efc7e1fmr591461wru.71.1697691754668;
        Wed, 18 Oct 2023 22:02:34 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id i7-20020adffdc7000000b00324853fc8adsm3518444wrs.104.2023.10.18.22.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 22:02:33 -0700 (PDT)
Message-ID: <9316aaef-6079-4151-89df-bdd4ff422707@kernel.org>
Date:   Thu, 19 Oct 2023 07:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: st-asc: Check return value of platform_get_irq()
 in asc_init_port()
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>, Yi Yang <yiyang13@huawei.com>
Cc:     gregkh@linuxfoundation.org, srinivas.kandagatla@st.com,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
References: <20231018091240.314620-1-yiyang13@huawei.com>
 <20231018142818.16eea64d71410c6717da41ba@hugovil.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20231018142818.16eea64d71410c6717da41ba@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18. 10. 23, 20:28, Hugo Villeneuve wrote:
> On Wed, 18 Oct 2023 09:12:40 +0000
> Yi Yang <yiyang13@huawei.com> wrote:
> 
>> The platform_get_irq() might be failed and return a negative result, there
>> should be return an error code when platform_get_irq() failed.
>> Fix it by add check return value of platform_get_irq().
>>
>> Fixes: c4b058560762 ("serial:st-asc: Add ST ASC driver.")
>> Signed-off-by: Yi Yang <yiyang13@huawei.com>
>> ---
>>   drivers/tty/serial/st-asc.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
>> index a821f5d76a26..8321167502dc 100644
>> --- a/drivers/tty/serial/st-asc.c
>> +++ b/drivers/tty/serial/st-asc.c
>> @@ -683,12 +683,16 @@ static int asc_init_port(struct asc_port *ascport,
>>   	struct resource *res;
>>   	int ret;
>>   
>> +	ret = platform_get_irq(pdev, 0);
> 
> Hi,
> for readability, you could define a new irq variable instead of using
> ret. See reasoning below.
> 
>> +	if (ret < 0)
>> +		return ret;
>> +
>>   	port->iotype	= UPIO_MEM;
>>   	port->flags	= UPF_BOOT_AUTOCONF;
>>   	port->ops	= &asc_uart_ops;
>>   	port->fifosize	= ASC_FIFO_SIZE;
>>   	port->dev	= &pdev->dev;
>> -	port->irq	= platform_get_irq(pdev, 0);
>> +	port->irq	= ret;
> 
> Assigning port->irq to irq instead of ret will make the code more
> understandable.

Yes. And you need not to worry that someone will stick another
ret = something();
after platform_get_irq() above.

thanks,
-- 
js
suse labs

