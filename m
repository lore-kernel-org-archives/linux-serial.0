Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284E3C433EF
	for <linux-serial@archiver.kernel.org>; Sat, 20 Nov 2021 21:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhKTVI5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 20 Nov 2021 16:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbhKTVI5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 20 Nov 2021 16:08:57 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25B8C06173E
        for <linux-serial@vger.kernel.org>; Sat, 20 Nov 2021 13:05:53 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id iq11so10575013pjb.3
        for <linux-serial@vger.kernel.org>; Sat, 20 Nov 2021 13:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vDEG37suVi75RS0zoThuG5W/DdcswDDvnaTC9lfOtYo=;
        b=1MAKU4JtvWic+ABL5KMPohFpM3lTZx9/afM680norQFa56JjW2NB2a7CiqMpKjCFjV
         WrKUnQi9j+JavN6iTNyh7q/OTzOcMMJuoxpEHTEIYuRvc7/k2AdaHGIzYbHZAL8trkiB
         WRwkTrsUQTmdL1pWfqmGvKBcX3BzWI0KicXlhk1yB3bkLD+Cpl1WVEUSeVGwk2dtoikx
         fjTDIRqspS809WajHJQQHcLeRyYF2FJCYqSl8oA+r6Vs4RR3WPShU8IFUP7ANjyMmuUx
         xh26dQytT9Qe//B2EkvmxyPyQypMWl7DpG+NgEKfCZLrQpLYNnn1RB/bvw2IP8qYWpIZ
         Ho4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vDEG37suVi75RS0zoThuG5W/DdcswDDvnaTC9lfOtYo=;
        b=F+Tc/ACOtX5JU7WV9gXatyE5LnHV+iFtyQa3WlkWzslwQxnc6iQ3HzHyTHAe90qomC
         yt54ArJxKv7iiP+XA57K/INRdKl2Ki7jeDX35yhLKfA2KFuSlciHitVlq6XG2Zoyqzou
         8EUQqxHOkJr6Oq1JWH5+0b2/NKMJWrXnPUyZ0cbxFl0ijzGPiWRimj4gA3FOmGyVsJfc
         R0y2+KKZnccnYKp37qajtGOGBSEhxKQqT1HQFlN4Eg2jL2/w+HIRuuF/EDn/9HhxM9W4
         pFwH+r6Zgpai/4QFWI+pFSTgakyXdWGeRok/94Nfb0NdYi+czkw8IfW1Y0r5Wu5+vaiw
         aVsA==
X-Gm-Message-State: AOAM532nE9s4YurzAL9k5UHwyJfhjyv9vdUDN5XYFJKjET4rmXOy7Stl
        i/siA5V3QBL+HdvYxeeS6EQJ
X-Google-Smtp-Source: ABdhPJyGqd/pof6wxDVgAjd+gF4aPblsWhfrtDZcVZyDgAZdAjWsIU9A1qWeEDO4OzQeEkiPOntd6A==
X-Received: by 2002:a17:903:248f:b0:143:8e81:4d7c with SMTP id p15-20020a170903248f00b001438e814d7cmr89641295plw.1.1637442353113;
        Sat, 20 Nov 2021 13:05:53 -0800 (PST)
Received: from [172.16.8.241] ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id k22sm3529496pfi.149.2021.11.20.13.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 13:05:52 -0800 (PST)
Subject: Re: [PATCH v1 0/2] serial: 8250_pci: Split Pericom driver
From:   Jay Dolan <jay.dolan@accesio.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
 <b99aabbe-add9-9c1e-ed4b-8850c69233de@accesio.com>
 <YZdfAdOcH2Bn1K+W@smile.fi.intel.com>
 <633bbad1-7b13-7299-a570-2bf1a87c47a5@accesio.com>
Message-ID: <7e83c01f-1aa4-56ef-e28f-9e7421864183@accesio.com>
Date:   Sat, 20 Nov 2021 13:05:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <633bbad1-7b13-7299-a570-2bf1a87c47a5@accesio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/19/21 6:33 AM, Jay Dolan wrote:
> 
> 
> On 11/19/21 12:23 AM, Andy Shevchenko wrote:
>> On Thu, Nov 18, 2021 at 10:32:51PM -0800, Jay Dolan wrote:
>>> On 11/17/21 6:57 AM, Andy Shevchenko wrote:
>>>> Split Pericom driver to a separate module.
>>>> While at it, re-enable high baud rates.
>>>>
>>>> Jay, can you, please, test this on as many hardware as you have?
>>>>
>>>> The series depends on the fix-series: 
>>>> https://lore.kernel.org/linux-serial/20211117145502.43645-1-andriy.shevchenko@linux.intel.com/T/#u 
>>>>
>>
>>> I have my current state here: 
>>> https://github.com/accesio/linux/blob/split-pericom-driver/drivers/tty/serial/8250/8250_pericom.c 
>>>
>>>
>>> * Change port type to UPIO_PORT
>>> * Add in pericom_do_startup() because the UPF_MAGIC_MULTIPLIER doesn't
>>> stick.
>>
>> Thanks, I have updated my local tree with these changes.
>>
>>> When I'm testing baud rates greater than baud_base I'm seeing strange 
>>> things
>>> on the scope.
>>
>> Can you confirm that there are no issues with the first (fixes) series?
> Yes. The fixes series has no issues, and was tested up to baud_base for 
> both 14 and 24 MHz crystals.
>> I have slightly changed your set_divisor() refactoring, it may be that 
>> issue
>> is there.
>>
>>> Maybe I'm just tired, and it's human error. I should be able
>>> to get back to it and get it done on Saturday.
>>
>> Thank you.
>>

Latest code is still here 
https://github.com/accesio/linux/blob/split-pericom-driver/drivers/tty/serial/8250/8250_pericom.c

Changes from last update:
* Avoid divide by zero when initializing delta

I retested and verified on the scope that speeds are now being set 
correctly.

I have also confirmed that all of the ACCES four port cards in the 
driver do have the offset fourth port. The item I raised about PCI was a 
misunderstanding that was all on my end.

Are there any other action items I should be handling?

Thank you for your work so far.
