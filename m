Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6580CC43217
	for <linux-serial@archiver.kernel.org>; Wed, 24 Nov 2021 14:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352444AbhKXOKS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 09:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354591AbhKXOI0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 09:08:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91C14610A1;
        Wed, 24 Nov 2021 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637759658;
        bh=CB18mmVPYgI6vqt6hsCkPXAOznDDNiOLcMvZ9hENQ+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2fTqdWxF0VNXvcJwAY4xeU0VBig0Vc4gK5AhHB0S1Y2QDKTmDmpx2NbWPsIzh4g8P
         GqfgwNOgAfTCbZf0gCiqoU2GKGfeZJMfawOjnHI6ODio3s8oFTTPkuk0JBSpoZ12th
         clqgAX/YfnZMOwI//9MEH0xxrDw2HBoFW2ySlxFo=
Date:   Wed, 24 Nov 2021 13:33:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ruediger Willenberg <r.willenberg@hs-mannheim.de>
Cc:     linux-serial@vger.kernel.org, git@xilinx.com,
        shubhrajyoti.datta@xilinx.com, michal.simek@xilinx.com
Subject: Re: [PATCH v3] serial: uartlite: Move out-of-range port-numbers into
 ULITE_NR_UARTS range
Message-ID: <YZ4w/4vkfSItlMoc@kroah.com>
References: <20211122231446.85138-1-r.willenberg@hs-mannheim.de>
 <YZ4PKesu+YzXcfxS@kroah.com>
 <fabc3767-c524-1a88-4bec-d1b03d57bf4a@hs-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fabc3767-c524-1a88-4bec-d1b03d57bf4a@hs-mannheim.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 24, 2021 at 12:47:57PM +0100, Ruediger Willenberg wrote:
> Am 24.11.2021 um 11:08 schrieb Greg KH:
> > On Tue, Nov 23, 2021 at 12:14:46AM +0100, Ruediger Willenberg wrote:
> > > Find free uart_port struct in range 0 <= id < ULITE_NR_UARTS when
> > > the device tree port-number property is outside that range. This
> > > happens when there are other UART types in the system because the
> > > Xilinx device tree generator numbers all UARTs consecutively;
> > > as a result, not as many Uartlites as specified by the
> > > SERIAL_UARTLITE_NR_UARTS parameter could be successfully added.
> > 
> > Ick.  Please just remove that build option entirely, this should just
> > dynamically allocate new devices based on what is in the system.
> > 
> > The driver should not care at build time about this.
> > 
> 
> Fully agree removing SERIAL_UARTLITE_NR_UARTS and making allocation dynamic
> is best.
> Please briefly advise on how to best handle the following resulting issue:
> 
> In  serial_core.c  the following check occurs:
> 
> int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
> {
> ...
> 	if (uport->line >= drv->nr)
> 		return -EINVAL;
> 		
> 
> To not let this fail on registering a legit uartlite port, should we
> 
> * Set  ulite_uart_driver.nr = INT_MAX  before registering the driver

Or just 256, be kind :)

> * Adjust  ulite_uart_driver.nr  when adding or removing a port (surely with
> lock, but still smells)

Why do you need to change this when adding/removing a port?

> * do something blindingly obvious I'm missing?

I do not know, sorry, try it and see!

greg k-h
