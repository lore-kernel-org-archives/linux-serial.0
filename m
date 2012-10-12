From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 8250_early for big-endian
Date: Fri, 12 Oct 2012 22:06:04 +0100
Message-ID: <20121012220604.3f99d003@pyramind.ukuu.org.uk>
References: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
	<20121012175150.4b081343@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A4@ezexch.ezchip.com>
	<20121012195102.5781c7d4@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A5@ezexch.ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37498 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab2JLVBD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Oct 2012 17:01:03 -0400
In-Reply-To: <264C179F799EF24AB26D5319053335E80CC30499A5@ezexch.ezchip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

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
