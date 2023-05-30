Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB75C7EE2C
	for <linux-serial@archiver.kernel.org>; Tue, 30 May 2023 11:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjE3Lis (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 May 2023 07:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjE3Lir (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 May 2023 07:38:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DDBB0
        for <linux-serial@vger.kernel.org>; Tue, 30 May 2023 04:38:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f6e83e12fso679573766b.1
        for <linux-serial@vger.kernel.org>; Tue, 30 May 2023 04:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685446724; x=1688038724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8+eL8ZKXRkAsAo/AO9eYLK3Pmksk9SK1NVbVJ9FWj8=;
        b=Ct1Y7coqPOJBBXKuzsZ8/F7NFQELirSayth2PFsyvR+fgUwyRjyzUsHuTh0uU7gqMI
         Ihjkzjcwp3DGKvKqD5VulvAdrPiNUXCLF2Bzwq5RerjTtaj94ckWcPHBkZiFniCWqMiI
         DiC1b4w2s/Ycyi6pFWv/rafKTaPrbrpPEh6/aZGLrfkIhC2mSgk4TIONk15ZOS8Z6zt7
         4G+l6HjafNIhCV7R3gspFCZC/4Ic65QCICbuwC1R6YDrTq8ZOre8gVLtnSPJBYLv7JAP
         fjMix1+jE4o2XVJE2kxSsIeQ/G9x2+DHyyf3alEtX019Aqo6izmlmzLoQh3qai/HfWrz
         I91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685446724; x=1688038724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8+eL8ZKXRkAsAo/AO9eYLK3Pmksk9SK1NVbVJ9FWj8=;
        b=REg+LFNGiqN5zYmsNeYTR1Pi9fp+PPB0ankFm4Ldito5nPWsWSlfmRoo2vj6Z6hkYX
         hy05ks06bWpk3oqUAkuHIpQdg9nQjGE0Yzq0/7a56wwvfQ5xoLXygS/qih40g2UGZH6s
         zJ/oj2vlEL8De/zRO4ankTu9+6HEPxEdb6sdqkLdv2XqvGjDX/RDzcvsitsAdwu4g5zY
         hRf2NI/tqX/5jI89Q5LCeaHNrDvA2LhcFovOnTYCNdoU7aTiPyB6M1UY1dDInO8IWc09
         MkDs/0JctfCIVS9XdxpkRmUuhzxQD+fYd+w/QdUgiuqatnBV2oq3FvcG5gLh2RmuaFNU
         i94g==
X-Gm-Message-State: AC+VfDxA3kYy4SSkdyAlTXRTG1U0gADPtETO8Eqs5tqE9pZ7Vz0DOrry
        FEef131+BBM6+uR/5QGSBn19xQ==
X-Google-Smtp-Source: ACHHUZ6IkRlG0eu1J5bKPyObMUekncsWIw3Ks56So9hGD0QfRym5sN39gmF8vANktlB0R3KV1NZHgg==
X-Received: by 2002:a17:906:6a27:b0:966:17b2:5b0b with SMTP id qw39-20020a1709066a2700b0096617b25b0bmr2060821ejc.49.1685446724451;
        Tue, 30 May 2023 04:38:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906151000b0096b15e4ffcesm7201757ejd.85.2023.05.30.04.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 04:38:44 -0700 (PDT)
Message-ID: <cd06b0f4-fb86-cc16-5a80-b4896b5c4cd9@linaro.org>
Date:   Tue, 30 May 2023 13:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: DT checker RS485 unevaluated property, 8250 OMAP UART
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>
References: <ZGefR4mTHHo1iQ7H@francesco-nb.int.toradex.com>
 <0cb182f8-eb53-45d8-3c8b-fb7d16f88d46@ti.com>
 <ZHXMMHQ9VevVtqHz@francesco-nb.int.toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZHXMMHQ9VevVtqHz@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30/05/2023 12:13, Francesco Dolcini wrote:
> On Sat, May 27, 2023 at 11:49:17AM +0530, Vignesh Raghavendra wrote:
>> On 19/05/23 9:39 pm, Francesco Dolcini wrote:
>>> Hello,
>>> while writing a new DT file I stumbled across this warning
>>>
>>> .../arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-dev.dtb: serial@2810000: Unevaluated properties are not allowed ('rs485-rts-active-high' was unexpected)
>>> 	From schema: .../Documentation/devicetree/bindings/serial/8250_omap.yaml
>>>
>>> The property is currently used in the OMAP serial driver
>>>
>>> drivers/tty/serial/omap-serial.c
>>> 1511:	if (of_property_read_bool(np, "rs485-rts-active-high")) {
>>>
>>
>> Would be it possible to update driver to imply rs485-rts-active-high"
>> this by lack of rs485-rts-active-low property in DT instead?
> 
> What about backward compatibility? This is what is done in all drivers
> apart omap-serial if I'm not wrong.

Uh, I removed too much in that commit. We need to keep backwards
compatibility because driver used default (missing property) as active low.


> 
>>> I would be inclined to send the following patch, do you agree?
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
>>> index eb3488d8f9ee..e634e98aa994 100644
>>> --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
>>> +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
>>> @@ -70,6 +70,7 @@ properties:
>>>    dsr-gpios: true
>>>    rng-gpios: true
>>>    dcd-gpios: true
>>> +  rs485-rts-active-low: true
>>
>> I believe you mean rs485-rts-active-high here
> whoops, yes of course.

Yes, with a Fixes tag.

> 
>>
>>>    rts-gpio: true
>>>    power-domains: true
>>>    clock-frequency: true
>>>
>>> [1] https://lore.kernel.org/all/ZBItlBhzo+YETcJO@francesco-nb.int.toradex.com/
>>>
>>
>> Also, I hope you are using 8250_ompa.c and not omap-serial.c for newer
>> designs. omap-serial.c is mostly there to support legacy SoCs and not to
>> be used with K3 SoCs.
> 
> Thanks for this head-up. This confused myself, while the issue I
> reported here is real, it does affect only omap-serial.c. In my case I
> am using 8250_omap.c and I can just omit the property from the DTS as
> generally expected!

OK. Are you going send a fix for original issue?

Best regards,
Krzysztof

