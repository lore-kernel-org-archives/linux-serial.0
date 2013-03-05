From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: UART IRQ over SMP
Date: Tue, 5 Mar 2013 14:04:38 +0800
Message-ID: <20130305060438.GA29301@kroah.com>
References: <264C179F799EF24AB26D5319053335E80CC40F680F@ezexch.ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:43086 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab3CEGES (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Mar 2013 01:04:18 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so3968065pbb.20
        for <linux-serial@vger.kernel.org>; Mon, 04 Mar 2013 22:04:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <264C179F799EF24AB26D5319053335E80CC40F680F@ezexch.ezchip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

On Mon, Mar 04, 2013 at 11:18:53AM +0200, Noam Camus wrote:
> Hello 
> 
> I got my UART IRQ line hardwired to CPU0. 
> However CPU1 (due to scheduler balancing I presume) is used for calling the request_irq() from 8250.c.
> By doing that the "chip" irq_enable() is unmasking UART IRQ line of CPU1 and not CPU0.
> Now I do not get UART interrupts since they are masked at CPU0.
> 
> I tried to unmask CPU0 UART IRQ line by default at early boot.
> Once I do that I get some spurious interrupt that handle_level_irq() leaves masked.
> It is because I did not register any action yet with the request_irq().
> 
> Is there known way for dealing with such scenario?

You need to fix your irq handling code for your platform, this isn't a
UART issue at all.

good luck,

greg k-h
