From: "Tobias Arp" <tobiasarp@gmx.de>
Subject: Re: ST16C654 stoppes transmitting after a while
Date: Tue, 17 Jul 2012 13:36:03 +0200
Message-ID: <20120717113603.9830@gmx.net>
References: <20120717074355.80180@gmx.net>
	<20120717105229.17b578a5@pyramind.ukuu.org.uk>
	<20120717100521.219440@gmx.net> <20120717122140.075aa7ae@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:34335 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751847Ab2GQLgH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Jul 2012 07:36:07 -0400
In-Reply-To: <20120717122140.075aa7ae@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

This is a single core arm processor (Cirrus EP9315), could this race condition happen in this case? 

But i have CONFIG PRREMPT set. Shall i take a stab on it by switching it to off?

Tobias
-------- Original-Nachricht --------
> Datum: Tue, 17 Jul 2012 12:21:40 +0100
> Von: Alan Cox <alan@lxorguk.ukuu.org.uk>
> An: "Tobias Arp" <tobiasarp@gmx.de>
> CC: linux-serial@vger.kernel.org
> Betreff: Re: ST16C654 stoppes transmitting after a while

> On Tue, 17 Jul 2012 12:05:21 +0200
> "Tobias Arp" <tobiasarp@gmx.de> wrote:
> 
> > I run kernel 3.2. Upgrading to a newer kernel would be not se easy at
> the moment.
> 
> 3.2 is certainly new enough that it should have all the major fixes in.
> 
> > I am not sure how to check if this change is really lost.
> 
> With a debugger dump the state of the port structures one the hung port
> once it has hung. Something like Red Hat's systemtap might also be very
> helpful in doing this kind of monitoring.
> 
> My first guess would be that you hit a race between the port stopping on
> one processor and the flow control event on another. We have one known
> case there still being debugged but I thought it could only be hit if you
> were using ttys in low latency mode.
> 
> Alan
