From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: selfmade serial driver problem with chipset other than VIA
Date: Mon, 19 Dec 2005 21:15:38 -0600
Message-ID: <43A7775A.7010402@microgate.com>
References: <32883.147.27.7.175.1135028325.squirrel@147.27.7.175>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:33935
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750754AbVLTDPl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Dec 2005 22:15:41 -0500
In-Reply-To: <32883.147.27.7.175.1135028325.squirrel@147.27.7.175>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gxatzipavlis@softnet.tuc.gr
Cc: linux-serial@vger.kernel.org

gxatzipavlis@softnet.tuc.gr wrote:
>>the driver isn't working in computers with INTEL and
>>NVIDIA chipsets... when ever i call outb from my
>>writer bottomhalf routine the interrupt isn't generated from the
>>hardware(in machines with inter or nvidia chipset).
 > ...
> i can't understand what registers to print during boot as alan proposed
> the registers from 0x03f8 - 0x03ff (aka /dev/ttyS0)?

If the Line Control Register (LCR) Divisor Latch Access Bit (DLAB)
is set, then offsets 0 and 1 access the divisor latch instead
of the transmit holding register (THR) and interrupt enable register (IER).

You do not state if you initialize that bit to zero.
If that bit is set, that could prevent the THR empty
interrupt you expect.

--
Paul Fulghum
Microgate Systems, Ltd
