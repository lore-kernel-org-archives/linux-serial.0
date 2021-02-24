Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F096AC433DB
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A278964F0D
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 17:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhBXRVU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Feb 2021 12:21:20 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:52978 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229644AbhBXRVT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Feb 2021 12:21:19 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 586926424C1;
        Wed, 24 Feb 2021 17:12:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a34.g.dreamhost.com (100-105-161-77.trex.outbound.svc.cluster.local [100.105.161.77])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B096F64296C;
        Wed, 24 Feb 2021 17:12:24 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a34.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.105.161.77 (trex/6.0.2);
        Wed, 24 Feb 2021 17:12:27 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Soft-Oafish: 738c9c641fb2499e_1614186745061_2183097138
X-MC-Loop-Signature: 1614186745060:2148479824
X-MC-Ingress-Time: 1614186745060
Received: from pdx1-sub0-mail-a34.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a34.g.dreamhost.com (Postfix) with ESMTP id 7E40A7F5DA;
        Wed, 24 Feb 2021 09:12:23 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a34.g.dreamhost.com (Postfix) with ESMTPSA id 456398B740;
        Wed, 24 Feb 2021 09:12:21 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id E9DFD282D7A;
        Wed, 24 Feb 2021 12:12:19 -0500 (EST)
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
To:     Johan Hovold <johan@kernel.org>,
        Charles Yeh <charlesyeh522@gmail.com>
Cc:     =?UTF-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Joe Abbott <jabbott@rollanet.org>
References: <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
 <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
 <YDUp0tIThOZSTHJt@hovoldconsulting.com>
 <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com>
 <CAAZvQQ6F=cQ-EhC0kgeTVM3GrtBWR+HfM6UJWj2AEF1NYZ-vAQ@mail.gmail.com>
 <YDaGRRYrEO5BEJv0@hovoldconsulting.com>
X-DH-BACKEND: pdx1-sub0-mail-a34
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
Message-ID: <95508527-f631-a798-d78c-bae791c1d9c2@IEEE.org>
Date:   Wed, 24 Feb 2021 12:12:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDaGRRYrEO5BEJv0@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2/24/21 12:00 PM, Johan Hovold wrote:
> On Wed, Feb 24, 2021 at 03:34:43PM +0800, Charles Yeh wrote:
> But can you confirm that your PL2303TA works with the current Linux
> driver at 110 Bd (and doesn't need the alternate divisor encoding)?
>
> Johan

And by works ... please confirm that the PL2303TA is ACTUALLY outputting data at 110bd (9.09ms bit width) with the current setting provided by the Linux driver.

Michael

