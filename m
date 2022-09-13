Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394D4C54EE9
	for <linux-serial@archiver.kernel.org>; Tue, 13 Sep 2022 16:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiIMQ5L (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Sep 2022 12:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiIMQ4s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 12:56:48 -0400
Received: from wedge010.net.lu.se (wedge010.net.lu.se [130.235.56.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E694980497
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=control.lth.se; s=edge;
        c=relaxed/relaxed; t=1663083278; h=from:subject:to:date:message-id;
        bh=oGFTdKbfZoa+wvZL9nP8FL93GRT6lYPTht/ziUpitlw=;
        b=MMJdXcqbjQ1sEoyeRAcOlLu4DzIu/X+nq26S05BnMb5Gg8RUtzzrHG6+y9b7t/fIMpxcKui+AI3
        zbVNnMcY05f7AE7JwGtrx+Q/Jwt8PIgbtpgHTVq128My9u2uhOWqmpismewmrUVO020DmHdJ5zlFf
        SFaxMUujoM3/eEKU4B3CyGIaazfEIGcXcqgWA00P+Mi0Iemih9YgAmxqFgg9dMebfQGKxiabP4BRW
        42DbHa0WSBg9fUAzZGyPuVXYQCz0+C0Fdc61EzTHs9v/RuzJ/0AA66p2Q7jUr4QNxtaAsjuwh6ZWo
        j0ggFvTq9SwRpTIuKWfkqtyxVwCBVIF/7gyg==
Received: from wexc007.uw.lu.se (130.235.59.251) by mail.lu.se
 (130.235.56.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2507.12; Tue, 13
 Sep 2022 17:34:37 +0200
Received: from [130.235.83.196] (130.235.139.100) by wexc007.uw.lu.se
 (130.235.59.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2507.12; Tue, 13
 Sep 2022 17:34:34 +0200
Message-ID: <e9ca9267-dfee-c7b0-f1ec-4d2b76a05991@control.lth.se>
Date:   Tue, 13 Sep 2022 17:34:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        <linux-serial@vger.kernel.org>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se>
 <YyA9maUOlPIExIUd@kroah.com>
 <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se>
 <YyB4AtFJx++PeA6S@kroah.com>
 <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se>
 <YyCNOV9no9NPwv8m@kroah.com>
From:   Anders Blomdell <anders.blomdell@control.lth.se>
In-Reply-To: <YyCNOV9no9NPwv8m@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.235.139.100]
X-ClientProxiedBy: wexc009.uw.lu.se (130.235.59.253) To wexc007.uw.lu.se
 (130.235.59.251)
X-CrossPremisesHeadersFilteredBySendConnector: wexc007.uw.lu.se
X-OrganizationHeadersPreserved: wexc007.uw.lu.se
X-ORF-InterSessionInfo: eid=CNqSUe6UtI0=;oid=AAAAAMCENUM=;bar=wip;cid=AFRb3DDViAQ08ILSDHAc86NA4A==;iss=y;loc=hp;s=Oie6nXlU2Z8zTP62WbTvQxt+2i3wKGZctH8FSJOhg/WO6SYEOKCSfV2lKzV0cKayN8ACSXoNtyjI4QrXFQ0YCg==
Received-SPF: Pass (wedge010.net.lu.se: domain of
 anders.blomdell@control.lth.se designates 130.235.59.251 as permitted sender)
 receiver=wedge010.net.lu.se; client-ip=130.235.59.251; helo=wexc007.uw.lu.se;
X-CrossPremisesHeadersFilteredBySendConnector: wedge010.net.lu.se
X-OrganizationHeadersPreserved: wedge010.net.lu.se
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2022-09-13 16:01, Greg Kroah-Hartman wrote:
> On Tue, Sep 13, 2022 at 02:43:03PM +0200, Anders Blomdell wrote:
>>
>>
>> On 2022-09-13 14:30, Greg Kroah-Hartman wrote:
>>> On Tue, Sep 13, 2022 at 02:16:39PM +0200, Anders Blomdell wrote:
>>>> I get incorrect baudrates, my oscilloscope gives:
>>>>
>>>> Programmed	Measured
>>>>
>>>>     2400		  5208
>>>>     4800		 13150
>>>>     9600		 10410
>>>>    19200		 71420
>>>>    38400		142000
>>>>    57600		201600
>>>> 115200		138800
>>>
>>> I'm sorry, I have no context here at all, what does this pertain to?
>> Programmed baudrate and the measured (actual) baudrate
> 
> I really don't know what to do here, sorry.  Are you saying a specific
> commit has broken this?  If so, did you test if you made a change it
> fixed the issue?

Yes, commit 366f6c955d4d1a5125ffcd6875ead26a3c7a2a1c broke the one to one correspondence
between programmed and actual baudrate; reverting it (and 9c5c8aaed50bf3478073ab51b8b1f3f5327d3cfa
that builds on that patch) restores the expected functionality (i.e. you get the baudrate you ask for)
on 5.19.8.

> What do you suggest happen here?
Either there is a bug in the code, or the chipset on my card (a Delock 2xRS232 card) is not a true oxford
chipset (the package and PCI id's says that they are).

Since the chip seems to be discontinued since 2014 (see https://www.mouser.com/PCN/PLX_Technology_2013_8.pdf),
I think a revert would not be uncalled for.

> 
> still confused,
So am I

> 
> greg k-h

/Anders
-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118
SE-221 00 Lund, Sweden
