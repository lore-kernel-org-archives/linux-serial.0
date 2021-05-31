Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A54C47082
	for <linux-serial@archiver.kernel.org>; Mon, 31 May 2021 15:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855B860FE8
	for <linux-serial@archiver.kernel.org>; Mon, 31 May 2021 15:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhEaPCk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 May 2021 11:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234142AbhEaPAj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 May 2021 11:00:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BD3460FEF;
        Mon, 31 May 2021 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622470351;
        bh=wkKztpo64XTQBWAnbxSKsTIGW62NyR1Cw1YrVMh3Z2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwYXnjd3T+Uk7jc/j3e+LtOttEOMKrNQ3Jhwc/jfMvZwIox3gh61RW790EEGQq97Z
         H6IYYS7WEHKkIdW3w6KJhwpWjGordesLIuoarJv/zWjz2MDLgvONdxt6lwXwWLQxna
         3dHiLeYJFdnwbfAqM85Uoy2CTK4WyzpUI+hRBa5g=
Date:   Mon, 31 May 2021 15:21:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Ondrej Jirman <megous@megous.com>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Josh Triplett <josh@joshtriplett.org>, tuxd3v@sapo.pt
Subject: Re: sunxi: Bluetooth broken since 5.6-rc1
Message-ID: <YLTi8iYdLiKNeaLC@kroah.com>
References: <20210530173454.5ab1dcf5@slackpad.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530173454.5ab1dcf5@slackpad.fritz.box>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, May 30, 2021 at 05:34:54PM +0100, Andre Przywara wrote:
> Hi,
> 
> as recently discovered via IRC discussions, Bluetooth (via UART)
> seems to be broken on many (if not all) Allwinner devices using recent
> mainline kernels. On *some* occasions it might work, but more often
> than not the hci_bcm driver just times out:
> ....
> [    5.046126] Bluetooth: HIDP socket layer initialized
> ...
> [    7.809425] Bluetooth: hci0: command 0x0c03 tx timeout
> [   15.969286] Bluetooth: hci0: BCM: Reset failed (-110)
> 
> After some guessing, trying, and bisecting I pinned the problem down to:
> commit dc56ecb81a0aa46a7e127e916df5c8fdb8364f0b
> Author: Josh Triplett <josh@joshtriplett.org>
> Date:   Fri Jan 10 18:25:13 2020 -0800
> 
>     serial: 8250: Support disabling mdelay-filled probes of 16550A variants
> 
> This seemingly innocent commit shaved off some milliseconds during the
> 8250 probe, which apparently lets the Bluetooth device trip.

What do you mean by "trip"?

And how are the different devices related?

> An obvious easy hack-fix is to just define
> CONFIG_SERIAL_8250_16550A_VARIANTS, which brings the delays back and
> seems to avoid the problem for me.
> Another hack which seems to mitigate the problem is to avoid switching
> the baudrate to something faster than 115200.
> 
> I observed this on a BananaPi-M64 (Allwinner A64 SoC with AP6212 WiFi/BT
> chip), but others reported the same issue on a NanoPi Air (Allwinner H3
> with 6212), but also other SoCs and devices (at least one AP6210).
> 
> Obviously those workarounds are not real solutions, and I was
> wondering if anybody has an idea how to properly fix this?
> What puzzles me is that the delay is happening during the *UART*
> probe, so before we even start dealing with the Bluetooth device.

What type of bluetooth device is this, and what does it have to do with
the serial port?  Is the SoC device using the same IP blocks for both?

> I see that hci_bcm.c has some history with adding delays, also with
> RTS/CTS lines, so does anyone have an idea what's going on here,
> exactly, and how to properly fix this problem?

No idea, sorry, as you have the hardware, you have the best chance of
debugging this :(

good luck!

greg k-h
