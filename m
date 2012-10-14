From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 8250_early for big-endian
Date: Sun, 14 Oct 2012 13:32:16 +0100
Message-ID: <20121014133216.686277e1@pyramind.ukuu.org.uk>
References: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
	<20121012175150.4b081343@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A4@ezexch.ezchip.com>
	<20121012195102.5781c7d4@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A5@ezexch.ezchip.com>
	<20121012220604.3f99d003@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A9@ezexch.ezchip.com>
	<20121013145212.27f6fcbd@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC3001073@ezexch.ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:38421 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858Ab2JNM1S (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 08:27:18 -0400
In-Reply-To: <264C179F799EF24AB26D5319053335E80CC3001073@ezexch.ezchip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Sun, 14 Oct 2012 12:11:13 +0200
Noam Camus <noamc@ezchip.com> wrote:

> Soon I will email you my patch for regshift addition.
> 
> In the meantime I discovered that one of my boards do need 32bit operations.
> 
> How to generalize the solution to cover this case as well?

Then I guess if you need 32bit I/O and aligned we do actually need to to
support the shifts and you do end up needing to do MMIO32 and >> 24 for
your serial_in (or as you originally suggested a byte reverse if faster).

For 8250_early it may well be the right thing is to support similar
serial_in/serial_out methods.

Alan
