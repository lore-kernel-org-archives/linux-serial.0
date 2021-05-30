Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2370BC47091
	for <linux-serial@archiver.kernel.org>; Sun, 30 May 2021 16:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D5A60BD3
	for <linux-serial@archiver.kernel.org>; Sun, 30 May 2021 16:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhE3QhS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 30 May 2021 12:37:18 -0400
Received: from foss.arm.com ([217.140.110.172]:40524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhE3QhR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 30 May 2021 12:37:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09A966D;
        Sun, 30 May 2021 09:35:39 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B93253F73D;
        Sun, 30 May 2021 09:35:36 -0700 (PDT)
Date:   Sun, 30 May 2021 17:34:54 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Ondrej Jirman <megous@megous.com>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-sunxi@lists.linux.dev
Cc:     Josh Triplett <josh@joshtriplett.org>, tuxd3v@sapo.pt
Subject: sunxi: Bluetooth broken since 5.6-rc1
Message-ID: <20210530173454.5ab1dcf5@slackpad.fritz.box>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

as recently discovered via IRC discussions, Bluetooth (via UART)
seems to be broken on many (if not all) Allwinner devices using recent
mainline kernels. On *some* occasions it might work, but more often
than not the hci_bcm driver just times out:
....
[    5.046126] Bluetooth: HIDP socket layer initialized
...
[    7.809425] Bluetooth: hci0: command 0x0c03 tx timeout
[   15.969286] Bluetooth: hci0: BCM: Reset failed (-110)

After some guessing, trying, and bisecting I pinned the problem down to:
commit dc56ecb81a0aa46a7e127e916df5c8fdb8364f0b
Author: Josh Triplett <josh@joshtriplett.org>
Date:   Fri Jan 10 18:25:13 2020 -0800

    serial: 8250: Support disabling mdelay-filled probes of 16550A variants

This seemingly innocent commit shaved off some milliseconds during the
8250 probe, which apparently lets the Bluetooth device trip.

An obvious easy hack-fix is to just define
CONFIG_SERIAL_8250_16550A_VARIANTS, which brings the delays back and
seems to avoid the problem for me.
Another hack which seems to mitigate the problem is to avoid switching
the baudrate to something faster than 115200.

I observed this on a BananaPi-M64 (Allwinner A64 SoC with AP6212 WiFi/BT
chip), but others reported the same issue on a NanoPi Air (Allwinner H3
with 6212), but also other SoCs and devices (at least one AP6210).

Obviously those workarounds are not real solutions, and I was
wondering if anybody has an idea how to properly fix this?
What puzzles me is that the delay is happening during the *UART*
probe, so before we even start dealing with the Bluetooth device.

I see that hci_bcm.c has some history with adding delays, also with
RTS/CTS lines, so does anyone have an idea what's going on here,
exactly, and how to properly fix this problem?

Many thanks,
Andre
