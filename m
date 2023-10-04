Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4ACE8FDDB
	for <linux-serial@archiver.kernel.org>; Wed,  4 Oct 2023 08:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbjJDIgT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Oct 2023 04:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbjJDIgR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Oct 2023 04:36:17 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E9B83
        for <linux-serial@vger.kernel.org>; Wed,  4 Oct 2023 01:36:13 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=8655c94f36=fe@dev.tdt.de>)
        id 1qnxMZ-00GJIm-Cf
        for linux-serial@vger.kernel.org; Wed, 04 Oct 2023 10:36:11 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qnxMZ-001bgR-1I
        for linux-serial@vger.kernel.org; Wed, 04 Oct 2023 10:36:11 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 9BED8240049
        for <linux-serial@vger.kernel.org>; Wed,  4 Oct 2023 10:36:10 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 5DD97240040;
        Wed,  4 Oct 2023 10:36:10 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id B023132186;
        Wed,  4 Oct 2023 10:36:09 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Oct 2023 10:36:09 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Eckert.Florian@googlemail.com,
        gregkh@linuxfoundation.org, pavel@ucw.cz, kabel@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/4] trigger: ledtrig-tty: move variable definition to
 the top
In-Reply-To: <05b03f3e-5863-4d33-8c70-03be7d7e972f@kernel.org>
References: <20230928132632.200263-1-fe@dev.tdt.de>
 <20230928132632.200263-4-fe@dev.tdt.de> <20231002140559.GB8453@google.com>
 <acda5dc4-e6d3-4870-929f-fb91636b5649@kernel.org>
 <59cc4073a94edbdec5d77f8457ed4f73@dev.tdt.de>
 <05b03f3e-5863-4d33-8c70-03be7d7e972f@kernel.org>
Message-ID: <d59855493baa936485a2b00aa29d0449@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1696408571-3E488A8C-46FA30E6/0/0
X-purgate-type: clean
X-purgate: clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



>> I decided to move the variable definition with a separate commit
>> to the top of the function, to make the build robot happy. After that
>> I made my changes for v2 to the ledtrig-tty to add the feature.
>> 
>>> Ah, lkp, then also the Closes: line as it suggests.
>> 
>> Sorry I do not understand your statement
> 
> The link you pasted above states:
> =======
> If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> https://lore.kernel.org/oe-kbuild-all/202309270440.IJB24Xap-lkp@intel.com/
> =======
> 
> So please follow that suggestion ;).

Ok, I understand, thanks will to this on a v3 patchset.
I will now wait for the comments of my changes in ledtrig-tty from the 
led subsystem.
And then I will send a new patch set with the requested changes.

Sorry for the silly question. But do I have to send this patch again for 
a v3?
https://lore.kernel.org/linux-leds/f41dc1e1-6d34-48b2-97dd-ba67df6003c6@kernel.org/T/#u
It was already marked by you with a `Reviewed-by:` from you?

--
Best regards
Florian
