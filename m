From: Noam Camus <noamc@ezchip.com>
Subject: RE: 8250_early for big-endian
Date: Fri, 12 Oct 2012 21:08:15 +0200
Message-ID: <264C179F799EF24AB26D5319053335E80CC30499A5@ezexch.ezchip.com>
References: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
	<20121012175150.4b081343@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A4@ezexch.ezchip.com>,<20121012195102.5781c7d4@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ezexch.ezchip.com ([212.179.42.101]:45032 "EHLO
	ezexch.ezchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130Ab2JLTLt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Oct 2012 15:11:49 -0400
In-Reply-To: <20121012195102.5781c7d4@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Sorry,but I wrote that I am using mmio32.

I thought it implies that I am using 32bit registers.

This is why I keep asking.
________________________________________
From: Alan Cox [alan@lxorguk.ukuu.org.uk]
Sent: Friday, October 12, 2012 8:51 PM
To: Noam Camus
Cc: linux-serial@vger.kernel.org
Subject: Re: 8250_early for big-endian

> Of course swapping is a waste of cpu cycles.
> Workaround can be 3 further bytes offset.
> Thanks
>
> Back to my problem.
> How can 8250_early be enhanced to support big endian registers.

They are 8bit registers - I don't understand why you are asking the
question ?