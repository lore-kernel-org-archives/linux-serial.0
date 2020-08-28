Return-Path: <SRS0=9Cit=CG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD3AC433E7
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 09:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7CC2071B
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 09:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598605611;
	bh=MPhtp0UtdEZ75rpOuAq7t66CaY460V2FzguTeM/ym6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XU56D7RWeN9/WpFCAKcylMkPfslk2V7Q9dCoAtxX8v4nxfPP0VsizG5XhIrsPYZ2y
	 mfoMxbii6qgCXOfDi/f+BpSwTU5ol2fN/y4nL0Vu4g+W3TLSVb6j6TPMzGCUcYMDYT
	 fJN9vfqz92/QU1xQFH1oNh8DjLE3bCMG5tOd3/6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgH1JGu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbgH1JGl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Aug 2020 05:06:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DC1D2071B;
        Fri, 28 Aug 2020 09:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598605599;
        bh=MPhtp0UtdEZ75rpOuAq7t66CaY460V2FzguTeM/ym6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A0bRjlHrquKlHU4zHVZhrlp9d3Y2By2Ei+MSTE1ZwDh2nnxwrAeNuRNcjYusUPAWs
         /fr41z6y8Lw1uo6Woec2U/a+1GiY680HU//nN0Uv6Tg48dqe1rWrt3toWDq29pFbSU
         dw7RWdVwgAn1rYS+M/bDi/PADHv4ERW79Bc2D198=
Date:   Fri, 28 Aug 2020 11:06:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH kernel] serial_core: Check for port state when tty is
 in error state
Message-ID: <20200828090651.GA1110962@kroah.com>
References: <20200728124359.980-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728124359.980-1-aik@ozlabs.ru>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 28, 2020 at 10:43:59PM +1000, Alexey Kardashevskiy wrote:
> At the moment opening a serial device node (such as /dev/ttyS3)
> succeeds even if there is no actual serial device behind it.
> Reading/writing/ioctls (most) expectantly fail as the uart port is not
> initialized (the type is PORT_UNKNOWN) and the TTY_IO_ERROR error state
> bit is set fot the tty.

That is only if there is no ldisc set for the port, right?  I don't
think that always will be the case if the port is not initialized.

Yes, we do clear this on port open, but we clear it before the
->activate() callback happens.

Why not check for initialized instead?  That would seem to be what you
want to do here instead of checking for an io error.

> However syzkaller (a syscall fuzzer) found that setting line discipline
> does not have these checks all the way down to io_serial_out() in
> 8250_port.c (8250 is the default choice made by univ8250_console_init()).
> As the result of PORT_UNKNOWN, uart_port::iobase is NULL which
> a platform translates onto some address accessing which produces a crash
> like below.
> 
> This adds tty_io_error() to uart_set_ldisc() to prevent the crash.
> 
> The example of crash on PPC64/pseries:
> 
> BUG: Unable to handle kernel data access on write at 0xc00a000000000001
> Faulting instruction address: 0xc000000000c9c9cc
> cpu 0x0: Vector: 300 (Data Access) at [c00000000c6d7800]
>     pc: c000000000c9c9cc: io_serial_out+0xcc/0xf0
>     lr: c000000000c9c9b4: io_serial_out+0xb4/0xf0
>     sp: c00000000c6d7a90
>    msr: 8000000000009033
>    dar: c00a000000000001
>  dsisr: 42000000
>   current = 0xc00000000cd22500
>   paca    = 0xc0000000035c0000   irqmask: 0x03   irq_happened: 0x01
>     pid   = 1371, comm = syz-executor.0
> Linux version 5.8.0-rc7-le-guest_syzkaller_a+fstn1 (aik@fstn1-p1) (gcc (Ubunt
> untu) 2.30) #660 SMP Tue Jul 28 22:29:22 AEST 2020
> enter ? for help
> [c00000000c6d7a90] c0000000018a8cc0 _raw_spin_lock_irq+0xb0/0xe0 (unreliable)
> [c00000000c6d7ad0] c000000000c9bdc0 serial8250_do_set_ldisc+0x140/0x180
> [c00000000c6d7b10] c000000000c9bea4 serial8250_set_ldisc+0xa4/0xb0
> [c00000000c6d7b50] c000000000c91138 uart_set_ldisc+0xb8/0x160
> [c00000000c6d7b90] c000000000c5a22c tty_set_ldisc+0x23c/0x330
> [c00000000c6d7c20] c000000000c4c220 tty_ioctl+0x990/0x12f0
> [c00000000c6d7d20] c00000000056357c ksys_ioctl+0x14c/0x180
> [c00000000c6d7d70] c0000000005635f0 sys_ioctl+0x40/0x60
> [c00000000c6d7db0] c00000000003b814 system_call_exception+0x1a4/0x330
> [c00000000c6d7e20] c00000000000d368 system_call_common+0xe8/0x214
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> While looking at it, I noticed that a bunch of callbacks are prone to
> this bug and since I wanted to fix them all with minimum effort,
> I tried checking for PORT_UNKNOWN in uart_port_check() but it breaks
> device opening. Another approach could be checking for uart_port::iobase
> in 8250 (and probably uart_port::membase as well) but this will make
> the rest of the code to think the device is ok while there is no device
> at all.
> 
> What would the correct approach be and what is the expectation?

We should probably check tty_port_initialized() on these code paths
better, care to fix that up?

thanks,

greg k-h
