From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 8250_early for big-endian
Date: Sat, 13 Oct 2012 14:52:12 +0100
Message-ID: <20121013145212.27f6fcbd@pyramind.ukuu.org.uk>
References: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
	<20121012175150.4b081343@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A4@ezexch.ezchip.com>
	<20121012195102.5781c7d4@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A5@ezexch.ezchip.com>
	<20121012220604.3f99d003@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A9@ezexch.ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37948 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab2JMNrL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Oct 2012 09:47:11 -0400
In-Reply-To: <264C179F799EF24AB26D5319053335E80CC30499A9@ezexch.ezchip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Sat, 13 Oct 2012 08:43:02 +0200
Noam Camus <noamc@ezchip.com> wrote:

> On Fri, 12 Oct 2012 21:11:06 +0200
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Do the values have to be read with 32bit operations and do they have to
> > be read on 32bi alignment ?
> 
> Yes I do need the 32bit alignment but I do not need 32bit operations.
> So using mmio (instead of mmio32) with regshift equals 2 worked for me.
> 
> However 8250_early got no configurable regshift.
> So it needs to be added.

I would favour adding the regshift and I see no problem in doing that.

Alan
