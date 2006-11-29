From: Theodore Tso <tytso@mit.edu>
Subject: Re: is_real_interrupt in 8250.c
Date: Wed, 29 Nov 2006 13:11:49 -0500
Message-ID: <20061129181148.GA31874@thunk.org>
References: <200611291744.kATHixEN006240@oogie-boogie.ics.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:8138 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S967497AbWK2SLv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Nov 2006 13:11:51 -0500
Content-Disposition: inline
In-Reply-To: <200611291744.kATHixEN006240@oogie-boogie.ics.uci.edu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dan Nicolaescu <dann@ics.uci.edu>
Cc: linux-serial@vger.kernel.org

On Wed, Nov 29, 2006 at 09:44:59AM -0800, Dan Nicolaescu wrote:
> 
> Hi,
> 
> In 8250.c is_real_interrupt is defined like this: 
> 
> /*
>  * We default to IRQ0 for the "no irq" hack.   Some
>  * machine types want others as well - they're free
>  * to redefine this in their header file.
>  */
> #define is_real_interrupt(irq)  ((irq) != 0)
> 
> on my platform the UART IRQ is 0, so is_real_interrupt returns
> false.
> 
> In order to allow machines to override is_real_interrupt, and for the
> code to match the comment shouldn't this patch be applied? 

No, IRQ 0 for linux is always "no IRQ".  We should probably add this
to the LKML FAQ, since it keeps coming up.  Per Linus, if there are
any architectures that has a valid IRQ #0, then the
architecture-specific kernel code should remap IRQ numbers.  See:

	http://comments.gmane.org/gmane.linux.kernel/468449

						- Ted
