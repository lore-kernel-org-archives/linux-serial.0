From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [1/1] stallion.c: "fix" initialisation path.
Date: Tue, 14 Jun 2005 10:35:25 +0400
Message-ID: <20050614103525.A15147@2ka.mipt.ru>
References: <20050613225833.08afa8ff@zanzibar.2ka.mipt.ru> <20050613211749.A32077@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relay.2ka.mipt.ru ([194.85.82.65]:25824 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261244AbVFNGec (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Jun 2005 02:34:32 -0400
Content-Disposition: inline
In-Reply-To: <20050613211749.A32077@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Jun 13, 2005 at 09:17:50PM +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org

On Mon, Jun 13, 2005 at 09:17:50PM +0100, Russell King (rmk@arm.linux.org.uk) wrote:
> On Mon, Jun 13, 2005 at 10:58:33PM +0400, Evgeniy Polyakov wrote:
> > Driver with such IRQ hacks inside looks really scary.
> > I do not have neither hardware nor deep knowledge about it,
> > just found a bug report from kerneltrap maillist.
> > That code really requires some changes.
> 
> Removing such things isn't a fix though - it changes something which
> fails/warns into a build-time silent run-time failure which are harder
> to find.

Sure, that is why I stated it as "fix".
I just wanted to bring some attention to 
this driver.

> (Also I don't process patches for non-drivers/serial based stuff, sorry.
> That should go via linux-kernel, thanks.)
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core

-- 
	Evgeniy Polyakov
