From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] serial: 8250: Do XR17V35X specific wakeup in
 serial8250_do_startup
Date: Tue, 28 Jul 2015 09:20:59 +0200
Message-ID: <20150728072059.GQ10969@8bytes.org>
References: <1437035353-13708-1-git-send-email-joro@8bytes.org>
 <55A90467.9000804@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55A90467.9000804@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Michael Welling <mwelling@ieee.org>, Joe Schultz <jschultz@xes-inc.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On Fri, Jul 17, 2015 at 09:34:31AM -0400, Peter Hurley wrote:
> On 07/16/2015 04:29 AM, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > The XR17V35X UART needs the ECB bit set in its XR_EFR
> > register to enable access to IER [7:5], ISR [5:4], FCR[5:4],
> > MCR[7:5], and MSR [7:0].
> > 
> > Also reset the IER register to mask interrupts after access
> > to all bits of this register has been enabled.
> > 
> > This makes my 8-port XR17V35X working with the in-kernel
> > serial driver.
> 
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

Thanks for your review.

> Also, would you please find out what bits are set in the IER
> that this fixes and let me know? I don't have this hardware.

Unfortunatly I put the card back into a production machine and can't
easily check this anymore. But I'll let you know when I update the
kernel on the box next time.


	Joerg
