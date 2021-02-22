Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC31C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 15:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2064E64E61
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 15:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhBVPnY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:43:24 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:15141 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231656AbhBVPnN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Feb 2021 10:43:13 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EBB987811A3;
        Mon, 22 Feb 2021 15:42:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a46.g.dreamhost.com (100-96-10-140.trex.outbound.svc.cluster.local [100.96.10.140])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6C13C781239;
        Mon, 22 Feb 2021 15:42:28 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a46.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.10.140 (trex/6.0.2);
        Mon, 22 Feb 2021 15:42:29 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Grain-Illegal: 6670cafe0e804f1c_1614008549706_4054329250
X-MC-Loop-Signature: 1614008549706:3781341860
X-MC-Ingress-Time: 1614008549706
Received: from pdx1-sub0-mail-a46.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a46.g.dreamhost.com (Postfix) with ESMTP id 3461789327;
        Mon, 22 Feb 2021 07:42:28 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a46.g.dreamhost.com (Postfix) with ESMTPSA id 792F37F056;
        Mon, 22 Feb 2021 07:42:26 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id 3F18B282D7A;
        Mon, 22 Feb 2021 10:42:25 -0500 (EST)
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
X-DH-BACKEND: pdx1-sub0-mail-a46
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
References: <3aee5708-7961-f464-8c5f-6685d96920d6@IEEE.org>
 <dc3458f1-830b-284b-3464-20124dc3900a@IEEE.org>
 <YDNwxtDxd7JntAXt@hovoldconsulting.com>
 <e2dcc839-3b43-2c80-6ad1-2d97e639b46a@IEEE.org>
 <YDOvLseYXaUHs0lS@hovoldconsulting.com>
 <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org>
 <YDPO/JprcDTaPmR4@hovoldconsulting.com>
Message-ID: <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
Date:   Mon, 22 Feb 2021 10:42:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDPO/JprcDTaPmR4@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Sorry, my mistake .. when I put it in the right order it does indeed also give 110Bd !

On 2/22/21 10:34 AM, Johan Hovold wrote:
> On Mon, Feb 22, 2021 at 09:53:39AM -0500, Michael G. Katzmann wrote:
>> On 2/22/21 8:18 AM, Johan Hovold wrote:
>>
>> I tried hardcoding buf[6-0] in pl2303_set_termios as
>>
>> a8 a6 01 80 00 02 07 and got a bitrate of ~200kb 
>>
>> so, no these settings do not work in my case (or I missunderstood your
>> instructions 8-))
> Thanks for testing (and that was with 0xa8 in byte 0, right?)
>
> So it seems we have three devices with bcdDevice 0x0300 encoding the
> divisors in slightly different ways and that are all still supported by
> the vendor's Windows driver.
>
> Unless Prolific are willing to shed some light on this, I guess someone
> needs to try to figure out how the Windows driver determines which
> encoding to use.
>
> Is your device supposedly also a PL2303 TA? Could you post the output of
> lsusb -v for completeness?
>
> Johan


-- 
   |\      _,,,---,,_             Michael Katzmann
   /,`.-'`'    -.  ;-;;,_         NV3Z / VK2BEA / G4NYV
  |,4-  ) )-,_. ,\ (  `'-' 
 '---''(_/--'  `-'\_)             MichaelK@IEEE.org

