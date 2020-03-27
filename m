Return-Path: <SRS0=8UUK=5M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875D6C43331
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6D920658
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 13:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tvGdGZyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgC0NjG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:39:06 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34426 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgC0NjG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Mar 2020 09:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7ckbIxg2fiUQxjjkt8X4mz6hEzOZNaNCrTXkN/lp+/M=; b=tvGdGZyBsLjOF9iWZLJo69/Dm
        sNPd52QSHz/u2l0fO3SFrqBhgjk4n3D+JXl8Jf8/ggw4EsTVGqW5WCbDZeb80VzCTK6i4CF91ywT0
        tl1LZ/CdrPCVuxu/c8fAsEe1CeYLDEZQ/iVl+FjTieshSqw0YWeHobswfcVPvzJR9wgKnZlIc5Bkr
        750HfTrvb3+AlYWt5JBK6uDFZyNY955PpIJqbpz1QTgXGEGqsEEcBNuY9RzV+qSzIHZAWi3DQ4X3i
        dPcQ5LMt3JMG0GL70VUFINgP+0pk3P//XAt53GWqMXZgBVDPGaPSE75GTDcr/oXeyuU0g9uo0CvuC
        Rd2vwBfUg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37922)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jHpCO-0001LX-I2; Fri, 27 Mar 2020 13:39:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jHpCM-0004Fu-UP; Fri, 27 Mar 2020 13:38:59 +0000
Date:   Fri, 27 Mar 2020 13:38:58 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Sergey Organov <sorganov@gmail.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Serial console and interrupts latency.
Message-ID: <20200327133858.GL25745@shell.armlinux.org.uk>
References: <87lfnq15vi.fsf@osv.gnss.ru>
 <aa0174f8-7cef-46c9-4164-605191393abd@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa0174f8-7cef-46c9-4164-605191393abd@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 27, 2020 at 02:13:12PM +0100, Jiri Slaby wrote:
> On 24. 03. 20, 10:04, Sergey Organov wrote:
> > Hello,
> > 
> > [Extended CC list to try to get some attention]
> > 
> > I was investigating random serial overruns on my embedded board and
> > figured it strongly correlates with serial output (to another serial
> > port) from kernel printk() calls, that forced me to dig into the kernel
> > sources, and now I'm very confused.
> > 
> > I'm reading drivers/tty/serial/8250/8250_port.c, and
> > serial8250_console_write() function in particular (being on tty-next
> > branch).
> > 
> > What I see is that it locks interrupts
> > 
> > 3141:		spin_lock_irqsave(&port->lock, flags);
> > 
> > and then calls wait_for_xmitr() both indirectly here:
> > 
> > 3159:	uart_console_write(port, s, count, serial8250_console_putchar);
> > 
> > and then directly as well:
> > 
> > 3165:	wait_for_xmitr(up, BOTH_EMPTY);
> > 
> > before re-enabling interrupts at:
> > 
> > 3179:		spin_unlock_irqrestore(&port->lock, flags);
> > 
> > Now, wait_for_xmitr(), even according to comments, could busy-wait for
> > up to 10+1000 milliseconds, and in this case this huge delay will happen
> > at interrupts disabled?
> > 
> > Does it mean any serial console output out of printk() could cause 10
> > milliseconds or even 1 second interrupts latency? Somehow I can't
> > believe it.
> > 
> > What do I miss?
> 
> 1 second _timeout_ is for flow-control-enabled consoles.
> 
> 10 ms is _timeout_ for a character. With slow 9600 baud console, sending
> one character takes 0.8 ms. With 115200, it is 70 us.
> 
> If you send one line (80 chars), it is really 66 and 5.5 ms, respectively.
> 
> So yes, serial consoles can slow down the boot and add latency. Use
> faster speeds or faster devices for consoles, if you mind. And do not
> enable flow control. Serial is serial.
> 
> You can also try to eliminate the interrupts disablement, but that would
> be a bit tough task, IMO.

... and likely difficult to implement, since the spinlock is there to
prevent coincident usage from userspace and kernel space to the port.
If userspace is outputting a message in unison with a kernel console
message, there must be exclusivity, otherwise the two messages will
either be intermingled, or completely corrupted due to TX FIFO
overflow, making the console quite useless.

Higher latency is something that IMHO has to be accepted as a result
of using serial console.

As Jiri says, the way around that is to use as fast a baud rate as
possible on the serial console.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
