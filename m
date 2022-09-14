Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66140C6FA82
	for <linux-serial@archiver.kernel.org>; Wed, 14 Sep 2022 14:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiINOZl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Sep 2022 10:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiINOZU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Sep 2022 10:25:20 -0400
Received: from wedge010.net.lu.se (wedge010.net.lu.se [130.235.56.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CB8DEE2
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2022 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=control.lth.se; s=edge;
        c=relaxed/relaxed; t=1663165473; h=from:subject:to:date:message-id;
        bh=siZicxfdS28z68wS0LTk6nl548EGbOo3p67K4MbtM/8=;
        b=Bm16FdpzHj92FSagvrNpNF0IeLZMDRxX+jotgxON0opeJHKO5fQH+gTkxswy5XBCzB8lR3SdriH
        OJ+7gLRnSu2C2SlV90dfPeJn9ChrvkV6lxcZQNbdgzJX7Bkwdg8A2zVOmtiG3PDwNegACMr1DIvqg
        Pzdfre2r+ksFu+3rrdGjuBEO+Wxj+/yOQTfVfMqxeNMJrlkAszp5f393/nF2VB6zJLRyCWBQprRn0
        c3nFD++si8Pg+kEYbta6ygn1yuA1aO9RO+87cTMF2Wx6eKX3qNj2ZWTsI2/pPRoiAVd3Vvhy88ZAs
        zky/g9yjVBeCGf69mbi3JyX5TcSMhBrauWbQ==
Received: from wexc007.uw.lu.se (130.235.59.251) by mail.lu.se
 (130.235.56.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2507.12; Wed, 14
 Sep 2022 16:24:33 +0200
Received: from [130.235.83.196] (130.235.139.100) by wexc007.uw.lu.se
 (130.235.59.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2507.12; Wed, 14
 Sep 2022 16:22:40 +0200
Message-ID: <bd0cbb01-927a-e225-8cb5-6216088c4c07@control.lth.se>
Date:   Wed, 14 Sep 2022 16:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
CC:     Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se>
 <YyA9maUOlPIExIUd@kroah.com>
 <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se>
 <YyB4AtFJx++PeA6S@kroah.com>
 <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se>
 <YyCNOV9no9NPwv8m@kroah.com>
 <e9ca9267-dfee-c7b0-f1ec-4d2b76a05991@control.lth.se>
 <alpine.DEB.2.21.2209131638550.60554@angie.orcam.me.uk>
 <3f2d2863-96dd-05d2-4d88-55666fe37bf8@control.lth.se>
 <alpine.DEB.2.21.2209132254150.60554@angie.orcam.me.uk>
 <5921dfd6-384e-b663-f0f7-8471b9e88c29@control.lth.se>
 <alpine.DEB.2.21.2209141224370.60554@angie.orcam.me.uk>
 <alpine.DEB.2.21.2209141456460.60554@angie.orcam.me.uk>
From:   Anders Blomdell <anders.blomdell@control.lth.se>
In-Reply-To: <alpine.DEB.2.21.2209141456460.60554@angie.orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.235.139.100]
X-ClientProxiedBy: wexc012.uw.lu.se (130.235.59.234) To wexc007.uw.lu.se
 (130.235.59.251)
X-CrossPremisesHeadersFilteredBySendConnector: wexc007.uw.lu.se
X-OrganizationHeadersPreserved: wexc007.uw.lu.se
X-ORF-InterSessionInfo: eid=CNqSUe6YTEk=;oid=AAAAAMCENUM=;bar=wip;cid=AFRb3DDViAQ08ILSDHAc86NA4A==;iss=y;loc=hp;s=Hd90RN4XlVwWdUGdV+YE//SoaJYsz9Iifm9Q5ZJNDBUZzv1iG7TgerPS1a2lkEozzBI6gamcqAaOhqKLsNlvCw==
Received-SPF: Pass (wedge010.net.lu.se: domain of
 anders.blomdell@control.lth.se designates 130.235.59.251 as permitted sender)
 receiver=wedge010.net.lu.se; client-ip=130.235.59.251; helo=wexc007.uw.lu.se;
X-CrossPremisesHeadersFilteredBySendConnector: wedge010.net.lu.se
X-OrganizationHeadersPreserved: wedge010.net.lu.se
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2022-09-14 16:15, Maciej W. Rozycki wrote:
> On Wed, 14 Sep 2022, Maciej W. Rozycki wrote:
> 
>> I'll examine your I/O conversation log in detail and will see if I can
>> come up with a possible explanation.
> 
>   I think I know what is going on here.  Can you please confirm that you
> have the CONFIG_SERIAL_8250_16550A_VARIANTS option disabled (default to
> "off" for x86 only)?  That would explain things.
Just found that myself while going through the initializaton sequence (while now knowing what to look for)

Thats what you get for choosing Fedora ;-)

> 
>   Offhand I am not sure what to do here.  There are several options to
> choose from I can think of right now:
> 
> 1. Disable new OxSemi Tornado clock code iff !SERIAL_8250_16550A_VARIANTS,
>     bringing back buggy calculation for rates above 115200bps and coarse
>     BOTHER granularity.
> 
> 2. Same as above, but additionally limit the baud rates to 115200bps to
>     avoid buggy rates.
> 
> 3. Force SERIAL_8250_16550A_VARIANTS to "y" if SERIAL_8250_PCI != "n".
> 
> 4. Remove SERIAL_8250_16550A_VARIANTS altogether and execute code it
>     guards unconditionally (does it still matter nowadays?).
> 
> 5. Something else not yet determined.
> 
>   Greg, do you have any opinion?
> 
>    Maciej

-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118
SE-221 00 Lund, Sweden
