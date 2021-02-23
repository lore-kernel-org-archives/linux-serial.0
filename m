Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95B2C433DB
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 16:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A4D61494
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 16:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhBWQb3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Feb 2021 11:31:29 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:32230 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231742AbhBWQb2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Feb 2021 11:31:28 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 45B51542F50;
        Tue, 23 Feb 2021 16:30:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (100-96-17-34.trex.outbound.svc.cluster.local [100.96.17.34])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B9DAD542DB0;
        Tue, 23 Feb 2021 16:30:44 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.17.34 (trex/6.0.2);
        Tue, 23 Feb 2021 16:30:45 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-White-Abortive: 4c82e4e341bffef3_1614097845037_1763475294
X-MC-Loop-Signature: 1614097845037:1705731403
X-MC-Ingress-Time: 1614097845036
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a45.g.dreamhost.com (Postfix) with ESMTP id 70CD77F04B;
        Tue, 23 Feb 2021 08:30:44 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a45.g.dreamhost.com (Postfix) with ESMTPSA id DA9C37F03D;
        Tue, 23 Feb 2021 08:30:42 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id BD586282D7A;
        Tue, 23 Feb 2021 11:30:41 -0500 (EST)
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
To:     Johan Hovold <johan@kernel.org>
Cc:     charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
References: <YDNwxtDxd7JntAXt@hovoldconsulting.com>
 <e2dcc839-3b43-2c80-6ad1-2d97e639b46a@IEEE.org>
 <YDOvLseYXaUHs0lS@hovoldconsulting.com>
 <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org>
 <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
 <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
 <YDUp0tIThOZSTHJt@hovoldconsulting.com>
X-DH-BACKEND: pdx1-sub0-mail-a45
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
Message-ID: <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
Date:   Tue, 23 Feb 2021 11:30:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDUp0tIThOZSTHJt@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2/23/21 11:14 AM, Johan Hovold wrote:
> I only have an HXD (and a GC) here.
>
> The HXD has bcdUSB as 1.10 unlike your TA with 2.00, but not sure that
> helps.

Sound promising .. why do you think this is this not reliable?

