From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RESEND 1/2] 8250: pm callback for platform uarts
Date: Sat, 25 Sep 2010 00:50:40 +0100
Message-ID: <20100925005040.1a127135@lxorguk.ukuu.org.uk>
References: <1285344809-16839-1-git-send-email-manuel.lauss@googlemail.com>
	<20100924182258.34a76623@lxorguk.ukuu.org.uk>
	<AANLkTin=OTRA-cYJyYUn7es6R3cpuZtTLgoggkXgeAnD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35568 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753696Ab0IXX11 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 Sep 2010 19:27:27 -0400
In-Reply-To: <AANLkTin=OTRA-cYJyYUn7es6R3cpuZtTLgoggkXgeAnD@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>

> > This bit makes sense - but why can't you simply propogate it to the
> > existing uart_8250_port callback when registering ?
> 
> 
> I need a hook for platform code to reenable the UART block clocks before
> serial8250_set_sleep() is invoked on resume.  The current code actually
> works, it's just that on resume the bootloader disables the clocks for
> all UART blocks except the debug one, which leaves all others dead.
> 
> So I added the these calls into these platform methods around
> serial8250_set_sleep().

Which isn't the right way to do this IMHO. It may work for your specific
case but a solution needs to be generic.

The comment about sticking it in the wrong structd also holds.

So NAK this patch.

Put the callback in the right struct, and make it do the whole work. One
way to do that would be to make the existing method

	serial8250_do_...

and the main one call the _do_xxx method if no private one is defined.

For your specific hardware you'd have a replacement method which called
the default one in the middle.

Alan
