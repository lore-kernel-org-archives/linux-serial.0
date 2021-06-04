Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF35C4743C
	for <linux-serial@archiver.kernel.org>; Fri,  4 Jun 2021 17:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B101D61405
	for <linux-serial@archiver.kernel.org>; Fri,  4 Jun 2021 17:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFDRPT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Jun 2021 13:15:19 -0400
Received: from foss.arm.com ([217.140.110.172]:43982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhFDRPT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Jun 2021 13:15:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9278B1063;
        Fri,  4 Jun 2021 10:13:32 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 387D03F73D;
        Fri,  4 Jun 2021 10:13:30 -0700 (PDT)
Date:   Fri, 4 Jun 2021 18:13:22 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ondrej Jirman <megous@megous.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Josh Triplett <josh@joshtriplett.org>, tuxd3v@sapo.pt,
        Rob Herring <robh@kernel.org>
Subject: Re: sunxi: Bluetooth broken since 5.6-rc1
Message-ID: <20210604181322.52a26de8@slackpad.fritz.box>
In-Reply-To: <20210531144136.GS30436@shell.armlinux.org.uk>
References: <20210530173454.5ab1dcf5@slackpad.fritz.box>
        <YLTi8iYdLiKNeaLC@kroah.com>
        <20210531144136.GS30436@shell.armlinux.org.uk>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 31 May 2021 15:41:36 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

Hi Greg,

> On Mon, May 31, 2021 at 03:21:54PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, May 30, 2021 at 05:34:54PM +0100, Andre Przywara wrote:  
> > > An obvious easy hack-fix is to just define
> > > CONFIG_SERIAL_8250_16550A_VARIANTS, which brings the delays back and
> > > seems to avoid the problem for me.
> > > Another hack which seems to mitigate the problem is to avoid switching
> > > the baudrate to something faster than 115200.
> > > 
> > > I observed this on a BananaPi-M64 (Allwinner A64 SoC with AP6212 WiFi/BT
> > > chip), but others reported the same issue on a NanoPi Air (Allwinner H3
> > > with 6212), but also other SoCs and devices (at least one AP6210).
> > > 
> > > Obviously those workarounds are not real solutions, and I was
> > > wondering if anybody has an idea how to properly fix this?
> > > What puzzles me is that the delay is happening during the *UART*
> > > probe, so before we even start dealing with the Bluetooth device.  
> > 
> > What type of bluetooth device is this, and what does it have to do with
> > the serial port?  Is the SoC device using the same IP blocks for both?  
> 
> Many bluetooth "devices" (I mean the interface from the local machine
> to the BT world, not as in remote devices) are connected through a
> standard UART. Pictorially, it's:
> 
>   CPU <---> UART <---> BT chip <---> Bluetooth RF world
> 
> The reporter seems to be saying is that a change to the UART driver now
> means that the bluetooth chip wired to that UART no longer functions due
> to slightly different initialisation timings of the host UART.

Yes, exactly, thanks Russell for clarifying this.
How this works (when it does) is that the UART driver probes, then we
look at the children of the UART devicetree node, to probe for those, by
virtue of the serdev bus.

My question was about if this rings a bell with someone, because I have
a hard time piecing together how a delay in the *UART probe* could
affect devices depending on it. And how to fix this ...

Cheers,
Andre

