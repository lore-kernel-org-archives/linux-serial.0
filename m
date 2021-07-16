Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990FEC12002
	for <linux-serial@archiver.kernel.org>; Fri, 16 Jul 2021 13:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71432613F3
	for <linux-serial@archiver.kernel.org>; Fri, 16 Jul 2021 13:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbhGPNKN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Jul 2021 09:10:13 -0400
Received: from mta02.hs-regensburg.de ([194.95.104.12]:55476 "EHLO
        mta02.hs-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbhGPNKN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Jul 2021 09:10:13 -0400
Received: from E16S03.hs-regensburg.de (e16s03.hs-regensburg.de [IPv6:2001:638:a01:8013::93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "E16S03", Issuer "E16S03" (not verified))
        by mta02.hs-regensburg.de (Postfix) with ESMTPS id 4GRBNN6NC5zy2y;
        Fri, 16 Jul 2021 15:07:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oth-regensburg.de;
        s=mta01-20160622; t=1626440836;
        bh=ouFmdmxN9fdZ0nW/HOuNa4kwdbEZ+5X3c22BP5HazTQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Yy5exus8dhK9N7VsMhq5VzrOcLNW5cQSVfVjHjfrcajRKkOZ1odLg4kjUadpabMHl
         nNM70AW5X9OwFFm/Nvq6ZtEZmd8ev1BvdrmvzvNrX0vAws1xwb2QgzEj60r+dBydGf
         lDxj1zweK9QTDT7yWP2pDIgH8zmzIpm+Mpg7DxRg9U1wINo933Tf13PeZnvLbQk6Em
         e09HV9tHgRCAYEhRdRLPXsuf2op9W8UPJmGa2jfI+jgMBEEcc68Gnj3tggFHq5C+v4
         oRnZmLGgfjB3rbgcQGrjs+pZfhTwXoKgwsc/Kqc5kTG7GBVOtu/h4ObmcDmAH/esvc
         snyJCoSynmXxQ==
Received: from [IPv6:2001:638:a01:8061:5c51:6883:5436:5db]
 (2001:638:a01:8013::138) by E16S03.hs-regensburg.de (2001:638:a01:8013::93)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 16 Jul
 2021 15:07:16 +0200
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
Message-ID: <ac8ac10e-aa43-93a1-d36e-6304643375ae@oth-regensburg.de>
Date:   Fri, 16 Jul 2021 15:07:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdoaE7hCOzsRvuf=7A4mmv0NWBmwqK_mM8vO-K3YZKTUQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2001:638:a01:8013::138]
X-ClientProxiedBy: E16S02.hs-regensburg.de (2001:638:a01:8013::92) To
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

So I found a no-name el-cheapo card that has some issues with MSI:

18:00.0 Serial controller: Device 1c00:3253 (rev 10) (prog-if 05 [16850])

The card comes with two serial lines. It comes perfectly up, if I enable
it to use MSI in the whitelist:

serial 0000:18:00.0: Using MSI(-X) interrupts
serial 0000:18:00.0: Setup PCI port: port 40c0, irq 104, type 0
0000:18:00.0: ttyS6 at I/O 0x40c0 (irq = 104, base_baud = 115200) is a
XR16850
serial 0000:18:00.0: Setup PCI port: port 40c8, irq 104, type 0
0000:18:00.0: ttyS7 at I/O 0x40c8 (irq = 104, base_baud = 115200) is a
XR16850

After loading 8250_pci, lspci -vvs 18:0.0 tells:

	Capabilities: [68] MSI: Enable+ Count=1/32 Maskable+ 64bit+
		Address: 00000000fee000b8  Data: 0000
		Masking: ffffffff  Pending: 00000000

Looks good so far. Now let's echo to the device.

$ echo asdf > /dev/ttyS6

-- stuck. The echoing process stucks at close():

write(1, "asdf\n", 5)                   = 5
close(1

Stuck in the sense of: the echo is still killable, no crashes. The same
happens if I try to access the device with stty. So something is odd
here. However, the Netmos cards that I whitelisted do a great job.

So I can't tell if I was just unlucky to grab a card that has issues
with MSI, and this is an exception rather than the rule…

HTH,
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
> 
