From: Noam Camus <noamc@ezchip.com>
Subject: RE: 8250_early for big-endian
Date: Sun, 14 Oct 2012 12:11:13 +0200
Message-ID: <264C179F799EF24AB26D5319053335E80CC3001073@ezexch.ezchip.com>
References: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
	<20121012175150.4b081343@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A4@ezexch.ezchip.com>
	<20121012195102.5781c7d4@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A5@ezexch.ezchip.com>
	<20121012220604.3f99d003@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A9@ezexch.ezchip.com>
 <20121013145212.27f6fcbd@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ezexch.ezchip.com ([212.179.42.101]:46585 "EHLO
	ezexch.ezchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325Ab2JNKL4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 06:11:56 -0400
In-Reply-To: <20121013145212.27f6fcbd@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Soon I will email you my patch for regshift addition.

In the meantime I discovered that one of my boards do need 32bit operations.

How to generalize the solution to cover this case as well?

Noam

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Saturday, October 13, 2012 3:52 PM
To: Noam Camus
Cc: linux-serial@vger.kernel.org
Subject: Re: 8250_early for big-endian

On Sat, 13 Oct 2012 08:43:02 +0200
Noam Camus <noamc@ezchip.com> wrote:

> On Fri, 12 Oct 2012 21:11:06 +0200
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Do the values have to be read with 32bit operations and do they have 
> > to be read on 32bi alignment ?
> 
> Yes I do need the 32bit alignment but I do not need 32bit operations.
> So using mmio (instead of mmio32) with regshift equals 2 worked for me.
> 
> However 8250_early got no configurable regshift.
> So it needs to be added.

I would favour adding the regshift and I see no problem in doing that.

Alan
