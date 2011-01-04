From: Greg KH <gregkh@suse.de>
Subject: Re: Need to disable MSR interrupts in 8250 driver. Request for
 guidance...
Date: Mon, 3 Jan 2011 16:07:31 -0800
Message-ID: <20110104000731.GA17841@suse.de>
References: <4D21D9EE.7070503@criticallink.com>
 <87pqsda6de.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:34792 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803Ab1ADAIN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jan 2011 19:08:13 -0500
Content-Disposition: inline
In-Reply-To: <87pqsda6de.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Michael Williamson <michael.williamson@criticallink.com>, linux-serial@vger.kernel.org, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>

On Mon, Jan 03, 2011 at 03:56:45PM -0800, Kevin Hilman wrote:
> Michael Williamson <michael.williamson@criticallink.com> writes:
> 
> > I am working on platform from the davinci architecture that uses the 8520 UART
> > driver.  However, there are some configurations that do not have a valid
> > CTS input pin (it is a multi-purpose pin on a SoC part, and it may be configured
> > for other functions).  These configurations can cause a pile of "false" 
> > MSR interrupts.  If, in 8250.c, I set the UART_BUG_NOMSR flag as part of
> > the up->bugs information, the problem clears up.
> 
> [...]
> 
> > Should I create a new port type, add a new UPF_ flag in the flags field, figure 
> > out how to pass bugs information via platform data, or continue along the
> > work-around path?  
> 
> I added Greg KH to Cc as he's maintaining the 8250 core now.
> 
> IMO, adding UPF_ flag(s) to indicate this bug seems like the right way
> to go to me.

Yes, it sounds correct to me as well.

thanks,

greg k-h
