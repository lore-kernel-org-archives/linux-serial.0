Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9030C433E3
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 12:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65D22078B
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 12:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594385133;
	bh=wpzRKbUTJ/D3MmU91mmC4uz1sijQouiUeKMqPeNEd/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JUSnNGQ05zbNxssM2eEXK0BjN+1KiZ9zlLCs3yAG31T8QJ8WTSFXvQ4e7+D8JM+Vy
	 s11nXMoGFEGPMZX25ltFrwZncsycoexYN6zZrIIw1UoHcXfnmgG8r8n0DcGFU/JfsC
	 IndbPS4zCX0vXi0kMyVfqMO8OjwfEBb16DI7+EG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGJMpc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:45:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbgGJMpb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 08:45:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E091B20772;
        Fri, 10 Jul 2020 12:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594385130;
        bh=wpzRKbUTJ/D3MmU91mmC4uz1sijQouiUeKMqPeNEd/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1R8xitnTXa3oSg9fDtr2o5emN1GLUKOibPm+qc9PLC6WOxnvMTnwjmexyt81cEa+R
         l2UYLf91Km9GTOykFMiHmSPFeTPrO8dt38xBmRkR52bQO3mgOp0WxqVm59DCGiGhD0
         ssdcwKThgXXVg7KTCPCzxaOY2rkATFQCNkFrkg3o=
Date:   Fri, 10 Jul 2020 14:45:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helmut Grohne <helmut.grohne@intenta.de>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jan Kiszka <jan.kiszka@web.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: xilinx_uartps: Really fix id assignment
Message-ID: <20200710124535.GA1584780@kroah.com>
References: <f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com>
 <20200709074849.GA28968@laureti-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709074849.GA28968@laureti-dev>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 09, 2020 at 09:48:53AM +0200, Helmut Grohne wrote:
> The problems started with the revert (18cc7ac8a28e28). The
> cdns_uart_console.index is statically assigned -1. When the port is
> registered, Linux assigns consecutive numbers to it. It turned out that
> when using ttyPS1 as console, the index is not updated as we are reusing
> the same cdns_uart_console instance for multiple ports. When registering
> ttyPS0, it gets updated from -1 to 0, but when registering ttyPS1, it
> already is 0 and not updated.
> 
> That led to 2ae11c46d5fdc4. It assigns the index prior to registering
> the uart_driver once. Unfortunately, that ended up breaking the
> situation where the probe order does not match the id order. When using
> the same device tree for both uboot and linux, it is important that the
> serial0 alias points to the console. So some boards reverse those
> aliases. This was reported by Jan Kiszka. The proposed fix was reverting
> the index assignment and going back to the previous iteration.
> 
> However such a reversed assignement (serial0 -> uart1, serial1 -> uart0)
> was already partially broken by the revert (18cc7ac8a28e28). While the
> ttyPS device works, the kmsg connection is already broken and kernel
> messages go missing. Reverting the id assignment does not fix this.
> 
> >From the xilinx_uartps driver pov (after reverting the refactoring
> commits), there can be only one console. This manifests in static
> variables console_pprt and cdns_uart_console. These variables are not
> properly linked and can go out of sync. The cdns_uart_console.index is
> important for uart_add_one_port. We call that function for each port -
> one of which hopefully is the console. If it isn't, the CON_ENABLED flag
> is not set and console_port is cleared. The next cdns_uart_probe call
> then tries to register the next port using that same cdns_uart_console.
> 
> It is important that console_port and cdns_uart_console (and its index
> in particular) stay in sync. The index assignment implemented by
> Shubhrajyoti Datta is correct in principle. It just may have to happen a
> second time if the first cdns_uart_probe call didn't encounter the
> console device. And we shouldn't change the index once the console uart
> is registered.
> 
> Reported-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Reported-by: Jan Kiszka <jan.kiszka@web.de>
> Link: https://lore.kernel.org/linux-serial/f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com/
> Fixes: 18cc7ac8a28e28 ("Revert "serial: uartps: Register own uart console and driver structures"")
> Fixes: 2ae11c46d5fdc4 ("tty: xilinx_uartps: Fix missing id assignment to the console")
> Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

What tree/branch is this against?  It doesn't seem to apply to my
tty-linus branch which is where I would think it should go to, right?

thanks,

greg k-h
