From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Wed, 04 Oct 2006 17:41:57 +0200
Message-ID: <87hcykkrzu.fsf@slug.be.48ers.dk>
References: <87ac9o3ak3.fsf@sleipner.barco.com>
	<878xlgercm.fsf@slug.be.48ers.dk>
	<20060912093301.77f75bfb@localhost.localdomain>
	<87ejugxqbw.fsf@slug.be.48ers.dk> <871wqfyjgi.fsf@slug.be.48ers.dk>
	<20060913100110.1e33d885@localhost.localdomain>
	<451CDA3D.2060109@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adicia.telenet-ops.be ([195.130.132.56]:56984 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1161246AbWJDPmC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Oct 2006 11:42:02 -0400
In-Reply-To: <451CDA3D.2060109@dlasys.net> (David H. Lynch, Jr.'s message of
	"Fri, 29 Sep 2006 04:33:01 -0400")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Cc: linux-serial@vger.kernel.org

>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:

Hi,

 David>     You force the port regshift value to 2 in your init code,
 David> but then you ignore it and hard code the register offsets
 David> preshifted.

Yes, the regshift value is not used by the driver, I just kept the
initialization as documentation. The Xilinx IP block afaik cannot be
configured with a different regshift value than 2, so I hardcoded
it.

We can change that if it would ever be a problem, but there's
unfortunately no clean way of representing this in the
device/ressource data, so I would prefer to leave that out unless it's
needed.

 David> Also there is no provision for running the UartLite without
 David> using interrupts.  The Pico E12/E14 frequently use FPGA
 David> firmare that does not include a PIC.  Some implimentations of
 David> the UartLite use dcr instead of memory mapped ports.
   
No - again like the early serial stuff that's something that can be
added once the base driver is mainlined if there's demand.

Does polling even work decently with the small fifo size of the
uartlite?

-- 
Bye, Peter Korsgaard
