Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59365C83005
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jun 2023 14:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbjFGOrG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Jun 2023 10:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbjFGOrE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Jun 2023 10:47:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788AA1BDD
        for <linux-serial@vger.kernel.org>; Wed,  7 Jun 2023 07:47:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-97454836448so1000087466b.2
        for <linux-serial@vger.kernel.org>; Wed, 07 Jun 2023 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686149220; x=1688741220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ROukzxyZ7E77MUkCsxPohsdtun3OnHgSrL1II1lH7wI=;
        b=WWd2+wszBOuo6lg4yIXaTNk0oGXMLVaJa9XmC04N20cqowFVHqTPTt/1CcEx/8YKfA
         Vb1V9ZPB1NwCNTAyk8xmZDr6mGbzmRtxhW2fHk2HdNKjNfTy4CzSjoVkq/eNI3Kgtudi
         pygBRiQSz3k1mBgFVPrC6lqby2Yrbnp1g5Rd2aCwGDAVt92HI4YsrtT7V200O59fSLqz
         7IFQTf9T95v3cI+OXz15MP6lGDDbqaePaE8Ref0UuTIM6L3nbM34fLJOVANs4fpl1BeM
         C+JFjI8VPNby1c5TXZsnZ66b96cpEGRG3/FriPQlFPp9JhgS3tONRBnlS8pGXJ0v3pve
         cdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686149220; x=1688741220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROukzxyZ7E77MUkCsxPohsdtun3OnHgSrL1II1lH7wI=;
        b=fKaiwbEJdC5/LdoE3Bzf3gSNG2EmN9l3LsqkAnfDTQXFreIGhBGPCL1fnnmiZGctTS
         IV1YVWxhJPi/ZaBwNaQUDw2VKwZqyfVrN6Fq4qgWiBMKtGZtzJAphumTAgwiFQEXYk6L
         CE4g90DZ5ey6emMVFXOp5Y3CIrmIEomnl4RFc/GB5SAbNkBI70zWwfP1wAPkxjen9u9m
         vR8dmc4P0rxg0ouYn7QMvdpSy8MEStGAzD/RLJ5q2H9vsJWsbmvUXvZNshLHcGpy12wf
         QZ31t/Tyn9I3WGy5HL8lGsJr58iuySXndTXkQRgLj6q+hTv+gxbCTbDB9CrD+L29Bhjw
         t8uA==
X-Gm-Message-State: AC+VfDw7twDpMakc6Zyx1KUyC8QjcY34if4FHanlJJj6QEgSQZ9eaEdx
        RR+15yYCyPAN3Ded6D7c2SCvhA==
X-Google-Smtp-Source: ACHHUZ5YuQYIyKPZdjXVsdWlZb7kj4qqMWl42TOAf1VZDpEWMhMk9NTMS5a2gZeOcREeJ2bXi463Gg==
X-Received: by 2002:a17:907:3e28:b0:978:8e58:e19f with SMTP id hp40-20020a1709073e2800b009788e58e19fmr555105ejc.16.1686149219926;
        Wed, 07 Jun 2023 07:46:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lh9-20020a170906f8c900b0097812e2b66csm2911059ejb.111.2023.06.07.07.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 07:46:59 -0700 (PDT)
Message-ID: <a6301c0e-b774-8963-8eb1-8e0948b1468c@linaro.org>
Date:   Wed, 7 Jun 2023 16:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 05/10] dt-bindings: sc16is7xx: Add property to change
 GPIO function
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        jesse.sung@canonical.com, isaac.true@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
References: <20230607140525.833982-1-hugo@hugovil.com>
 <20230607140525.833982-6-hugo@hugovil.com>
 <f5cfc81d-d8ae-d270-f29a-c2b45b07a651@linaro.org>
 <20230607104100.0186b1afc872e583cb9466b8@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607104100.0186b1afc872e583cb9466b8@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 07/06/2023 16:41, Hugo Villeneuve wrote:
> On Wed, 7 Jun 2023 16:30:26 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 07/06/2023 16:05, Hugo Villeneuve wrote:
>>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>>
>>> Some variants in this series of UART controllers have GPIO pins that
>>> are shared between GPIO and modem control lines.
>>>
>>> The pin mux mode (GPIO or modem control lines) can be set for each
>>> ports (channels) supported by the variant.
>>>
>>> This adds a property to the device tree to set the GPIO pin mux to
>>> modem control lines on selected ports if needed.
>>>
>>> Cc: <stable@vger.kernel.org> # 6.1.x
>>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>> Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
>>> ---
>>>  .../bindings/serial/nxp,sc16is7xx.txt         | 46 +++++++++++++++++++
>>>  1 file changed, 46 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>>> index 0fa8e3e43bf8..1a7e4bff0456 100644
>>> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>>> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>>> @@ -23,6 +23,9 @@ Optional properties:
>>>      1 = active low.
>>>  - irda-mode-ports: An array that lists the indices of the port that
>>>  		   should operate in IrDA mode.
>>> +- nxp,modem-control-line-ports: An array that lists the indices of the port that
>>> +				should have shared GPIO lines configured as
>>> +				modem control lines.
>>>  
>>>  Example:
>>>          sc16is750: sc16is750@51 {
>>> @@ -35,6 +38,26 @@ Example:
>>>                  #gpio-cells = <2>;
>>>          };
>>>  
>>> +	sc16is752: sc16is752@53 {
>>
>> Since you keep sending new versions, fix the names. nNode names should
>> be generic. See also explanation and list of examples in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> Hi,
> by the way, I do not "keep sending new versions" just for the fun of
> it...

Sure, I know. So when the next version is necessary to send, fix also this.

>
> Even after reading your link, I cannot see what is wrong with that
> name.

They are not generic. They are specific.

> 
> You are the first one since V1 to think it is inappropriate.
> 
> Please suggest what the name should be.

Depends what this is. I know nothing about this device, so I cannot
suggest you. Therefore I gave you link with ideas to choose from.

Best regards,
Krzysztof

