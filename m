Return-Path: <SRS0=nVIq=DB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FA0C4363D
	for <linux-serial@archiver.kernel.org>; Thu, 24 Sep 2020 21:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D9922208
	for <linux-serial@archiver.kernel.org>; Thu, 24 Sep 2020 21:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3e6P0jA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIXVHG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Sep 2020 17:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXVHG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Sep 2020 17:07:06 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62F8C0613CE;
        Thu, 24 Sep 2020 14:07:05 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p15so130884ejm.7;
        Thu, 24 Sep 2020 14:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rkxYLB+lfWbz4FohLDcSfT4fdzwjyILNCZtO54fvfxI=;
        b=b3e6P0jAHc8fH18e6EnBasnbrSS1Y89qgdBYDQFnRKGmFP41FMVRypE94oPHjgX+Hx
         hdiNvUUOhHYZqft6UYcpKYV43DwrASN9Vr6pJWtbAI9rkU/riEWtdQrhgUwz1pORMC9s
         YBLDDIk2o9eQzjC27luzrfPxr53HqqOQs5WGBVhLek/efR5xasv5av+tyueAcfV7kjGn
         DHShoSHhuIIgDhzMMYl2UC/0A9Xd7n5vfjbH8T7lVZKwNO5MifIBPQzXfwef3ciYswjA
         UaUj1DIKnx50aivBXGCKZYQz7oJt0ZkbV2y2PCUG+XtkVqjMq+F2pDLKbioFbuPcroz2
         bjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rkxYLB+lfWbz4FohLDcSfT4fdzwjyILNCZtO54fvfxI=;
        b=SlADdq8/hhDSloa3XSkMqPEH5dO6kU3hGD6OxuLazuP0YOR0/SWEMdUwuWqY57q5fP
         obOzk+sfnqNHBvuoEHlyLhlF9Xz005xn8okZpwmTKKwfHyWVYIY8v8E9SdFk6MrdlX8k
         bBsSczop6lLkMNBZkciVq8ogICI9v29iBQPX/smR7yk5cjy2jmOn+E9P8rbU47eBbmLN
         BuMdyKTnYHSxCV4RiuLDYCiehx1n6dM+F1jQTZOMFOHdffsYZj0LDAu1sm9BYE2Yeq0t
         lxjHaEwfTzf9fBlnl5awjPah/nzZtmJMmRKNdLt/0Awj1QktJH+w/F/sOQicDLyTHxxp
         SGdQ==
X-Gm-Message-State: AOAM531r3U3k2bgVDIMM4OaPsRl3XTjXeknz1iuJgt9t/DAGWpxq1ehM
        iaA2I6U7Z/FeBrNdghp6ALVzlEMpQHw=
X-Google-Smtp-Source: ABdhPJwjvP7IOrZfSs603V1qE80+ZUlp0UcDrAemKRbBr7YUrivRy2EUsrUUcusf41pNBk/6Wbui1Q==
X-Received: by 2002:a17:906:29ca:: with SMTP id y10mr499729eje.327.1600981624057;
        Thu, 24 Sep 2020 14:07:04 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9d2.dip0.t-ipconnect.de. [217.229.169.210])
        by smtp.gmail.com with ESMTPSA id t3sm257414edv.59.2020.09.24.14.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 14:07:03 -0700 (PDT)
Subject: Re: [RFC PATCH 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
 <dad42dce-15d0-245a-4d91-4733e54883a0@gmail.com>
 <CAK8P3a2ryzmsrHHApT9O=dvsw+=z18Sjd4ygVxvFrrDetKA+rQ@mail.gmail.com>
 <c4c1d999-9ab7-8988-906a-3cb6a70bc93d@gmail.com>
 <CAK8P3a2XegsP71yvd8Ku08_k6ecQfkU+V+t+QnjQBrJKF2MwCg@mail.gmail.com>
 <d07adfb3-9f79-c00a-cb70-e044aa0b19f8@gmail.com>
 <CAK8P3a23V8vug2U-9tXUOdO3DvQvEc5+GhZuQh7_HKtTavCqVQ@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <0a861a86-e9eb-668c-f725-46336b48a86a@gmail.com>
Date:   Thu, 24 Sep 2020 23:07:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a23V8vug2U-9tXUOdO3DvQvEc5+GhZuQh7_HKtTavCqVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 9/24/20 9:38 PM, Arnd Bergmann wrote:
> On Thu, Sep 24, 2020 at 8:59 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>> On 9/24/20 10:26 AM, Arnd Bergmann wrote:
>>> On Thu, Sep 24, 2020 at 1:28 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> 
>>> Note that drivers that connect to the bus typically don't live in the
>>> same subdirectory as the driver that operates the bus. E.g. the
>>> battery driver would go into drivers/power/supply and the input
>>> would go into drivers/input/ or drivers/hid.
>>
>> Right. I wonder if this also holds for devices that are directly
>> dependent on a special platform though? It could make sense to have them
>> under plaform/surface rather than in the individual subsystems as they
>> are only ever going to be used on this platform. On the other hand, one
>> could argue that having them in the subsystem directories is better for
>> maintainability.
> 
> Yes, absolutely. The subsystem maintainers are the ones that are
> most qualified of reviewing code that uses their subsystem, regardless
> of which bus is used underneath the device, and having all drivers
> for a subsystem in one place makes it much easier to refactor them
> all at once in case the internal interfaces are changed or common bugs
> are found in multiple drivers.

Got it.

Thank you for bearing with me and answering all my (probably a bit
silly) questions! I really appreciate it!

Regards,
Max
