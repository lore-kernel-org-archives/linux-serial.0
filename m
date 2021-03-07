Return-Path: <SRS0=PbAg=IF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E24C433DB
	for <linux-serial@archiver.kernel.org>; Sun,  7 Mar 2021 11:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5580564FF2
	for <linux-serial@archiver.kernel.org>; Sun,  7 Mar 2021 11:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCGLmr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 7 Mar 2021 06:42:47 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:43842 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCGLmf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 7 Mar 2021 06:42:35 -0500
Received: by mail-ej1-f53.google.com with SMTP id p8so14237536ejb.10;
        Sun, 07 Mar 2021 03:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bpPJ6IkOTz50xq4H5ZvnUgMjnZj0Dmv5rdRTqFH842A=;
        b=bNKYnkY7fXyPlqmdzd/fdL9PH+iIPJYoGcBAiQFhx29Bzia+V3FO+2dGQVmTrK3FGf
         HcYWuQE4xVZmcT5827Qn+GUFYHp1fkNb3jz/qfq2vmU5MOnZvTZCsZBLbW4vsfiF6BoW
         0/qR52yuWCAbupE4E39C+8dUdmDSm4Cg4EUbXnVGc+Z+4ZCiJXgwqm8SZPmoEwyM8PCA
         gFyCELh5ucIJJDyc2kTFGNovI8N13gEjwyfLEbsj/xAVBTHzEu0d6rYpZBU7DFD1NdpE
         +ZsO0XOJJUjwg1YIYNTmePrzCM+ccNgLIeMZdQYQUpMaJXXfMPYtYA76c/yIaE2SMuwT
         KICQ==
X-Gm-Message-State: AOAM5328M5IjB+Hk3zfemQZ7BD+voQ4NQRpKoUpnFQ0H1G59aIedMJMI
        SfaiVx8PrZUQiNxG7DgVw2KFtiHtqD4=
X-Google-Smtp-Source: ABdhPJw8bkYXg0UrngrTNBlLXiMcM4iLzMiC1wwB0BKVtRhAJLIdnEQhfmvNOaPmXgihmfT4n3FlCQ==
X-Received: by 2002:a17:907:9863:: with SMTP id ko3mr10480992ejc.543.1615117352917;
        Sun, 07 Mar 2021 03:42:32 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id x21sm5210276eds.53.2021.03.07.03.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 03:42:32 -0800 (PST)
Subject: Re: [PATCH 2/2] dt-bindings: serial: samsung: include generic
 dtschema to match bluetooth child
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210212163905.70171-1-krzk@kernel.org>
 <20210212163905.70171-2-krzk@kernel.org>
 <20210305204938.GA613254@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <6ff17125-5c71-70f9-5042-c73eac12f4c9@kernel.org>
Date:   Sun, 7 Mar 2021 12:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305204938.GA613254@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05/03/2021 21:49, Rob Herring wrote:
> On Fri, Feb 12, 2021 at 05:39:05PM +0100, Krzysztof Kozlowski wrote:
>> Include the generic serial.yaml dtschema so the child node like
>> "bluetooh" will be properly matched:
>>
>>   arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml:
>>     serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  .../bindings/serial/samsung_uart.yaml         | 26 ++++++++++++++++++-
>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>> index 3e29b561223d..f4faf32ab00f 100644
>> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>> @@ -78,9 +78,11 @@ required:
>>    - interrupts
>>    - reg
>>  
>> -additionalProperties: false
>> +unevaluatedProperties: false
>>  
>>  allOf:
>> +  - $ref: /schemas/serial.yaml#
>> +
>>    - if:
>>        properties:
>>          compatible:
>> @@ -134,3 +136,25 @@ examples:
>>                   <&clocks SCLK_UART>;
>>          samsung,uart-fifosize = <16>;
>>      };
>> +
>> +  - |
>> +    #include <dt-bindings/clock/exynos4.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    serial@13800000 {
>> +        compatible = "samsung,exynos4210-uart";
>> +        reg = <0x13800000 0x100>;
>> +        interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
>> +        clock-names = "uart", "clk_uart_baud0";
>> +        dmas = <&pdma0 15>, <&pdma0 16>;
>> +        dma-names = "rx", "tx";
>> +        pinctrl-0 = <&uart0_data &uart0_fctl>;
>> +        pinctrl-names = "default";
>> +
>> +        bluetooth {
>> +            compatible = "brcm,bcm4330-bt";
> 
> Do we need a whole new example for this?

No, we don't need it. I find examples useful but if you prefer to have
them smaller, then I can skip it.

Best regards,
Krzysztof
