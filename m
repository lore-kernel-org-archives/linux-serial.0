From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Using the MAX3107
Date: Tue, 29 May 2012 16:55:43 +0100
Message-ID: <20120529165543.4224a22a@pyramind.ukuu.org.uk>
References: <4FC4E511.7010501@student.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36040 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab2E2Pw4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 May 2012 11:52:56 -0400
In-Reply-To: <4FC4E511.7010501@student.kit.edu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ubdfu <ubdfu@student.kit.edu>
Cc: linux-serial@vger.kernel.org

On Tue, 29 May 2012 17:02:41 +0200
Ubdfu <ubdfu@student.kit.edu> wrote:

> Hello,
> 
> Please excuse my and be aware that I'm quite new to kernel hacking :-)
> 
> I'm currently trying to enable the RS485 support on the MAX3107 and 
> continuously getting the error:
> "max3107 spi2.0: interrup isn't serviced normally!"
> Assuming it means interrupt it nevertheless does not help me to find the 
> cause of the problem.
> 
> Added some patches form:
> http://marc.info/?l=linux-serial&w=2&r=1&s=max3107&q=b
> 
> And changed the baudrate to the appropriate, set bit for rs458 mode.
> 
> Has anyone tried working with the MAX3107?

Not in rs485 mode and not for a while. The base code in drivers/tty/serial
should work for RS232 mode at least.

The trigger you are hitting implies that it got an event during
suspend/freezing or somehow tried to queue work when work was already
queued.

The current code doesn't cope with the device being on a shared interrupt
line, so my first guess would be that might be the problem ?

Alan

