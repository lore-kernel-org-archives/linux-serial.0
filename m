From: <Grzegorz.Sygieda@tieto.com>
Subject: RE: [PATCH] pl011: added clock management feature
Date: Wed, 17 Nov 2010 10:24:35 +0200
Message-ID: <0CBD3CD1188FB94093DB405A20CBCFBE06C7415895@EXMB01.eu.tieto.com>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
 <20101109224012.GA21992@kroah.com>
 <20101110000152.GA8993@n2100.arm.linux.org.uk>
 <0CBD3CD1188FB94093DB405A20CBCFBE06C5C4D8D2@EXMB01.eu.tieto.com>
 <20101110171104.GC27571@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ebb06.tieto.com ([131.207.168.38]:46525 "EHLO ebb06.tieto.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934199Ab0KQIZA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Nov 2010 03:25:00 -0500
In-Reply-To: <20101110171104.GC27571@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: greg@kroah.com, linus.walleij@stericsson.com, par-gunnar.p.hjalmdahl@stericsson.com, gregkh@suse.de, Lukasz.Rymanowski@tieto.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> If a port is open, and bound (eg to a bluetooth hci), how does the higher level decide whether to place the port in low power mode?  How does it know that there isn't going to be > >characters sent to the port?
> 
> When the port is in this low power mode, it's as good as closed from the external world point of view.
> 
> I don't like this idea because I really can't see how it could be used effectively - there isn't really any way for a bound protocol to know whether there's characters expected to be received > or not.  Either the port is open and in use, or it isn't.
> 
> Let's take an example of a modem waiting for an incoming call.  It spends most of its time waiting for the call.  You could argue that you could shut the clock off to the port to save > power - but then how do you receive the "RING" message from the modem?  As you've shut the clock off, you're not going to detect the activity on the receive line.
> 
> I'm sure that also applies to bluetooth as well, especially if you're a 'client' device - as long as the port is attached, bluetooth probably expects to be able to listen to what's going on so >the device can be discovered.
>
> It's all very well adding hooks to the transmit path to ensure that there clock is on while there's characters to be sent, but this really doesn't help you on the receive side.
> 
> I'm worried...

We have chip which acts (is registred) as platform_device, and have knowledge about its status through GPIO, (eg. Wake-up line), as well as it can control low power mode. This driver registers to hci discipline, thus gives posibliity to invoke tty functions, including set_termios. And this is what we are actualy doing. We think that this is best way to keep clock control without closing the uart.

We don't think, if it possible to shutdown and then startup the uart port completly, from the chip's driver level. 

Correct us if We're wrong.