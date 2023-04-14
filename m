Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0FFC77B70
	for <linux-serial@archiver.kernel.org>; Fri, 14 Apr 2023 07:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjDNHrD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Apr 2023 03:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjDNHq7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Apr 2023 03:46:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1326C44B2
        for <linux-serial@vger.kernel.org>; Fri, 14 Apr 2023 00:46:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j17so33847019ejs.5
        for <linux-serial@vger.kernel.org>; Fri, 14 Apr 2023 00:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681458415; x=1684050415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dt+A98jlqtbpeel2naOzylBvCk3G6/Q++nwH3epknTU=;
        b=gfgztzkwvm4gf2aIWjlZL3RjZrGc0EZbhfb1YHOpNB6u39HnCow+CWMOaNCQj4TGd0
         BTuA5kO/54Nu9izUwi6RyrymuJS0Ulvplwl/7s+cbRW3E+SCyuxEkIoIOw+Xabo7hDPB
         o31RWBIw3tMXtjlbuW51hsEkS6eW+aSOOcF0xuUA1HpAmaxXvR6UGkgl1+sR0q2uIUnZ
         lkslhm+GNb6ZoIrlae0uYFI2+SL2COzOKo4aw7LzzTdPvXPSTppDOz6QbhmkZ2MtBRpP
         Y4XONL446Ax/S2IH7glLnIimLeeiPa+RKmfqp1nsSD6GjhkfTNucg3tQEtg7Koj4HygL
         3BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681458415; x=1684050415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dt+A98jlqtbpeel2naOzylBvCk3G6/Q++nwH3epknTU=;
        b=dCf2AI8qkmmLynQEIXREz7x2vgEpB3FJlFasROPtvK4vko5UnAn65t0Q070hrIWXsp
         NCo2JROiLWvuyQ+QBTYc9HxPRSRzqaWQB1brEvpEsNClPK47H3RCegmZhIguaPnt5oDG
         f9+pDA+BFoysy6i+umHHfXmC2tlEQQHCcGu6T8sqB/bY4+W6q5QQku70lqVJHTp3ej/n
         QCnZhPeokpnRgFZ6mkXBb9YOM3nUrJwLAhNCKpVzjttr9y8eYojM90joZzaQBPGEPtCm
         ZIlSrBfgb0co9GQ3HOEgoyRFsCRfjdNETh2GTi1fXri0ottUDLtTb2HW7PlHPqywUf01
         beSQ==
X-Gm-Message-State: AAQBX9dGE3qwQVQI1yBJqftCSvR+YzNXp7kIBXqG+HRA1dce9ct881lO
        grGc/2qpLHl1JkD+DLLGMEHLGQ==
X-Google-Smtp-Source: AKy350bLBmexUEFzr5LRWNNM6G7YHG2r1iyM3NyfBneNEodYOJT8tqYAQv0G0zNqUi4S+WfZ7YXsOw==
X-Received: by 2002:a17:906:e2c7:b0:94e:e049:6d2a with SMTP id gr7-20020a170906e2c700b0094ee0496d2amr1504414ejb.66.1681458415547;
        Fri, 14 Apr 2023 00:46:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906314200b0094bb4c75695sm2023228eje.194.2023.04.14.00.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 00:46:55 -0700 (PDT)
Message-ID: <4b9a0f13-d03a-8496-a400-8621b8d7c98a@linaro.org>
Date:   Fri, 14 Apr 2023 09:46:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 12/12] MAINTAINERS: Add entry for NUVOTON MA35
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-13-ychuang570808@gmail.com>
 <241f6cb1-193f-d372-0eda-157946b15780@linaro.org>
 <91861072-dc2d-46d3-dc0d-26d17a3693c7@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <91861072-dc2d-46d3-dc0d-26d17a3693c7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14/04/2023 03:22, Jacky Huang wrote:
> Dear Krzysztof,
> 
> 
> On 2023/4/14 上午 01:01, Krzysztof Kozlowski wrote:
>> On 12/04/2023 07:38, Jacky Huang wrote:
>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>
>>> Add entry for Nuvoton ma35d1 maintainer and files.
>>> In addition, update board binding paths of NUVOTON NPCM.
>>
>>>   ARM/NUVOTON NPCM ARCHITECTURE
>>>   M:	Avi Fishman <avifishman70@gmail.com>
>>>   M:	Tomer Maimon <tmaimon77@gmail.com>
>>> @@ -2512,7 +2522,8 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
>>>   S:	Supported
>>>   F:	Documentation/devicetree/bindings/*/*/*npcm*
>>>   F:	Documentation/devicetree/bindings/*/*npcm*
>>> -F:	Documentation/devicetree/bindings/arm/npcm/*
>> It is not a bisectable change.
>>
>> Best regards,
>> Krzysztof
>>
> 
> F:    Documentation/devicetree/bindings/*/*/*npcm*
> F:    Documentation/devicetree/bindings/*/*npcm*
> F:    Documentation/devicetree/bindings/arm/nuvoton/*npcm*    <-- remove 
> this
> F:    Documentation/devicetree/bindings/soc/nuvoton/*npcm* <-- remove this
> 
> Yes, the two statements at the bottom seem redundant. I will remove them.

I did not comment about "redundant". I used the word "bisectable". git
help bisect.

Best regards,
Krzysztof

