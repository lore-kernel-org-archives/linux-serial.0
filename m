From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ST16C654 stoppes transmitting after a while
Date: Wed, 18 Jul 2012 12:08:42 +0100
Message-ID: <20120718120842.6bdc0fd8@pyramind.ukuu.org.uk>
References: <20120717074355.80180@gmx.net>
	<20120717105229.17b578a5@pyramind.ukuu.org.uk>
	<20120717100521.219440@gmx.net>
	<20120717122140.075aa7ae@pyramind.ukuu.org.uk>
	<20120717113603.9830@gmx.net>
	<20120717173847.1c5b4863@pyramind.ukuu.org.uk>
	<20120718063704.130240@gmx.net>
	<20120718074530.17620@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:38720 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab2GRLFA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Jul 2012 07:05:00 -0400
In-Reply-To: <20120718074530.17620@gmx.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Arp <tobiasarp@gmx.de>
Cc: linux-serial@vger.kernel.org

On Wed, 18 Jul 2012 09:45:30 +0200
"Tobias Arp" <tobiasarp@gmx.de> wrote:

> The problem occurs very quick by setting the baud rate to 230400 on a single null modem connection (without usunign the orher ports of the quad uart). So i would say you are right with your guess...

> > magic: 0x5401
> > name: ttyS0
> > flags: 0x00000A00
> > count: 1
> > stopped: 0
> > hw_stopped: 1
> > flow_stopped: 0
> > packet: 0
> > low_latency: 0
> > warned: 0
> > ctrl_status: 0x00
> > receive_room: 4095

Ok that's not quite what I had expected to see

So the port is in use, not stopped at the higher levels and has lots of
receiver room as expected.

The hw_stopped flag is the hardware state - so somehow we've missed a
transition on the flow control or the UART hasn't bothered reporting it
or the IRQ got lost.

When it jams transmitting does it unjam if you send a single character
the other way ?

Alan
