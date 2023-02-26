Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB661C64ED6
	for <linux-serial@archiver.kernel.org>; Sun, 26 Feb 2023 15:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBZPmS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 26 Feb 2023 10:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBZPmR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Feb 2023 10:42:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8706F93DD
        for <linux-serial@vger.kernel.org>; Sun, 26 Feb 2023 07:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677426078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWuCETYlGm5nXIPBM19Dg25vOC37BZrnNuNH9S7qgEM=;
        b=Oha153I3KeoSKr6a7fhVWnEc19Bb+ruBbYzxC6YxQFuiXbeiMVY4L/25v19vEpMVkt+Ygu
        0FjDCx2Kd5M6CejLIFGPh8iviufB00sJE2cwLuzkQKl01jOInyeLSxTtVEUwbHsG+lmYI3
        mKfed9F6WDjzvph5yWbVZUOn5MBM8VM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-352-vcJmD_GuNHSdC_BJY2Ni2A-1; Sun, 26 Feb 2023 10:02:10 -0500
X-MC-Unique: vcJmD_GuNHSdC_BJY2Ni2A-1
Received: by mail-qk1-f198.google.com with SMTP id 19-20020a370c13000000b007428253bb55so2566423qkm.23
        for <linux-serial@vger.kernel.org>; Sun, 26 Feb 2023 07:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWuCETYlGm5nXIPBM19Dg25vOC37BZrnNuNH9S7qgEM=;
        b=qIcRxGI+PSFZKz5uH5xvTwMDLNBuWw6pavq98DS7ki0dTii16MMBRT2GK7CAKMZMCI
         sYgigI6BrSCkCPRQ+wnuyEKhsd5+p9R1t93GqKn5MOuutDGr7ouUUWY539IIz0juv8xL
         q4/QF6DYT/W+eRqeUmqTdxZ13EPFmHSC/iBCbxj7V1I4XyeI68mkB26D+s+f8jSJ2whY
         aigyjscyAN1/PUb1PF3OYziuEmYoWQgOm4XQNGFcrq/eo37645ZQiHUQoYuNnRxr0yfM
         /XLzXH3tvaq2x/gBjc52v0lGdtpXSm0SqTGit9KwS5XNt69ihIXWRQbolonsE54K7qFO
         FYnQ==
X-Gm-Message-State: AO0yUKVa2KvDG1wNo5cOWSzbrMFXK4NO8hKq3TlA7Mhv6hKxdXacf4O5
        swg0aom5pqXysPoiKVTN+uTW+y2REYxMioJejVfPSiuBMwaOF5gowZsF+4Y/vPYmagV5pWNSoVZ
        uhQm0T44huhr7AAcDnIRRb/oW
X-Received: by 2002:ac8:584f:0:b0:3ba:ef:fc0e with SMTP id h15-20020ac8584f000000b003ba00effc0emr38862243qth.57.1677423730308;
        Sun, 26 Feb 2023 07:02:10 -0800 (PST)
X-Google-Smtp-Source: AK7set/SXesiOhOnAgh3EpQdbpIYg1w5jnpyIXaoHzasz8z/7gzWSqqsQylwzoVbm8kRJ4sdLh/n4w==
X-Received: by 2002:ac8:584f:0:b0:3ba:ef:fc0e with SMTP id h15-20020ac8584f000000b003ba00effc0emr38862208qth.57.1677423729999;
        Sun, 26 Feb 2023 07:02:09 -0800 (PST)
Received: from [192.168.1.19] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id p3-20020ac84083000000b003b9a573aec6sm2982825qtl.70.2023.02.26.07.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 07:02:09 -0800 (PST)
Subject: Re: [PATCH] tty: serial: fsl_lpuart: select SERIAL_FSL_LPUART for
 SERIAL_FSL_LPUART_CONSOLE
To:     Randy Dunlap <rdunlap@infradead.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230225173949.651311-1-trix@redhat.com>
 <0f8a8857-5e18-e49a-0361-197b4bc892ab@infradead.org>
 <026ee207-3b90-c7ae-a7fd-66a34cd3ee90@redhat.com>
 <6dd89251-f4d6-8051-8ecf-cdea7d23bc68@infradead.org>
 <c3ca14dc-14d0-959c-0f55-8f584457db33@infradead.org>
 <9a16ee6f-5a49-167e-fc33-9ca147b3686a@infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e767cb93-eb46-a82c-186c-68d12cefce31@redhat.com>
Date:   Sun, 26 Feb 2023 07:02:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9a16ee6f-5a49-167e-fc33-9ca147b3686a@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 2/25/23 10:38 AM, Randy Dunlap wrote:
>
> On 2/25/23 10:16, Randy Dunlap wrote:
>>
>> On 2/25/23 10:03, Randy Dunlap wrote:
>>>
>>> On 2/25/23 09:51, Tom Rix wrote:
>>>> On 2/25/23 9:46 AM, Randy Dunlap wrote:
>>>>> Hi--
>>>>>
>>>>> On 2/25/23 09:39, Tom Rix wrote:
>>>>>> A rand config causes this link error
>>>>>> ld: drivers/tty/serial/earlycon.o: in function `parse_options':
>>>>>> drivers/tty/serial/earlycon.c:99: undefined reference to `uart_parse_earlycon'
>>>>>>
>>>>>> The rand config has
>>>>>> CONFIG_SERIAL_CORE=m
>>>>>> CONFIG_SERIAL_EARLYCON=y
>>>>>> CONFIG_SERIAL_FSL_LPUART=m
>>>>>> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
>>>>>>
>>>>>> SERIAL_FSL_LPUART should have been selected instead of depends on-ed.
>>>>>>
>>>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>>>> ---
>>>>>>    drivers/tty/serial/Kconfig | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>>>>> index 625358f44419..b24d74d389fc 100644
>>>>>> --- a/drivers/tty/serial/Kconfig
>>>>>> +++ b/drivers/tty/serial/Kconfig
>>>>>> @@ -1313,7 +1313,7 @@ config SERIAL_FSL_LPUART
>>>>>>      config SERIAL_FSL_LPUART_CONSOLE
>>>>>>        bool "Console on Freescale lpuart serial port"
>>>>>> -    depends on SERIAL_FSL_LPUART
>>>>>> +    select SERIAL_FSL_LPUART
>>>>> Most other _CONSOLE Kconfig have:
>>>>>
>>>>>      depends on SERIAL_FSL_LPUART=y
>>>> commit 5779a072c248db7a40cfd0f5ea958097fd1d9a30 removed the =y. so it could be built as a module.
>>>>
>>> uh. But it's still a bool, not a tristate. How does that work?
>> OK, I see. :)
>>
>> Well, I don't see another decent solution ATM.
>>
>> Tom, does your patch fix the build error?
>>
>> What are the listed CONFIG settings after the patch?
> OK, after I apply the patch, all of the listed config symbols are
> changed to =y (builtin), so not built as a loadable module.
>
> Do you see something different?

No, all y's.

Since the showing the after state is useful, I added it to v2

>
>
>>>>> e.g.
>>>>>
>>>>> but I noticed a few others with a similar problem.
>>>>>
>>>>>>        select SERIAL_CORE_CONSOLE
>>>>>>        select SERIAL_EARLYCON
>>>>>>        help

