From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pmac serial_pci_guess_board problem
Date: Sat, 05 Nov 2005 09:53:19 +1100
Message-ID: <1131144799.29195.31.camel@gaston>
References: <436BD229.3090401@am.sony.com>
	 <1131140861.29195.13.camel@gaston>
	 <20051104225051.GC12026@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60369 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751009AbVKDWy1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 4 Nov 2005 17:54:27 -0500
In-Reply-To: <20051104225051.GC12026@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Geoff Levand <geoffrey.levand@am.sony.com>, linux-serial@vger.kernel.org


> That's the expected size of the ports.  Remember this is a heuristic
> for finding the correct details of the ports.  Some cards seem to
> have regions of 16 bytes which aren't serial ports.
> 
> I'm _very_ nervous about changing this, especially as it pre-dates
> my time and you seem to imply that it's an OF problem.  Can't it be
> fixed up in a PCI quirk?

Could be yes. a ppc64 specific one that re-do the BAR sizing... I wonder
what's up with OF tho ...  Maybe Apple's OF can't assign BARs smaller
than 16 bytes ?

Ben.


