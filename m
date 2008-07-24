From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Thu, 24 Jul 2008 14:00:26 +0100
Message-ID: <20080724140026.70c5d6a3@lxorguk.ukuu.org.uk>
References: <200807241347.33261.laurentp@cse-semaphore.com>
	<20080724125706.19844a96@lxorguk.ukuu.org.uk>
	<20080724122402.GC9327@flint.arm.linux.org.uk>
	<20080724132746.1a961584@lxorguk.ukuu.org.uk>
	<20080724125210.GD9327@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54220 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754531AbYGXNRr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 09:17:47 -0400
In-Reply-To: <20080724125210.GD9327@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Laurent Pinchart <laurentp@cse-semaphore.com>, linux-serial@vger.kernel.org

> > So the 16550 sucks, that's not true of everyone elses uarts.
> 
> It's true of all 8250 compatibles which don't have hardware RS485
> support.  I think that's all of them except 16850 and 16960.

Its not true of a lot of other uart devices however.

> A while back, there were people asking for:
> 1. handshaking on DTR/DSR rather than RTS/CTS.
> 2. a different handshaking method for RTS/CTS (where you assert
>    RTS to ask for permission to send when you actually have something
>    to send.)
> 
> Should CRTSCTS be a global "enable some kind of flow control" bit and
> setserial be used to configure the actual flow control method
> (conventional RTS/CTS, DTR/DSR, alternate RTS/CTS, RS485 on RTS,
> RS485 on DTR) ?

I've actually been trying to find out how other Unixen handle DTR/DSR and
not had any luck finding a sensible common interface for it.

Alan
