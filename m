From: Jon Anders Haugum <jonah@omegav.ntnu.no>
Subject: Re: [PATCH] serial8250: set divisor register correctly for AMD
 Alchemy SoC uart. Re-posted.
Date: Wed, 29 Mar 2006 15:39:46 +0200 (CEST)
Message-ID: <20060329153513.L86511@invalid.ed.ntnu.no>
References: <20060327131437.P55909@invalid.ed.ntnu.no>
 <20060327125423.GA24311@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fri.itea.ntnu.no ([129.241.7.60]:39133 "EHLO fri.itea.ntnu.no")
	by vger.kernel.org with ESMTP id S1750706AbWC2Njt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Mar 2006 08:39:49 -0500
In-Reply-To: <20060327125423.GA24311@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org

On Mon, 27 Mar 2006, Russell King wrote:
> I'm not sure whether this is a good idea - this is used to detect
> an 16C850 UART, so probably should be kept as is.
> 
> In other words, we should use serial_dl_read() / serial_dl_write()
> when we're actually wanting to read or set the actual divisor, but
> not for the autoconfiguration stuff.

Agree.

Should I send you a updated patch?


-- 
Jon Anders Haugum

