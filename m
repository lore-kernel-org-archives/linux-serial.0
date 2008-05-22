From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: Initialization Packet in Serial Communication?!
Date: Thu, 22 May 2008 15:27:21 -0600
Message-ID: <4835E539.2000501@microgate.com>
References: <48358AB2.2070602@informatik.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:53137
	"EHLO gw.microgate.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158AbYEVUml (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 May 2008 16:42:41 -0400
In-Reply-To: <48358AB2.2070602@informatik.uni-hamburg.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Daniel Kreischer <3kreisch@informatik.uni-hamburg.de>
Cc: linux-serial@vger.kernel.org

Daniel Kreischer wrote:
> we are trying to make a small embedded sensor device (Crossbow's TelosB mote)[1] talk to a SmartCard reader
> via a serial connection.
> To do so, we checked which packets are being sent by a open source linux driver to the reader and successfully
> replicated the behaviour manually with cutecom[2].
> We then implemented a stripped down version of the driver on the mote, but when we attach the reader to it, it
> won't answer to the commands sent by the mote.
> 
> We recognized a kind of initialization packet received by cutecom and even cat everytime we open a connection:
> 	00 00 80 00 00 00 80 00 80 80 80 80 80 80 80 80 80 80 80
>         80 00 80 80 80 00 00 80 00 00 00 00 80 00 00 80 00 00
> 
> We don't seem to receive that packet when connecting the reader to the mote, though.
> Connecting the mote via a null modem cable to the PC and imitating the reader's responses with cutecom does
> work, so the driver on the mote is ok.
> 
> We have already debugged the 8250.c serial kernel driver with printk()s before every outb() and inb() to the
> UART's registers and started writing a miniature user space driver to find out what causes the packet, but we
> can't exactly replicate the behaviour manually, yet.
> 
> The question is: Does anybody of you know what that packet is about, and what triggers it?

If I understand you correctly, the card reader sends this
init packet when connected to cutecom running on Linux
but not when connected to mote?

I don't know the meaning of that packet, but if it is
sent by the reader when a connection is open but no
data has been sent then the card reader is probably
responding to a UART control signal (DTR or RTS) which is
asserted when the tty device is opened.

If the mote does not drive or assert these signals then
the card reader may ignore data sent by the mote.
I would verify that the control signals from the mote
are the same state as the control signals from the Linux box.

-- 
Paul Fulghum
Microgate Systems, Ltd.
