Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D5AECAAD3
	for <linux-serial@archiver.kernel.org>; Mon, 19 Sep 2022 06:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiISGuj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 19 Sep 2022 02:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiISGud (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Sep 2022 02:50:33 -0400
Received: from wedge009.net.lu.se (wedge009.net.lu.se [130.235.56.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5D7DF95
        for <linux-serial@vger.kernel.org>; Sun, 18 Sep 2022 23:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=control.lth.se; s=edge;
        c=relaxed/relaxed; t=1663570222; h=from:subject:to:date:message-id;
        bh=YNCBsiZ95xq5NkRa1NuHw32Ku8kZ+Z4XjSzx5gT8W48=;
        b=baOqtBCgNsH5oa2j2x7zN94Ob8tmKbFvuESPine0IN8sO3HYJV6z1QDt+i/3wUzsaQ9Fsx4Yqr/
        TXLEvOGHzZPZcW0YPiUIytdQvkcae1LhshQWzw9dad/EDLw465xYtNo4V5igDOGRndWtwoT8TdfaZ
        4FbDUzSQuSPJxi8PjrohZpOnFbJaGyy9Rs4RQZ6bcuMK8cMo4uOfyvRdKNGDmCxJQ2Yd9QDChkx3w
        RpERuBG1n2xrhgFr38lL9QTfGDP7beeKCjs9aTX4KibqJK705UUO2mMOeqsa+s1RK9suvfHeTZ63Y
        xzvfb58F3ZtxGUHKBWRa/zPCQCYVjF3+0HvA==
Received: from wexc007.uw.lu.se (130.235.59.251) by mail.lu.se
 (130.235.56.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2507.12; Mon, 19
 Sep 2022 08:50:22 +0200
Received: from [130.235.83.196] (130.235.139.100) by wexc007.uw.lu.se
 (130.235.59.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2507.12; Mon, 19
 Sep 2022 08:50:21 +0200
Message-ID: <2c55cb59-c8c5-05f1-3d82-0bd9190d9ce3@control.lth.se>
Date:   Mon, 19 Sep 2022 08:50:21 +0200
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
 <bd0cbb01-927a-e225-8cb5-6216088c4c07@control.lth.se>
 <alpine.DEB.2.21.2209142154210.60554@angie.orcam.me.uk>
From:   Anders Blomdell <anders.blomdell@control.lth.se>
In-Reply-To: <alpine.DEB.2.21.2209142154210.60554@angie.orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.235.139.100]
X-ClientProxiedBy: wexc007.uw.lu.se (130.235.59.251) To wexc007.uw.lu.se
 (130.235.59.251)
X-CrossPremisesHeadersFilteredBySendConnector: wexc007.uw.lu.se
X-OrganizationHeadersPreserved: wexc007.uw.lu.se
X-ORF-InterSessionInfo: eid=CNqSPWVCJCM=;oid=AAAAAJ/vdc8=;bar=wip;cid=CkEH+aCenQTtoKmWBCSG6rGzcA==;iss=n;s=YyTx9JfeEYn3Bc0MZfGw9a+n+TkCittHTYUVg/MZDMZTkh1gmmj26HoA+bmHX1hapTe5sToqnKrFtBgtO7mpBw==
Received-SPF: Pass (wedge009.net.lu.se: domain of
 anders.blomdell@control.lth.se designates 130.235.59.251 as permitted sender)
 receiver=wedge009.net.lu.se; client-ip=130.235.59.251; helo=wexc007.uw.lu.se;
X-CrossPremisesHeadersFilteredBySendConnector: wedge009.net.lu.se
X-OrganizationHeadersPreserved: wedge009.net.lu.se
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2022-09-16 23:03, Maciej W. Rozycki wrote:
> On Wed, 14 Sep 2022, Anders Blomdell wrote:
> 
>>>    I think I know what is going on here.  Can you please confirm that you
>>> have the CONFIG_SERIAL_8250_16550A_VARIANTS option disabled (default to
>>> "off" for x86 only)?  That would explain things.
>> Just found that myself while going through the initializaton sequence (while
>> now knowing what to look for)
>>
>> Thats what you get for choosing Fedora ;-)
> 
>   May I suggest that as a person directly affected you file a defect with
> the distribution?  I think a distribution kernel should in principle have
> all the reasonable features enabled for the hardware handled.
First thing I did :-)

https://bugzilla.redhat.com/show_bug.cgi?id=2126201

> 
>    Maciej

-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118
SE-221 00 Lund, Sweden
