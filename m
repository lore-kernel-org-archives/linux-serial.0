Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD163CD98F5
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 06:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjJKG6p (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 02:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjJKG6p (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 02:58:45 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C7A98
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 23:58:43 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=96621b7d4a=fe@dev.tdt.de>)
        id 1qqTB3-00ESrC-AQ
        for linux-serial@vger.kernel.org; Wed, 11 Oct 2023 08:58:41 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qqTB2-008ZTB-VC
        for linux-serial@vger.kernel.org; Wed, 11 Oct 2023 08:58:40 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 6ECF42400B0
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 08:58:40 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 271D1240082;
        Wed, 11 Oct 2023 08:58:40 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 7E37B334C9;
        Wed, 11 Oct 2023 08:58:39 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Oct 2023 08:58:39 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Lee Jones <lee@kernel.org>
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, kabel@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/4] trigger: ledtrig-tty: move variable definition to
 the top
In-Reply-To: <20231002140559.GB8453@google.com>
References: <20230928132632.200263-1-fe@dev.tdt.de>
 <20230928132632.200263-4-fe@dev.tdt.de> <20231002140559.GB8453@google.com>
Message-ID: <66ca9e2231629a72e098e1b17736ca34@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1697007521-91376A89-A86807DF/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Lee,

I only got reviews for the fixes and preparations for commits that 
change the
tty subsystem, but no reaction from the maintainer of the feature I want 
to
add to ledtrig-tty for v1 and v2 patchset.

How should I proceed? Send a v3 with the the requested changes.

[Patch v2 1/4]: 
https://lore.kernel.org/linux-leds/20230928132632.200263-1-fe@dev.tdt.de/T/#m913d3822465f35b54dfa24b1dfe4d50e61352980
Change got a 'Reviewed-by: Jiri Slaby <jirislaby@kernel.org>'.
Will add this to an upcoming v3 again.

[Patch v2 2/4] : 
https://lore.kernel.org/linux-leds/20230928132632.200263-1-fe@dev.tdt.de/T/#m7ee7618894a66fd3c89bed488a2394265a3f8df1
I missed to add the robot error message to the commit message and also 
missed
to add the the following 'Reported-by: kernel test robot 
<lkp@intel.com>' and
'Closes: 
https://lore.kernel.org/oe-kbuild-all/202309270440.IJB24Xap-lkp@intel.com/'
to the commit message. Will add this to an upcoming v3.

And do not wait for the review of the following patches.
https://lore.kernel.org/linux-leds/20230928132632.200263-1-fe@dev.tdt.de/T/#mc0ecb912fa0e59015ad0a9b4cb491ae9f18c1ea9
https://lore.kernel.org/linux-leds/20230928132632.200263-1-fe@dev.tdt.de/T/#mba36217323c386ecd900e188bbdf6276c3c96c91

---

Florian
