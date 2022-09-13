Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A8CC54EE9
	for <linux-serial@archiver.kernel.org>; Tue, 13 Sep 2022 12:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiIMMRO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Sep 2022 08:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIMMRM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 08:17:12 -0400
Received: from wedge010.net.lu.se (wedge010.net.lu.se [130.235.56.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAD715720
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=control.lth.se; s=edge;
        c=relaxed/relaxed; t=1663071424; h=from:subject:to:date:message-id;
        bh=F+m24p1GzqI+lbT+ZBom7pwe2vsMXLIkA9PWTBKYWZ4=;
        b=i5nCUC84lCwgvhgdW7qic0nSdfwFo6UuOyMKt1n43Q7FZqz2YOi0I71nWAnBmiDuDRxE8x+Isqb
        GsMqCOUEFppeudRq+OPi7nxUqr4giQZ4g2lC+8vEKch1UQQMCmlc6PwzQoMsqLNtSWUYvfrmUhjs5
        dwHdTa1GQ77HMkley3UwwHjN+sABzR3uh0oJ7AeTo91bjkZEBCaPXfNjj3p+97bT4UGQ+8zlfvY/o
        nYUZaLWlwbtqOd01VSNwr0bn2dOKCEwrfBoUSJ71LfmFPMm/c4sZLoWPzpOJZioYg+2wOkZX3e10e
        6/OwONAcbnvjCQw1UBjS6lH5ZzIXBQqxepug==
Received: from wexc007.uw.lu.se (130.235.59.251) by mail.lu.se
 (130.235.56.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2507.12; Tue, 13
 Sep 2022 14:17:04 +0200
Received: from [130.235.83.196] (130.235.139.100) by wexc007.uw.lu.se
 (130.235.59.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2507.12; Tue, 13
 Sep 2022 14:16:40 +0200
Message-ID: <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se>
Date:   Tue, 13 Sep 2022 14:16:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
CC:     <linux-serial@vger.kernel.org>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se>
 <YyA9maUOlPIExIUd@kroah.com>
From:   Anders Blomdell <anders.blomdell@control.lth.se>
In-Reply-To: <YyA9maUOlPIExIUd@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.235.139.100]
X-ClientProxiedBy: wexc008.uw.lu.se (130.235.59.252) To wexc007.uw.lu.se
 (130.235.59.251)
X-CrossPremisesHeadersFilteredBySendConnector: wexc007.uw.lu.se
X-OrganizationHeadersPreserved: wexc007.uw.lu.se
X-ORF-InterSessionInfo: eid=CNqSUe6T9zQ=;oid=AAAAAMCENUM=;bar=wip;cid=AFRb3DDViAQ08ILSDHAc86NA4A==;iss=y;loc=hp;s=/Ojn+UWQE8NZ18kMyvqLxZKLpGePDg03RyUvfmkbARf1j6W2uB9p+/h4l5VKGujezmYpEnf4vvjFTB84uvIGDA==
Received-SPF: Pass (wedge010.net.lu.se: domain of
 anders.blomdell@control.lth.se designates 130.235.59.251 as permitted sender)
 receiver=wedge010.net.lu.se; client-ip=130.235.59.251; helo=wexc007.uw.lu.se;
X-CrossPremisesHeadersFilteredBySendConnector: wedge010.net.lu.se
X-OrganizationHeadersPreserved: wedge010.net.lu.se
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I get incorrect baudrates, my oscilloscope gives:

Programmed	Measured

   2400		  5208
   4800		 13150
   9600		 10410
  19200		 71420
  38400		142000
  57600		201600
115200		138800


On 2022-09-13 10:21, Greg Kroah-Hartman wrote:
> On Mon, Sep 12, 2022 at 09:59:08PM +0200, Anders Blomdell wrote:
>> Reverting commits
>>    366f6c955d4d1a5125ffcd6875ead26a3c7a2a1c
>>    9c5c8aaed50bf3478073ab51b8b1f3f5327d3cfa
>> fixes my problems.
> 
> What problems exactly?
> 
> And why not cc: the developers of those commits?
> 
> thanks,
> 
> greg k-h

-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118
SE-221 00 Lund, Sweden
