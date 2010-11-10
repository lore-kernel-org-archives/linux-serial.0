From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] pl011: added clock management feature
Date: Wed, 10 Nov 2010 17:11:04 +0000
Message-ID: <20101110171104.GC27571@n2100.arm.linux.org.uk>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com> <20101109224012.GA21992@kroah.com> <20101110000152.GA8993@n2100.arm.linux.org.uk> <0CBD3CD1188FB94093DB405A20CBCFBE06C5C4D8D2@EXMB01.eu.tieto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57394 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185Ab0KJRLh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Nov 2010 12:11:37 -0500
Content-Disposition: inline
In-Reply-To: <0CBD3CD1188FB94093DB405A20CBCFBE06C5C4D8D2@EXMB01.eu.tieto.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grzegorz.Sygieda@tieto.com
Cc: greg@kroah.com, linus.walleij@stericsson.com, par-gunnar.p.hjalmdahl@stericsson.com, gregkh@suse.de, Lukasz.Rymanowski@tieto.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Nov 10, 2010 at 10:15:53AM +0200, Grzegorz.Sygieda@tieto.com wrote:
> The main goal was to disable/enable clock while port open. This is usefull
> for scenario, where some higher level driver wants to control the power
> consumption (using set_termios). In the same time a user-space app (eg.
> hciattach) is still bounded to the specific /dev/tty* device associated
> with particular uart. From user POV device is always open, and app does
> not have to respawn, and we can save power.

If a port is open, and bound (eg to a bluetooth hci), how does the higher
level decide whether to place the port in low power mode?  How does it
know that there isn't going to be characters sent to the port?

When the port is in this low power mode, it's as good as closed from the
external world point of view.

I don't like this idea because I really can't see how it could be used
effectively - there isn't really any way for a bound protocol to know
whether there's characters expected to be received or not.  Either the
port is open and in use, or it isn't.

Let's take an example of a modem waiting for an incoming call.  It spends
most of its time waiting for the call.  You could argue that you could
shut the clock off to the port to save power - but then how do you receive
the "RING" message from the modem?  As you've shut the clock off, you're
not going to detect the activity on the receive line.

I'm sure that also applies to bluetooth as well, especially if you're a
'client' device - as long as the port is attached, bluetooth probably
expects to be able to listen to what's going on so the device can be
discovered.

It's all very well adding hooks to the transmit path to ensure that there
clock is on while there's characters to be sent, but this really doesn't
help you on the receive side.

I'm worried...
