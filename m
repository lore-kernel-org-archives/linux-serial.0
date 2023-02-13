Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A38BC636D4
	for <linux-serial@archiver.kernel.org>; Mon, 13 Feb 2023 08:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjBMI0i (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Feb 2023 03:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjBMI0g (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Feb 2023 03:26:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093AAD53D
        for <linux-serial@vger.kernel.org>; Mon, 13 Feb 2023 00:26:35 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bu23so11219076wrb.8
        for <linux-serial@vger.kernel.org>; Mon, 13 Feb 2023 00:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=btO60ISoDCCCjTcPpziOha13/oZmmCzb4CppffdGSyY=;
        b=gr4M0c/pg7b5rnZdTelGKeUp1CUT7jgyAu7Gnr/6ZPg00dOs/xv89xcBxRJ+qCq5ks
         ESzOjB+5nadbC9CZT/jWVI8ssqVtXW5zlk9AUEbtPdgj1m1fIO1yQ+g8NcX6Fz1ugrdm
         S4L5YsEIBxuwsQ6OLGnRt6oCIEzywdM6kHsB+of/uxp+kTxzP5bevO5VW7kytQ5c94Dy
         TSva52bcWqWhzHdhKwkVLBwWowdYS8kd1StX1Cht7UehP2RaqPOOuQwictCc9WYU8Td3
         LoorLJL+Q7ciGIEK4Fk7OUPIMCXgyQjkOBJMQpD2M6jhmu5UScGPAdk1bOI4dZ6ijYh9
         CekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btO60ISoDCCCjTcPpziOha13/oZmmCzb4CppffdGSyY=;
        b=1JkXwGtydmPYR0fBQMwuhdgV0IFZCZMmQC/M4KfGVXg8zFtFX4uR6SVupOM8F4g2fG
         gGm/n5PSZDBb7tELhWba5lAJWjXb4R5j+ntpxPZBkYm6x1cVtLRv4He238+yfRFg0RyJ
         +UvsIwMNYWASBY7raZF5JhH/gYFVCG1ZxGn9WTgK21hedLJP7DsAo24QrmOvDVH3U8Js
         /gIPOd8QgwLJC8AzJT+NnVFj8cxCp2pQXPi6KdpZn9hJd89BzGrzPvls0X84VPPuy8m0
         jIPGlgDB5pKdwBl7v2jHXhEhOkp7yGjzKPFlkGdEpPh2YLZPTD6E7MBF4UcqBJwrsn+Z
         4ilA==
X-Gm-Message-State: AO0yUKV+70r9q7HY9L3A4rjvpEb3/hAS/FDg54IvFx6Y0idYQckIPiBP
        KbjPPu/mGBC+/B02Jo/V6MKQmwelhLwLOagB
X-Google-Smtp-Source: AK7set8oFpGy0A60H1v9tSrwcMLpV6gVgI9davXRbD298V+rJ6N2lRPxcI4WwJ00q/18K0ETDrA4zQ==
X-Received: by 2002:a05:6000:1d2:b0:2bf:b661:87d9 with SMTP id t18-20020a05600001d200b002bfb66187d9mr19450135wrx.50.1676276793536;
        Mon, 13 Feb 2023 00:26:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d13-20020adfe88d000000b002c54f4d0f71sm5057137wrm.38.2023.02.13.00.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 00:26:33 -0800 (PST)
Message-ID: <e09d6807-a548-0218-5ff0-274668f1eb94@linaro.org>
Date:   Mon, 13 Feb 2023 09:26:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] dt-bindings: aspeed: Add UART controller
To:     ChiaWei Wang <chiawei_wang@aspeedtech.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
 <20230210072643.2772-2-chiawei_wang@aspeedtech.com>
 <2d0d1866-95f9-942d-57e0-06a5ed17d35d@linaro.org>
 <KL1PR0601MB3781A9E9E209F2E94CE2F08D91DD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <KL1PR0601MB3781A9E9E209F2E94CE2F08D91DD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 13/02/2023 02:57, ChiaWei Wang wrote:
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, February 10, 2023 5:13 PM
>>
>> On 10/02/2023 08:26, Chia-Wei Wang wrote:
>>> Add dt-bindings for Aspeed UART controller.
>>
>> Describe the hardware. What's the difference against existing Aspeed UART
>> used everywhere?
> 
> The description will be revised to explain more for UART and Virtual UART controllers.
> 
>>
>>>
>>> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
>>> ---
>>>  .../bindings/serial/aspeed,uart.yaml          | 81
>> +++++++++++++++++++
>>>  1 file changed, 81 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/serial/aspeed,uart.yaml
>>
>> Filename: aspeed,ast2600-uart.yaml
>> (unless you are adding here more compatibles, but your const suggests that it's
>> not going to happen)
>>
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/aspeed,uart.yaml
>>> b/Documentation/devicetree/bindings/serial/aspeed,uart.yaml
>>> new file mode 100644
>>> index 000000000000..10c457d6a72e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/serial/aspeed,uart.yaml
>>> @@ -0,0 +1,81 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/serial/aspeed,uart.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Aspeed Universal Asynchronous Receiver/Transmitter
>>
>> This title matches other Aspeed UARTs, so aren't you duplicating bindings?
>>
>>> +
>>> +maintainers:
>>> +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
>>> +
>>> +allOf:
>>> +  - $ref: serial.yaml#
>>> +
>>> +description: |
>>> +  The Aspeed UART is based on the basic 8250 UART and compatible
>>> +  with 16550A, with support for DMA
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: aspeed,ast2600-uart
>>> +
>>> +  reg:
>>> +    description: The base address of the UART register bank
>>
>> Drop description
> 
> Will revise as suggested.
> 
>>
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    description: The clock the baudrate is derived from
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    description: The IRQ number of the device
>>
>> Drop description
> 
> Will revise as suggested.
> 
>>
>>> +    maxItems: 1
>>> +
>>> +  dma-mode:
>>> +    type: boolean
>>> +    description: Enable DMA
>>
>> Drop property. DMA is enabled on presence of dmas.
>>
>>> +
>>> +  dma-channel:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: The channel number to be used in the DMA engine
>>
>> That's not a correct DMA property. dmas and dma-names git grep dma --
>> Documentation/devicetree/bindings/
>>
>>
>>> +
>>> +  virtual:
>>> +    type: boolean
>>> +    description: Indicate virtual UART
>>
>> Virtual means not existing in real world? We do not describe in DTS
>> non-existing devices. Drop entire property.
> 
> The virtual property indicates it is a Virtual UART device.

vuart already has its bindings, so you do not need this in such case.

> VUART of Aspeed SoC is actually a FIFO exposed in the 16550A UART interface.
> The one head of the FIFO is exposed to Host via eSPI/LPC and the other one is for BMC.
> There is no physical serial link between Host and BMC. And thus named as Virtual UART.

I don't understand what is the virtual in terms of hardware. How you
route your serial lines does not change the type of the device. You need
to describe the hardware in Devicetree, not some concepts for system.

> 
>>
>>> +
>>> +  sirq:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: The serial IRQ number on LPC bus interface
>>
>> Drop entire property.
> 
> Mandatory for Virtual UART

It's not a explanation why this is a property suitable for Devicetree.
IRQ numbers are given via interrupts field.

> 
>>
>>> +
>>> +  sirq-polarity:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: The serial IRQ polarity on LPC bus interface
>>
>> Drop entire property.
> 
> Mandatory for Virtual UART
> 

Same here, this is a flag for interrupts field.


Best regards,
Krzysztof

