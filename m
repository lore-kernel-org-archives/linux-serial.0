Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7EDECAAD8
	for <linux-serial@archiver.kernel.org>; Tue, 13 Sep 2022 19:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiIMTCj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Sep 2022 15:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiIMTCV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 15:02:21 -0400
Received: from wedge010.net.lu.se (wedge010.net.lu.se [130.235.56.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0909A6
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=control.lth.se; s=edge;
        c=relaxed/relaxed; t=1663095560; h=from:subject:to:date:message-id;
        bh=f7KAV7KO4XAVzzhmwOA096xjxAMG+qPpw5e4BYQUeqk=;
        b=CtCMRdHDfgjYuf+rDoxvUKD7Tf5RLRICEhlTO7dNhy6tvn9nfP8Z8tGNf85i9Ss+/zl7edzzWHY
        KU/KPafhToafvBWZ10GCOHMGqfUcUkk5EAPG9kq56xCnZ/NUONyUxiqG9C9DrLG2e3rLXKWO4szsa
        9Z/GqVxil1mDsMF4OZphI/U63feeCMHv/O4r52j6Jz8/xGLMQyqLAKeTg1FaDaANb3moWpbrmKBiX
        lrvJfGIChU0GMEry2d0ko5/lFPjr8DmDqRp4XUsDblP6qJ5JlGFK1FU/r9ZelB7/qrIO6K7alzYTj
        5u8omNoyY+BVPBmSyLBJhZuiWsp6Len/nUoA==
Received: from wexc007.uw.lu.se (130.235.59.251) by mail.lu.se
 (130.235.56.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2507.12; Tue, 13
 Sep 2022 20:59:20 +0200
Received: from [130.235.83.196] (130.235.139.100) by wexc007.uw.lu.se
 (130.235.59.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2507.12; Tue, 13
 Sep 2022 20:59:15 +0200
Message-ID: <3d6e5798-f8c9-ebe2-719c-520a3b62171c@control.lth.se>
Date:   Tue, 13 Sep 2022 20:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se>
 <YyA9maUOlPIExIUd@kroah.com>
 <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se>
 <YyB4AtFJx++PeA6S@kroah.com>
 <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se>
 <YyCNOV9no9NPwv8m@kroah.com>
 <e9ca9267-dfee-c7b0-f1ec-4d2b76a05991@control.lth.se>
 <alpine.DEB.2.21.2209131638550.60554@angie.orcam.me.uk>
From:   Anders Blomdell <anders.blomdell@control.lth.se>
In-Reply-To: <alpine.DEB.2.21.2209131638550.60554@angie.orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.235.139.100]
X-ClientProxiedBy: wexc010.uw.lu.se (130.235.59.254) To wexc007.uw.lu.se
 (130.235.59.251)
X-CrossPremisesHeadersFilteredBySendConnector: wexc007.uw.lu.se
X-OrganizationHeadersPreserved: wexc007.uw.lu.se
X-ORF-InterSessionInfo: eid=CNqSUe6VRQg=;oid=AAAAAMCENUM=;bar=wip;cid=AFRb3DDViAQ08ILSDHAc86NA4A==;iss=y;loc=hp;s=E5iwnbg2IH/zt95ytsPL6Vf9lJXcsX63l9pdQa1SPW0pkwrwJg9fACeb0Yql6M7CssHDa/d86jUAq6b+YCkdBw==
Received-SPF: Pass (wedge010.net.lu.se: domain of
 anders.blomdell@control.lth.se designates 130.235.59.251 as permitted sender)
 receiver=wedge010.net.lu.se; client-ip=130.235.59.251; helo=wexc007.uw.lu.se;
X-CrossPremisesHeadersFilteredBySendConnector: wedge010.net.lu.se
X-OrganizationHeadersPreserved: wedge010.net.lu.se
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I honestly don't understand how to calculate the  baudrate, the following hack:

         switch (baud) {
           case 9601: { tcr = 4;  cpr = 32; quot = 406; } break;
           case 9602: { tcr = 8;  cpr = 16; quot = 406; } break;
           case 9603: { tcr = 16; cpr = 8;  quot = 406; } break; /* tcr will be masked to 0 */
         }
	*frac = (cpr << 8) | (tcr & OXSEMI_TORNADO_TCR_MASK);
         
I believed that they should give the same baudrate, but I get these baudrates:

9600 -> 10700   tcr = 9;  cpr = 9;  quot = 643;    /* Use standard calculations, not hack */
9601 -> 38400	tcr = 4;  cpr = 32; quot = 406;
9602 -> 19200	tcr = 8;  cpr = 16; quot = 406
9603 ->  9600	tcr = 16; cpr = 8;  quot = 406;


On 2022-09-13 18:19, Maciej W. Rozycki wrote:
> Hi Anders,
> 
>   Sorry to cause you trouble.
> 
>>> I really don't know what to do here, sorry.  Are you saying a specific
>>> commit has broken this?  If so, did you test if you made a change it
>>> fixed the issue?
>>
>> Yes, commit 366f6c955d4d1a5125ffcd6875ead26a3c7a2a1c broke the one to one
>> correspondence
>> between programmed and actual baudrate; reverting it (and
>> 9c5c8aaed50bf3478073ab51b8b1f3f5327d3cfa
>> that builds on that patch) restores the expected functionality (i.e. you get
>> the baudrate you ask for)
>> on 5.19.8.
> 
>   I have implemented the calculation using parameters from original OxSemi
> datasheets and verified this code across three architectures available to
> me (POWER9, RISC-V, 32-bit x86) and a couple of cards made by different
> manufacturers connected to a non-OxSemi serial device each at the other
> end.  I have checked the usual baud rates of up to 460800bps.  Higher baud
> rates work too, though I could only try them between OxSemi devices, so
> actual rates were not verified for correctness.
> 
>   And offhand I can say it works just fine at 230400bps with 6.0.0-rc2 as
> at commit 10d4879f9ef0 and my RISC-V machine (using an EXSYS EX-44171
> 1S+1P port PCIe option card, built around the OXPCIe952 too) talking to a
> remote console server in my lab.  I don't have an oscilloscope available
> to check actual waveforms produced.
> 
>>> What do you suggest happen here?
>> Either there is a bug in the code, or the chipset on my card (a Delock 2xRS232
>> card) is not a true oxford
>> chipset (the package and PCI id's says that they are).
> 
>   A bug can never be ruled out.  I doubt that Delock would use a fake chip
> or indeed that anyone would choose to clone an OxSemi part, which seems
> fairly complex to me for a serial port.
> 
>> Since the chip seems to be discontinued since 2014 (see
>> https://www.mouser.com/PCN/PLX_Technology_2013_8.pdf),
>> I think a revert would not be uncalled for.
> 
>   The problem is the original calculation is inaccurate enough for the
> serial interface not to communicate correctly at higher baud rates.  I
> found setting two stop bits while talking to a remote end that has one
> stop bit set a possible workaround for some cases, but why not do the
> calculation correctly in the first place?
> 
>   If you're willing to debug it, then I'll be more than happy to supply you
> with diagnostic patches, some of which I made in the development of the
> fix.  Also what processor architecture do you use the interface with?
> 
>    Maciej

-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118
SE-221 00 Lund, Sweden
