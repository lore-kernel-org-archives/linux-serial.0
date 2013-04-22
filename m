From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: using a RS232->RS485 adapter issues...
Date: Mon, 22 Apr 2013 21:53:37 +0000 (UTC)
Message-ID: <kl4bh1$lir$1@ger.gmane.org>
References: <51757F18.8070908@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39874 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969Ab3DVVxx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Apr 2013 17:53:53 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1UUOgK-0003yu-8l
	for linux-serial@vger.kernel.org; Mon, 22 Apr 2013 23:53:52 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 22 Apr 2013 23:53:52 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 22 Apr 2013 23:53:52 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-04-22, Rick Bolen(gm) <rickbolgm@gmail.com> wrote:

> I'm perplexed in using a RS232C->RS485 dongle that worked perfectly
> on a Debian Lenny box for years. Now that I'm migrating to Debian
> Wheezy, albeit, different mobo (Intel mini-itx D2500CC) and serial
> card (RocketPort), this dongle doesn't work as before.
>
> The dongle sourced working power *from* the host serial port 
> (cannibalizing DTR, etc?). Using the RocketPort, I have to power the 
> dongle separately and create a simple data only pass-thru (TX\RX\GND, no 
> other connections) connection for this dongle to function.
>
> So I don't know if there are voltage level differences on the DTR etc 
> that result in the failure to power the dongle from the serial port.

That could be.  

It's not as common as it used to be, but motherboard serial ports used
to put out +/- 12V.  The RocketPort card is probably only putting out
+/- 5V (the RS-232 spec only requires +/- 3V).  Even if the RS485
adapter could run off 5V, the RocketPort card might not be capable of
sourcing enough current at 5V to power it.

Have you verified that the pins from which you're scavenging power are
in the same states in the two different setups?  Is your software
explicitly setting the states of the pins from which you're scavenging
power (RTS and DTR), or are you relying on the default states for DTR
and RTS when the port opens.  IIRC, it should be the same for the
RocketPort card as for the motherboard UART, but you might want to
verify that.

> Also, having examined the serial port configs with stty between the two 
> machines, and making all the settings identical, I don't understand why 
> I have to create the data only pass-thru for communication to work.

If your adapter requires DTR to be (for example) at 9V or higher, then
connecting it to a DTR driver that's only putting out 5V might cause
it to malfunction.  It's also possible that the adapter with the
external power supply is trying to put out a voltage on DTR that's
higher than the RocketPort DTR driver output voltage.  If that's the
case, your adapter could be sourcing current into the RocketPort DTR
output. Transceivers can act pretty weird when you do that, and it can
corrupt either transmit or receive data.  I saw that happen just last
week when a 5V RTS driver on one machine was connected to a 12V RTS
driver on another machine.  Even though nobody was doing anything with
the RTS pins, the overvoltage condition on the RTS pin was causing the
charge-pump in the transceiver to malfunction causing the negative
rail to collapse and as aresult tx data would get corrupted.

> All hw\sw flow controls are identical between the working machine and
> the new machine... at least as far as stty reports.

> 1) What serial pin can reliably measure to determine voltage level
>    for the port (i.e. 12V, 5V, 3.3V)?

Data lines should idle low (-5V).  DTR and RTS are usually low when
the port isn't opened and high (+5) when the port is opened.

-- 
Grant Edwards               grant.b.edwards        Yow! Excuse me, but didn't
                                  at               I tell you there's NO HOPE
                              gmail.com            for the survival of OFFSET
                                                   PRINTING?

