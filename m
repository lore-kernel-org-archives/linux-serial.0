Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE572C7EE45
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jun 2023 16:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjFJQYG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 10 Jun 2023 12:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjFJQYE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 10 Jun 2023 12:24:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D103330EC
        for <linux-serial@vger.kernel.org>; Sat, 10 Jun 2023 09:24:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso5014823a12.0
        for <linux-serial@vger.kernel.org>; Sat, 10 Jun 2023 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686414241; x=1689006241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pd1ySyif81ZEmdOhujalqY6qZNVl7+w+GriNkv4KMlE=;
        b=VVq/OdkQygheYkFphc8bAXO43NV9AMvV4c2zje5mqNsortsMDAIpkbk+sjMS3dxLrm
         1zBOCzoyT5n21Pk4MQv0WYFclihCDj/7SUE4RCK51mtZIMzKW7f9gP66PUmSkM7Q789X
         fCbl8dkYUUP3ERrVmdWG8Qsc578/pn3uW5T1es7x75WpAYlf+Kx5KrEMXnp7GO9ZrHNN
         E9he5iG8kx0hdoVf8pRYsuAw8pgpnxcwO9I14iAXjAUthy2uTKk7Jn1tVPr4oBwBo2d9
         yjDeJB5nh35tkKSqc2CofnPrafiVgUl7AItHAGQAYiktZDONsE9n1mQV+ofW3M9XBBkr
         WBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686414241; x=1689006241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pd1ySyif81ZEmdOhujalqY6qZNVl7+w+GriNkv4KMlE=;
        b=FmcH0zXrQtYYajrOWbdCcq9Uuh7T5f1oPkL5PKsb60hI/hI9KvyYaJtBG+foK7vUcP
         0C4S19Nv5NMm4Pdiv06yD8E78JClu4+T0lCrlZ/2i0cy7L0QKvvAL49wDcVeORURq4Mx
         OpxSxa9IP11sgi9Y16fblMqYfEHlk+cug8Sb7upuUlYAS0g9Svw+ps31BdJvY9IYgFz5
         lJ5fQK63dQD4ooLkphKSCOQc9eacy7bgQQS2J1Tf4hLsHBzruKzouu0FkPcJghxzEQ5y
         jDktsjl/FLj6OvZZMzG/gMoECyfh74SaXdSMN09AO4oIIlIXFsKywnz1LNacV0outR1B
         g+fQ==
X-Gm-Message-State: AC+VfDzwffN+MKUb54mQK5fC8/ffSRayKF68V2O6Xa3UfvyXffj+UDEn
        V2o1RBhApDMXFEL8c9QRd9Zd4g==
X-Google-Smtp-Source: ACHHUZ6nS4XwTl4j51nPSZzPIzQZjvp6/dlONHlOpa6csHUiV8kK29gamWzpucZ3aDf7cbNFVOK6aA==
X-Received: by 2002:aa7:d80f:0:b0:514:92d8:54b3 with SMTP id v15-20020aa7d80f000000b0051492d854b3mr1745962edq.12.1686414241023;
        Sat, 10 Jun 2023 09:24:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f14-20020a056402004e00b00514b3dd8638sm3006861edu.67.2023.06.10.09.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 09:24:00 -0700 (PDT)
Message-ID: <eb935f16-1f89-0be9-86c9-24e8a88c2d8b@linaro.org>
Date:   Sat, 10 Jun 2023 18:23:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() in case of error
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
 <20230610102607.7nonyh5xhuhpyy6e@intel.intel>
 <58d3f250-499d-5a18-6798-f9833cc2dbbd@wanadoo.fr>
 <20230610145429.uvmxxgxc5tc6x5b5@intel.intel>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230610145429.uvmxxgxc5tc6x5b5@intel.intel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/06/2023 16:54, Andi Shyti wrote:
> On Sat, Jun 10, 2023 at 04:07:51PM +0200, Christophe JAILLET wrote:
>> Le 10/06/2023 à 12:26, Andi Shyti a écrit :
>>>> @@ -1459,8 +1459,10 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>>>>   			continue;
>>>>   		rate = clk_get_rate(clk);
>>>> -		if (!rate)
>>>> +		if (!rate) {
>>>> +			clk_put(clk);
>>>>   			continue;
>>>
>>> could you also print an error here?
>>>
>>
>> Is:
>> 	dev_err(ourport->port.dev,
>> 		"Failed to get clock rate for %s.\n", clkname);

Why do we need it? Most of other users of clk_get_rate() don't print.
Probably because such condition is highly unlikely if not impossible.
This makes simple function unnecessarily bigger...

Best regards,
Krzysztof

