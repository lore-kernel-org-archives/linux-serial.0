Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE561C43381
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 13:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE89664DF3
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 13:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhBWN0M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Feb 2021 08:26:12 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:5214 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232853AbhBWN0L (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Feb 2021 08:26:11 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1659E7E31C8;
        Tue, 23 Feb 2021 13:25:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (100-96-13-41.trex.outbound.svc.cluster.local [100.96.13.41])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 8AA677E2B6B;
        Tue, 23 Feb 2021 13:25:28 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.13.41 (trex/6.0.2);
        Tue, 23 Feb 2021 13:25:28 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Suffer-Vacuous: 3b89499900c11f82_1614086728848_406775145
X-MC-Loop-Signature: 1614086728848:1177074307
X-MC-Ingress-Time: 1614086728848
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a45.g.dreamhost.com (Postfix) with ESMTP id 548897F11C;
        Tue, 23 Feb 2021 05:25:28 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a45.g.dreamhost.com (Postfix) with ESMTPSA id 958747F13C;
        Tue, 23 Feb 2021 05:25:24 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id 68CC3282D7A;
        Tue, 23 Feb 2021 08:25:23 -0500 (EST)
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
To:     =?UTF-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>, Johan Hovold <johan@kernel.org>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
References: <3aee5708-7961-f464-8c5f-6685d96920d6@IEEE.org>
 <dc3458f1-830b-284b-3464-20124dc3900a@IEEE.org>
 <YDNwxtDxd7JntAXt@hovoldconsulting.com>
 <e2dcc839-3b43-2c80-6ad1-2d97e639b46a@IEEE.org>
 <YDOvLseYXaUHs0lS@hovoldconsulting.com>
 <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org>
 <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <cd92ea17-4e0a-2b6c-1032-9a81727841c9@IEEE.org>
 <43da22ced8e14442bbc8babea77e4ed7@MailHC2.prolific.com.tw>
X-DH-BACKEND: pdx1-sub0-mail-a45
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
Message-ID: <f91e9f1b-affc-8b13-19eb-a1ab19771032@IEEE.org>
Date:   Tue, 23 Feb 2021 08:25:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <43da22ced8e14442bbc8babea77e4ed7@MailHC2.prolific.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The markings on the device I have are
PL2303TA
G19101E
CDH81920

... and yes I had to destroy it to open it 8-(

Photo here..... https://photos.app.goo.gl/ontHBzGBbaDV6FWu6

Michael.  


On 2/23/21 5:14 AM, Yeh.Charles [葉榮鑫] wrote:
> I set 110 bps / 8 data bits/ none parity / 1 stop bit.
> I used PL2303TA , I got the data is d5 0e 00 80 00 00 08 on 5.8.0-41 kernel.
> Please refer to attached file : PL2303TA.png.
>
> The divider algorithm is OK on Linux for my test.
>
> Can you use you PL2303TA board to print log?
> What are the differences between the log you printed and the log printed in the attachment?
