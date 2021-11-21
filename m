Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8237BC433EF
	for <linux-serial@archiver.kernel.org>; Sun, 21 Nov 2021 15:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbhKUPjk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 21 Nov 2021 10:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbhKUPjk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 21 Nov 2021 10:39:40 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34694C061574
        for <linux-serial@vger.kernel.org>; Sun, 21 Nov 2021 07:36:35 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id q17so11951034plr.11
        for <linux-serial@vger.kernel.org>; Sun, 21 Nov 2021 07:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OiGTTVWrlOnAEbHbsnOLTIV8tcQFzQvQYpLftDhlz/U=;
        b=vM/kwTpc7E5c2sX6qx3wRqaK7lrWCwtwtZoHTXmLi1XULrVp/f9PNAZpn8w0+l9uYR
         lz9rgytw5UlwKav79k74HeENMI7kazXKXS2f84rwC4zQQ0e1iAxQI/37aN4K95ZaEXqn
         R8LDH2QPMYhuK/eB3Li3x37giUYxCUAXZz2Pm7NukoXfBUz2BfZcFrbBCJPz1GEdBqyD
         aPn8UHNvRNQLnNsdQ74WEw06ycwDs9U/AYSQvG1HnhH02IfMznWTjmW11fSmz4AOiocA
         5mArBx76QJr5XAURc7J+fZ8LgTGreAxQUsaa8uY4WjrRC7VRYE136qru6F1Bel3g8c7m
         U/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OiGTTVWrlOnAEbHbsnOLTIV8tcQFzQvQYpLftDhlz/U=;
        b=kXK5MgWuNVtEWPZvtzQ4yf4M5Hghtairp2JH+ZQe2nzEqKajZd1DWqVJaNRVnHdy2y
         0kZ7t+PRlHYeJvhNXpcbHPTi5hrLND5uuEbIgY9a1DImrF2S3iB7JM+YRXBryIQ7zykv
         7TAuAzFTk5b6DDYz76vYDbZhbe0h+FSE+ouJFMPebq1xYQDfWqYpbymq3vnnGSbsPp3r
         Vf8dXNQVchkTFZKn2mWJg8WPPzgefX5KOsHt2YRf1zsMvBONCzuFVprKKZDIbCkF2mL+
         OtJD9rD6xFB4Y09I38BJ+ZkK9OyqvRKqWmd/GIgmG2ge8SP2Y+G7MJ1oDDTD7NDh/WJ4
         Z/Zw==
X-Gm-Message-State: AOAM532oMAiEWAWvUC0GKiqCQdudjPqyi6OKpbKP3/+66zLS1Tj5HRUX
        ce8Bn3lN670WJW5svVGa5P9M
X-Google-Smtp-Source: ABdhPJzEoSX8vxlqyAelsF/JM3xXRaMPwlSBjV62ZEw2obcX3UsHyhNeQf9VRh9SnHTI73cNzn9Afw==
X-Received: by 2002:a17:90a:1b45:: with SMTP id q63mr22167642pjq.135.1637508994583;
        Sun, 21 Nov 2021 07:36:34 -0800 (PST)
Received: from [172.16.8.241] ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id s19sm180741pfu.104.2021.11.21.07.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Nov 2021 07:36:34 -0800 (PST)
Subject: Re: [PATCH v1 0/2] serial: 8250_pci: Split Pericom driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
 <b99aabbe-add9-9c1e-ed4b-8850c69233de@accesio.com>
 <YZdfAdOcH2Bn1K+W@smile.fi.intel.com>
 <633bbad1-7b13-7299-a570-2bf1a87c47a5@accesio.com>
 <7e83c01f-1aa4-56ef-e28f-9e7421864183@accesio.com>
 <CAHp75VedLLiB=Ujrymq9F1=SG2NRCeempUwqSbX9KHu1ND4x5g@mail.gmail.com>
From:   Jay Dolan <jay.dolan@accesio.com>
Message-ID: <063610ab-3416-d8fe-c05f-205382e0c5cd@accesio.com>
Date:   Sun, 21 Nov 2021 07:36:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VedLLiB=Ujrymq9F1=SG2NRCeempUwqSbX9KHu1ND4x5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/21/21 2:16 AM, Andy Shevchenko wrote:
> On Sat, Nov 20, 2021 at 11:46 PM Jay Dolan <jay.dolan@accesio.com> wrote:
>> On 11/19/21 6:33 AM, Jay Dolan wrote:
>>> On 11/19/21 12:23 AM, Andy Shevchenko wrote:
>>>> On Thu, Nov 18, 2021 at 10:32:51PM -0800, Jay Dolan wrote:
>>>>> On 11/17/21 6:57 AM, Andy Shevchenko wrote:
> 
>>>>>> Split Pericom driver to a separate module.
>>>>>> While at it, re-enable high baud rates.
>>>>>>
>>>>>> Jay, can you, please, test this on as many hardware as you have?
>>>>>>
>>>>>> The series depends on the fix-series:
>>>>>> https://lore.kernel.org/linux-serial/20211117145502.43645-1-andriy.shevchenko@linux.intel.com/T/#u
>>>>
>>>>> I have my current state here:
>>>>> https://github.com/accesio/linux/blob/split-pericom-driver/drivers/tty/serial/8250/8250_pericom.c
>>>>>
>>>>>
>>>>> * Change port type to UPIO_PORT
>>>>> * Add in pericom_do_startup() because the UPF_MAGIC_MULTIPLIER doesn't
>>>>> stick.
>>>>
>>>> Thanks, I have updated my local tree with these changes.
>>>>
>>>>> When I'm testing baud rates greater than baud_base I'm seeing strange
>>>>> things
>>>>> on the scope.
>>>>
>>>> Can you confirm that there are no issues with the first (fixes) series?
>>> Yes. The fixes series has no issues, and was tested up to baud_base for
>>> both 14 and 24 MHz crystals.
>>>> I have slightly changed your set_divisor() refactoring, it may be that
>>>> issue
>>>> is there.
>>>>
>>>>> Maybe I'm just tired, and it's human error. I should be able
>>>>> to get back to it and get it done on Saturday.
>>>>
>>>> Thank you.
>>
>> Latest code is still here
>> https://github.com/accesio/linux/blob/split-pericom-driver/drivers/tty/serial/8250/8250_pericom.c
>>
>> Changes from last update:
>> * Avoid divide by zero when initializing delta
> 
> Thanks for digging into it. But doesn't it mean that the issue is in
> the fix series as I assumed before?
Yes. It just happens to not get hit at any of the standard baud rates 
that I found in the termbits.h files. So testing didn't find it until 
testing rates greater than what is allowed without the magic multiplier 
flag.
I found it when doing the math on 3000000 because that causes it with 
the 14 MHz crystal.
> 
>> I retested and verified on the scope that speeds are now being set
>> correctly.
>>
>> I have also confirmed that all of the ACCES four port cards in the
>> driver do have the offset fourth port. The item I raised about PCI was a
>> misunderstanding that was all on my end.
> 
> Good to know that is not relevant.
> 
>> Are there any other action items I should be handling?
> 
> I think I have to issue two new iterations of each series and collect
> your formal Tested-by on the second one.
> 
