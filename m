From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: can't detect 16550A at port 0x010 on Vortex86dx board
Date: Mon, 9 Jul 2012 16:52:17 +0100
Message-ID: <20120709165217.63e983b7@pyramind.ukuu.org.uk>
References: <CAJkQPOm_TpNp6Y=rx0x9EtH1zvvwOb5JAo7Z+45BKRQPru-4ZQ@mail.gmail.com>
	<20120706235459.5886e2ee@pyramind.ukuu.org.uk>
	<CAJkQPO=GYpDYOTiQ+Z-cs34=RRwnJLED79Xo4sZXg_Nd_2xM_A@mail.gmail.com>
	<CAJkQPOmBQPejYxa7=nW6pczCP+soYgLCxhuGHQMg3MjO0aZVmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55584 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab2GIPsi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Jul 2012 11:48:38 -0400
In-Reply-To: <CAJkQPOmBQPejYxa7=nW6pczCP+soYgLCxhuGHQMg3MjO0aZVmQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Aras Vaichas <aras.vaichas@gmail.com>
Cc: linux-serial@vger.kernel.org

> CONFIG_SERIAL_8250_SHARE_IRQ=y
> 
> It needed IRQ sharing to make it work.

Fair enough, that's usually set.

> COM9 on a Vortex86DX is now working in Linux 3.3.8 but it requires
> more than a simple serial driver patch.
> 
> I'm not entirely sure how to go about creating a proper patch for the
> changes I have made. My serial driver writes to the South Bridge, but
> it's a quick hack using outl() calls to the right addresses. Should I
> use a proper PCI function call?

If the Southbridge is a PCI device then yes.

> I also modified the x86 io port mappings in /arch/x86/kernel/setup.c.
> Do I either add #ifdef-ery to setup.c, or create a new entry in
> arch/x86/kernel/cpu/ and do my different io mappings there?

ifdeffery is bad. New cpu type is preferable. If the differences are
trivial then some kind of runtime handling is even better.

What you could do is post the hack patch with the questions attached -
not as a proposed kernel patch but as a "what is needed" guide so we can
work out the best way to do it.

Alan

