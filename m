From: Gerald Emig <gme@emig-software.de>
Subject: Re: RS485 communication
Date: Sun, 16 Mar 2003 19:23:31 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030316192331.104a4151.gme@emig-software.de>
References: <PEEPIDHAKMCGHDBJLHKGGECKCDAA.rwhite@casabyte.com>
	<1047598241.5292.2.camel@hp.outpostsentinel.com>
	<1047732394.20703.10.camel@imladris.demon.co.uk>
	<1047776160.1327.0.camel@irongate.swansea.linux.org.uk>
	<1047809131.22070.33.camel@imladris.demon.co.uk>
	<20030316103517.B14404@flint.arm.linux.org.uk>
	<1047811906.22070.44.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [212.227.126.206] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 18ucoN-0007ro-00
	for linux-serial@vger.kernel.org; Sun, 16 Mar 2003 19:24:43 +0100
Received: from [217.4.178.231] (helo=emig4.heisch.inka.de)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 18ucoM-0007Xd-00
	for linux-serial@vger.kernel.org; Sun, 16 Mar 2003 19:24:43 +0100
In-Reply-To: <1047811906.22070.44.camel@imladris.demon.co.uk>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


Hi all,


RS485 (like RS232-C) is simply an electrical
specification, and nothing else. No protocol at all; surely there are
"proprietary" ones depending on device manufacturers. If I'm
totally wrong please correct me.

There are several protocols that use RS485. Samples are Profibus,
SIEMENS MPI, ISDN, EIB and many others (maybe even CAN), and they are
all different.
Most of these protocols use some master - slave conceptuation, but this
is not allways necessary; best example for the opposite is good old
ethernet.

So if we talk about this stuff and keep in mind the goal of
the initiator of this discussion, fact is that a protocol must be used
when we have more than two devices, either an existing or a new one. 

Problem: which protocol ???
And it seems to me that this is the real point to be discussed: there is
no such protocol (designed for RS485 bus systems) available, right ?



Gerald Emig

