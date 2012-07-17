From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ST16C654 stoppes transmitting after a while
Date: Tue, 17 Jul 2012 10:52:29 +0100
Message-ID: <20120717105229.17b578a5@pyramind.ukuu.org.uk>
References: <20120717074355.80180@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36894 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab2GQJsr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Jul 2012 05:48:47 -0400
In-Reply-To: <20120717074355.80180@gmx.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Arp <tobiasarp@gmx.de>
Cc: linux-serial@vger.kernel.org

> I found out that the hw_stopped flag is set to 1 but not set to 0 again although CTS is set (measuring with the oscilloscope and reading out the modem status register are confirming this / i modified the serial8250_get_mctrl function to print out these values).
> 
> It seems to me that an CTS change (UART_MSR_DCTS) is lost.
> Could this cause this behaviour?

Possibly you'd need to instrument your kernel as well to prove it. It
could also be a race in the kernel drivers somewhere. We certainly had
those in old kernels here and there.
 
> Any suggestions for a workaround are appreciated.

What kernel are you running ?
