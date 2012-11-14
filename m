From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 8250_early for big-endian
Date: Wed, 14 Nov 2012 12:20:34 +0000
Message-ID: <20121114122034.0bcc4423@pyramind.ukuu.org.uk>
References: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
	<20121012175150.4b081343@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A4@ezexch.ezchip.com>
	<20121012195102.5781c7d4@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A5@ezexch.ezchip.com>
	<20121012220604.3f99d003@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A9@ezexch.ezchip.com>
	<20121013145212.27f6fcbd@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC3001073@ezexch.ezchip.com>
	<20121014133216.686277e1@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC300184F@ezexch.ezchip.com>
	<20121025121815.0689c196@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499FF@ezexch.ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:52289 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161153Ab2KNMP1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Nov 2012 07:15:27 -0500
In-Reply-To: <264C179F799EF24AB26D5319053335E80CC30499FF@ezexch.ezchip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Gilad Ben Yossef <giladb@ezchip.com>

>From e2dda56ab679d81bb0a021e102519185028deded Mon Sep 17 00:00:00 2001
> From: Noam Camus <noamc@ezchip.com>
> Date: Sun, 11 Nov 2012 05:49:39 +0200
> Subject: [PATCH] tty/8250_early: Turn serial_in/serial_out into weak symbols.
> 
> Allows overriding default methods serial_in/serial_out.
> 
> In such platform specific replacement it is possible to use,
> other regshift, biased register offset, any other manipulation
> that is not covered with common default methods.
> 
> Overriding default methods may be useful for platforms which got
> serial peripheral with registers represented in big endian.
> In this situation and assuming that 32 bit operations / alignment
> is required then it may be useful to swab words before/after
> accessing the serial registers.


Looks ok to me.

Acked-by: Alan Cox <alan@linux.intel.com>
