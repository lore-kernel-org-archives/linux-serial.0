Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E60C433DB
	for <linux-serial@archiver.kernel.org>; Sun, 21 Feb 2021 15:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF70264F04
	for <linux-serial@archiver.kernel.org>; Sun, 21 Feb 2021 15:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhBUPjC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 21 Feb 2021 10:39:02 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:21242 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhBUPjB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 21 Feb 2021 10:39:01 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0AA7A70239F
        for <linux-serial@vger.kernel.org>; Sun, 21 Feb 2021 15:37:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a97.g.dreamhost.com (100-96-27-121.trex.outbound.svc.cluster.local [100.96.27.121])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 536A6701E87
        for <linux-serial@vger.kernel.org>; Sun, 21 Feb 2021 15:37:22 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a97.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.27.121 (trex/6.0.2);
        Sun, 21 Feb 2021 15:37:22 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Irritate-Little: 645d67894c36b1c1_1613921842546_2372601821
X-MC-Loop-Signature: 1613921842546:268452279
X-MC-Ingress-Time: 1613921842546
Received: from pdx1-sub0-mail-a97.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a97.g.dreamhost.com (Postfix) with ESMTP id 1A0457F210
        for <linux-serial@vger.kernel.org>; Sun, 21 Feb 2021 07:37:22 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a97.g.dreamhost.com (Postfix) with ESMTPSA id EE8CA7F15F
        for <linux-serial@vger.kernel.org>; Sun, 21 Feb 2021 07:37:21 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id 7AEB0282D7A
        for <linux-serial@vger.kernel.org>; Sun, 21 Feb 2021 10:37:20 -0500 (EST)
X-DH-BACKEND: pdx1-sub0-mail-a97
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
To:     linux-serial@vger.kernel.org
Subject: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <3aee5708-7961-f464-8c5f-6685d96920d6@IEEE.org>
Date:   Sun, 21 Feb 2021 10:37:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I am trying to use a USB serial interface with a Prolific chip to connect to an old ASR 33 Teletype at 110 Bd.

The USB device will work at 110 Bd in Windows 10 but not under the Linux driver. The USB PID/VID is 0673 / 2303 which corresponds to

static const struct usb_device_id id_table[] = {
    { USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID),
        .driver_info = PL2303_QUIRK_ENDPOINT_HACK },

in the pl2303 driver. The Manufacturer of this device is 'Sabrabt' (CB-DB9P) and I believe it's a genuine chip device (and not a clone).

The Linux driver does not seem to produce sensible baud rated for other than the 'supported' rates.

stty to 110 bd results in ~95,000 bd (that's not a typo but 95 thousand). Other rates like 200 also produce odd speeds although not in a logical manner.

The data sheets don't describe the formula used for deriving the four bytes used to set the speed.

I tried adding 110 to the supported rates but this did not produce the correct baud rate so I presume the Windows driver is using a formula different than the one in the Linux driver for 'non standard' baud rates.

Does anyone have any suggestions to get this working at 110bd or what other experiments to try?

- Michael


