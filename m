Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D464FC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 12:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB4A64E41
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 12:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhBVMtO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Feb 2021 07:49:14 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:16638 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231293AbhBVMsq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Feb 2021 07:48:46 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2FDF1101F76;
        Mon, 22 Feb 2021 12:39:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a46.g.dreamhost.com (100-98-118-117.trex.outbound.svc.cluster.local [100.98.118.117])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A8D15101A4D;
        Mon, 22 Feb 2021 12:39:46 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a46.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.98.118.117 (trex/6.0.2);
        Mon, 22 Feb 2021 12:39:47 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Spot-Chief: 77190bf72eb2d824_1613997586973_340005202
X-MC-Loop-Signature: 1613997586973:2902972099
X-MC-Ingress-Time: 1613997586973
Received: from pdx1-sub0-mail-a46.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a46.g.dreamhost.com (Postfix) with ESMTP id 7169F88D85;
        Mon, 22 Feb 2021 04:39:46 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a46.g.dreamhost.com (Postfix) with ESMTPSA id 0E3E17FDDB;
        Mon, 22 Feb 2021 04:39:44 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id 776F5282D7A;
        Mon, 22 Feb 2021 07:39:42 -0500 (EST)
To:     Johan Hovold <johan@kernel.org>, charles-yeh@prolific.com.tw
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
References: <3aee5708-7961-f464-8c5f-6685d96920d6@IEEE.org>
 <dc3458f1-830b-284b-3464-20124dc3900a@IEEE.org>
 <YDNwxtDxd7JntAXt@hovoldconsulting.com>
X-DH-BACKEND: pdx1-sub0-mail-a46
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <e2dcc839-3b43-2c80-6ad1-2d97e639b46a@IEEE.org>
Date:   Mon, 22 Feb 2021 07:39:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDNwxtDxd7JntAXt@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2/22/21 3:52 AM, Johan Hovold wrote:
> Does your updated algorithm also result in 110 baud (8n1) being encoded
> as:
>
> 	a8 a6 01 80 00 02 07
>
> And are you using some official Prolific Windows driver or something
> that came with the device?

Johan,

  On Windows I did not install a new driver. It was recognized by the system and uses the Microsoft provided Prolific driver Ver 3.8.38.2.

On windows everything looks fine (no sign of distress (i.e. no yellow caution triangle)).

Where should I look for the encoding (a8 a6 01 80 00 02 07) ? (110bd encodes as 80 00 C3 54 using the algorithm I described))

cheers,

   Michael

> I tried asking Prolific about this but I'm still not sure whether these
> are official chips or counterfeit. 0x0300 is supposed to be a PL2303TA
> and Prolific claims that the current driver is working fine with these
> so we'd need to key off something more than just bcdDevice.


