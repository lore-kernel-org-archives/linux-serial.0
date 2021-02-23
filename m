Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5184CC433E0
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 19:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB4064EC3
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 19:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhBWTP4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:15:56 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:54334 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233602AbhBWTPz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Feb 2021 14:15:55 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DAE4722569;
        Tue, 23 Feb 2021 19:15:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (100-96-133-21.trex.outbound.svc.cluster.local [100.96.133.21])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4F0BE205ED;
        Tue, 23 Feb 2021 19:15:12 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.133.21 (trex/6.0.2);
        Tue, 23 Feb 2021 19:15:12 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Stop-Eight: 3256f254205c773f_1614107712625_1346096189
X-MC-Loop-Signature: 1614107712622:1926028336
X-MC-Ingress-Time: 1614107712622
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a45.g.dreamhost.com (Postfix) with ESMTP id B35B37F04B;
        Tue, 23 Feb 2021 11:15:11 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a45.g.dreamhost.com (Postfix) with ESMTPSA id 103907F03D;
        Tue, 23 Feb 2021 11:15:08 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id BE266282D7A;
        Tue, 23 Feb 2021 14:15:06 -0500 (EST)
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
To:     Johan Hovold <johan@kernel.org>
Cc:     charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
References: <YDOvLseYXaUHs0lS@hovoldconsulting.com>
 <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org>
 <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
 <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
 <YDUp0tIThOZSTHJt@hovoldconsulting.com>
 <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com>
X-DH-BACKEND: pdx1-sub0-mail-a45
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
Message-ID: <4edfb35f-ed81-bade-daee-38a1d7a60a7d@IEEE.org>
Date:   Tue, 23 Feb 2021 14:15:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDUysZY90FfVhrHK@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2/23/21 11:52 AM, Johan Hovold wrote:
> On Tue, Feb 23, 2021 at 11:30:41AM -0500, Michael G. Katzmann wrote:
>> On 2/23/21 11:14 AM, Johan Hovold wrote:
>>> I only have an HXD (and a GC) here.
>>>
>>> The HXD has bcdUSB as 1.10 unlike your TA with 2.00, but not sure that
>>> helps.
>> Sound promising .. why do you think this is this not reliable?
> Perhaps it is. Perhaps even bcdDevice of 3.00 is enough (includes some
> older variants that the TA replaced supposedly). Not sure anyone ever
> tried the current scheme on those older models.
>
> Charles, could you post the output of "lsusb -v" for your PL2303TA? And
> did you verify that you actually got 110 Bd with the current Linux
> driver?
>
> Johan

Here is the USB packet capture from Wireshark oon Windows 10 when:

1) plugging in pl2303 (packets 18-393)

2) setting the device wia cmd line to 110/even/7 bits/2 stop (packets 393-690)

(device is on port 1.7)

https://drive.google.com/file/d/17TkV9JB2iFNdr4LvRftBnV3_DgITGvUH/view?usp=sharing

There are orders of magnitude more traffic than in Linux!


-- 
   |\      _,,,---,,_             Michael Katzmann
   /,`.-'`'    -.  ;-;;,_         NV3Z / VK2BEA / G4NYV
  |,4-  ) )-,_. ,\ (  `'-' 
 '---''(_/--'  `-'\_)             MichaelK@IEEE.org

