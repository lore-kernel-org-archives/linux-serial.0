Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637B3C6FA82
	for <linux-serial@archiver.kernel.org>; Tue, 13 Sep 2022 12:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiIMMnm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Sep 2022 08:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiIMMnl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 08:43:41 -0400
Received: from wedge010.net.lu.se (wedge010.net.lu.se [130.235.56.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C9952822
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 05:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=control.lth.se; s=edge;
        c=relaxed/relaxed; t=1663073017; h=from:subject:to:date:message-id;
        bh=qsHBZjy0zKt4+UNwSQ99b//917WCASAsQs5kN4z5CMY=;
        b=bZo4I3i+qdgALqeqh+JJunc9S2A6RLj1kXDzJb1JbZ3Uz2HArUQIJ3Ve1p6AKysXxqOH/eRi7pk
        0ANAODQ4x2/lL2vvhcWf90vVCVurQ5FMzGvClXp8HAmHxDvsQP1jiQm/3I1NsmOppIsIDFa2z3jXK
        RKX2r7Jo8B4xQkZruWk1Sy9lUbxCAR8FyFSZJYSnuKzM9zSanddk3j7V/vn94Xhj4zEOCZzrd5VkR
        dc8nUxkTi5PztazW1bO10pPhgMmNCdy+D+2vCMKWvuWCqOSFcGvm7xF7MhS3GWYYFEsN5LHoQ94TO
        90sWBDAzrq0mz3znpdzpSBwDenQ9O/afl5mw==
Received: from wexc007.uw.lu.se (130.235.59.251) by mail.lu.se
 (130.235.56.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2507.12; Tue, 13
 Sep 2022 14:43:37 +0200
Received: from [130.235.83.196] (130.235.139.100) by wexc007.uw.lu.se
 (130.235.59.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2507.12; Tue, 13
 Sep 2022 14:43:04 +0200
Message-ID: <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se>
Date:   Tue, 13 Sep 2022 14:43:03 +0200
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
From:   Anders Blomdell <anders.blomdell@control.lth.se>
In-Reply-To: <YyB4AtFJx++PeA6S@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.235.139.100]
X-ClientProxiedBy: wexc012.uw.lu.se (130.235.59.234) To wexc007.uw.lu.se
 (130.235.59.251)
X-CrossPremisesHeadersFilteredBySendConnector: wexc007.uw.lu.se
X-OrganizationHeadersPreserved: wexc007.uw.lu.se
X-ORF-InterSessionInfo: eid=CNqSUe6UFTo=;oid=AAAAAMCENUM=;bar=wip;cid=AFRb3DDViAQ08ILSDHAc86NA4A==;iss=y;loc=hp;s=M5T7w6l/xRtRTq6Crw/0gvSHXdlhF66qjhnAL8m7tAM3/7T9fYI/5wMFQbtMlQ4h/8sZpEGYOEdK8A6iv2ogDw==
Received-SPF: Pass (wedge010.net.lu.se: domain of
 anders.blomdell@control.lth.se designates 130.235.59.251 as permitted sender)
 receiver=wedge010.net.lu.se; client-ip=130.235.59.251; helo=wexc007.uw.lu.se;
X-CrossPremisesHeadersFilteredBySendConnector: wedge010.net.lu.se
X-OrganizationHeadersPreserved: wedge010.net.lu.se
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2022-09-13 14:30, Greg Kroah-Hartman wrote:
> On Tue, Sep 13, 2022 at 02:16:39PM +0200, Anders Blomdell wrote:
>> I get incorrect baudrates, my oscilloscope gives:
>>
>> Programmed	Measured
>>
>>    2400		  5208
>>    4800		 13150
>>    9600		 10410
>>   19200		 71420
>>   38400		142000
>>   57600		201600
>> 115200		138800
> 
> I'm sorry, I have no context here at all, what does this pertain to?
Programmed baudrate and the measured (actual) baudrate
> 
> confused,
> 
> greg k-h

/Anders
-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118
SE-221 00 Lund, Sweden
