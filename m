From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: Re: [PATCH] make 8250_pnp use pnp_manual_config_dev()
Date: Wed, 11 May 2005 17:48:05 -0300
Message-ID: <20050511204805.GJ3907@cathedrallabs.org>
References: <20050510121521.GB4676@cathedrallabs.org> <20050510135128.C3358@flint.arm.linux.org.uk> <20050510130715.GF3907@cathedrallabs.org> <20050511202432.GA2720@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from panda.sul.com.br ([200.219.150.4]:45323 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S262054AbVEKVLh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 May 2005 17:11:37 -0400
Content-Disposition: inline
In-Reply-To: <20050511202432.GA2720@neo.rr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-serial@vger.kernel.org

> pnp_manual_config_dev is intented for drivers that use different
> resource assignments than those automatically set by PnP.  It looks
> like you're passing the same config back.
> 
> Could you please explain your rational here further.
> 
> Values already assigned by the BIOS are not checked against reserved
> regions.  Is this what you're getting it?  If so, we could have double
> detection issues between the PnP protocol and the legacy detection
> mechanism.
My idea was just to enforce pnp_reserve_{io,irq} options for serial
ports too (8250_pnp does not check for those options). I was looking for a
way of ignoring a serial port I/O range (before Russell King point me to
setserial).
So, yes, please drop this patch as my problem is already solved in a
different (and much better) way. :)

--
Aristeu

