From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ST16C654 stoppes transmitting after a while
Date: Tue, 17 Jul 2012 12:21:40 +0100
Message-ID: <20120717122140.075aa7ae@pyramind.ukuu.org.uk>
References: <20120717074355.80180@gmx.net>
	<20120717105229.17b578a5@pyramind.ukuu.org.uk>
	<20120717100521.219440@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37017 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab2GQLR4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Jul 2012 07:17:56 -0400
In-Reply-To: <20120717100521.219440@gmx.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Arp <tobiasarp@gmx.de>
Cc: linux-serial@vger.kernel.org

On Tue, 17 Jul 2012 12:05:21 +0200
"Tobias Arp" <tobiasarp@gmx.de> wrote:

> I run kernel 3.2. Upgrading to a newer kernel would be not se easy at the moment.

3.2 is certainly new enough that it should have all the major fixes in.

> I am not sure how to check if this change is really lost.

With a debugger dump the state of the port structures one the hung port
once it has hung. Something like Red Hat's systemtap might also be very
helpful in doing this kind of monitoring.

My first guess would be that you hit a race between the port stopping on
one processor and the flow control event on another. We have one known
case there still being debugged but I thought it could only be hit if you
were using ttys in low latency mode.

Alan
