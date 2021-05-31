Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446DBC47082
	for <linux-serial@archiver.kernel.org>; Mon, 31 May 2021 16:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292476135B
	for <linux-serial@archiver.kernel.org>; Mon, 31 May 2021 16:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhEaQGS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 May 2021 12:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbhEaQEX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 May 2021 12:04:23 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96589C061351;
        Mon, 31 May 2021 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=euB7BL2XuW3HoSpXnWIwx0mLzMjhawHcBqDGg751C3g=; b=tDWS4hOZfgY456Ivm/TAoCqAi
        kwzSbsxZzymv6NNi44bQffd7ZVRueqJlNBszDtH/qddj46tkhS/3Fuw+g8KWvQi6JsUHe4dq/Kwc+
        9YJrjaDlUyrlg1ENb0GZqTSnR8QXlZ0aakBYMTkeDqJ5SEqj+IrsOnUF/DdY9lHOzkLkGzV08kV7a
        8h+GklEje69BI1jShscsHfdMkfebBoWOLNr7s3SllPMQAkFQqMilwb2dvauJcsy4MlG5Vm17JS1l8
        mSG6Dfl1lID8lL4zgtQt1eM+fdGEbG6Pqm1pUw4u+Qct3o4zWw7vkf0cqlmthZbmhe2cSV0uXZ+WL
        B5HbFDzdA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44520)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lnj6r-0002p9-Al; Mon, 31 May 2021 15:41:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lnj6m-0007d2-9u; Mon, 31 May 2021 15:41:36 +0100
Date:   Mon, 31 May 2021 15:41:36 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Ondrej Jirman <megous@megous.com>,
        Chen-Yu Tsai <wens@csie.org>,
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
Message-ID: <20210531144136.GS30436@shell.armlinux.org.uk>
References: <20210530173454.5ab1dcf5@slackpad.fritz.box>
 <YLTi8iYdLiKNeaLC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLTi8iYdLiKNeaLC@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 31, 2021 at 03:21:54PM +0200, Greg Kroah-Hartman wrote:
> On Sun, May 30, 2021 at 05:34:54PM +0100, Andre Przywara wrote:
> > An obvious easy hack-fix is to just define
> > CONFIG_SERIAL_8250_16550A_VARIANTS, which brings the delays back and
> > seems to avoid the problem for me.
> > Another hack which seems to mitigate the problem is to avoid switching
> > the baudrate to something faster than 115200.
> > 
> > I observed this on a BananaPi-M64 (Allwinner A64 SoC with AP6212 WiFi/BT
> > chip), but others reported the same issue on a NanoPi Air (Allwinner H3
> > with 6212), but also other SoCs and devices (at least one AP6210).
> > 
> > Obviously those workarounds are not real solutions, and I was
> > wondering if anybody has an idea how to properly fix this?
> > What puzzles me is that the delay is happening during the *UART*
> > probe, so before we even start dealing with the Bluetooth device.
> 
> What type of bluetooth device is this, and what does it have to do with
> the serial port?  Is the SoC device using the same IP blocks for both?

Many bluetooth "devices" (I mean the interface from the local machine
to the BT world, not as in remote devices) are connected through a
standard UART. Pictorially, it's:

  CPU <---> UART <---> BT chip <---> Bluetooth RF world

The reporter seems to be saying is that a change to the UART driver now
means that the bluetooth chip wired to that UART no longer functions due
to slightly different initialisation timings of the host UART.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
