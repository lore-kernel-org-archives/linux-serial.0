Return-Path: <SRS0=9Zku=3F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FD8C33CB1
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 13:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B533820730
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 13:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgAPNiS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:38:18 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:38819 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgAPNiS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jan 2020 08:38:18 -0500
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2020 08:38:17 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 040CA100BE781;
        Thu, 16 Jan 2020 14:29:55 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 99C9DDFE15; Thu, 16 Jan 2020 14:29:54 +0100 (CET)
Date:   Thu, 16 Jan 2020 14:29:54 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ivan Sistik <sistik@3ksolutions.sk>
Cc:     Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] tty: serial: amba-pl011: added RS485 support
Message-ID: <20200116132954.5tcxmezs5qhseiem@wunner.de>
References: <20200106235203.27256-1-sistik@3ksolutions.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106235203.27256-1-sistik@3ksolutions.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 07, 2020 at 12:52:03AM +0100, Ivan Sistik wrote:
> AMBA PL011 do not have hardware support for RS485. This implementation is
> for drive enable signal (DE), which switch direction of RS485 driver chip.

So I've implemented rs485 support for amba-pl011.c two years ago
but the patches need a little more polishing before they can be
upstreamed and I haven't gotten around to that yet.  I apologize
that it meant you had to reinvent the wheel.

You can find my implementation on this branch:
https://github.com/RevolutionPi/linux/commits/revpi-4.19

Specifically this commit:
https://github.com/RevolutionPi/linux/commit/0099313962a5

You've used hrtimers in case delays are necessary after assertion
or before deassertion of RTS.  Note that 8250_port.c already contains
code for that.  If one wants to go that route, it would probably be
best to move that code into serial_core.c to make it available to
non-8250 ports.

I took a completely different approach:  I converted amba-pl011.c
to threaded interrupt handling using two kthreads, one for sending,
one for receiving.  This allows simultaneous writing to and reading
from the FIFO.  The driver keeps track of the FIFO fill level,
which allows writing to the FIFO blindly.  The hardirq handler
updates the fill level counter and wakes either of the IRQ threads.

Once the driver was converted to threaded interrupts, it became
possible to sleep in the IRQ handler, so I just used msleep()
for the RTS delays.

The above-linked branch also has rs485 console support for amba-pl011.c
as well as for the auxiliary UART on the Raspberry Pi.


> There is missing FIFO empty interrupt in PL011. It is replaced by second
> hrtimer which is started if there are no more data in port transmit buffer.

The tty layer lets you know when there's nothing more to transmit by
calling the ->stop_tx() hook.  Then you just busy-wait for the FIFO
to empty before you deassert RTS.

Another idea would be to set TXIFLSEL (TX interrupt FIFO level select)
in the UARTIFLS register to the lowest possible setting.  Then you'll
get an interrupt when the TX FIFO only contains 2 bytes (on a PL011
with 16 byte FIFOs), thus minimizing the busy-wait duration.

Thanks,

Lukas
