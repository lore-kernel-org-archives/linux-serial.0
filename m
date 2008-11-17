From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: serial8250_interrupt idea
Date: Mon, 17 Nov 2008 10:51:53 +0100
Message-ID: <B98538A31FB14FC2A64239FC940CA0C1@acksys.local>
References: <20081113150308.3590.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp05.msg.oleane.net ([62.161.4.5]:36356 "EHLO
	smtp05.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbYKQKOU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Nov 2008 05:14:20 -0500
In-Reply-To: <20081113150308.3590.qmail@science.horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'George Spelvin' <linux@horizon.com>, linux-serial@vger.kernel.org

Hello Mr Spelvin,

When I put this kind of improvement in my serial drivers I usually run into
the following problem:

If several ports are very busy receiving at the same time, one of them gets
served much more often than the others, and the others start loosing data.

Does your changes take this into account ?

Sorry, I didn't take the time to go through your code (I'm working on un
unrelated project right now).

Regards

> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org
> [mailto:linux-serial-owner@vger.kernel.org]On Behalf Of George Spelvin
> Sent: Thursday, November 13, 2008 4:03 PM
> To: linux-serial@vger.kernel.org
> Cc: alan@lxorguk.ukuu.org.uk; linux@horizon.com
> Subject: serial8250_interrupt idea
>
>
> When ISA-style edge-sensitive interrupts are shared (as is
> commonly done
> on multi-serial cards), it's essential that all interrupt sources are
> quieted before returning from the interrupt handler, so there will be
> an inactive-to-active edge to trigger on next time.
>
> This requires repeatedly polling all of the ports sharing one
> IRQ until
> you've done a full pass during which nobody had an interrupt pending.
> That ensures that there was an interval (between emptying the last
> busy port and checking the status of the first empty port in the final
> all-empty pass) during which the interrupt line was not asserted.
>
> The current code keeps all the ports in a linked list and polls them
> in a loop, remembering the position of the last busy port, until that
> position has been reached again without seeing a non-empty port.
>
> However, it seems to me that it's possible to improve on this.
> Which would be valuable, given that ISA I/O port reads (usually on a
> super-IO chip via an LPC bus these days) are quite time-consuming.
>
> If you could predict which ports were going to be busy, you
> could check
> them first on the first pass, allowing you to start the final
> verification
> pass as early as possible.
>
> This could be done very easily via a self-organizing list.  When a
> port is polled busy, move it up to the front of the list so it will be
> checked earlier next time.  The inactive ports would migrate
> to the end
> of the list.  The struct uart_8250_port list is already locked for the
> duration of the interrupt, so there is no need for additional locking.
>
>
> I was thinking about preparing a patch to do this, but I have
> one style
> question: it would be easier to do the list rearrangement if the
> list were singly-linked.  Removing a port would require walking the
> whole list, but we already do that each interrupt so it's hardly
> a frightening cost.
>
> Is there any reason to preserve the "struct list" configuration?
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

