Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A855C433ED
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 12:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCB061468
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 12:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhD3Mhy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Apr 2021 08:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhD3Mhx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Apr 2021 08:37:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A849AC06174A;
        Fri, 30 Apr 2021 05:37:04 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g65so8619124wmg.2;
        Fri, 30 Apr 2021 05:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w64guxGS9FMEWcZon3B2qnFpVFodmAXPvDD4UORab6k=;
        b=R67HR52vRDHFU9oQxAY+dvLc8wXKDQYHj3rYvvz3NlYx3rbcSCoMjFuEd8wKhMooRz
         wZGbE3QSIFGCjeIy9zlB04qnIVdiwnaqEwPlGKP/7dKv/4DgAnbNlLNbyzOKyU1BZnFb
         0c/OEdlGTweClDPtTxpw7HlDVrWcWXx/kO1gKGzgOokQhbi3nPxs+nctyzEJdmqe5fzm
         8HdQEkC0fntaHHzIaO2hQw4QvUGNv2hmwU5C9ysMAjfpNAMpEir1AomtOffu3/WR8QJz
         y2qXXC+ThRvRU2U/rCJeB7egcj68JpRJ64cy+0iaIRoSHnP+Cdm8IynvG4rCpumgV2bn
         vAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w64guxGS9FMEWcZon3B2qnFpVFodmAXPvDD4UORab6k=;
        b=FtFIukoCfHpaFiDu2rgrDj9ZPs8Ke0+imC6snugiXGURIasmPbckTou5xpuJb64tQe
         9LGWHFmhF51PzC3hvr0YWA3p7PEbW1GrESvCLj0UZshDA4LI2jBPqAbrVl4Bg0VyrGDA
         ap2aVVPzNEggzSceaN2EyKEaml+y1BhqTFcdXepciV3oKvExrnUzK1/HoseKh3rIclJV
         YJt5NZw6Eery72ngx8at443jpBw5qtA1Wcogytj1K/IAYaqz2Oc1S9VOml7xzku4Pjnm
         4QAYByNpOSB5pe9Ad4pXR3O6X3jgBI/YOy6X7QbdChj1SolTsSU1rZHHbDyp27Cj5HLm
         Nc3A==
X-Gm-Message-State: AOAM533gFrhOCivUpabWEZ6zONDtcizJRCmoAW6sTXILNo07NUVF72qX
        6qy1HIoNAFxYmZ3njtqexnc=
X-Google-Smtp-Source: ABdhPJwUrHApqG/2GAxHmuBEFvD+H6a+tok+3Mx8mmgRU3UCynwUKegz2hQbuiA1GSKWK51jcCtm+w==
X-Received: by 2002:a1c:7fcd:: with SMTP id a196mr16646869wmd.180.1619786223227;
        Fri, 30 Apr 2021 05:37:03 -0700 (PDT)
Received: from [192.168.2.202] (p5487bc52.dip0.t-ipconnect.de. [84.135.188.82])
        by smtp.gmail.com with ESMTPSA id h8sm2953616wmq.19.2021.04.30.05.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 05:37:02 -0700 (PDT)
Subject: Re: Support for AMDI0022 UART
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wang Hongcheng <annie.wang@amd.com>, Ken Xue <Ken.Xue@amd.com>
References: <295686a0-240d-71d1-a6a0-f3752cf24477@gmail.com>
 <CAHp75VcLoTsjyQyVAo6cd+HMd+z_irM8ofcenRm0P6CzYGOQNw@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <85ec3e9a-e69b-ecd6-3d77-4364064c57a3@gmail.com>
Date:   Fri, 30 Apr 2021 14:37:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcLoTsjyQyVAo6cd+HMd+z_irM8ofcenRm0P6CzYGOQNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 4/24/21 12:25 PM, Andy Shevchenko wrote:
> On Fri, Apr 23, 2021 at 10:58 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
>> Hi all,
>>
>> I received a report from a Surface Laptop 4 which has a UART that is
>> identified as AMDI0022 in ACPI [1] and that does not seem to be
>> supported by the kernel yet.
>>
>>   From what I can tell via ACPI, this is similar to the AMDI0020 [2] UART
>> that's already supported by the kernel (well, both are devices with two
>> MMIO regions and an interrupt as far as I can tell...). So it's possible
>> that all that's needed is adding it to the respective device ID lists
>> [3, 4]. Unfortunately, I a) don't have a device to test this myself, b)
>> haven't found any more details on that online, and c) don't want to tell
>> others to test this without knowing a bit more about that (potentially
>> writing random stuff to some unknown MMIO region that I don't know
>> anything about doesn't sound as safe to me as I'd like).
> 
> To me they look completely the same. Depending on the device which is
> connected to the UART, I would suggest just to add an ID and see if it
> makes it work.

Thanks! We've tried that now and we do have some progress, meaning that
the serial device seems to work as expected (we have some basic
communication working).

The driver that we want to load (drivers/platform/surface/aggregator/)
still doesn't quite load yet, but that now seems to be due to a missing
GPIO driver for an AMDI0031 device. There's again an AMDI0030 in
drivers/pinctrl/pinctrl-amd.c, but this time the definitions do seem a
bit different (compare [5, 6]), specifically there are now two memory
regions (altough the combined size is still the same).

I'll try to have a look around and maybe ping the linux-gpio list if I
don't find anything else. I'll post some patches once we've got the
driver loading properly and can run some more tests.

Regards,
Max

[5]: AMDI0030 on Surface Laptop 3
https://github.com/linux-surface/acpidumps/blob/4da0148744164cea0c924dab92f45842fde03177/surface_laptop_3_amd/dsdt.dsl#L1767-L1802

[6]: AMDI0031 on Surface Laptop 4
https://github.com/linux-surface/acpidumps/blob/4da0148744164cea0c924dab92f45842fde03177/surface_laptop_4_amd/dsdt.dsl#L1404-L1428
