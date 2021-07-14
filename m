Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D211BC07E9A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 16:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB81660FDB
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 16:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhGNQwm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhGNQwm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 12:52:42 -0400
X-Greylist: delayed 14394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Jul 2021 09:49:50 PDT
Received: from mta02.hs-regensburg.de (mta02.hs-regensburg.de [IPv6:2001:638:a01:1096::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F858C06175F;
        Wed, 14 Jul 2021 09:49:50 -0700 (PDT)
Received: from E16S03.hs-regensburg.de (e16s03.hs-regensburg.de [IPv6:2001:638:a01:8013::93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "E16S03", Issuer "E16S03" (not verified))
        by mta02.hs-regensburg.de (Postfix) with ESMTPS id 4GQ3Q20s3WzyKH;
        Wed, 14 Jul 2021 18:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oth-regensburg.de;
        s=mta01-20160622; t=1626281386;
        bh=HdkPsmS3CzfxqWjY4kwQysyY+bLPHmZ79xZMXkjw4fU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=tgealBdl26o+0+dexJXGzOHmoaXVW3u2KOc3u2Mg8tGYx8/AbuYRC2rvFRCmE1Qui
         qOLHZpD4caKTbCL8GOLGNOS5XEZxhUJQ9DmRIjhrsla7ROUMjFUWXI5xWX4jok4At2
         MoG6bp6kDsV25rbWHuHHuRJ/U6F9Q8Et8HB+wwMldDUSKkpsQ7nOMzqZ5DPhfz6Ypd
         VMQDLqu9vbyMTuIsyEj8H7pF9UMrR+76dUEDvH0+loLuxAUjjPEoek+RJ3EYjh2DC9
         cIK3HsbFBLxg8zo4/JJm+599sFAqRsFGAPdrvCbDDd8J2fak3G7OXF2M1P8/0PdWRj
         zhh5cH1B26p4g==
Received: from [IPv6:2001:678:ddc:11:17a4:3bb5:620b:1dcb]
 (2001:638:a01:8013::138) by E16S03.hs-regensburg.de (2001:638:a01:8013::93)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.10; Wed, 14 Jul
 2021 18:49:45 +0200
Subject: Re: [EXT] Re: [PATCH v1 3/4] serial: 8250_pci: Always try MSI/MSI-X
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
 <20210713104026.58560-3-andriy.shevchenko@linux.intel.com>
 <9af24b96-8119-7ccf-f0d0-d725af80aa0b@kernel.org>
 <784629f9-677e-ee53-aceb-89397ce0951a@oth-regensburg.de>
 <CAHp75VdoaE7hCOzsRvuf=7A4mmv0NWBmwqK_mM8vO-K3YZKTUQ@mail.gmail.com>
From:   Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Message-ID: <0a15be25-d4e1-f2f5-22f7-6144b7100bf1@oth-regensburg.de>
Date:   Wed, 14 Jul 2021 18:49:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdoaE7hCOzsRvuf=7A4mmv0NWBmwqK_mM8vO-K3YZKTUQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2001:638:a01:8013::138]
X-ClientProxiedBy: E16S01.hs-regensburg.de (2001:638:a01:8013::91) To
 E16S03.hs-regensburg.de (2001:638:a01:8013::93)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 14/07/2021 15:35, Andy Shevchenko wrote:
> On Wed, Jul 14, 2021 at 3:56 PM Ralf Ramsauer
> <ralf.ramsauer@oth-regensburg.de> wrote:
>> On 14/07/2021 08:54, Jiri Slaby wrote:
>>> On 13. 07. 21, 12:40, Andy Shevchenko wrote:
> 
>>> Hmm, have you checked the commit which introduced the whitelist?
>>>
>>>     Nevertheless, this needs to handled with care: while many 8250 devices
>>>     actually claim to support MSI(-X) interrupts it should not be
>>> enabled be
>>>     default. I had at least one device in my hands with broken MSI
>>>     implementation.
>>>
>>>     So better introduce a whitelist with devices that are known to support
>>>     MSI(-X) interrupts. I tested all devices mentioned in the patch.
>>>
>>>
>>> You should have at least CCed the author for an input.
>>
>> Yep, back then I was testing three different 8250 pci cards. All of them
>> claimed to support MSI, while one really worked with MSI, the one that I
>> whitelisted. So I thought it would be better to use legacy IRQs as long
>> as no one tested a specific card to work with MSI.
> 
> Can you shed a light eventually what those cards are?

That's been a while. Let me check that if I can still find them, and
I'll test them once again against MSI being enabled. But this can take
some days.

  Ralf

> 
>> Don't do that… And don't convert it to a blacklist. A blacklist will
>> break users until they report that something doesn't work.
> 
> White list is not okay either. MSI in general is a right thing to do.
> preventing users from MSI is asking for the performance degradation
> and IRQ resource conflicts (in case the IRQ line is shared).
> 
> Besides that, shouldn't it be rather the specific field in private (to
> 8250_pci) structure than constantly growing list?
