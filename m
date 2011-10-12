From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Using serial driver 16550A in poll mode without interrupt
 connected
Date: Wed, 12 Oct 2011 14:51:53 +0100
Message-ID: <20111012145153.5490b592@lxorguk.ukuu.org.uk>
References: <4E95902B.7080204@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56435 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752329Ab1JLNxT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Oct 2011 09:53:19 -0400
In-Reply-To: <4E95902B.7080204@monstr.eu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: monstr@monstr.eu
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Peter Korsgaard <jacmet@sunsite.dk>

> Driver is probed with no IRQ (NO_IRQ = -1 on Microblaze)
> 83e00000.serial: ttyS0 at MMIO 0x83e01003 (irq = -1) is a 16550A

Zero means no IRQ. NO_IRQ is a legacy internal thing for the old IDE code
so not something other code should be using. Setting the IRQ to -1 is
bogus and will confuse the rest of the kernel.

> Is it possible to use serial driver without IRQ - or blocking IRQ, etc.?

Within limits - it kills your power management and data rates because of
the continual polling.

Alan
