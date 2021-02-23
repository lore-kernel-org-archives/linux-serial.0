Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533C3C433DB
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 15:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F088A64EC3
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 15:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhBWP7D convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Feb 2021 10:59:03 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:2558 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233313AbhBWP64 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Feb 2021 10:58:56 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 52BB932377F;
        Tue, 23 Feb 2021 15:57:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (100-96-16-18.trex.outbound.svc.cluster.local [100.96.16.18])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CACEA32367E;
        Tue, 23 Feb 2021 15:57:12 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.16.18 (trex/6.0.2);
        Tue, 23 Feb 2021 15:57:13 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Abortive: 79a5151838c66d0c_1614095833137_1377275420
X-MC-Loop-Signature: 1614095833137:1106550808
X-MC-Ingress-Time: 1614095833137
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a45.g.dreamhost.com (Postfix) with ESMTP id 9600D7F03C;
        Tue, 23 Feb 2021 07:57:12 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a45.g.dreamhost.com (Postfix) with ESMTPSA id 754A47F11C;
        Tue, 23 Feb 2021 07:57:10 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id 23DDA282D7A;
        Tue, 23 Feb 2021 10:57:09 -0500 (EST)
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
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
X-DH-BACKEND: pdx1-sub0-mail-a45
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
Date:   Tue, 23 Feb 2021 10:57:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2/23/21 10:43 AM, Johan Hovold wrote:
> On Tue, Feb 23, 2021 at 09:58:47AM -0500, Michael G. Katzmann wrote:
>> Is it that we are presuming that what Prolific is telling us is true
>> and only Joe and I are actually measuring the data rate?  (i.e. why
>> does the Prolific Windows driver set the values as Joe found ???)
> I'm starting to think they've added some alternate baud rate encoding in
> order to make life harder for the people pushing (or unknowingly buying)
> counterfeit devices.
>
> As you say, why else would the Windows driver support this encoding?

I find that  'Halon;'s razor' is helpful in these situations...  I can't think that messing with people who use old teleprinters would be useful in protecting one's products 8-)

If Joe has some wireshark traces we can see if there are any vendor specific USB packets. If not I can try it (I'd be starting from scratch as I've only use wireshark on Linux).

I presume you can't see any differentiators in the normal USB identifiers that we can use. 

If someone has a device that works under the existing driver, it would be helpful to see if the modified scheme also works on those devices?


