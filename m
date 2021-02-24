Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0F9C433E9
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F113464EFA
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 15:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhBXPll (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Feb 2021 10:41:41 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:34545 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236909AbhBXOYf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Feb 2021 09:24:35 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id F0D09681134
        for <linux-serial@vger.kernel.org>; Wed, 24 Feb 2021 14:23:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a88.g.dreamhost.com (100-96-11-27.trex.outbound.svc.cluster.local [100.96.11.27])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6F12E680E58
        for <linux-serial@vger.kernel.org>; Wed, 24 Feb 2021 14:23:47 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a88.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.11.27 (trex/6.0.2);
        Wed, 24 Feb 2021 14:23:47 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Obese-Bubble: 3de378a067aa7190_1614176627649_2370107046
X-MC-Loop-Signature: 1614176627649:3888530111
X-MC-Ingress-Time: 1614176627648
Received: from pdx1-sub0-mail-a88.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a88.g.dreamhost.com (Postfix) with ESMTP id 348067EE50
        for <linux-serial@vger.kernel.org>; Wed, 24 Feb 2021 06:23:47 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a88.g.dreamhost.com (Postfix) with ESMTPSA id F2A367EE41
        for <linux-serial@vger.kernel.org>; Wed, 24 Feb 2021 06:23:46 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id 95DC9282D7A
        for <linux-serial@vger.kernel.org>; Wed, 24 Feb 2021 09:23:45 -0500 (EST)
X-DH-BACKEND: pdx1-sub0-mail-a88
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
To:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: closing serial device dumps data in buffer
Message-ID: <23e9e8aa-1f6f-47d3-6ad4-97057e4975f1@IEEE.org>
Date:   Wed, 24 Feb 2021 09:23:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I've noticed that when the serial device is closed, the USB serial device dumps any buffered data. Is this expected behavior?

i.e ls -l >/dev/ttyUSB0 will not print everything (I'm missing some at the end) but

(ls -l; sleep 30) >/de/ttyUSB0 will print everything.

(this is at 110bd so it's probably longer than most people will see to drain the buffer)


Michael

