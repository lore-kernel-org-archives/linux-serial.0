From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 01/30] disallow SERIAL_8250_PNP with SERIAL_8250_CONSOLE
Date: Tue, 24 Mar 2009 15:22:03 +0000
Message-ID: <20090324152203.6a989d06@lxorguk.ukuu.org.uk>
References: <20090324135930.12735.7827.stgit@localhost.localdomain>
	<20090324140145.12735.29459.stgit@localhost.localdomain>
	<20090324151034.GC6859@ports.donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54768 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754482AbZCXPWR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Mar 2009 11:22:17 -0400
In-Reply-To: <20090324151034.GC6859@ports.donpac.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrey Panin <pazke@donpac.ru>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, torvalds@linux-foundation.org

> This patch looks very controversial from my POV. Now distro people must decide
> what to enable SERIAL_8250_PNP or SERIAL_8250_CONSOLE. And no matter what you 

They do already, otherwise your machine crashes at boot.

> choose you'll get a regression, non-working serial console vs broken detection of
> perfectly working hardware like additional serial ports on industrial computers,
> notebook touchpads and finally old and dusty ISA PnP modems.
> 
> How widespread are these "known but hard to fix issues", to justify such drastic
> change ?

Any situation where you have a serial console on an ISAPnP device
explodes on boot. I do intend to find a better fix for this, but in the
meantime it is best that the quick fix goes in IMHO.
