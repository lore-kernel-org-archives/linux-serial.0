Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23954C77B73
	for <linux-serial@archiver.kernel.org>; Tue,  2 May 2023 11:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjEBLK5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 May 2023 07:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjEBLK4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 May 2023 07:10:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D16F120
        for <linux-serial@vger.kernel.org>; Tue,  2 May 2023 04:10:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-95678d891d6so752929566b.1
        for <linux-serial@vger.kernel.org>; Tue, 02 May 2023 04:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683025853; x=1685617853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRRTwUe+8V8C3INWsF+uYeBnZ+q4L2TYyWhCbOPcdtw=;
        b=RW7ycB1m8VOj8uM1EfpHUvHLFgrI6VgDk9AXMg2jnDuKpDHc+0mxj0zGCso5vSTplt
         uGxiPhCniPgPeQLDilqbbwqR1DzB7U4l7/GIG9+Paq4Q2vx8n9m26fm1hCqJ56yemNI1
         3LCd7tnpOC0fcifB4EoJivZLoWoOrIDuT6REKenvl17FFPvUTKwqTqzG4vxh0f5gXXES
         ReXVmATu4ShQRoF/ar+p7meW5jUkHdXINkkIgCbi1HDc9V4zm22DgwwrbXVU/RITg4vB
         wh/PxGIFC1AVfnDxT6nkumuHdDOv44NZcX9GbvapDbh7cWITS23J7QLIeAGMhVhEczDe
         JmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683025853; x=1685617853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRRTwUe+8V8C3INWsF+uYeBnZ+q4L2TYyWhCbOPcdtw=;
        b=TTt9e3qsNeKqogsSgPV4b2Qep7KkGNHd9YEr1w2QyUSq/EEyD2FIzch+Wa1WodvCQM
         0L7jlN38X8pYVeQBMtCpZcKJ4BSLIvArix/7G2ro6KuKbyA+5CZLIZCJat5vw4YmN823
         jbLjSEoqSWMoMQrpy51PF/B+hyuOhiI7JvtqYiqiIgw42ZY5fW3zPQphrFTVw1wx5L90
         apKjppoqMp4vY2Fj5i47dKchjAN9ZfeLKyp5SpkVs5/2gXd1hFlQmaEn9CXdACikw+zn
         oE5Akj/bhtG7m8uZgg7B3MS3VXpWZO0A6v/bje6v9zcDjQBHfGURfLlZNS8jkJlMfilA
         HNeg==
X-Gm-Message-State: AC+VfDy5IA12ABdjkEdoG2itOPv125oQJJciy5lNU9DG97EWbsF+6y9F
        YrLUCUmN3/VA9w6NAC9AY3F9Lw==
X-Google-Smtp-Source: ACHHUZ4R5e8YLeyQwZZx7DFS3VaT5IAFYCg7UKjsyeLxhKtq/0e+ASOuERaYoXOpT8hnW8m8EUAAtQ==
X-Received: by 2002:a17:907:9716:b0:961:272d:bdbe with SMTP id jg22-20020a170907971600b00961272dbdbemr11408909ejc.35.1683025853547;
        Tue, 02 May 2023 04:10:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id hz19-20020a1709072cf300b009629ffabe0asm838524ejc.224.2023.05.02.04.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 04:10:53 -0700 (PDT)
Message-ID: <f82ed326-3064-a2e5-32fc-e3fe6ff8a1e1@linaro.org>
Date:   Tue, 2 May 2023 13:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] dt-bindings: Add optional gpio property to uartps
 node to support rs485
To:     Michal Simek <michal.simek@amd.com>,
        "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>,
        Rob Herring <robh@kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>,
        "manion05gk@gmail.com" <manion05gk@gmail.com>
References: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
 <1682512187-8828-2-git-send-email-manikanta.guntupalli@amd.com>
 <20230427164351.GA3146210-robh@kernel.org>
 <DM4PR12MB6109C2BCDFD616AE37E10B9A8C6F9@DM4PR12MB6109.namprd12.prod.outlook.com>
 <59b9214a-19e6-fd4e-6982-6e8c28c7e4a8@linaro.org>
 <39d3e076-94ad-a349-5df6-b6e78714e407@amd.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <39d3e076-94ad-a349-5df6-b6e78714e407@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 02/05/2023 12:57, Michal Simek wrote:
> 
> 
> On 5/2/23 12:19, Krzysztof Kozlowski wrote:
>> On 02/05/2023 12:14, Guntupalli, Manikanta wrote:
>>> Hi Rob Herring,
>>>
>>>> -----Original Message-----
>>>> From: Rob Herring <robh@kernel.org>
>>>> Sent: Thursday, April 27, 2023 10:14 PM
>>>> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
>>>> Cc: gregkh@linuxfoundation.org; krzysztof.kozlowski+dt@linaro.org;
>>>> michal.simek@xilinx.com; linux-serial@vger.kernel.org;
>>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> jirislaby@kernel.org; linux-arm-kernel@lists.infradead.org; Simek, Michal
>>>> <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>; Pandey,
>>>> Radhey Shyam <radhey.shyam.pandey@amd.com>; Datta, Shubhrajyoti
>>>> <shubhrajyoti.datta@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
>>>> manion05gk@gmail.com
>>>> Subject: Re: [PATCH 1/2] dt-bindings: Add optional gpio property to uartps
>>>> node to support rs485
>>>>
>>>> On Wed, Apr 26, 2023 at 05:59:46PM +0530, Manikanta Guntupalli wrote:
>>>>> Add optional gpio property to uartps node and add reference to rs485.yaml
>>>>
>>>> The diff tells me that already. Why?
>>> Please check Figure 11-3 (Page number 37) in the below mentioned data sheet, It shows PMOD (ISOW14x2) devices used in half duplex configuration. Driver outputs Y and Z are shorted to A and B respectively. This reduces overall cabling requirements. Also DE/RE are shorted to each other, and at a time, any node acts as either a driver or a receiver.
>>> Using above optional GPIO controlling driver or a receiver. This GPIO is optional because it is not required for uart console node.
>>>
>>> Here,
>>> DE - Driver enable. If pin is floating, driver is disabled (internal pull-down resistor)
>>> RE - Receiver enable. If pin is floating, receiver buffer is disabled (internal pull-up resistor)
>>>
>>> Datasheet:
>>> https://www.ti.com/lit/ds/symlink/isow1432.pdf?ts=1682607122706&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FISOW1432%252Fpart-details%252FISOW1432DFMR%253FkeyMatch%253DISOW1432DFMR%2526tisearch%253Dsearch-everything%2526usecase%253DOPN
>>
>> Your request for us to get into some datasheet somewhere, to get the
>> answer to the basic question, is not reasonable. Commit must justify its
>> existence, not some external source.
> 
> Not really. Manual itself just shows picture of that connection if you are 
> interested.
> On schematics it looks like that DE and /RE are just handle via one gpio. That's 
> why you need 3 wires instead of 4. Definitely it should be described better.

By looking at commit reviewer did not figure out why do we need it.
Referencing datasheet in a reply in LKML thread does not solve it
because the next person reading the commit might have the same question.

The commit must answer to "why" if this is not obvious. I don't find
responses "Please check..." to this helpful.


Best regards,
Krzysztof

