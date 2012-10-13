From: Noam Camus <noamc@ezchip.com>
Subject: RE: 8250_early for big-endian
Date: Sat, 13 Oct 2012 08:43:02 +0200
Message-ID: <264C179F799EF24AB26D5319053335E80CC30499A9@ezexch.ezchip.com>
References: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
	<20121012175150.4b081343@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A4@ezexch.ezchip.com>
	<20121012195102.5781c7d4@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A5@ezexch.ezchip.com>,<20121012220604.3f99d003@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ezexch.ezchip.com ([212.179.42.101]:18305 "EHLO
	ezexch.ezchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab2JMGnp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Oct 2012 02:43:45 -0400
In-Reply-To: <20121012220604.3f99d003@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Fri, 12 Oct 2012 21:11:06 +0200
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Do the values have to be read with 32bit operations and do they have to
> be read on 32bi alignment ?

Yes I do need the 32bit alignment but I do not need 32bit operations.
So using mmio (instead of mmio32) with regshift equals 2 worked for me.

However 8250_early got no configurable regshift.
So it needs to be added.
Alternatively I can use regshift equals 0 and redefine locally all offsets from serial_reg.h e.g. UART_LST, UART_IER...

What do you think is the way to work this regshift?

BTW: no more endian-ness from my side.
________________________________________
From: Alan Cox [alan@lxorguk.ukuu.org.uk]
Sent: Friday, October 12, 2012 11:06 PM
To: Noam Camus
Cc: linux-serial@vger.kernel.org
Subject: Re: 8250_early for big-endian

On Fri, 12 Oct 2012 21:08:15 +0200
Noam Camus <noamc@ezchip.com> wrote:

> Sorry,but I wrote that I am using mmio32.

Yes but you also keep talking about endian-ness. The underlying registers
are 8bit so they are not 'endian' at all. They might be at the address
"base + 4 * offset + 3" perhaps ?

If so they to use mmio32 presumably you just need to set the base address
properly (ie 0xXXXXXXX3 or similar).

Do the values have to be read with 32bit operations and do they have to
be read on 32bi alignment ?

Alan
