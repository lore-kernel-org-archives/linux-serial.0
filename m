From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Tue, 16 May 2006 15:07:34 +0200
Message-ID: <87hd3qxgmh.fsf@LKG7F3A44.lan>
References: <87ac9o3ak3.fsf@sleipner.barco.com>
	<20060511222001.GC28693@flint.arm.linux.org.uk>
	<87slnapagf.fsf@LKG7F3A44.lan>
	<20060516125329.GE15481@flint.arm.linux.org.uk>
	<4469CDAD.20506@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hoboe1bl1.telenet-ops.be ([195.130.137.72]:28366 "EHLO
	hoboe1bl1.telenet-ops.be") by vger.kernel.org with ESMTP
	id S932089AbWEPPR4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 May 2006 11:17:56 -0400
In-Reply-To: <4469CDAD.20506@246tNt.com> (Sylvain Munaut's message of "Tue, 16
	May 2006 15:03:41 +0200")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-serial@vger.kernel.org

>>>>> "Sylvain" == Sylvain Munaut <tnt@246tNt.com> writes:

 Sylvain> Yes, I confirm that using the major 4 space is really a bad
 Sylvain> idea. The mpc52xx driver did this, up until the point of
 Sylvain> people reported very annoying problems when pcmcia serial
 Sylvain> card were presents ;)

Exactly. Using standard 16550 UARTs together with the uartlites is
quite common, that's why I hijacked the 204 range from the mpc52xx
driver instead of the 4 range of the 8250 driver.

But ok, I'll request a separate range for the uartlite driver.

-- 
Bye, Peter Korsgaard
