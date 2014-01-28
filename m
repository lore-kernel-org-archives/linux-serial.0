From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/11] resolve PXA<->8250 serial device address conflict
Date: Tue, 28 Jan 2014 15:14:37 +0100
Message-ID: <20140128141437.GB8713@xo-6d-61-c0.localdomain>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <1385879185-22455-2-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34575 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574AbaA1OOy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jan 2014 09:14:54 -0500
Content-Disposition: inline
In-Reply-To: <1385879185-22455-2-git-send-email-ynvich@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>

Hi!

> PXA serial ports have "standard" UART names (ttyS[0-3]), major
> device number (4) and first minor device number (64) by default.
> 
> If the system has extra 8250 serial port hardware in addition
> to onboard PXA serial ports, default settings produce a device
> allocation conflict.
> 
> The patch provides a configuration option which can move onboard
> ports out of the way of 8250_core by assigning a different (204)
> major number and corresponding device names (ttySA[0-3]).

Yes, please. I was hitting the same issue with Sharp Zaurus and bluetooth
CF card... Bluetooth card had 8250 inside...


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
