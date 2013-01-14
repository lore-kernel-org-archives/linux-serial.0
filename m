From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Printf hangs when internal buffer of driver is temporarily full
Date: Mon, 14 Jan 2013 19:36:45 +0000
Message-ID: <20130114193645.63a2d12c@pyramind.ukuu.org.uk>
References: <50F40403.9040000@septentrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:50112 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277Ab3ANT34 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jan 2013 14:29:56 -0500
In-Reply-To: <50F40403.9040000@septentrio.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Philip Oberstaller <Philip.Oberstaller@septentrio.com>
Cc: linux-serial@vger.kernel.org

> which happens when the driver's internal buffer is temporarily full.
> I would have expected that the TTY layer or the libc implementation of
> printf would requery write_room automatically and thus would notice

How is it going to magically notice ?

> after a while that there is space again, but this doesn't seem to happen.
> Eventually the printf function returns after a very long timeout but without
> that the remaining characters have been printed.

You need to wake it up and tell it there is room in your completion
interrupts. It will then think about retrying.

> I based my code mainly on the ifx6x60-driver and I looked at other similar
> drivers as well, but I can't see that they are using a different strategy.
> 
> In a dated driver book it was suggested that write_room and write should
> always return at least one.

I would suggest recycling that book 8)

Alan
