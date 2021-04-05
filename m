Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2050DC433B4
	for <linux-serial@archiver.kernel.org>; Mon,  5 Apr 2021 00:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF9961391
	for <linux-serial@archiver.kernel.org>; Mon,  5 Apr 2021 00:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhDEAYP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 4 Apr 2021 20:24:15 -0400
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:52026 "EHLO
        elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231688AbhDEAYP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 4 Apr 2021 20:24:15 -0400
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Apr 2021 20:24:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1617582250; bh=huGBOiU6YkSgCISfXFKLa0MqdWIoqj9p8eiN
        F3z1CFo=; h=Received:To:From:Subject:Message-ID:Date:User-Agent:
         MIME-Version:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-ELNK-Trace:X-Originating-IP; b=MPydTWnX1n+/vzA7
        Kn1Pk1zTb614sWgObdiUEY+WyAXdqdHphAqKajf6s0z85R36vO7aQ0bjDRV5LOjr2v4
        TbI84PRu5+fkdimUivYO938H44v5xqM0duntCm9TqTO28VQ+UNHTcUO1mZFw+BzjpxX
        o9aq7QnEmi01laZmtY5D6onYADgJTvP4snd9pMtGdkVtsCsjlqUe4cQ6yFIOSt8jFQf
        N2juPXd5hRi5s4SrD7sj+OXwd3CsBFUrN98mKRUbYtFXzojw/xXuCGyb1iK3NrxmA/l
        AJqjOVQhIt8zWGK7RlpBXe2KoBgEQNmS+3zf/+EVng5aSg2PIdUP1T4qvw==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=rfAX95x7ykoWV0UmrP4pHJc2XhQaK2+LlPRjKVQMchyjyaE4jp2q/rx3ZIn8K0896kHK9p/TIq8ZisvZEXBYReLOhbqwkEvVEsry6YUDDwhNBmLNbmyGOkShaz7gV6itZ0OAvsSBfHCWJTU/iyPBWHTGvr4hpjZAf0WAUZeYfXrsHB+0eERnPXv2GU/PCh6UzO/IIOE3GZ/GDw+wo6W0IUih2CQYMSEzuMNOH+KZcD9UgZpa60cbVMTbQjpD2DaU1kzhdhXRBFrFOpUP6UpESUvh6eXBQiEOtGiMHOYbgDROIn20mnkdsBK2sNM7zJyqOCfwPr4bMIRfmlQtSDDzog==;
  h=Received:To:From:Subject:Message-ID:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Language:X-ELNK-Trace:X-Originating-IP;
Received: from [50.53.39.0] (helo=ssd1tb.sawyer.home)
        by elasmtp-curtail.atl.sa.earthlink.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4)
        (envelope-from <dansawyer@earthlink.net>)
        id 1lTCuq-0004ya-1s
        for linux-serial@vger.kernel.org; Sun, 04 Apr 2021 20:16:28 -0400
To:     linux-serial@vger.kernel.org
From:   Dan Sawyer <dansawyer@earthlink.net>
Subject: requested message -
Message-ID: <b85d1bb2-71e7-a2db-1e0b-11317cd8f16f@earthlink.net>
Date:   Sun, 4 Apr 2021 17:16:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ELNK-Trace: 9b76c4488e3039a271639b933de7ae6f7e972de0d01da940804a1de282246a73b751fb7e7e3cf05d350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 50.53.39.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Below are outputs for a pci dev. I am not sure if this device correctly 
configured or not.

Thank you,

Dan

lspci -vv

01:00.0 Communication controller: MosChip Semiconductor Technology Ltd. 
PCI 9835 Multi-I/O Controller (rev 01)
     Subsystem: LSI Logic / Symbios Logic PCI 9835 Multi-I/O Controller
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin A routed to IRQ 21
     Region 0: I/O ports at d050 [size=8]
     Region 1: I/O ports at d040 [size=8]
     Region 2: I/O ports at d030 [size=8]
     Region 3: I/O ports at d020 [size=8]
     Region 4: I/O ports at d010 [size=8]
     Region 5: I/O ports at d000 [size=16]
     Kernel modules: parport_serial

   9.855040] parport1: PC-style at 0xd030, irq 21 [PCSPP,TRISTATE,EPP]
[    9.872857] intel_powerclamp: No package C-state available
[    9.946228] intel_powerclamp: No package C-state available
[    9.969597] parport_serial 0000:01:00.0: 0000:01:00.0: unknown 
NetMos/Mostech device
                Please send the output of lspci -vv, this
                message (0x9710,0x9835,0x1000,0x0010), the
                manufacturer and name of serial board or
                modem board to <linux-serial@vger.kernel.org>.

