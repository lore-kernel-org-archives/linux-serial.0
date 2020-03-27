Return-Path: <SRS0=8UUK=5M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F719C43331
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 23:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6E8206E6
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 23:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1sT98oYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC0XeZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Mar 2020 19:34:25 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41366 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgC0XeZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Mar 2020 19:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UzwPS7G+drXDxv2tRrnhfE+UVek4Ph8f4KYDQCLpmjY=; b=1sT98oYsAC7juQRDmLPSPXXvH
        PVdVDzXlIEGaP9VVZcRLKM5WcSEf6Yh6EcBMnS6aHuhyPG0l5WZr7qN95aPdjlRTQqBJdYCDm5K3C
        +3BWOy0OrvmuSbMU8n2Tu1IUTUqcd6lcdTzAmfdjUTsyAGVw+iDGIBaNL3RLYJJ7BSJvPJIViaVwg
        S3ij91RHY1/4CnqjoHOy/J0bsNLXvWOV9AFoXR7NCQtp+4eTX2dc35gk2Uio3jNjxmNFb/T7XlDXb
        JRZxV25WA74tmSRy6plyuCCqtdcg/hCMzKaobPm1rDjXe9jlurFYF8iXh09kgUIEv/w+sLFnSTLkr
        JfbmvUYxQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38102)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jHyL0-0003s3-Ld; Fri, 27 Mar 2020 23:24:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jHyKy-0004dH-Mg; Fri, 27 Mar 2020 23:24:28 +0000
Date:   Fri, 27 Mar 2020 23:24:28 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Serial console and interrupts latency.
Message-ID: <20200327232428.GT25745@shell.armlinux.org.uk>
References: <87lfnq15vi.fsf@osv.gnss.ru>
 <aa0174f8-7cef-46c9-4164-605191393abd@suse.cz>
 <87ftdtzypi.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftdtzypi.fsf@osv.gnss.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 27, 2020 at 04:58:33PM +0300, Sergey Organov wrote:
> Jiri Slaby <jslaby@suse.cz> writes:
> 
> > On 24. 03. 20, 10:04, Sergey Organov wrote:
> >> Hello,
> >> 
> >> [Extended CC list to try to get some attention]
> >> 
> >> I was investigating random serial overruns on my embedded board and
> >> figured it strongly correlates with serial output (to another serial
> >> port) from kernel printk() calls, that forced me to dig into the kernel
> >> sources, and now I'm very confused.
> >> 
> >> I'm reading drivers/tty/serial/8250/8250_port.c, and
> >> serial8250_console_write() function in particular (being on tty-next
> >> branch).
> >> 
> >> What I see is that it locks interrupts
> >> 
> >> 3141:		spin_lock_irqsave(&port->lock, flags);
> >> 
> >> and then calls wait_for_xmitr() both indirectly here:
> >> 
> >> 3159:	uart_console_write(port, s, count, serial8250_console_putchar);
> >> 
> >> and then directly as well:
> >> 
> >> 3165:	wait_for_xmitr(up, BOTH_EMPTY);
> >> 
> >> before re-enabling interrupts at:
> >> 
> >> 3179:		spin_unlock_irqrestore(&port->lock, flags);
> >> 
> >> Now, wait_for_xmitr(), even according to comments, could busy-wait for
> >> up to 10+1000 milliseconds, and in this case this huge delay will happen
> >> at interrupts disabled?
> >> 
> >> Does it mean any serial console output out of printk() could cause 10
> >> milliseconds or even 1 second interrupts latency? Somehow I can't
> >> believe it.
> >> 
> >> What do I miss?
> >
> > 1 second _timeout_ is for flow-control-enabled consoles.
> 
> Yeah, sure. So it does mean interrupts could be disabled for up to 1
> second, on already up and running system. Too bad.
> 
> Actually, I use 8250 only as a reference implementation, my actual
> chip is handled by imx.c, and the latter even has no timeouts on this
> path, so apparently may block (the entire kernel) indefinitely!
> 
> > 10 ms is _timeout_ for a character. With slow 9600 baud console, sending
> > one character takes 0.8 ms. With 115200, it is 70 us.
> 
> 70us of disabled interrupts is a huge number, and for FIFO-enabled chips
> the estimate should be multiplied by FIFO size (say, x16) that brings us
> close to 1ms even on 115200, right?
> 
> Anyway, it must cause receiving overruns on another port running at
> higher or the same baud rate and no DMA, sooner or later, as it does
> for me.

So, don't use serial console then, it's unsuitable for your use case.

> > If you send one line (80 chars), it is really 66 and 5.5 ms, respectively.
> >
> > So yes, serial consoles can slow down the boot and add latency. Use
> > faster speeds or faster devices for consoles, if you mind. And do not
> > enable flow control. Serial is serial.
> 
> I don't care about slowing-down boot. I care about huge interrupt
> latency on up and running system, causing loss of characters  (overruns)
> on other serial ports.
> 
> To be sure, it is this code that works on already running system as
> well, not only on boot-time, right? Or is my system somehow
> misconfigured?
> 
> I'm confused as this seems to be a major issue and nobody but me seems
> to care or to suffer from it, and I can't figure why.
> 
> For reference, I figured this locking was introduced by:
> 
> commit d8a5a8d7cc32e4474326e0ecc1b959063490efc9
> Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
> Date:   Tue May 2 16:04:29 2006 +0100
> 
>     [SERIAL] 8250: add locking to console write function
>     
>     x86 SMP breaks as a result of the previous change, we have no real
>     option other than to add locking to the 8250 console write function.
>     If an oops is in progress, try to acquire the lock.  If we fail to
>     do so, continue anyway.

Correct, and what I said back then still applies - and more.

> It seems like I need to, and yeah, it'd be a somewhat tough task indeed,
> but then there is one simple question: why isn't console output handled
> through usual buffer/ISR paths?

The "usual" paths may not be active, and, in the case of an oops, we
want to see the output, which we wouldn't be able to if the oops
occurred in interrupt context.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
